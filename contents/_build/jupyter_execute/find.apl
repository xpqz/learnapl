⎕IO ← 0
]box on
]rows on

]DISPLAY ↑(2=data)(data ← 4 1 22 20 16 10 25 7 18 11 15 2 12 23 9 17 6 14 21 19 3 8 5 13 24)

⍸2=data ⍝ Where is data = 2?

⎕ ← nested ← (1 2 (3 4 5))(4 (1 2(3 4)))
4=nested

strings ← 'aaa' 'bbb' 'ccc' 'ddd' 'ccc' 'aaa' 'ccc' 'bbb'
'ccc'=strings  ⍝ LENGTH ERROR!

⍸'ccc'∘≡¨strings
⍸(⊂'ccc')≡¨strings

data⍳2

data⍳2 3

⍸∨⌿2 3 ∘.= data

⎕ ← mat ← 4 4⍴2 15 16 14 11 9 12 10 13 1 7 5 4 8 6 3

⎕ ← mask ← 7=mat
⍸mask

'ana' ⍷ 'banana'

substr ← ⍸⍷
'ana' substr 'banana'

]DISPLAY needle ← 2 2⍴0 1 1 0
]DISPLAY haystack ← 4 4⍴0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0

needle ⍷ haystack

needle (⍸⍷) haystack

'll.\sw'⎕S'&' ⊢ 'hello world well  worn'

'he' 'wo' 'll'⎕S'&' ⊢ 'hello world well  worn'

'he' 'wo' 'll'⎕S{⍵.Match}'hello world well  worn'

'(a{2,}|b{2,})'⎕S'\1' ⊢'aaabababbbbbaaaa'

'(a{2,}|b{2,})'⎕S{1⎕C ⍵.Match}'aaabababbbbbaaaa'

'a(.)a'⎕R'A\1A'⊢'abababadabaaba' ⍝ \1 is the first capture group

rsplit ← {(⊢/¨r)↓¨⍵⊂⍨(⍳≢⍵)∊1+⊃¨r←(⍺,'|^')⎕S 0 1⊢⍵} ⍝ APL Cart

'\d+' rsplit 'aaaa6666bbb1cccc999eee87'

'a.'⎕S'&'⊢'abaac' ⍝ Won't return ab aa ac

'(?=(a.))'⎕S'\1'⊢'abaac'

'a.'⎕S'&'⍠'OM'1⊢'abaac' 


