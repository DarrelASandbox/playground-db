import { sessionsKey } from '$services/keys';
import { client } from '$services/redis';
import type { Session } from '$services/types';

export const getSession = async (id: string) => {
	const session = await client.hGetAll(sessionsKey(id));
	// empty object means the user is not signed in
	if (Object.keys(session).length === 0) return null;
	return deserialize(id, session);
};

export const saveSession = async (session: Session) =>
	client.hSet(sessionsKey(session.id), serialize(session));

const serialize = (session: Session) => ({ userId: session.id, username: session.username });

const deserialize = (id: string, session: { [key: string]: string }) => ({
	id,
	userId: session.userId,
	username: session.username
});
