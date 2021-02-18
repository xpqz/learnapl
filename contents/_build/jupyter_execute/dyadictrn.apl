⎕IO ← 0
{}⎕SE.UCMD'box on -s=max -t=tree -f=on'
{}⎕SE.UCMD'rows on'

⊢B ← 3 4⍴9 4 2 7 2 5 4 7 8 6 1 2 6 8 2 9
⍉B

1 0⍉B ⍝ Same result as the monadic form: x-is-y

m ← 3 3 3⍴1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3

3 3⍴1 2 3

2 1 0⍉m

⊢data ← ∊9/⊂1 2 3
mat ← 3 3 3⍴0             ⍝ Empty matrix

(2 1 0⍉mat) ← 3 3 3⍴data  
mat

⊢mat ← 6 6⍴⍳36

⊢r4 ← 2 3 2 3⍴mat

0⌷r4

⊢reorder ← 0 2 1 3⍉r4

⊂⍤2⊢reorder


