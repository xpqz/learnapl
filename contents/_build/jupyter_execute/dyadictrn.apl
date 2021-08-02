⎕IO ← 0
]box on -style=max
]rows on
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

⎕ ← B ← 3 4⍴9 4 2 7 2 5 4 7 8 6 1 2 6 8 2 9
⍉B

1 0⍉B ⍝ Same result as the monadic form: x-is-y

m ← 3 3 3⍴1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3

3 3⍴1 2 3

2 1 0⍉m

⎕ ← data ← ∊9/⊂1 2 3
mat ← 3 3 3⍴0             ⍝ Empty matrix

(2 1 0⍉mat) ← 3 3 3⍴data  
mat

⎕ ← mat ← 6 6⍴⍳36

⎕ ← r4 ← 2 3 2 3⍴mat

0⌷r4

⎕ ← reorder ← 0 2 1 3⍉r4

⊂⍤2⊢reorder

4 4 4⍴'FLIVFLIVLLIVLLMVSPTASPTASPTASPTAYHNDYHND.QKE.QKECRSGCRSG.RRGWRRG'

0 2 1⍉4 4 4⍴'FLIVFLIVLLIVLLMVSPTASPTASPTASPTAYHNDYHND.QKE.QKECRSGCRSG.RRGWRRG'

0 2 1⍉⍉4 4 4⍴'FLIVFLIVLLIVLLMVSPTASPTASPTASPTAYHNDYHND.QKE.QKECRSGCRSG.RRGWRRG'

codon ← 0 2 1⍉⍉4 4 4⍴'FLIVFLIVLLIVLLMVSPTASPTASPTASPTAYHNDYHND.QKE.QKECRSGCRSG.RRGWRRG'

]dinput
prot ← {
    enc ← 0 1 2 3['UCAG'⍳⍵]        ⍝ Convert RNA string from UCAG to 0123
    ¯1↓codon[⊂⍤1⊢(3÷⍨≢enc) 3⍴enc]  ⍝ Group into triplets and index into codon table, and drop Stop.
}

test ← 'AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA'
⎕ ← r ← prot test
assert 'MAMAPRTEINSTRING'≡r

⎕IO ← 0
sales ← ?10 25 12⍴250

year ← 6
month ← 3
sales[year;;month] ⍝ Sales figures for month/year

year month⌷0 2 1⍉sales

⊢employee_of_the_month←⊃⍒year month⌷0 2 1⍉sales

month year⌷1 2 0⍉sales

⊢data←⍳45

⎕ ← m←(9÷⍨≢data) 9⍴data
↑(m[;0 1 2])(m[;3 4 5])(m[;6 7 8])

3 5 3⍴data

5 3 3⍴data

1 0 2⍉5 3 3⍴data

⍴5 3 3⍴data

⍴1 0 2⍉5 3 3⍴data

⍴2 0 1⍉5 3 3⍴data ⍝ SURPRISE!


