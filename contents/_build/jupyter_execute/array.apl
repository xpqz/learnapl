⍴5

⍝ Some visualisation help, please. We'll use these settings from now on in.
⎕IO ← 0
]box on -s=max -t=tree -f=on
]rows on
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

⍴5

]box on -s=min -t=tree -f=on

⍬≡⍴5 ⍝ Does zilde match shape of 5?

]DISPLAY 8 5 2 3 ⍝ A vector, yay

]DISPLAY ⍴ 8 5 2 3 ⍝ What's the shape of my vector?

⊢m ← ↑(1 2 3 4)(5 6 7 8)(9 10 11 12)

⍴m

]DISPLAY ⍴⍴m
≢⍴m ⍝ rank

1 + 1          ⍝ Scalar + scalar
1 + 1 2 3      ⍝ Scalar + vector
1 2 3 + 9 3 2  ⍝ Vector + vector

]DISPLAY 2 4⍴⍳8 ⍝ Reshape vector to 2×4 matrix

]DISPLAY ⊢v ← ⍳4     ⍝ Vector of length 4
]DISPLAY ⊢m ← 1 4⍴⍳4 ⍝ Reshape vector to 1×4 matrix

≢⍴v
≢⍴m

v≡m ⍝ Does v match m?

v 
m

v≡m ⍝ ?????

⊢m ← 2 4⍴⍳8 ⍝ y=2, x=4
⍴m

⊢v ← 1 2 3
⊂v         ⍝ Enclose the vector 1 2 3
v≡⊂v       ⍝ Does the vector v match the enclosed v? Of course not!

≢⍴v  ⍝ Rank of vector should be 1
≢⍴⊂v ⍝ Rank of scalar should be 0

⊢v ← (1 2 3) (2 3 4) (2 3 4)

v[1] ⍝ Get position 1 -- we get back an enclosed vector

(1 ('hello' 2)) (3 ('world' 4))


