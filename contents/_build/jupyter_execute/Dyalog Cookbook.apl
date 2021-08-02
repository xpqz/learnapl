⎕IO←1 ⍝ one-based indexing (this is the default, but let's be explicit)
]box on -style=max -trains=tree -fns=on ⍝ Pass all output through DISPLAY

⍝ Get all words. The config-string '&' returns the matched string.
'\w+' ⎕S '&' ⊣ 'the cat sat on the mat'

⍝ Reverse each word
'\w+' ⎕S {⌽⍵.Match} ⊣ 'the cat sat on the mat'

⍝ Capture groups
'c([^t]+)t' ⎕S '\1' ⊣ 'The cabriolet parked on the road'

⊃,/'(hello|goodbye)\s+(\d+)\s+(\d+)'⎕S{⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)} ⊢ 'hello 123 456'

RegexGroups←{⊃,/⍺⎕S{⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)} ⊢ ⍵}

'[si]'⎕R'S' ⊢ 'mississippi'

's'⎕R'S'⍠'ML' 2 ⊢ 'mississippi' ⍝ Set the "match limit" to 2, with the variant operator ⍠

{⊃('.+' ⎕S '\u0')⍵} 'Hello All People in The World' ⍝ Upper-case a string

RegSplit←{⊃{⍵/⍨⍺∨¯1⌽⍺}/↓⍉↑('(.*?)',⍺)'(.*?)$'⎕S{⍵.((~PatternNum)(Lengths[2]↑Offsets[2]↓Block))}⊢⍵}
RegSplit2←{(⊢/¨r)↓¨⍵⊂⍨(⍳≢⍵)∊1+⊃¨r←(⍺,'|^')⎕S 0 1⊢⍵} ⍝ faster

'/+' RegSplit 'Here///be/dragons/'  ⍝ Note empty last item in result
'/+' RegSplit2 'Here///be/dragons/'  ⍝ Note empty last item in result

'(?|.*#(\d+).*|.*:(\d\d)).*'⎕r'\1'⊢'[1518-02-15 23:58] Guard #3557 begins shift' '[1518-02-16 00:33] falls asleep'

{⊃⍵ 'Fizz' 'Buzz' 'FizzBuzz'[⎕IO++/1 2×0=3 5|⍵]}¨⍳16

{3 5|⍵}¨10 11 15 ⍝ Return length 2 vector with remainder from div by 3 and 5

{0= 3 5|⍵}¨10 11 15 ⍝ Return length 2 vector with remainder from div by 3 and 5, highlighing zeros

{1 2× 0= 3 5| ⍵}¨10 11 15 ⍝ ...multiplied by 1 and 2

{⎕IO++/1 2× 0= 3 5|⍵}¨10 11 15 ⍝ ...multiplied by 1 and 2, and summed

{⊃⍵ 'Fizz' 'Buzz' 'FizzBuzz'[⎕IO++/ 1 2× 0= 3 5| ⍵]} ¨ 3 10 11 15

]dinput
FizzBuzz←{
    nums←⍳⍵
    mat←(⍱⌿⍪⊢)0=3 5∘.|nums  ⍝ Remainder matrix
    mat×@1⍨←nums            ⍝ Multiply first row by the source numbers
    mat←(⊂'Fizz')@⊢@2⊢mat   ⍝ Replace any 1s in second row by Fizz
    mat←(⊂'Buzz')@⊢@3⊢mat   ⍝ Replace any 1s in third row by Buzz
    0~⍨¨,⌿mat               ⍝ Merge downwards and remove any zeros
}

FizzBuzz 16

1(↑,∘⍎↓)'X1234' ⍝ Drop the first char, evaluate the rest, and catenate the first char.

(⊃,∘⍎∩∘⎕D)'X4234' ⍝ safer, but can throw an error.

⎕D

1(↑,2⊃∘⎕VFI↓)'X1234' 

2⊃'x'⎕VFI'19x29x21'

