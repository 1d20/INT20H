var fs = require('fs');
var countries = require('./countries.js');
var country = require('./country.js');
var univ = require('./univ.js');

var c_c = {}

for (key in countries) {
	var c = countries[key].toUpperCase();
	// console.log(c);
	if(country[c]) console.log(country[c]);

	c_c[key] = {code: country[c], name: c.toLowerCase()};
};

fs.writeFile('cc.json', JSON.stringify(c_c));