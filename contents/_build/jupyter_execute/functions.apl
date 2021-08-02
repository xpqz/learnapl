⎕IO ← 0
]box on
]rows on

assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

]dinput
MyFirstFunction ← {
    ⍝ Add left and right
    ⍺+⍵
}

32 MyFirstFunction 98

]dinput
Sum ← {
    ⍝ Add left and right
    total ← ⍺+⍵
    total
}

32 Sum 98

{⍺←¯99 ⋄ ⍺+⍵} 99
57 {⍺←¯99 ⋄ ⍺+⍵} 99

{⍺←¯99 ⋄ ⍺←¯999999 ⋄ ⍺+⍵} 99

]dinput
sum ← {
    ⍺ ← 0       ⍝ Initialise the accumulator
    0=≢⍵:⍺      ⍝ If right arg empty vector, return accumulator, see below!
    (⍺+⊃⍵)∇1↓⍵  ⍝ Add head to accumulator, recurse over tail
}

sum ⍳10
100 sum ⍳10

]dinput
Palinish ← {
    rev ← ⊖⍵ ⍝ Reverse the right arg
    rev≡⍵: 1 ⍝ If right arg matches its own reverse, return 1
    0        ⍝ Else, return 0
}

Palinish 1 2 3 2 1
Palinish 1 2 3 4 5
Palinish 3

{⍵≡⊖⍵} 1 2 3 2 1 ⍝ Anonymous (unnamed) version

foo ← {47>flerp ⍵: 92+flumm ⍵ ⋄ 57+8} ⍝ Note: diamond separator

]dinput
foo ← {
    answer ← ⍵
    a ← {⍵:42 ⋄ ¯99} answer
    ⍝ ...execution follows here
    ⍝ do something with a
}

]dinput
foo ← {⎕IO←0
    answer ← ⍵
    a ← answer⊃¯99 42
    ⍝ ...execution follows here
    ⍝ do something with a
}

]dinput
foo←{
    a←45
    _←{a←¯99⋄⍬}⍬
    a
}

foo ⍬ ⍝ Note: 45, not ¯99

]dinput
foo ← {
    a ← 45
    _ ← {a +← 45 ⋄ ⍬}⍬
    a
}

⊢r ← foo ⍬
assert r=90

]dinput
foo ← {
    a ← 45
    _ ← {a ⊢← ¯99 ⋄ ⍬}⍬
    a
}

⎕ ← r ← foo ⍬
assert r=¯99

]dinput
foo ← {
    a ← 3 3⍴1 ⍝ 3×3 matrix of all 1
    _ ← {a[1;1] ← 0 ⋄ ⍬}⍬
    a
}

⊢r ← foo ⍬
assert r≡3 3⍴1 1 1 1 0 1 1 1 1 

2 (+/) ⍳10 ⍝ Parentheses not required, added for illustrative purposes

sumred ← +/
2 sumred ⍳10

]dinput
foldl ← {                 ⍝ Fold (reduce) from the left.
    ⍺ ← ⊃0⍴⍵              ⍝ Default initial value for accumulator
    ↑⍺⍺⍨/(⌽⍵),⊂⍺        
}

+foldl ⍳10
+/⍳10
-foldl ⍳10
-/⍳10

99 +foldl ⍳10