{a←1↑⍵ ⋄ b←⍎1↓⍵ ⋄ a,b} 'X1234' ⍝ Take head, eval tail

{(1↑⍵),(⍎1↓⍵)} 'X1234'         ⍝ substitute variables
1 {(⍺↑⍵),(⍎⍺↓⍵)} 'X1234'       ⍝ break out 1
1 ((⊣↑⊢),(⍎⊣↓⊢)) 'X1234'       ⍝ train
1 ((↑),(⍎↓)) 'X1234'           ⍝ simplify
1 (↑,∘⍎↓) 'X1234'              ⍝ remove parens

partition←{⍵⊂⍨1,2≠/⍵}
partition 1 1 1 1 1 2 2 1 4 4 4 4 1 1 2 2

≢¨partition 1 1 1 1 1 2 2 1 4 4 4 4 1 1 2 2

{+\1 ¯1 0['()'⍳⍵]} '((2×3)+4)' 

{+\-⌿'()'∘.=⍵} '((2×3)+4)'  ⍝ Match brackets

'()'∘.='((2×3)+4)'

-⌿'()'∘.='((2×3)+4)'

+\-⌿'()'∘.='((2×3)+4)'

⍝ Zips -- remix is basically zip 
Zip←↓⍉↑
PythonZip←↓∘⍉∘↑(⌊⌿≢¨)↑¨⊢  ⍝ Python's behaviour is to only zip to shortest vector if unmatched
PythonZip2←↓(⌊/≢¨)↑⍉∘↑

NotUnzip←|∘⍳∘≢⊢∘⊂⌸⊢                                    ⍝ 2 Unzip 'dyalog' NB: Not really unzip as such

Split←≠⊆⊢                                           ⍝ Split string on a char

MSplit←(~∊⍨)⊆⊢                                      ⍝ Multi-char split

RegSplit←{(⊢/¨r)↓¨⍵⊂⍨(⍳≢⍵)∊1+⊃¨r←(⍺,'|^')⎕S 0 1⊢⍵}  ⍝ Split string on a pattern

RegexGroups←{⍺⎕S{⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)} ⊢ ⍵} ⍝ Return all capture groups as a vector

Range←⊣+∘⍳-⍨                                        ⍝ start Range end, but see dfns.iotag instead

Replace←' '@(=∘'-')⊢

Foldl←{↑⍺⍺⍨/(⌽⍵),⊂⍺}                                ⍝ 0 + Foldl 1 2 3 4 5 ⍝ Must give initial accumulator state

Flatten←{⊃,/,⊆¨⍵}⍣≡

Filter←{⍵/⍨⍺⍺ ⍵}                                    ⍝ Simple list only: {⍵<10} Filter 1 2 55 27 11 6 5 0

FilterNested←{⍵/⍨⍺⍺¨⍵}                             

Pairs←{,⍳⍵ ⍵}

OverlappingPairs←{{⊂⍵}⌺2 ⊢ ⍵}

Balance←{+\-⌿⍺∘.=⍵}                                 ⍝ '()' Balance '(a+b+(1-c))'

Normalise←⊢÷+/                                      ⍝ Make vector components sum to 1

Divisors←{⍵=1:,1⋄∊∘.×/{⍺∘.*0,⍳⍵}⌿2 dfns.pco ⍵}

DivisiorSum←{×/{(¯1+⍺*⍵+1)÷⍺-1}⌿2 dfns.pco ⍵}       ⍝ A.k.a sigma1

SortByCol←{⍵[⍋⍵[;⍺];]}                              ⍝ col SortByCol mat

Convert←{6::⍵⋄⍎⍵}                                   ⍝ Note -- unsafe

]dinput
Cmb←{                                               ⍝ Find all combinations of N numbers ∊⍳M that sum to M
    (num total)←⍵
    A←⊃∘.+/(num-1)⍴⊂⍳total
    ⊃,/{⍵,¨⍸(total-⍵)=A}¨⍳total
}

