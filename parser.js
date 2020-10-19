var fs  = require("fs");
var parser = require("./grd");

fs.readFile("entrada1.txt", (err,data) => {
    if(err) throw err;
    parser.parse(data.toString());
});