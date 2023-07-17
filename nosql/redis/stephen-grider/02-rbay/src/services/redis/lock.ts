import { randomBytes } from 'crypto';
import { client } from './client';

export const withLock = async (key: string, cb: () => any) => {
	// Initialize a few variables to control retry behavior
	const retryDelayMs = 100;
	let retries = 20;

	// Generate a random value to store at the lock key
	const token = randomBytes(6).toString('hex');

	// Create a lock key
	const lockKey = `lock:${key};`;

	// Business Logic
	while (retries >= 0) {
		retries--;
		const acquired = await client.set(lockKey, token, { NX: true });
		if (!acquired) {
			await pause(retryDelayMs);
			continue;
		}

		const result = await cb();
		await client.del(lockKey);
		return result;
	}
};

const buildClientProxy = () => {};

const pause = (duration: number) => {
	return new Promise((resolve) => {
		setTimeout(resolve, duration);
	});
};
