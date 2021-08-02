⎕IO ← 0
]box on -s=min
]rows on
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

where ← 2|data ← ⍳20 ⍝ mod-2 for the whole array at once
where/data

'aeiou' {(⍵∊⍺)/⍵} 'pick out all vowels from a string'

'aeiou' (∊⍨⊢⍤/⊢) 'pick out all vowels from a string'

'aeiou' ∩⍨ 'pick out all vowels from a string'

card ← 7 9 9 2 7 3 9 8 7 1 3

⎕ ← body ← (count←¯1+≢card)↑card
⎕ ← check ← ⊢/card

⎕ ← weights ← count⍴(2|count)⌽1 2
⎕ ← products ← body×weights

⎕ ← digits ← 0 10⊤products ⍝ We can think of `0 10⊤` as divmod
⎕ ← sum ← +⌿,digits        ⍝ By raveling, we save doing sum the sum of cols

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

¯1+2*20

e←¯1+2∘*⋄e¨21+⍳9

⍉2∘⊥⍣¯1⍳2*3

1 1 0 {(⍺/⍵)(⍵/⍨~⍺)} 1 1 2 ⍝ compress and compress ~
1 1 0 {(⍵~v)(v←⍺/⍵)} 1 1 2 ⍝ compress and set difference

+/1 1 0×1 1 2

1 1 0 +.× 1 1 2

patterns ← ⍉2∘⊥⍣¯1⍳2*3
patterns +.× 1 1 2

]dinput
Balance ← {
    total ← +/⍵
    2|total: ⍬             ⍝ Sum must be divisible by 2
    psum ← total÷2         ⍝ Our target partition sum
    bitp ← ⍉2∘⊥⍣¯1⍳2*≢⍵    ⍝ All possible bit patterns up to ≢⍵
    idx ← ⍸<\psum=bitp+.×⍵ ⍝ First index of partition sum = target
    ⍬≡idx: ⍬               ⍝ If we have no 1s, there is no solution
    part ← idx⌷bitp        ⍝ Partition corresponding to solution index
    (part/⍵)(⍵/⍨~part)     ⍝ Compress input by solution pattern and inverse
}

Balance 1 1 2

Balance 10 81 98 27 28 5 1 46 63 99 25 39 84 87 76 85 78 64 41 93

]runtime "Balance 10 81 98 27 28 5 1 46 63 99 25 39 84 87 76 85 78 64 41 93"

]dinput
BalanceScalar ← {⎕IO←0     
    total ← +/⍵
    2|total: ⍬             ⍝ Sum must be divisible by 2
    psum ← total÷2         ⍝ Our target partition sum
    data ← ⍵
    bitp ← ↓⍉2∘⊥⍣¯1⍳2*≢⍵   ⍝ Pre-compute the bit patterns
    {                      ⍝ Try one sum after the other, halt on first solution
        0=⍵: ⍬
        patt ← ⍵⊃bitp
        psum=patt+.×data: (patt/data)(data/⍨~patt) ⍝ Exit on first solution found
        ∇¯1+⍵
    } ¯1+≢bitp
}

BalanceScalar 1 1 2

'cmpx'⎕CY'dfns'

d←10 81 98 27 28 5 1 46 63 99 25 39 84 87 76 85 78 64 41 93
cmpx 'Balance d' 'BalanceScalar d'

]dinput
KarmarkarKarp ← {
    sort ← {⍵[;⍋⍵[0;]]}
    (pairs last) ← ⍬ {
        2>≢⍉⍵:⍺ (1 0⌷⍵)
        (i x)(j y) ← ↓⍉⍵[;0 1]
        (⍺,⊂x y)∇sort (2↓⍤1⊢⍵),(i-j) x
    } sort ↑(-⍵)(⍵)
        
    last ⍬ {
        (a b) ← ⍺
        0=≢⍵: ⍺
        pair ← ⊃¯1↑⍵
        a∊⍨⊃pair: (a (b,1⊃pair))∇¯1↓⍵
        ((a,1⊃pair) b)∇¯1↓⍵
    } pairs
}

KarmarkarKarp 10 81 98 27 28 5 1 46 63 99 25 39 84 87 76 85 78 64 41 93

cmpx 'Balance d' 'KarmarkarKarp d'

Balance 4 5 6 7 8
KarmarkarKarp 4 5 6 7 8

template ← '/Users/stefan/template.txt'
⊃⎕NGET template

merge ← '/Users/stefan/merge1.json'
⊃⎕NGET merge

