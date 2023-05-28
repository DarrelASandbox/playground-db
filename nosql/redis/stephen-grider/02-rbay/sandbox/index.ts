import 'dotenv/config';
import { client } from '../src/services/redis';

const run = async () => {
	await client.hSet('car', { color: 'red', year: 1915 });
	const car = await client.hGetAll('car');
	console.log(car);
};
run();

/*
WRONGTYPE Operation against a key holding the wrong kind of value

If you get this error on this lecture, it's because we previously set "car" as a key with simple string from rbook.  You need to go back to rbook and delete the exist key/value you have for car (most likely a simple string) with `DEL car`, then you will be able to set car as a hash type without error.
*/
