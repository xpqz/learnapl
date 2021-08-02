⎕IO ← 0
⎕PP ← 34
]box on
]rows on
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

⎕←data ← 11 11⍴'..##.......#...#...#...#....#..#...#.#...#.#.#...##..#...#.##......#.#.#....#.#........##.##...#...#...##....#.#..#...#.#'

data,⍣3⊢data

11 44⍴'0.##.........##.........##.........##.......#..0#...#..#...#...#..#...#...#..#...#...#...#....⎕..#..#....#..#..#....#..#..#....#..#...#.#...#0#..#.#...#.#..#.#...#.#..#.#...#.#.#...##..#..⎕...##..#..#...##..#..#...##..#...#.##.......#.⎕#.......#.##.......#.##......#.#.#....#.#.#.#.0..#.#.#.#....#.#.#.#....#.#........#.#........⎕.#........#.#........##.##...#...#.##...#...#.⎕#...#...#.##...#...#...##....##...##....##...#⎕....##...##....#.#..#...#.#.#..#...#.#.#..#...⎕.#.#..#...#.#'

↓⍉↑1 3×⊂⍳11 ⍝ Remix to create y x pairs

↓⍉↑11 11|1 3×⊂⍳11

+⌿'#'=data[↓⍉↑11 11|1 3×⊂⍳11]

data {+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]} 1 3

data ← ↑⊃⎕NGET'../../AoCDyalog/data/2020/day03.txt'1

⍴data

⎕ ← part1 ← data {+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]} 1 3
assert 203=part1

⎕ ← part2 ← ×⌿data∘{+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]}¨(1 1)(1 3)(1 5)(1 7)(2 1)
assert 3316272960=part2

data ← 'eedadn' 'drvtee' 'eandsr' 'raavrd' 'atevrs' 'tsrnev' 'sdttsa' 'rasrtv' 'nssdts' 'ntnada' 'svetve' 'tesnvt' 'vntsnd' 'vrdear' 'dvrsen' 'enarar'
↑data

{⍺,≢⍵}⌸¨↓⍉↑data

∊{0 0⌷⍵[⍒⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data

data ← ⊃⎕NGET'../../AoCDyalog/data/2016/06.txt'1

⎕ ← part1 ← ∊{0 0⌷⍵[⍒⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data
assert 'qrqlznrl'≡part1

⎕ ← part2 ← ∊{0 0⌷⍵[⍋⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data
assert 'kgzdfaon'≡part2

_day6 ← {∊⍺⍺{0 0⌷⍵[⍺⍺⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑⍵}

⍒_day6 data
⍋_day6 data

data ← ↑'-?\d+'⎕S{⍎⍵.Match}¨⊃⎕NGET'../../AoCDyalog/data/2018/10.txt'1

pos ← ,/data[;0 1]
vel ← ,/data[;2 3]

bbx ← {+/|-⌿2 2⍴(⌊⌿,⌈⌿)↑⍵} ⍝ Width + height of bounding box

msg ← vel-⍨{vel+⍵}⍣{⍺>⍥bbx⍵}⊢pos ⍝ Add velocity until bounding box no longer decreases.

(w h) ← |-⌿2 2⍴(⌊⌿,⌈⌿)↑msg           ⍝ Width and height of bounding box
(-h+1)(-w+1)↑'*'@(⊖¨msg)⊢143 203⍴' ' ⍝ Prune our display, and make stars

⎕ ← STATE ← 6 6⍴1 1 1 0 ¯1 2 1 ¯1 0 1 1 3 1 1 0 0 ¯1 4 1 1 0 0 1 1 1 ¯1 5 1 ¯1 2 1 1 3 1 1 0

TAPE ← 12919244⍴0

]dinput
stf ← {
    (pos state) ← ⍵
    args ← (0 3[pos⊃TAPE])+⍳3
    (nv m ns) ← STATE[state;args]
    TAPE[pos] ← nv
    (pos+m) ns
}

_ ← stf⍣12919244⊢6459622 0  ⍝ Takes ~20s

assert 4287=⎕←+/TAPE

data←⊃⎕NGET'/Users/stefan/work/dyalog/learnapl/loremipsum.txt'1

1↑data

words←⎕←('\W' '.'⎕S 3⍠'UCP'1⊆⊢)1⎕C⊃,/data

('\W' '.'⎕S 3⍠'UCP'1⊆⊢) 'These are words 55, 56 and 57 in total. Number1nmiddle'

('\W' '.'⎕S 3⍠'UCP'1⊆⊢) '\d'⎕R''⊢1⎕C'These are words 55, 56 and 57 in total. Number1nmiddle'

words←('\W' '.'⎕S 3⍠'UCP'1⊆⊢) '\d'⎕R''⊢1⎕C⊃,/data

(≢words)(≢data)

letters⌷⍨⊂0~⍨⊢/0,⊢⌸letters←∊words

(+/÷≢)≢¨words

⍎1⍕(+/÷≢)≢¨words

{(≢w)(≢⍵)(⍎1⍕(+/÷≢)≢¨w)(l⌷⍨⊂0~⍨⊢/0,⊢⌸l←∊w←('\W' '.'⎕S 3⍠'UCP'1⊆⊢)'\d'⎕R''⊢1⎕C⊃,/⍵)}data

(≢w)(≢data)(⍎1⍕(+/÷≢)≢¨w)(l⌷⍨⊂0~⍨⊢/0,⊢⌸l←∊w←(∊∘⎕A⊆⊢)1⎕C⊃,/data)

]dinput
stats ← {
    words   ← ('\W' '.'⎕S 3⍠'UCP'1⊆⊢) '\d'⎕R''⊢1⎕C⊃,/⍵ ⍝ Flatten, upcase, remove numbers, split on "non-word"
    letters ← ∊words                                   ⍝ Join
    common  ← letters⌷⍨⊂0~⍨⊢/0,⊢⌸letters               ⍝ Frequency table, picking the most frequent
    lengths ← ≢¨words                                  ⍝ Vector of length of each word
    ave     ← ⍎1⍕(+/÷≢)lengths                         ⍝ Average, and round to 1 decimal place
    (≢words) (≢⍵) ave common
}

stats data


