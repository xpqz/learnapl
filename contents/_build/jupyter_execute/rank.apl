⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'

⊢m ← 3 3 3⍴27?27
≢⍴m

1↓[1]m ⍝ Apply drop ↓ to axis 1, i.e. the y-axis, with ⎕IO←0

1↓⍤2⊢m

⊢V ← (1 2 3)(2 2⍴1 1 1 1)(1)

≢⍤1⊢V ⍝ NOTE: this is wrong!

1 2 3,⍤0 1 ⊢ 'hello'

rankpairs ← ⊂⍤,⍥⊂


1 2 3 rankpairs⍤0 1 ⊢ 'hello'

I←⌷⍨∘⊃⍨⍤0 99 ⍝ Sane indexing, a.k.a select

⌷⍨∘⊃⍨⍤0 99

sane←{(⊃⍺)⌷⍵}

3 sane 'abcdefg'

1 2 3 sane⍤0 99⊢'abcdefg'

⊢A ← 3 4⍴2 1 1 1 1 2 1 1 1 1 2 1
⊢B ← 3 4⍴1 2 3 4 1 2 3 4 1 2 3 4

A∘//B     ⍝ Nope... ERROR
{A/⍵}/B   ⍝ Nope... ERROR
A∘{⍺/⍵}/B ⍝ Nope... ERROR

A/⍤1⊢B