ConvToIdx←∪⍳⊢                                       ⍝ convert strings to IDs

ConvToDigits←10∘⊥⍣¯1                                ⍝ Split a number into a vector of digits

IsNumber←{(1=2|⎕DR)⍵}                               ⍝ Are we numeric?
IsString←⍕≡⊢                                        ⍝ Are we a simple character vector?
IsNamespace←{(326=⎕DR⍵)}                            ⍝ Are we a reference/object/namespace?

Substring←⍸⍷                                        ⍝ 'll' (⍸⍷) 'hello' ⍝ 3

Del←{⍵/⍨0@⍺⊢1⍨¨⍵}                                   ⍝ 2 5 Del ⍳10 ⍝ remove indices ⍺ from array ⍵

Group←↓⊃¨,∘⊂⌸⊢/¨                                    ⍝ Group vector elements based on first

GroupSplit←{⍵⊆⍨×≢¨⍵}                                ⍝ Group vector elements separated by empty

BinaryCombos←{⍉(⍵⍴2)⊤⍳2*⍵}                          ⍝ All binary combinations of ⍵ bits

ExtractNumbers←⍎¨∊∘⎕d⊆⊢

4 {3::'out of bounds' ⋄ ⍺ ⌷ ⍵} 1 2 3 4 5 6 7

8 {3::'out of bounds' ⋄ ⍺ ⌷ ⍵} 1 2 3 4 5 6 7

]dinput
F1←{ ⍝ Can you spot the bug?
    11::nums
    nums←1 ⍺
    nums×÷⍵
}

]dinput
F2←{
    nums←1 ⍺
    0=⍵:nums
    nums×÷⍵
}

4 F2 0 ⍝ The expected behaviour

4 F1 0 ⍝ Throws a perhaps unexpected VALUE ERROR

⊃(∪~∩)/ (1 2 3 4 5 6) (4 5 6 7 8) ⍝ Elements in ⍺ or ⍵ but not in both

10 10 10 10 10 ⊤ 12

0 24 60 60 ⊤ 8473

0 24 60 60 ⊥ 0 2 21 13 

12 ⊤⍨ 5⍴10 ⍝ instead of (5⍴10) ⊤ 12

1⊥1 3 2 5 6

⍝ Construct a vector of the sum and product of two numbers
2 (+,×) 5  ⍝ x (F G H) y -> (x F y) G (x H y)

',' (≠⊆⊢) 'one,two,three'

Lhs ← ','≠'one,two,three'  ⍝ Binary match vector
Rhs ← ','⊢'one,two,three'  ⍝ Just return the right-hand argument
Lhs ⊆ Rhs                  ⍝ Partition based on binary match vector

(+/÷≢) 3 6 4 9

Lhs ← +/ 3 6 4 9   ⍝ Sum 
Rhs ← ≢ 3 6 4 9    ⍝ Count
Lhs ÷ Rhs          ⍝ Mean

⊃(∪~∩)/ (1 2 3 4 5 6) (4 5 6 7 8)

¯1+5 (⊣+∘⍳-⍨) 10

2 (|∘⍳∘≢⊢∘⊂⌸⊢) 'dyaloge'

m←(5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)
(↓⊃¨,∘⊂⌸⊢/¨)m

'Left'⊣'Right' ⋄ 'Left'⊢'Right'

',' (≠⊆⊢) 'one,two,three'

mem ← 1 2 3 4 5
mem ⊣ mem[1 2] ← 10 10

⎕←m←2 3⍴1 2 3 4 5 6 7 8 9
⎕←first←⊣/m
⎕←last←⊢/m

v←⍳10
v[5]
v[5 2]
3⌷v

v←(1 2 3)(4 5 6)(7 8 9)
v[1]  ⍝ Return the box at element 1

⊃v[1]  ⍝ Open box (disclose)
1⊃v    ⍝ Pick element at 1