mrg←⎕JSON⊃⎕NGET merge
keys←mrg.⎕NL¯2
vals←mrg.(⍎¨#.keys)
↑keys vals

↑(({'@',(⍕⍵),'@'}¨keys), (⊂'@@'), ⊂'@[^@]+@') ((⍕¨vals), (⊂,'@'), ⊂'???')

]dinput
Merge ← {
    mrg←⎕JSON⊃⎕NGET ⍺
    keys←mrg.⎕NL¯2
    vals←mrg.(⍎¨#.keys)
    
    (({'@',(⍕⍵),'@'}¨keys), (⊂'@@'), ⊂'@[^@]+@')⎕R((⍕¨vals), (⊂,'@'), ⊂'???')⊢⊃⎕NGET ⍵
}

merge Merge template

'@' (=⊂⊢) 'aaaa @bbb@ ccc @@ @ddd@' ⍝ Partitions starting at @

⎕ ← tmpls←'@'(1↓¨=⊂⊢)'aaaa @bbb@ ccc @@ @ddd@' 

(mrg←⎕NS⍬).(bbb ccc ddd) ← 'bees' 'cees' 'dees'

]dinput
val ← {
    0=≢⍵: ,'@'
    ~(⊂⍵)∊mrg.⎕NL¯2: '???'
    ⍕mrg⍎⍵
} 

val¨'bbb' 'ddd' 'ccc' '' 'hubba'

val¨@{1 0 1 0 1 0}⊢tmpls

]dinput
Merge ← {
    mrg ← ⎕JSON⊃⎕NGET ⍺
    templ ← ⊃⎕NGET ⍵
    first ← templ⍳'@'
    first>≢templ: templ    ⍝ No templates at all
    prefix ← first↑templ
    val ← {
        0=≢⍵: ,'@'
        ~(⊂⍵)∊mrg.⎕NL¯2: '???'
        ⍕mrg⍎⍵
    }
    ∊prefix,val¨@{1 0⍴⍨≢⍵}'@'(1↓¨=⊂⊢)templ
}

merge Merge template



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
⎕ ← sh ← 8 {⍺,⍨(2=≡,⍵)/≢,⍵} data ⍝ Shape
↑,data                           ⍝ Mix ravel
⎕ ← mat ← 8↑⍤1⊢↑,data            ⍝ (over)take, rank 1

' '=mat

∧\1 1 1 0 0 0 1 0 1 0

⌽∧\⌽' '=mat   ⍝ We're keeping on arraying

⎕ ← data ← ' ABCDEFGHIK'         ⍝ Note: leading space
⎕ ← repl ← 5 1 1 1 1 1 1 1 1 1 1 ⍝ Five spaces, one of everything else
repl/data

trailing ← ⌽∧\⌽' '=mat     ⍝ Find trailing spaces, as per above
⎕ ← spaced ← ' ',mat       ⍝ Add a space as the first char of each row
⎕ ← keepers ← ~trailing    ⍝ Everything not a trailing space
⎕ ← padding ← +/trailing   ⍝ Amount of leading padding to be inserted per row
⎕ ← repl ← padding,keepers ⍝ Number of replications per character

repl/⍤1⊢spaced ⍝ Replicate along vectors

]dinput
Align ← {
    shape ← ⍺,⍨(2=≡,⍵)/≢,⍵  ⍝ Shape, as specified
    mat ← ⍺↑⍤1⊢↑,⍵          ⍝ Truncate rank 1
    trailing ← ⌽∧\⌽' '=mat  ⍝ Find trailing spaces
    spaced ← ' ',mat        ⍝ Add a space as the first char of each row
    keepers ← ~trailing     ⍝ Everything not a trailing space
    padding ← +/trailing    ⍝ Amount of leading padding to be inserted per row
    repl ← padding,keepers  ⍝ Number of replications per character
    repl/⍤1⊢spaced          ⍝ Replicate rank 1
}

6 Align '⍋'
10 Align 'Parade'
8 Align 'Longer Phrase' 'APL' 'Parade'
8 Align 'K' 'E' 'Iverson'

{∊(3↑(0=3 5|⍵)∪1)/'Fizz' 'Buzz'⍵}¨1+⍳16

data ← 1+⍳16
⎕ ← fizzbuzz ← 0=3 5∘.|data

⎕ ← mat ← (⍱⌿⍪⊢)fizzbuzz  ⍝ Tacit for {(⍱⌿⍵)⍪⍵} -- column-wise logical NOR as the new first row

mat×@0⍨←data ⍝ Check that out! Modified assignment
mat

mat[↓1,⍤0 0⊢⍸1⌷mat]←⊂'fizz'
mat[↓2,⍤0 0⊢⍸2⌷mat]←⊂'buzz'
mat

0~⍨¨,⌿mat


