# accessibility-compliance
A path on how to make accessibility compliant applications

Currently code scans are limited to checking if images have an alt tag or not.
This was my attempt at trying to significantly speed up the manual review.
As most developers/testers/managers check these things on images only that it renders

so I created a shell script that creates an html file that has a summary of your source code images.
- It checks alt tag and displays it for review
- It checks if you include default width and height to render images as faster and conver aspect ratio
- It checks if you fat fingered your filename extension and if so makes suggestion

## Methods

### suggestExtensions
```javascript
const extensions = ['webp', 'png', 'bmp', 'jpg']; // <- short simple list for example purposes
console.log(suggestExtension(extensions, 'jng')); // ['png', 'jpg']
console.log(suggestExtension(extensions, 'wtf')); // ['webp]
console.log(suggestExtension(extensions, 'aaa')); // []
```

*** Looking to convert to: NPM package instead of shell script

```javascript
const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

function writeHtmlFile (directoryPath) {
  if (!fs.existsSync(directoryPath)) {
    throw new Error(`Directory ${directoryPath} does not exist.`);
  }
  if (!fs.lstatSync(directoryPath).isDirectory()) {
    throw new Error(`${directoryPath} is not a directory.`);
  }
  fs.readdir(directoryPath, (err, files) => {
    if (err) throw err;
    const jsxFiles = files.filter(file => path.extname(file) === '.jsx');
    const htmlList = jsxFiles.map(file => {
      const fileContents = fs.readFileSync(path.join(directoryPath, file), 'utf8');
      const $ = cheerio.load(fileContents);
      const imgElements = $('img');
      if (imgElements.length > 0) {
        const imgList = imgElements.map((i, el) => `<li>${$(el).attr('src')}</li>`).get().join('');
        return `<li>${file}<ul>${imgList}</ul></li>`;
      } else {
        return '';
      }
    }).join('');
    const html = `<ul>${htmlList}</ul>`;
    fs.writeFile(path.join(directoryPath, 'image-summary.html'), html, err => {
      if (err) throw err;
      console.log('HTML file has been created successfully!');
    });
  });
}
```