v[2]←1 2 3 ⍝ Will fail with LENGTH ERROR, as value isn't boxed.

v[2]←⊂1 2 3
v

9 9 @ 3 4 ⊢ vec←1 2 3 4 5 6 7 8             ⍝ Note -- no mutation
vec 

vec ⊣ vec[4 5] ← 8 8          ⍝ Note -- direct assignment mutates v

(-@2 5)10 20 30 40 50 60  ⍝ Apply monadic - at positions 2 and 5

7(+@2 5)10 20 30 40 50 60 

'x'@(∊∘⎕A)'Hello World' ⍝ Replace all uppercase letters with 'x'. ⎕A gives the uppercase letters.

'*'@(2∘|) 1 2 3 4 5     ⍝ Replace odds with '*'

'*'@{1 0 1 0 1}1 2 3 4 5

mat←↑{(⍵ 1) (0 0)}¨3+⍳5  ⍝ Start state: a 5x2 matrix, columns are vectors
vals←⍳5                ⍝ Values to append to the first column
rows←?⍨5               ⍝ ...of these rows

(,¨∘vals)@(rows,¨1)⊢mat

rows
rows,¨1

{⍵,¨vals} mat[rows,¨1]

array←?10 3⍴10
specific←1 2 3 4
replacements←0 10 100 1000

{replacements[specific⍳⍵]}@{⍵∊specific} array

Repl←{⍺⍺(⍵⍵⌷⍨∘⊂⍳)@(∊∘⍺⍺)⍵}
specific Repl replacements ⊢ array

⎕←mat←3 4⍴?⍳12

2↑⍤1⊢mat        ⍝ Two first, as proper columns
mat[;1 2]       ⍝ Brackets, as proper columns
(⊂1 2)⌷[2]mat   ⍝ Using squad ⌷, somewhat clumsily

keys←(0 0)(0 1)(3 2)
keys ⍳ (⊂0 1)

find←keys∘⍳
find ⊂0 9

pairs ← {,(⍳⍵)∘.,⍳⍵}  ⍝ Python [[x, y] for x in range(1,n+1) for y in range(1,n+1)]
pairs 3

pairs ← {,⍳⍵ ⍵}
pairs 3

1 2 3 4,¨5 6 7 8

↓⍉↑(1 2 3 4)(5 6 7 8)

(~R∊R∘.×R)/R←1↓⍳100

sum←{⍺+⍵}
add5←5∘sum

add5 7

add5 1 2 3 4 5 6 7

{⊂⍵}⌺(⍪2 2) ⊢ ⍳10

,⌿⍉5 2 ⍴ ⍳10

↓5 2 ⍴ ⍳10

{⊂⍵}⌺2 ⊢ ⍳10

foldl←{↑⍺⍺⍨/(⌽⍵),⊂⍺}

0 + foldl 1 2 3 4 5 ⍝ Must give initial accumulator state

¯1+5 {⍺↓⍳⍵} 10   ⍝ Wasteful, as generating from ⎕IO

¯1+5 (⊣↓∘⍳) 10   ⍝ The abobve as a train

¯1+5 {⍺+⍳⍵-⍺} 10 ⍝ Better!

¯1+5 (⊣+∘⍳-⍨) 10 ⍝ The above as a train

'iotag'⎕CY'dfns' ⍝ iotag -- generalised iota
12 iotag 3 3 ⍝ 12 downto 3, step 3

⎕←letters ← 4 6⍴⎕A
{⊂⍵}⌺3 3 ⊢ letters     ⍝ Enclose the selected window

({⊂⍺}⌺3 3) ⊢ letters

({⊂⍺↓⍵}⌺3 3) ⊢ letters

{⍺,⍵}⌸'Mississippi'  ⍝ Show indexes of items, by item

{⍺,≢⍵}⌸'Mississippi' ⍝ Frequencies

(,∘≢⌸)'Mississippi'

