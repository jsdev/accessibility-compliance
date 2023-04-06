#Methods

##suggestExtensions
```javascript
const extensions = ['webp', 'png', 'bmp', 'jpg'];
console.log(suggestExtension(extensions, 'jng')); // ['png', 'jpg']
console.log(suggestExtension(extensions, 'wtf')); // ['webp]
console.log(suggestExtension(extensions, 'aaa')); // []
```
