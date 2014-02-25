"use strict";

var phidget = require('phidget'),
    bridge = new phidget.bridge();

var phidgetHandler = function () {
    var bridge = new phidget.bridge(),
        RIGHT = 0,
        LEFT = 1,
        INTERVAL = 20, // millisecond
        value = 0,

        setter = function (index, gain, callback) {
            if (!bridge.ready) {
                bridge.attach(function (err) {
                    console.log("bridge attached");
                    bridge.setEnabled(index, true, function (err) {
                        bridge.setGain(index, bridge.GAIN[1], function (err) {
                            if (!err) {
                                callback();
                            }
                        });
                    });
                });
            }
        },

        readloop = function (index, interval) {
            if (bridge.ready) {
                bridge.getValue(RIGHT, function (err, val) {
                    if (!err) {
                        value = val;
                    }
                });
            }
            setTimeout(readloop, interval);
        },

        getValue = function () {
        }

        end = function () {
            if (bridge.ready) {
                bridge.close(function (err) {
                    //TODO: closing 
                });
            }
        };

    console.log("bang bang");
    setter(RIGHT, bridge.GAIN[1], function (err) {
        if (!err) {
            console.log("phidgetHandler initialized");
        }
    });

    return this;
};

angular.module('phidget.bridge', [])
	.factory('bridge', function ($rootScope) {
        return function (index
    });