{(⊣/m)/⍨frq⍷⍨frq⌷⍨⊃⍒frq←⊢/m←(,∘≢⌸)⍵} 'Mississippi' ⍝ Most frequent

]dinput
moves←{
     d←(0 1)(1 0)(0 ¯1)(¯1 0)      ⍝ Move offsets
     m←⍵
     {⌽@i ⍵⊢m}¨(,⍳⍴m)∩d+⊂i←⊃⍸0=m
 }

state←¯1+4 4⍴?⍨16
moves state

state ⋄ ⊃⍸0=state

d←(0 1)(1 0)(0 ¯1)(¯1 0)
d+⊂i←⊃⍸0=state                ⍝ disclose-enclose as we want the enclosed version later

,⍳⍴state

(,⍳⍴state)∩d+⊂i←⊃⍸0=state

{⌽@i ⍵⊢state}¨(,⍳⍴state)∩d+⊂i←⊃⍸0=state

state ⋄ (⌽@(1 1) (1 2)) state

⌽@(1 1) (1 2) ⊢ state

]dinput
Pop←{ ⍝ Pop off smallest element from a leftist tree ⍵
    0=≢⍵:⍬
    (value left right)←1↓⍵
    (left Merge right) value
}

]dinput
Push←{ ⍝ Insert item ⍵ into leftist tree ⍺, returning the resulting tree
    ⍺←⍬              ⍝ default to init
    1 ⍵ ⍬ ⍬ Merge ⍺ 
}

]dinput
Merge←{ ⍝ Merge leftist trees ⍺ and ⍵
    0=≢⍺:⍵ ⋄ 0=≢⍵:⍺                                 ⍝ If either is a leaf, return the other
    (key left right)←1↓⍺
    key>(⎕IO+1)⊃⍵:⍵∇⍺                               ⍝ Flip to ensure smallest is root of merged
    merged←right∇⍵                                  ⍝ Merge rightwards
    leftRank←⊃left ⋄ mergedRank←⊃merged
    leftRank≥⊃merged:(1+mergedRank) key left merged ⍝ Right is shorter
    (1+leftRank) key merged left                    ⍝ Left is shorter; make it the new right
}

⍝ Example given in http://typeocaml.com/2015/03/12/heap-leftist-tree/
h←Push 2
h Push←10
h Push←9

s←Push 3
s Push←6

h Merge s

(819⌶) 'Hello All People in The World'   ⍝ NOTE: deprecated in Dyalog 18.X in favour of ⎕C

1(819⌶) 'Hello All People in The World'  ⍝ NOTE: deprecated in Dyalog 18.X in favour of ⎕C

{⊃('.+' ⎕S '\u0')⍵} 'Hello All People in The World'

RegSplit←{(⊢/¨r)↓¨⍵⊂⍨(⍳≢⍵)∊1+⊃¨r←(⍺,'|^')⎕S 0 1⊢⍵}

'/+' RegSplit 'here/////be/dragons/'

' ' (≠⊆⊢) 'hello world out there'

(2∘⊥⍣¯1) 54
(16⍴2)⊤54      ⍝ Fixed number of bits

2⊥0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0

0 0 0 0 1 0 ∧ 1 1 0 1 1 0 

Lshift←{(≢⍺)↑⍵↓⍺}
Rshift←{(-≢⍺)↑(-⍵)↓⍺}

1 1 0 1 1 0 Rshift 2
1 1 0 1 1 0 Lshift 2

JSONSTR←'{"key11":"value11","key12":{"key121":"value121"},"key13":[1,2,3]}'
⎕←data←⎕JSON JSONSTR

data.(⎕NL ¯2)  ⍝ Simple keys
data.(⎕NL ¯9)  ⍝ Object references

⎕←simpleValues←data.(⍎¨⎕NL ¯2)
⎕←objectValues←data.(⍎¨⎕NL ¯9)

