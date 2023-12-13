export const removeFrontAlphabet = (str: string) => {
	const arrStr = str.split('');
	let removeCount = 0;

	for (let index = 0; index < arrStr.length; index++) {
		const element = arrStr[index];

		if (isNaN(parseInt(element))) {
			removeCount++;
		} else {
			break;
		}
	}

	return str.slice(removeCount, str.length);
};
export const dateFormating = (date: string, isDateOnly: boolean | undefined = true) => {
	if (isDateOnly && date) {
		return new Date(date).toLocaleDateString('en-GB', {
			day: 'numeric',
			month: 'numeric',
			year: 'numeric'
		});
	} else if (!isDateOnly && date) {
		return new Date(date).toLocaleDateString('en-GB', {
			day: 'numeric',
			month: 'numeric',
			year: 'numeric',
			hour: 'numeric',
			minute: 'numeric'
		});
	} else {
		return '-';
	}
};
export const numberWithPeriods = (value: number) => {
	if (!value) return '0';
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
};
