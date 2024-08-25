"use strict";
let s = "kujbkjbkj jhkjh fffv$"
console.log(s.length)

function o(str, pattern) {

    return str.replace(new RegExp(pattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + "+$"), "");
}

s = o(s, "$")
console.log(s.length)

console.log(s)