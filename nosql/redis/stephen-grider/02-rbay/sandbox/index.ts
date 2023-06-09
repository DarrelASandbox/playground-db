import 'dotenv/config';
import { client } from '../src/services/redis';

const run = async () => {
	await client.hSet('car1', {
		color: 'red',
		year: 1950

		// Flatten object structure to make it fit the expected format
		// or use a different Redis command that can handle more complex object structures
		// engine: { cylinders: 8 },

		// Include `|| ''` to handle null error
		// TypeError: Cannot read properties of null (reading 'toString')
		// owner: null || '',
		// service: undefined || ''
	});

	// const car = await client.hGetAll('car1'); // original key is `car`
	// // Check for empty object instead of if exist because response is not null
	// if (Object.keys(car).length === 0) return console.log('Car not found, respond with 404.');
	// console.log(car);

	await client.hSet('car2', {
		color: 'green',
		year: 1955
	});

	await client.hSet('car3', {
		color: 'blue',
		year: 1960
	});

	const commands = [1, 2, 3].map((id) => client.hGetAll('car' + id));
	const results = await Promise.all(commands);

	console.log(results);
};
run();

/*
WRONGTYPE Operation against a key holding the wrong kind of value

If you get this error on this lecture, it's because we previously set "car" as a key with simple string from rbook.  You need to go back to rbook and delete the exist key/value you have for car (most likely a simple string) with `DEL car`, then you will be able to set car as a hash type without error.
*/
