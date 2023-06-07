import { itemsKey, userLikesKey } from '$services/keys';
import { client } from '$services/redis';

export const userLikesItem = async (itemId: string, userId: string) =>
	client.sIsMember(userLikesKey(userId), itemId);

export const likedItems = async (userId: string) => {};

export const likeItem = async (itemId: string, userId: string) => {
	const inserted = await client.sAdd(userLikesKey(userId), itemId);

	// Handle user pressing the like button in quick succession (2 requests in a row)
	// We want to increment the like by only 1
	if (inserted) return client.hIncrBy(itemsKey(itemId), 'likes', 1);
};

export const unlikeItem = async (itemId: string, userId: string) => {
	const removed = await client.sRem(userLikesKey(userId), itemId);
	if (removed) return client.hIncrBy(itemsKey(itemId), 'likes', -1);
};

export const commonLikedItems = async (userOneId: string, userTwoId: string) => {};
