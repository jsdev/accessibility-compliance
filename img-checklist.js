const suggestExtension = (extensions, invalidExtension) => {
    let maxCount = 0;
    let suggestions = [];

    for (let i = 0; i < extensions.length; i++) {
      const extension = extensions[i];
      let count = 0;
      for (let j = 0; j < invalidExtension.length; j++) {
        if (extension.includes(invalidExtension[j])) {
          count++;
        }
      }
      if (count > maxCount) {
        maxCount = count;
        suggestions = [extension];
      } else if (count === maxCount) {
        suggestions.push(extension);
      }
    }

    return suggestions;
};

const popExtension = src => {
    const arr = src.split('.');

    if (arr.length > 1 && !!(arr[0].trim() && arr[arr.length - 1].trim())) {
        return arr.pop().toLowerCase()
    }

    return 'Invalid Filename'    
};

const MISSING = ' *** MISSING *** ';
const EMPTY = 'EMPTY';
const UNSUPPORTED = 'UNSUPPORTED';
const INVALID = 'INVALID';
const QUESTION = {
    ALT: "Is this purely decorative?",
};

const IMAGE_TYPES = [
    "apng",
    "avif",
    "gif",
    "jpg",
    "jpeg",
    "jfif",
    "pjpeg",
    "pjp",
    "png",
    "svg",
    "webp",
    "bmp",
    "ico",
    "cur",
    "tif",
    "tiff"
];

document.querySelectorAll('article').forEach(a => {
    const img = a.children[0];
    const width = img.getAttribute('width');
    const height = img.getAttribute('height');
    const alt = img.alt ? img.alt.trim() || EMPTY : MISSING;
    const extension = popExtension(img.src);
    const extensionInvalid = !IMAGE_TYPES.includes(extension);
    const extensionSuggestions = suggestExtension(IMAGE_TYPES, extension);
    let html = `
    <h3>${img.src}</h3>
    <dl>
        <dt>ALT</dt>
        <dd>${alt} ${[EMPTY, MISSING].includes(alt) ? QUESTION.ALT : ''}</dd>
        <dt>WIDTH</dt>
        <dd>${width ? width || EMPTY : MISSING}</dd>
        <dt>HEIGHT</dt>
        <dd>${height ? height || EMPTY : MISSING}</dd>
        <dt>EXTENSION</dt>
        <dd>${
            extension} ${extensionInvalid ?
                INVALID + ' suggestions: ' + extensionSuggestions : ''
            }</dd>
    </dl>`;
    a.innerHTML = html;
});
