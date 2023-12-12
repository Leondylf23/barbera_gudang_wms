export const removeFrontAlphabet = (str: string) => {
    const arrStr = str.split("");
    let removeCount = 0;

    for (let index = 0; index < arrStr.length; index++) {
        const element = arrStr[index];

        if(isNaN(parseInt(element))) {
            removeCount++;
        } else {
            break;
        }
    }

    return str.slice(removeCount, str.length);
}