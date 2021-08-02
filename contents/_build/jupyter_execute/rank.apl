⎕IO ← 0
]box on
]rows on

]DISPLAY m ← 3 3 3⍴27?27
≢⍴m

1↓[1]m ⍝ Apply drop ↓ to axis 1, i.e. the y-axis, with ⎕IO←0

1↓⍤2⊢m

⎕ ← V ← (1 2 3)(2 2⍴1 1 1 1)(1)

≢⍤1⊢V ⍝ NOTE: this is wrong!

1 2 3,⍤0 1 ⊢ 'hello'

rankpairs ← ⊂⍤,⍥⊂


1 2 3 rankpairs⍤0 1 ⊢ 'hello'

I←⌷⍨∘⊃⍨⍤0 99 ⍝ Sane indexing, a.k.a select

]box on -trains=tree ⍝ Visualise tacit functions as a parse tree

⌷⍨∘⊃⍨⍤0 99

sane←{(⊃⍺)⌷⍵}

3 sane 'abcdefg'

1 2 3 sane⍤0 99⊢'abcdefg'

]DISPLAY A ← 3 4⍴2 1 1 1 1 2 1 1 1 1 2 1
]DISPLAY B ← 3 4⍴1 2 3 4 1 2 3 4 1 2 3 4

A∘//B     ⍝ Nope... SYNTAX ERROR
{A/⍵}/B   ⍝ Nope... RANK ERROR
A∘{⍺/⍵}/B ⍝ Nope... SYNTAX ERROR

A/⍤1⊢B

,t←2 3 4⍴⍳24

,⍤3⊢t
]DISPLAY ,⍤2⊢t
]DISPLAY ,⍤1⊢t

⊂⍤3⊢t
⊂⍤2⊢t
⊂⍤1⊢t

↑ ,¨ ⊂⍤3⊢t
]DISPLAY ↑ ,¨ ⊂⍤2⊢t
]DISPLAY ↑ ,¨ ⊂⍤1⊢t

]DISPLAY +⌿⍤3⊢t
]DISPLAY +⌿⍤2⊢t
]DISPLAY +⌿⍤1⊢t

]DISPLAY ⊖⍤3⊢t
]DISPLAY ⊖⍤2⊢t
]DISPLAY ⊖⍤1⊢t


