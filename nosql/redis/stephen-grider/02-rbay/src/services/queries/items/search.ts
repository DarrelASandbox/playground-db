export const searchItems = async (term: string, size: number = 5) => {
	// Fuzzy Search Pre-Processing
	const cleaned = term
		.replaceAll(/[^a-zA-z0-9]/g, '')
		.trim()
		.split(' ')
		.map((word) => (word ? `%${word}%` : ''))
		.join(' ');
};
