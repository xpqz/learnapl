⎕IO ← 0
{}⎕SE.UCMD'box on -s=max -t=tree -f=on'
{}⎕SE.UCMD'rows on'
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

where ← 2|data ← ⍳20 ⍝ mod-2 for the whole array at once
where/data

'aeiou' {(⍵∊⍺)/⍵} 'pick out all vowels from a string'

card ← 7 9 9 2 7 3 9 8 7 1 3

⊢body ← (count←¯1+≢card)↑card
⊢check ← ⊢/card

⊢weights ← count⍴(2|count)⌽1 2
⊢products ← body×weights

⊢digits ← 0 10⊤products ⍝ We can think of `0 10⊤` as divmod
⊢sum ← +⌿,digits        ⍝ By raveling, we save doing sum the sum of cols

10|-sum ⍝ Magic

]dinput
luhn ← {
    check ← ⊢/⍵
    body ← (count←¯1+≢⍵)↑⍵
    weights ← count⍴(2|count)⌽1 2
    digits ← 0 10⊤body×weights
    check=10|-+/,digits
}

assert luhn 7 9 9 2 7 3 9 8 7 1 3

⍝ 6 Align '⍒'
'     ⍒'

⍝ 10 Align 'Parade'
'    Parade'

⍝ 8 Align 'Longer Phrase' 'APL' 'Parade'
3 8⍴'Longer P     APL  Parade'

6 {⍺,⍨(2=≡,⍵)/≢,⍵} '⍋'
10 {⍺,⍨(2=≡,⍵)/≢,⍵} 'Parade'
8 {⍺,⍨(2=≡,⍵)/≢,⍵} 'Longer Phrase' 'APL' 'Parade'

data ← 'Parade'
⊢sh ← 10 {⍺,⍨(2=≡,⍵)/≢,⍵} data ⍝ Shape
↑,data                         ⍝ Mix ravel (no change for a char vector)
10↑⍤1⊢↑,data                   ⍝ (over)take, rank-1

data ← 'Longer Phrase' 'APL' 'Parade'
⊢sh ← 8 {⍺,⍨(2=≡,⍵)/≢,⍵} data ⍝ Shape
↑,data                        ⍝ Mix ravel
⊢mat ← 8↑⍤1⊢↑,data            ⍝ (over)take, rank 1

' '=mat

∧\1 1 1 0 0 0 1 0 1 0

⌽∧\⌽' '=mat   ⍝ We're keeping on arraying

⊢data ← ' ABCDEFGHIK'         ⍝ Note: leading space
⊢repl ← 5 1 1 1 1 1 1 1 1 1 1 ⍝ Five spaces, one of everything else
repl/data

trailling ← ⌽∧\⌽' '=mat ⍝ Find trailling spaces, as per above
⊢spaced ← ' ',mat       ⍝ Add a space as the first char of each row
⊢keepers ← ~trailling   ⍝ Everything not a trailling space
⊢padding ← +/trailling  ⍝ Amount of leading padding to be inserted per row
⊢repl ← padding,keepers ⍝ Number of replications per character

repl/⍤1⊢spaced ⍝ Replicate along vectors

]dinput
Align ← {
    shape ← ⍺,⍨(2=≡,⍵)/≢,⍵  ⍝ Shape, as specified
    mat ← ⍺↑⍤1⊢↑,⍵          ⍝ Truncate rank 1
    trailling ← ⌽∧\⌽' '=mat ⍝ Find trailling spaces
    spaced ← ' ',mat        ⍝ Add a space as the first char of each row
    keepers ← ~trailling    ⍝ Everything not a trailling space
    padding ← +/trailling   ⍝ Amount of leading padding to be inserted per row
    repl ← padding,keepers  ⍝ Number of replications per character
    repl/⍤1⊢spaced          ⍝ Replicate rank 1
}

6 Align '⍋'
10 Align 'Parade'
8 Align 'Longer Phrase' 'APL' 'Parade'

{⊃⍵ 'Fizz' 'Buzz' 'FizzBuzz'[+/1 2×0=3 5|⍵]}¨1+⍳16 ⍝ Requires ⎕IO←0

data ← 1+⍳16
⊢fizzbuzz ← 0=3 5∘.|data

⊢mat ← (⍱⌿⍪⊢)fizzbuzz  ⍝ Tacit for {(⍱⌿⍵)⍪⍵} -- column-wise logical NOR as the new first row

mat×@0⍨←data ⍝ Check that out! Modified assignment
mat

mat[↓1,⍤0 0⊢⍸1⌷mat]←⊂'fizz'
mat[↓2,⍤0 0⊢⍸2⌷mat]←⊂'buzz'
mat

0~⍨¨,⌿mat


