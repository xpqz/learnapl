⎕IO ← 0            ⍝ Index origin is zero
]box on -style=max ⍝ Show boxes at max verbosity
]rows on           ⍝ Don't wrap long output lines

⎕ ← mat ← 3 4⍴12?12 ⍝ Ladies and gentlemen: our matrix

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

⍉mat ⍝ Transpose
⌽mat ⍝ Reverse
⊖mat ⍝ Reverse first

⊖⍤1⊢mat ⍝ Apply reverse-first to second axis using Rank
⊖[1]mat ⍝ Apply reverse-first to second axis bracket-axis

1 2 ¯1 0⊖mat

⎕ ← v ← 'Hello' 'world'
↑v

⎕ ← m ← 3 3⍴9?9
↓m

⎕ ← v ← (0 6 3)(2 5 1)(4 7 8)
↓⍉↑v

↓⍉↑(1 2 3 4)(5 6)(7 8 9 10)

↑(1 2 3 4)(5 6)(7 8 9 10)

1↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 1
2↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 2

0⌷(1 2 3 4)(5 6)(7 8 9 10) ⍝ Squad 0 returns a cell
0⊃(1 2 3 4)(5 6)(7 8 9 10) ⍝ Pick 0 returns an element

¯1↑(1 2 3 4)(5 6)(7 8 9 10) ⍝ Take 1 from the back

1↓(1 2 3 4)(5 6)(7 8 9 10)  ⍝ Drop 1 from the front
¯1↓(1 2 3 4)(5 6)(7 8 9 10) ⍝ Drop 1 from the back

mat
1↑mat ⍝ Take first cell
1↓mat ⍝ Drop first cell

⍳10

⍳3 4

'Hello world'⍳'o'

'Hello world'⍳'od'

⎕ ← staff ← 'Adam' 'Bob' 'Charlotte'
lookup ← staff,⊂'Not found'
lookup[staff⍳'Bob' 'David']

⍸1 0 0 1 0 1 0 1 1 1 0 1 0 1

⎕←nums←⍳20
nums[⍸0=5|nums] ⍝ Find all numbers divisible by 5

3 3⍴1 0 0 1 1 0 0 1 0
⍸3 3⍴1 0 0 1 1 0 0 1 0

⍸0 1 0 2 0 3 0 4 0 5

1 3 5 7 9⍸8 9 0  ⍝ bin 8, 9 and 0 over the intervals 1 3 5 7 9

1 3 5 7 9⍸5      ⍝ elements on on boundary goes in the higher bin

3 5 7 9⍸0 100

'AEIOU'⍸'HELLO WORLD'

ciders←'Kopparberg Sparkling Rose' 'Bulmers Original' 'Crispin the Jacket' 'Old Mout Cherries & Berries'
abv←7.0 4.5 8.3 0.0

code←431 481 487 486
rate←0 40.38 50.71 61.04
limits←1.2 6.9 7.5 8.5

⎕←bin←1+limits⍸abv

]box off
('Name' 'Rate' 'Code')⍪⍉↑(ciders (rate[bin]) (code[bin]))
]box on

simple ← 3 4⍴3 0 5 1 7 9 8 6 2 10 11 4
,simple ⍝ Ravel
∊simple ⍝ Enlist

⎕ ← nested ← ↑((2 3)(4 5))((6 7)(8 9))
,nested ⍝ Ravel
∊nested ⍝ Enlist

1 2 3 4 , 5 6 'hello'
1 2 3 4 5 6 , 'hello'

(3 3⍴⍳9),(3 3⍴⍳9) ⍝ Catenate-last (new cols)
(3 3⍴⍳9)⍪(3 3⍴⍳9) ⍝ Catenate-first/laminate (new rows)

'l'∊'Hello world'

'lo w'∊'Hello world'

'lo'(⍸⍷)'Hello world' ⍝ Index of start of substring

⎕ ← v ← 6 9 5 2 0 9
v↑⍨1     ⍝ Take 1 but commute arguments ⍨

{⍵⊂⍨1,2≠/⍵}
{(1,2≠/⍵)⊂⍵}

=⍨1 2 3 4 5

1 2 3 4 5 = 1 2 3 4 5

tally ← +/=⍨

tally 1 2 3 4 5

1⍨ 2
3 (1⍨) 2
1⍨ 2 3 4 5
1⍨¨ 2 3 4 5

⎕ ← m ← 3 3⍴9?9 
5⍨¨m ⍝ Make an array that looks like m, but will all elements 5

5⍴⍨⍴m

∪1 1 2 2 3 3 4 4 5 5 6 6
∪'hello world'

1 1 2 3 4 ∪ 1 2 5 6

1 1 2 3 4 ∩ 1 2 5 6

1 1 2 3 4 5 ~ 1 3 5

~1 0 1 1 0 0 1

⎕ ← data ← 110 109 204 40 105 201 2 208 160 143 213 31 21 317 132 242 164 176 67 18 75 89 18 7 20
data[⍋data]

⍋data

⎕ ← minidx ← ⊃⍋data ⍝ Index of smallest value: first element of Grade-up
data[minidx]


