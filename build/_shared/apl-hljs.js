export default function(hljs){
  var NAME = /[A-Za-z_∆⍙][A-Za-z0-9_∆⍙]*/;
  var PRIMITIVE = /[-+×÷*⍟⌹○!?⌈⌊⊥⊤⊣⊢=≠≤<>≥≡≢∨∧⍲⍱↑↓⊂⊃⊆⌷⍋⍒⍳⍸∊⍷∪∩~,⍪⍴⌽⊖⍉→←¨⍨⍣⍠⍤⍥∘.⌸⌺⍢⌶⋄@|⍎⍕\/\\⌿⍀{}()\[\];]/;
  return {
    name: "APL",
    case_insensitive: false,
    contains: [
      hljs.COMMENT(/⍝/, /$/),
      { className: "string", begin: /'/, end: /'/, contains: [{ begin: /''/ }] },
      { className: "meta", begin: /^\s*[\]\)]/, end: /$/, contains: [hljs.COMMENT(/⍝/, /$/)] },
      { className: "built_in", begin: /[⎕⍞][A-Za-z]*/ },
      { className: "variable", begin: /[⍺⍵⍶⍹∇]/ },
      { className: "number", begin: /¯?(?:\d+\.?\d*|\.\d+)(?:[eE]¯?\d+)?(?:[jJ]¯?(?:\d+\.?\d*|\.\d+))?/ },
      { className: "title", begin: NAME },
      { className: "keyword", begin: PRIMITIVE }
    ]
  };
}