⍝ CHECK: (↑⍣≡0∘⎕JSON)Y
⍝ (1⎕JSON{1<≢⍴⍵:∇¨⊂⍤¯1⊢⍵ ⋄ ⍵})Y apl->json

a←⎕NS''  ⍝ Create an anonymous namespace                 

a.(Name City)← 'Stefan' 'Bristol'  ⍝ Assign two fields
a.Name ⋄ a.City

IsNumber←{(1=2|⎕DR)⍵}                     ⍝ Are we a number?
IsString←⍕≡⊢                              ⍝ Are we a string?
IsNamespace←{(326=⎕DR⍵)}                  ⍝ Are we a reference/object/namespace?

b←↑{(⍵ 1) (0 0)}¨⍳10000
vs←⍳10000
rs←?⍨10000

]runtime -c "vs,¨⍨@1⍤0 1@rs⊢b" "(,¨∘vs)@(rs,¨1)⊢b"

m1←(5 3)(5 6)(7 5)(4 7)(1 8)(2 4)(1 2)
data←(↑m1)[⍋(↑m1)[;1];]
k←⊣/data
↓⍉↑(∪k)(k⊆⊢/data)

(⊃¨{⊂⍺⍵}⌸⊢/¨)m1

(↓⊃¨,∘⊂⌸⊢/¨)m1

vect←243 243 243 243 251 243 243

hist←{⍺,≢⍵}⌸d
oneIndex←hist[;2]⍳1
oddVal←hist[oneIndex;1]
vect⍳oddVal

∊{⊂⍵/⍨1=≢⍵}⌸vect

{⍺ ⍵}⌸vect

∊{∩/⍵}⌸vect

∊∩/1 2 3 4 6 7

∊∩/5

⍸{⍵∧1⌽⍵}∘{⍵≠¯1⌽⍵}vect

(1⍳⍨1⊥∘.=⍨)vect

assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

elems⍳⌊/elems←6 2 8 9 3 1 10 15
⊃⍋elems

⊢∘⊂⌺(2 2⍴2 2)⊢4 4⍴⍳16

1 1↓⊢∘⊂⌺(2 2⍴3 3)⊢0⍪0⍪0,0,12 12⍴⍳144

⎕IO←1 ⋄ 2 2 {⊂[2×⍳≢⍴⍵]⍵⍴⍨∊⍺,¨⍨⍺÷⍨⍴⍵} 4 4 ⍴ ⍳16

⊂⍤2⊢1 3 2 4⍉2 3 2 3⍴6 6⍴⍳36

m←1 1↓⊢∘⊂⌺(2 2⍴3 3)⊢0⍪0⍪0,0,12 12⍴⍳144
Merge←{((⍴×⍴∘⊃)⍴1 3 2 4⍉↑)⍵}
Merge m

v←⍸×3 3 ⍴ 5 0 4 0 0 3 0 2 0 ⍝ All non-zero coord pairs
n4←{⍺∩⍵(+,-)(0 1)(1 0)}
n8←{⍺∩⍵(+,-)(0 1)(1 0)(¯1 1)(1 1)}
Move←{('NESW'⍳⍵)⊃(¯1 0)(0 1)(1 0)(0 ¯1)}

v n4 ⊂2 3

alupsert←{(k v)←⍵⋄3::⍺ alpush k v⋄⍺ alset k v} ⍝ Modify if present
algetd←{3::¯1↑⍵⋄⍺ alget (⊃⍵)}                  ⍝ Get if present, else return given default

'YYYY DD MM hhmm'(1200⌶)1⎕DT⊂2020 08 11 11 32 ⍝ Dyalog 18 date time

⎕io←0
YMIN←0 ⋄ YMAX←50 ⋄ XMIN←0 ⋄ XMAX←50
c←(23 43)(78 34)(¯45 34)

⊃∧/0=(YMIN YMAX) (XMIN XMAX)⍸¨↓⍉↑c

(⊢≡YMIN XMIN⌈YMAX XMAX⌊⊢)¨c          ⍝ Slower

