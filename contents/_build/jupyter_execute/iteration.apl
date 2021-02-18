⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

×⍨¨1+⍳9  ⍝ Square elements via each (but see below!)

×⍨1+⍳9  ⍝ Square elements via scalar extension

⊢V ← (1 2 3 4)(1 2)(3 4 5 6 7)(,2)(5 4 3 2 1)
≢¨V ⍝ Tally-each

+⌿1 2 3 4 5 6 7 8 9 ⍝ sum-reduce integers 1-9

1+2+3+4+5+6+7+8+9

-⌿1 2 3 4 5 6 7 8 9 ⍝ difference-reduction -- take care: right to left fold!

1-2-3-4-5-6-7-8-9

⊢m ← 3 3⍴9?9
+⌿m

+/m

+⌿[1]m

2+⌿1 2 3 4 5 6 7 8 9

+⌿1 2 3 4 5 6 7 8 9
+⍀1 2 3 4 5 6 7 8 9

+⌿1
+⌿1 2
+⌿1 2 3
+⌿1 2 3 4
+⌿1 2 3 4 5
+⌿1 2 3 4 5 6
+⌿1 2 3 4 5 6 7 
+⌿1 2 3 4 5 6 7 8
+⌿1 2 3 4 5 6 7 8 9

2÷⍨⍣=10 ⍝ Divide by 2 until fixpoint

 {⍞ ← ?10}⍣{6=⍺} 0 ⍝ Keep generating random numbers between 1 and 10 until we get a 6

]dinput
Sum ← {
    ⍺ ← 0        ⍝ Left arg defaults to 0 if not given
    0=≢⍵:⍺       ⍝ If right arg is empty, return left arg
    (⍺+⊃⍵)∇1↓⍵   ⍝ Add head to acc, recur over tail
}

⊢mysum ← Sum 1 2 3 4 5 6 7 8 9
assert mysum=+/1 2 3 4 5 6 7 8 9

]dinput
Sscan ← {
    ⍺ ← ⍬              ⍝ Left arg defaults to ⍬ if not given
    0=≢⍵:⍺             ⍝ If right arg is empty, return left arg
    (⍺,⊃⍵+⊃¯1↑⍺)∇1↓⍵   ⍝ Append the sum of the head and the last element of acc and recur on tail
}

⊢myscan ← Sscan 1 2 3 4 5 6 7 8 9
assert myscan≡+⍀1 2 3 4 5 6 7 8 9

]dinput
Fib←{ ⍝ Tail-recursive Fibonacci.
    ⍺ ← 0 1
    ⍵=0:⊃⍺
    (1↓⍺,+/⍺)∇⍵-1
}

Fib¨⍳10 ⍝ The 10 first Fibonacci numbers

⊢nesty ← (1 2 3 (3 4 (5 6)) 7)

-nesty

(1 2) 3 + 4 (5 6)
(1 1⍴5) - 1 (2 3)


