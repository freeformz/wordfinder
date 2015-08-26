# Find Words!

Finds words in the letters param, limited by length (defaults to 8)

Uses the SOWPODS [dictionary](http://en.wikipedia.org/wiki/SOWPODS)

Source: https://github.com/freeformz/wordfinder

Internet: http://wordfinder.herokuapp.com

## Locally

heroku local

## Examples

curl -F letters=abcd http://localhost:5000/find
["AB","AD","BA","DA","BAD","CAB","CAD","BAC","DAB"]

curl -F letters=abcd -F length=2 http://localhost:5000/find
["AB","AD","BA","DA"]

Dedicated to: @Jamiegirl1
She kicks ass in Hanging With Friends
