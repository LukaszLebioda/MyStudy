// tsc sandbox.ts sandbox.js (sandbox.js can be deleted, will be re-created)
// tsc sandbox.ts (enough if both files are named the same way)
// tsc sandbox.ts --watch (or -w, to watch for changes)
var character = "mario";
console.log(character);
var inputs = document.querySelectorAll("input");
console.log(inputs);
inputs.forEach(function (input) {
    console.log(input);
});
var char = "wookie";
var age = 44;
var isStudent = false;
var circ = function (diameter) {
    return diameter * Math.PI;
};
console.log(circ(7.5));
