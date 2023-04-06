# accessibility-compliance
A path on how to make accessibility compliant applications

Currently code scans are limited to checking if images have an alt tag or not.
This was my attempt at trying to significantly speed up the manual review.
As most developers/testers/managers check these things on images only that it renders

so I created a shell script that creates an html file that has a summary of your source code images.
- It checks alt tag and displays it for review
- It checks if you include default width and height to render images as faster and conver aspect ratio
- It checks if you fat fingered your filename extension and if so makes suggestion

