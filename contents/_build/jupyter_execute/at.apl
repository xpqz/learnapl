⎕IO ← 0
]box on
]rows on

0@1 2 3⊢1 1 1 1 1 1 1

(0@1 2 3) 1 1 1 1 1 1 1

'*'@{0 1 1 1 0 0 0 0 0 0 0} 'Hello world' ⍝ Right operand: function returning Boolean array

{5+⍵}@{0=2|⍵} ⍳12

{0=2|⍵} ⍳12 ⍝ Return Boolean mask indicating the even numbers

({0=2|⍵} ⍳12)/⍳12 ⍝ Compress

{5+⍵} 0 2 4 6 8 10 ⍝ Left operand applied to elements selected by right operand

]dinput
_At_ ← { ⍝ Partial @ - left and right operands must be functions, and the right arg a vector
    mutator ← ⍺⍺                   ⍝ Left operand -- function only
    selector ← ⍵⍵                  ⍝ Right operand -- function only
    data ← ⍵                       ⍝ Derived function right argument -- vector only. Note: copy
    mask ← selector data
    selection ← mask/data          ⍝ Compress the data according to boolean mask
    newvals ← mutator selection    ⍝ Mutate our selection
    (mask/data) ← newvals          ⍝ Replace with the mutated values in copy
    data                           ⍝ Return result
}

{5+⍵}_At_{0=2|⍵} ⍳12

]dinput
_At_ ← { ⍝ Partial @ - left and right operands must be functions, and the right arg a vector
    data ← ⍵
    (mask/data) ← ⍺⍺ (mask←⍵⍵ ⍵)/⍵
    data
}

{5+⍵}_At_{0=2|⍵} ⍳12

-@0 2 ⊢ 3 3⍴1 2 3 4 5 6 7 8 9 ⍝ Negate rows 0 and 2: major cells

-@(0 0)(2 2) ⊢ 3 3⍴1 2 3 4 5 6 7 8 9 ⍝ Negate corners of main diagonal by choose indexing

⎕ ← G ← 2 3⍴('Adam' 1)('Bob' 2)('Carl' 3)('Danni' 4)('Eve' 5)('Frank' 6)
'***' ¯999@((0 0)0)((1 2)1)⊢G

' '@(=∘'-') 'Hello-World-One-Two'

{⍵@(1+⍳⍴⍵)⊢0⍴⍨2+⍴⍵} 2 2⍴1 1 1 1 

]DISPLAY array ← ?10 3⍴10
]DISPLAY 1 2 3 4 {⍺⍺(⍵⍵⌷⍨∘⊂⍳)@(∊∘⍺⍺)⍵} 0 10 100 1000 ⊢ array 

A ← 1 2 3 4
B ← 11 22 33 44
C ← 0 1 0 1
(C/⍥,B)@{C}A

(C/B)@{C}A

(C/A) ← C/B

A
