⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'

⊢data ← 4 1 22 20 16 10 25 7 18 11 15 2 12 23 9 17 6 14 21 19 3 8 5 13 24
2=data

⍸2=data ⍝ Where is data = 2?

⊢nested ← (1 2 (3 4 5))(4 (1 2(3 4)))
4=nested

data⍳2

data⍳2 3

⍸∨⌿2 3 ∘.= data

⊢mat←4 4⍴2 15 16 14 11 9 12 10 13 1 7 5 4 8 6 3

⊢mask←7=mat
⍸mask

'ana' ⍷ 'banana'

substr ← ⍸⍷
'ana' substr 'banana'

⊢needle ← 2 2⍴0 1 1 0
⊢haystack ← 4 4⍴0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0

needle ⍷ haystack

needle (⍸⍷) haystack

('ll.\sw'⎕S'&')'hello world well  worn'

'he' 'wo' 'll'⎕S'&' ⊢ 'hello world well  worn'

'he' 'wo' 'll'⎕S{⍵.Match} ⊢ 'hello world well  worn'

groups←{⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)} ⍝ This is worth remembering!

'(a{2,}|b{2,})'⎕S groups 'aaabababbbbbaaaa'

'(a{2,}|b{2,})'⎕S{≢⊃⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)}'aaabababbbbbaaaa'

'a.a'⎕R'AXA'⊢'abababadabaaba'

'a(.)a'⎕R'A\1A'⊢'abababadabaaba' ⍝ \1 is the first capture group


