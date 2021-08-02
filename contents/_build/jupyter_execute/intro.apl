crt←{m|⍵+.×⍺(⊣×⊢|∘⊃{0=⍵:1 0 ⋄ (⍵∇⍵|⍺)+.×0 1,⍪1,-⌊⍺÷⍵})¨⍨⍺÷⍨m←×/⍺} ⍝ From APL Cart

∇ FizzBuzz end;i
:For i :In ⍳end
    :If 0=15|i
        ⎕←'FizzBuzz'
    :ElseIf 0=3|i
        ⎕←'Fizz'
    :ElseIf 0=5|i
        ⎕←'Buzz'
    :Else
        ⎕←i
    :EndIf
:EndFor
∇

⎕IO ← 0 ⍝ Index origin gets 0

⍝ This line does nothing!

2*5 ⍝ Wait... wot?

2×5

6/2 ⍝....?

20÷4 ⍝ Division is ÷, not /

¯87 ⍝ Note: not -87

2×5+7 

(2×5)+7

a ← (2×5)+7 ⍝ a gets 17. 

a ⍝ Just evaluating the variable returns its value

⊢a ← 42 ⍝ a gets 42, and please evaluate it so I can see the value

⎕ ← a

⎕ ← fiftySeven ← 57
⎕ ← five38 ← 538
⎕ ← My_Variable_Name ← 'hello world'

(a b _ d) ← 3 1 4 1 ⍝ Don't care about the third value
a b d

1 + 1 ⍝ Infix function application, dyadic +

!7 ⍝ Monadic ! is factorial: 1×2×3×4×5×6×7

7×3 ⍝ Dyadic × is multiplication
×¯7 ⍝ Monadic × is 'direction', or signum (the sign, in our case). Thanks.


