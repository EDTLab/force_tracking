"use strict";

var phidget = require('phidget');
var bridge = new phidget.bridge();

var RIGHT = 0,
    LEFT = 1;
var INTERVAL = 20; // millisecond
var value = 0;

var setter = function (index, gain, callback) {
    if (!bridge.ready) {
        bridge.attach(function (err) {
            console.log('bridge attached');
            bridge.setEnabled(index, true, function (err) {
                console.log('channel ' + index + ' enabled');
                bridge.setGain(index, bridge.GAIN[1], function (err) {
                    console.log('channel ' + index + ' gain set');
                    if (!err) {
                        callback();
                    }
                });
            });
        });
    }
};

var readloop = function (index, interval) {
    if (bridge.ready) {
        bridge.getValue(RIGHT, function (err, val) {
            console.log('channel ' + index + ' value: ' + val);
            if (!err) {
                value = val;
                $('#result').text(value);
            }
        });
    }
    setTimeout(readloop, interval);
};

$(document).ready(function () {
    console.log('document ready');
    setter(RIGHT, bridge.GAIN[1], function () {
        readloop();
    });
});

$(window).unload(function () {
    if (bridge.ready) {
        bridge.close(function (err) {
            //TODO: closing 
        });
    }
});