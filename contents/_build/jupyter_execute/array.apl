⎕IO ← 0

⎕ ← data ← (1 2 3 4) (2 5 8 6) (8 6 2 3) (8 7 6 1)

⊃+⌿↑data

↑data

+⌿↑data

⊃+⌿↑data

⍴5

⍝ Some visualisation help, please.
]box on -style=max

⍴5

]box on -style=min

⍬≡⍴5 ⍝ Does zilde match shape of 5?

]DISPLAY 8 5 2 3 ⍝ A vector, yay

]DISPLAY ⍴ 8 5 2 3 ⍝ What's the shape of my vector?

m ← ↑(1 2 3 4)(5 6 7 8)(9 10 11 12)
]DISPLAY m

⍴m

]DISPLAY ⍴⍴m

≢⍴m ⍝ Rank

1 + 1          ⍝ Scalar + scalar
1 + 1 2 3      ⍝ Scalar + vector
1 2 3 + 9 3 2  ⍝ Vector + vector

]DISPLAY 2 4⍴⍳8 ⍝ Reshape vector to 2×4 matrix

]DISPLAY v ← 8 6 2 9     ⍝ Vector of length 4
]DISPLAY m ← 1 4⍴v       ⍝ Reshape vector to 1×4 matrix

≢⍴v
≢⍴m

v≡m ⍝ Does v match m?

v 
m

v≡m ⍝ ?????

⎕ ← m ← 2 4⍴0 1 2 3 4 5 6 7 ⍝ y=2, x=4
⍴m

⎕ ← v ← 1 2 3
⊂v         ⍝ Enclose the vector 1 2 3
v≡⊂v       ⍝ Does the vector v match the enclosed v? Of course not!

≢⍴v  ⍝ Rank of vector should be 1
≢⍴⊂v ⍝ Rank of scalar should be 0

]DISPLAY v ← (1 2 3) (2 3 4) (2 3 4)

v[1] ⍝ Get position 1 -- we get back an enclosed vector

(1 ('hello' 2)) (3 ('world' 4))


