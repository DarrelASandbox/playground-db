import { usernamesKey, usernamesUniqueKey, usersKey } from '$services/keys';
import { client } from '$services/redis';
import type { CreateUserAttrs } from '$services/types';
import { genId } from '$services/utils';

export const getUserByUsername = async (username: string) => {};

export const getUserById = async (id: string) => {
	const user = await client.hGetAll(usersKey(id));
	return deserialize(id, user);
};

export const createUser = async (attrs: CreateUserAttrs) => {
	const id = genId();

	const exists = await client.sIsMember(usernamesUniqueKey(), attrs.username);
	if (exists) throw new Error('Username is taken.');

	// Why do we create a separate object instead of using `attrs`?
	await client.hSet(usersKey(id), serialize(attrs));
	await client.sAdd(usernamesUniqueKey(), attrs.username);

	// Sorted set requires a number
	// Convert to number represented with decimal (base 10)
	// using number represented with hexadecimal (base 16)
	// to handle id
	await client.zAdd(usernamesKey(), {
		value: attrs.username,
		score: parseInt(id, 16)
	});

	return id;
};

const serialize = (user: CreateUserAttrs) => ({ username: user.username, password: user.password });
const deserialize = (id: string, user: { [key: string]: string }) => ({
	id,
	username: user.username,
	password: user.password
});
