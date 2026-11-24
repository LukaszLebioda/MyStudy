// tsc sandbox.ts sandbox.js (sandbox.js can be deleted, will be re-created)
// tsc sandbox.ts (enough if both files are named the same way)
// tsc sandbox.ts --watch (or -w, to watch for changes)

const character = "mario";
console.log(character);

const inputs = document.querySelectorAll("input");
console.log(inputs);
inputs.forEach((input) => {
  console.log(input);
});

let char = "wookie";
let age = 44;
let isStudent = false;

const circ = (diameter: number) => {
  return diameter * Math.PI;
};
console.log(circ(7.5));
