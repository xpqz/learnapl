⎕IO ← 0

(8⍴2)⊤54 ⍝ Convert a base-10 number to 8-bit binary

2⊥0 0 1 1 0 1 1 0

2∘⊥⍣¯1 ⊢ 54 ⍝ Convert a base-10 number to binary, using the least number of bits

10∘⊥⍣¯1 ⊢ 677398723 ⍝ Number to digit vector

1 24 60 60⊤10000

1 24 60 60⊥1 0 0 0

units ← 'legion' 'cohort' 'century' 'contubernia' 'soldier'
bases ← 10 10 6 10 8

↑units (bases⊤16894)

bases⊥1 0 0 0 0

1⊥⍳10

(1⍳⍨1⊥∘.=⍨) 243 243 243 243 251 243 243 ⍝ Index of "odd one out"

⊥⍨0 1 0 0 1 1 0 1 1 1 1 1

⊢m ← 3 5 ⍴15?15
⊢rav ← ,m

index ← 1 4
⊢k ← (⍴m)⊥index ⍝ 2D to 1D
m[⊂index]
k⊃rav

⊢i j←(⍴m)⊤k ⍝ 1D to 2D


