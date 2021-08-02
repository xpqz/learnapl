⎕IO ← 0
]box on
]rows on

∘.×⍨⍳10

∘.<⍨⍳10

(⍳10) <⍤0 1 ⊢ ⍳10

prod ← ∘.×
rank ← ×⍤0 1
x←⍳1000
]runtime -c "x prod x" "x rank x"

(2=+⌿0=x∘.|x)/x←⍳20

]DISPLAY A ← 3 4⍴3 2 0 8 11 7 5 1 4 9 6 10
]DISPLAY B ← 4 3⍴8 10 11 2 4 6 5 1 7 9 3 0
]DISPLAY A +.× B

⎕ ← row0col0prod ← A[0;]×B[;0]

+/row0col0prod

+/A[0;]×B[;1]

+/'GATTACA' = 'TATTCAG' ⍝ Equal-then-sum-reduce

'GATTACA' +.= 'TATTCAG'

data ← 19083 17341 19657 16896 16197 18256

prob ← 1 1 1 0.75 0.5 0

2×data+.×prob ⍝ Same as 2× +/ data×prob

X ← {f←⍺⍺ ⋄ ⍺←⊢ ⋄ '(',⍺,(⎕CR'f'),⍵,')'} ⍝ The product eXplanation operator

]DISPLAY A ← 2 3⍴6?20
]DISPLAY B ← 3 2⍴6?20
]DISPLAY A +.× B

A +X.(×X) B


