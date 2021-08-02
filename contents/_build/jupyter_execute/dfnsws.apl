'iotag' ⎕CY 'dfns' ⍝ Load the iotag function

10 iotag 20 ⍝ ⍺ to ⍵ inclusive range

20 iotag 10

¯10 iotag ¯20
¯20 iotag ¯10

10 iotag 21 2

10 iotag 21 0.53

'Q' iotag 'H'

'segs' ⎕CY 'dfns'

',;: ' segs 'one,two;three four,;:five,six,'

',;: ' {(~⍵∊⍺)⊆⍵} 'one,two;three four,;:five,six,'

'cmat' 'pmat' ⎕CY 'dfns'

3 cmat 5

↓3{⍵[⍺ cmat⍴⍵]}'abcde'

pmat 4

⎕IO←0
g ← ⎕ ← (1 2)(,2)(1 3)(0 4)(,⍬)

vertices ← 'adam' 'bob' 'charlotte' 'damian' 'erica'

'span' 'stpath' 'scc'⎕CY 'dfns'

show←{↑⍕¨(⍳⍴⍵),¨'→',¨⍵}

show g

st ← g span 0

vertices[st stpath 4]

⎕IO ← 1
⎕ ← graph ← (,2) (1 8) ⍬ (,10) (,9) (,10) (,9) (,2) (5 7) (4 6)

]display ↑(⍳10) (scc graph)


