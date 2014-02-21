var fs = require('fs'),
    jade = require('jade');


var view = function(file, params) {
    jade.renderFile(file, {
        filename: file,
        pretty: true,
        debug: true,
        compileDebug: true,
        globals: params
    }, function(err, html) {
        document.write(html);
    });
}

window.title = 'Force Tracking';
view('jade/test.jade', ['title']);