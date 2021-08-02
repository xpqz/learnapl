⎕IO ← 0
]box on -style=min -trains=tree -fns=on
]rows on
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

⎕ ← Y ← 3 3⍴⍳9
(-⍉)Y ⍝ Tacit
-⍉Y   ⍝ Explicit "beside"

B ← 1 2 3 4 5 6 7
A ← 3 2 6
≢ B ~ A

B (≢~) A

cmp ← >-<

1 cmp 2
1 cmp 1
2 cmp 1

cmp

cmp ← ×- ⍝ Try it!

Split ← {⍵⊆⍨⍺≠⍵}

' ' Split 'A common problem is to split a string into substrings'

Split ← {(⍺≠⍵) ⊆ (⍵)}

Split ← {(⍺≠⍵) ⊆ (⍺⊢⍵)}

2⊢3
⊢5
2⊣3

Split ← ≠⊆⊢

' ' Split 'It should still work the same way'

UnitSum ← ⊢÷+/

UnitSum 1 2 3 4 5 6

UnitSum ← ⊢ ÷ +/

UnitSum ← {⍵÷+/⍵}

UnitSum 1 2 3 4 5 6

6 (⌽+,-,×,÷) 2

⌽+,-,×,÷

f1 ← ×,÷ ⍝ ...fork, (6×2),(6÷2)

⎕ ← r ← 6 (⌽+,-,f1) 2 ⍝ does it still work?
assert r≡6 (⌽+,-,×,÷) 2

f2 ← -,f1 ⍝ ...fork: (6-2),f1 → (6-2),(6×2),(6÷2)

6 (⌽+,f2) 2 

f3 ← +,f2 ⍝ (6+2),(6-2),(6×2),(6÷2)

6 (⌽f3) 2 

⌽ 6 f3 2

6 {⌽(⍺+⍵),(⍺-⍵),(⍺×⍵),⍺÷⍵} 2

minmax ← ⌊/,⌈/
minmax 7 2 3 8 0 9 12

minmax

⎕ ← ones ← ⊢∧(∧⍀∨⍀=⊢) ⍝ Hat tip to Adám Brudzewski for the suggestion

ones 0 0 1 1 1 0 0 0 1 0 1 1 1 0

⎕ ← f1 ← ∨⍀ = ⊢ ⍝ ...monadic fork, giving a dfn equivalent: {(∨⍀⍵)=⍵}

⎕ ← r ← (⊢∧(∧⍀f1)) 0 0 1 1 1 0 0 0 1 0 1 1 1 0
assert r≡ones 0 0 1 1 1 0 0 0 1 0 1 1 1 0 ⍝ still works!

⎕ ← a1 ← ∧⍀f1

(⊢∧a1) 0 0 1 1 1 0 0 0 1 0 1 1 1 0

{⍵∧a1 ⍵} 0 0 1 1 1 0 0 0 1 0 1 1 1 0

{⍵∧∧⍀(∨⍀⍵)=⍵} 0 0 1 1 1 0 0 0 1 0 1 1 1 0

tacit ← ⊢∧(∧⍀∨⍀=⊢)
expl  ← {⍵∧∧⍀(∨⍀⍵)=⍵}

group ← ↓⊃¨,∘⊂⌸⊢/¨ ⍝ Group pairs based on first element
group ⎕←(5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)

group

key ← ⎕←,∘⊂⌸

↓⊃¨key⊢/¨

discloseAll ← ⊃¨
mergeLasts ← ⊢/¨
↓discloseAll key mergeLasts

{↓(discloseAll ⍵) key (mergeLasts ⍵)}  (5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)

{↓(⊃¨⍵) ,∘⊂⌸ ⊢/¨⍵} (5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)

{↓(⊃¨⍵) {⍺,⊂⍵}⌸ ⊢/¨⍵} (5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)

2 (|∘⍳∘≢⊢∘⊂⌸⊢) 'dyaloge'

]box on -style=mid -trains=parens -fns=on

|∘⍳∘≢⊢∘⊂⌸⊢

2 {(⍺|⍳≢⍵) {⊂⍵}⌸ ⍵} 'dyaloge'

]DISPLAY (↑⍴¨∘'⎕')3 0 9 6 2 7 6

]DISPLAY ↑{⍵⍴'⎕'}¨3 0 9 6 2 7 6

trim ← 1↓,⊢⍤/⍨1(⊢∨⌽)0,≠
' ' trim '        hello     world     '

]box on -style=mid -trains=tree -fns=on ⍝ I'm a tree guy!

trim

f ← {1{⍵∨⍺⌽⍵}⍺{0,⍺≠⍵}⍵}
g ← {⍵/⍺}     
trimdfn ← {1↓(⍺,⍵)g⍺f⍵}

' ' trimdfn '        hello     world     '

trim ← {1↓(x∨1⌽x←0,⍺≠⍵)/⍺,⍵}

' ' trim '        hello     world     '

{(1↑⍵),⍎1↓⍵} 'X1234'

((1↑⊢),(⍎(1↓⊢))) 'X1234'

1 ((⊣↑⊢),(⍎(⊣↓⊢))) 'X1234'

1 (↑,(⍎↓)) 'X1234'

1 (↑,∘⍎↓) 'X1234'

↑,(⍎↓)
↑,∘⍎↓

{(1∧⍵)÷1,⍵} 0.75

f1 ← {1∧⍵}
f2 ← {1,⍵}
{(f1 ⍵) ÷ f2 ⍵} 0.75

((1∧⊢)÷1,⊢) 0.75

3 {⍺↓⍵,⍺↑0} ⍳10

⊢,0↑⍨⊣

⎕ ← shift ← ⊣↓⊢,0↑⍨⊣

3 shift ⍳10

↓,0↑⍨⊣

4 {,⍉2⍺⍴⍵} 1 2 3 4 4 3 2 1

4 (∊↑,¨↓) 1 2 3 4 4 3 2 1

1 2 3 4 ,¨ 4 3 2 1

4 {∊(⍺↑⍵),¨(⍺↓⍵)} 1 2 3 4 4 3 2 1

(∊↑,¨↓)

(,∘⍉2@0⍴⊃) (1 2 3 4 4 3 2 1) 4

,∘⍉2@0⍴⊃

2@0⍴⊃

(2@0⍴⊃) (1 2 3 4 4 3 2 1) 4

2@0 ⊢ (1 2 3 4 4 3 2 1) 4

((⍋≢⍴(⍳.5×≢))⊃¨⊂) 1 2 3 4 4 3 2 1 ⍝ Author: @Razetime -- no need for the length
(⊢⌷⍨∘⊂∘⍋∘⍋2|⍳∘≢)  1 2 3 4 4 3 2 1 ⍝ Author: @rak1507  -- no need for the length


