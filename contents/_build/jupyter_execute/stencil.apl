⎕IO ← 0
]box on
]rows on

gol←{≢⍸⍵}⌺3 3∊¨3+0,¨⊢ ⍝ Generate the next generation

glider ← 3 3⍴0 0 1 1 0 1 0 1 1
dish ← 8 8⍴0
dish[(⊂3 3)+⍸glider]←1
dish

1 4⍴(gol⍣1⊢dish)(gol⍣2⊢dish)(gol⍣3⊢dish)(gol⍣4⊢dish)

{≢⍸⍵} glider

⊂⍤⊢⌺2⊢⍳10

⊂⍤⊢⌺3⊢⍳10

⊂⍤⊢⌺(2 1⍴3 3)⊢⍳10

⊂⍤⊢⌺(2 1⍴2 2)⊢⍳10

⊂⍤⊢⌺(⍪4 4)⊢⍳10

{⊂⍺ ⍵}⌺3 3⊢3 5⍴⎕A ⍝ Show the left argument vector

{⊂⍺↓⍵}⌺3 3⊢3 5⍴⎕A ⍝ Drop all fillers


