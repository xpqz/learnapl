⎕IO ← 0
{}⎕SE.UCMD'box on -s=max -t=tree -f=on'

⊢mat ← 3 4⍴12?12 ⍝ Ladies and gentlemen: our matrix

≢7 5 1 2 9
≢'Hello world'
≢mat

≡1 2 3 4
≡(1 2)(3 4)
≡((1 2)(2 3))((4 5)(6 7))
≡(1 2)(3 4)3

1 2 3 4 ≡ 1 2 3 4 5
1 2 3 4 ≡ 1 2 3 4
1 2 3 4 ≡ 4 1 2 3
1 2 3 4 ≡ 1 4⍴1 2 3 4

transpose ← ⎕ ← ⍉mat
reverse ← ⎕ ← ⌽mat
revfirst ← ⎕ ← ⊖mat

⊢⊖⍤1⊢mat ⍝ Apply reverse-first to second axis using rank
⊢⊖[1]mat ⍝ Apply reverse-first to second axis bracket-axis

1 2 ¯1 0⊖mat

⊢v ← 'Hello' 'world'
↑v

⊢m ← 3 3⍴9?9
↓m

⊢v ← (0 6 3)(2 5 1)(4 7 8)
↓⍉↑v

↓⍉↑(1 2 3 4)(5 6)(7 8 9 10)

↑(1 2 3 4)(5 6)(7 8 9 10)

1↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 1
2↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 2

0⌷(1 2 3 4)(5 6)(7 8 9 10) ⍝ Squad-0 returns a cell
0⊃(1 2 3 4)(5 6)(7 8 9 10) ⍝ Pick-0 returns an element

¯1↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 1 from the back

1↓(1 2 3 4)(5 6)(7 8 9 10) ⍝ Drop 1 from the front
¯1↓(1 2 3 4)(5 6)(7 8 9 10) ⍝ Drop 1 from the back

mat
1↑mat ⍝ Take first cell
1↓mat ⍝ Drop first cell

⍳10

⍳3 4

'Hello world'⍳'o'

'Hello world'⍳'od'

⊢staff ← 'Adam' 'Bob' 'Charlotte'
lookup ← staff,⊂'Not found'
lookup[staff⍳'Bob' 'David']

simple ← 3 4⍴3 0 5 1 7 9 8 6 2 10 11 4
⊢ravel ← ,simple
⊢enlist ← ∊simple

⊢nested ← ↑((2 3)(4 5))((6 7)(8 9))
⊢ravel ← ,nested
⊢enlist ← ∊nested

1 2 3 4 , 5 6 'hello'
1 2 3 4 5 6 , 'hello'

(3 3⍴⍳9),(3 3⍴⍳9) ⍝ Catenate-last (new cols)
(3 3⍴⍳9)⍪(3 3⍴⍳9) ⍝ Catenate-first/laminate (new rows)

'l'∊'Hello world'

'lo w'∊'Hello world'

'lo'(⍸⍷)'Hello world' ⍝ Index of start of substring

⊢v ← ⍳5
v↑⍨1     ⍝ Take-1 but commute arguments ⍨

{⍵⊂⍨1,2≠/⍵}
{(1,2≠/⍵)⊂⍵}

1⍨42
1⍨¨⍳14

=⍨1 2 3 4 5
1 2 3 4 5 = 1 2 3 4 5

tally ← +/=⍨

tally 1 2 3 4 5

∪1 1 2 2 3 3 4 4 5 5 6 6
∪'hello world'

1 1 2 3 4 ∪ 1 2 5 6

1 1 2 3 4 ∩ 1 2 5 6

1 1 2 3 4 5 ~ 1 3 5

~1 0 1 1 0 0 1

⊢data ← 11 19 24 4 15 21 2 20 10 13 23 3 1 17 12 22 14 16 6 18 5 9 8 7 0
data[⍋data]

⍋data

⊢minidx ← ⊃⍋data ⍝ Index of smallest value: first element of grade-up
data[minidx]
