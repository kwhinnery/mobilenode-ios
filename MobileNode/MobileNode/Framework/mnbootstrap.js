// Before this code is run, a function __callNativeFunction has been created in
// the global scope automagically.  This is how JS calls out to native code

// Create some of the trappings of the node.js environment, plus a few mobile-
// specific extras
var __callFunction = null,
    __defineFunction = null,
    global = {}, // Node's global object
    console = {}, // Console logging functions
    alert = null, // Trusty dusty UI standby
    // TODO: make this contain more useful information
    process = {
        platform:'ios'
    };

// Populate JS API for standard library functions
(function() {
    // Set up hooks for native code
    var _functions = {};
    __callFunction = function(name, args) {
        var func = _functions[name];
        if (func) {
            func(args);
        }
    };

    __defineFunction = function(name, func) {
        _functions[name] = func;
    };

    // Display a simple UI alert
    alert = function(message) {
        __callNativeFunction('alert', {
            title:'',
            message:message
        });
    };

    // Log to console with NSLog 
    function log(level, message) {
        return  __callNativeFunction('log', {
            level:level,
            message:message
        });
    }

    // Console logging commands
    console.log = function(message) { return log('INFO',message); };
    console.info = function(message) { return log('INFO',message); };
    console.error = function(message) { return log('ERROR',message); };
    console.warn = function(message) { return log('WARN',message); };
     
    // Other node console functions, currently no op
    console.dir = function() {};
    console.time = function() {};
    console.timeEnd = function() {};
    console.trace = function() {};
    console.assert = function() {};
 })();