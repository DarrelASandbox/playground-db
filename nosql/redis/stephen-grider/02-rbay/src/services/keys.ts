import { client } from './redis';
import type { CreateUserAttrs } from './types';
import { genId } from './utils';

export const pageCacheKey = (id: string) => 'pagecache#' + id;
export const usersKey = (userId: string) => 'users#' + userId;
export const createUser = async (attrs: CreateUserAttrs) => {
	const id = genId();
	// Why do we create a separate object instead of using `attrs`?
	await client.hSet(usersKey(id), { username: attrs.username, password: attrs.password });
	return id;
};
