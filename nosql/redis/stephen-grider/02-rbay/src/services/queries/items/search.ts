import { itemsIndexKey } from '$services/keys';
import { client } from '$services/redis';
import { deserialize } from './deserialize';

export const searchItems = async (term: string, size: number = 5) => {
	// Fuzzy Search Pre-Processing
	const cleaned = term
		.replaceAll(/[^a-zA-z0-9]/g, '')
		.trim()
		.split(' ')
		.map((word) => (word ? `%${word}%` : ''))
		.join(' ');

	if (cleaned === '') return;
	const results = await client.ft.search(itemsIndexKey(), cleaned, { LIMIT: { from: 0, size } });
	return results.documents.map(({ id, value }) => deserialize(id, value));
};
