⎕IO ← 0

]box on

⎕ ← v ← 9 2 6 3 5 8 7 4 0 1
v[5]    ⍝ Grab the cell at index 5

v[5 2]  ⍝ Grab the cells at indices 5 and 2

v[3] ← ¯1
v

]DISPLAY m ← 3 3⍴4 1 6 5 2 9 7 8 3 ⍝ a 3×3 matrix
m[1;1]  ⍝ Row 1, col 1
m[1;]   ⍝ Row 1
m[;1]   ⍝ Col 1

m[⊂1 1] ⍝ Centre

m[(0 0)(1 1)(2 2)] ⍝ Three points along the main diagonal

⎕ ← m ← 3 3⍴(1 2 3)(3 2 1)(4 5 6)(5 3 1)(5 6 8)(7 1 2)(4 3 9)(3 7 6)(4 5 1)

]DISPLAY m[1;1] ⍝ Note the returned enclosure.

⎕ ← m ← 3 3⍴(1 2 3)(3 2 1)(4 5 6)(5 3 1)(5 6 8)(7 1 2)(4 3 9)(3 7 6)(4 5 1)

1⌷m       ⍝ Row 1

1 1⌷m     ⍝ Cell 1 1

(⊂1 2)⌷m  ⍝ Rows 1 and 2

2⌷[1]m

2⌷⍉m

n ← 3 3⍴4 1 6 5 2 9 7 8 3

n[⊂1 1] ⍝ Centre

n[(0 0)(1 1)(2 2)] ⍝ Three points along the main diagonal

1 1⌷n ⍝ Centre

(⊂1 1)⌷n ⍝ Repeat row 1

I←⌷⍨∘⊃⍨⍤0 99 ⍝ Sane indexing

⎕ ← m ← 3 3⍴(1 2 3)(3 2 1)(4 5 6)(5 3 1)(5 6 8)(7 1 2)(4 3 9)(3 7 6)(4 5 1)

1 2I m   ⍝ Sane:  select leading axis cells 1 and 2, or m[1 2;]
1 2⌷ m   ⍝ Squad: select m[⊂1 2]

(⊂1 2)I m  ⍝ Sane:  select m[⊂1 2]
(⊂1 2)⌷ m  ⍝ Squad: select m[1 2;]

(0 0)(1 2)(2 2)I m ⍝ Multiple cells by index, like m[(0 0)(1 2)(2 2)]

data   ← 0 1 2 3 4 5 6 7 8 9
select ← 0 0 1 0 1 1 0 1 1 0 ⍝ Select elements 2, 4, 5, 7 and 8
select/data

select ← 1 3 0 0 5 0 7 0 0 1
select/data

m ← 3 3⍴9?9
]DISPLAY m

select ← 0 1 0

select⌿m ⍝ Replicate first

select/m ⍝ Replicate

⎕ ← m ← 3 3⍴(1 2 3)(3 2 1)(4 5 6)(5 3 1)(5 6 8)(7 1 2)(4 3 9)(3 7 6)(4 5 1)

(⊂1 1)⊃m

⊃m

⎕ ← G ← 2 3⍴('Adam' 1)('Bob' 2)('Carl' 3)('Danni' 4)('Eve' 5)('Frank' 6)
G[⊂(0 1)0] ⍝ First element of the vector nested at ⊂0 1 of G
G[((0 0)0)((1 2)1)]

]DISPLAY m ← 3 3⍴9?9
(0 0⍉m) ← ¯1 ¯1 ¯1 ⍝ 0 0⍉m is the main diagonal.
]DISPLAY m

data   ← 0 1 2 3 4 5 6 7 8 9
select ← 0 0 1 0 1 1 0 1 1 0

(select/data) ← ¯1 ¯1 ¯1 ¯1 ¯1
data

⎕ ← s ← 'This is a string'
(2↑s) ← '**'
s

s←'This' 'is' (,'a') 'string' 'without' 'is.'
((s='i')/¨s)←'*'
s
