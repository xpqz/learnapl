⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'

∘.×⍨⍳10

∘.<⍨⍳10

(⍳10) <⍤0 1 ⊢ ⍳10

prod ← ∘.×
rank ← ×⍤0 1
X←⍳1000
]runtime -c "X prod X" "X rank X"

⊢A←3 4⍴3 2 0 8 11 7 5 1 4 9 6 10
⊢B←4 3⍴8 10 11 2 4 6 5 1 7 9 3 0
A +.× B

⊢row0col0prod ← A[0;]×B[;0]

+/row0col0prod

+/A[0;]×B[;1]

+/'GATTACA' = 'TATTCAG' ⍝ Equal-then-sum-reduce

'GATTACA' +.= 'TATTCAG'