Hash←{keys←(1500⌶),⍺⋄vals←,⍵⋄{⍵⊣⍵.(Vals Keys Default)←vals keys ⍬}⎕NS''}
In←{⍺∊⍵.Keys}

]dinput
Get←{
    ~⍵ In ⍺:⍺.Default
    ⍺.Vals[⍺.Keys⍳⍵]
}

]dinput
Set←{ ⍝ Upsert ht ⍺ with kv pair ⍵. ⍝ Returns 1 if this is a new key; 0 otherwise.
    ht←⍺
    (k v)←⍵
    i←ht.Keys⍳⊂k
    i=≢ht.Keys:1⊣ht.Keys,←⊂k⊣ht.Vals,←v ⍝ New key
    ht.Vals[i]←v                        ⍝ Replace existing
    0
}

]dinput
Append←{ ⍝ Append a value to those belonging to the key. If new key, insert kv pair
    ht←⍺
    (k v)←⍵
    i←ht.Keys⍳⊂k
    i=≢ht.Keys:1⊣ht.Keys,←⊂k⊣ht.Vals,←v ⍝ New key
    ht.Vals[i],←v                       ⍝ Append to existing
    0
}

ssc1←{⊃¯1 0 1[⍸⍺(<,=,>)⍵]}
ssc2←>-<
ssc3←×-

tuples←{↓(⍺÷⍨≢⍵) ⍺⍴⍵} ⍝ errors if not equally dividable
tuples←{⍵⊂⍨(≢⍵)⍴⍺↑1}
tuples←⊢⊂⍨≢⍤⊢⍴⊣↑≢

⍸≠ 1 1 2 1 3 4 5 2 1

_Gets←{⍎'⍺⍺.',⍺,'←⍵'⊣⍺⍺}

ns←⎕ns''
'hello'(ns _Gets)'world'
ns.hello
ns⍎'hello'

⊢m←3 5 ⍴15?15

⊢ravel←,m

⊢k←(⍴m)⊥1 4 ⍝ 2D to 1D

k⊃ravel

⊢i j←(⍴m)⊤k ⍝ 1D to 2D

m[⊂i j]

⊢d←3 3⍴0 1 0 0 0 1 1 1 1

Pad←{(-⍵+⍵+⍴⍺)↑(⍵+⍴⍺)↑⍺}

d Pad 5

Pad2←{⍵@(1+⍳⍴⍵)⊢0⍴⍨2+⍴⍵} ⍝ https://aplcart.info/?q=surround%20array#

Pad2 1 2 3

Pad2 d

Pad2⍣5⊢d

Pad2 (↑,∘⊂)d ⍝ Increase rank first

⎕IO←1 ⍝ voidhawk
p←(⊢⊆⍨0≠≢¨)⊃⎕NGET'data/2020/day16.txt'1
ds←{⍎¨⍵(∊⊆⊣)⎕D}
rs←ds¨⊃p ⋄ yt ot←{↑ds¨1↓⍵⊃p}¨2 3
ir←{a b c d←⍵ ⋄ ((d≥⍺)∧c≤⍺)∨(b≥⍺)∧a≤⍺}
+/ot[⍸~e←∨/ot∘.ir rs] ⍝ part 1
m←∧⌿rs∘.ir⍨yt⍪ot⌿⍨∧/e
×/6↑(,yt)⌷⍨⊂⍋(⊂⍋⍋+/m)⌷∊~⍨\⍸¨↓m[⍋+/m;] ⍝ part 2

⊢m←3 3⍴9?9
{↑(⊣/⍵)(⊢/⍵)}⍣2⊢m

⌷⍨∘⊃⍨⍤0 99 ⍝ Sane indexing

(⊢⊂⍨1,2≠/⊢) ⍝ map of changes

(∨.∧⍨∨⊢)⍣≡ ⍝ Transitive closure on APL Cart?
