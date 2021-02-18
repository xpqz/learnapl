⎕IO ← 0
⎕PP ← 34
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'
assert←{⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕signal 8 ⋄ shy←0}

⊢data←11 11⍴'..##.......#...#...#...#....#..#...#.#...#.#.#...##..#...#.##......#.#.#....#.#........##.##...#...#...##....#.#..#...#.#'

data,⍣3⊢data

11 44⍴'0.##.........##.........##.........##.......#..0#...#..#...#...#..#...#...#..#...#...#...#....⎕..#..#....#..#..#....#..#..#....#..#...#.#...#0#..#.#...#.#..#.#...#.#..#.#...#.#.#...##..#..⎕...##..#..#...##..#..#...##..#...#.##.......#.⎕#.......#.##.......#.##......#.#.#....#.#.#.#.0..#.#.#.#....#.#.#.#....#.#........#.#........⎕.#........#.#........##.##...#...#.##...#...#.⎕#...#...#.##...#...#...##....##...##....##...#⎕....##...##....#.#..#...#.#.#..#...#.#.#..#...⎕.#.#..#...#.#'

↓⍉↑1 3×⊂⍳11 ⍝ Remix to create y x pairs

↓⍉↑11 11|1 3×⊂⍳11

+⌿'#'=data[↓⍉↑11 11|1 3×⊂⍳11]

data {+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]} 1 3

data←↑⊃⎕NGET'../../AoCDyalog/data/2020/day03.txt'1

⍴data

⊢part1 ← data {+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]} 1 3
assert 203=part1

⊢part2 ← ×⌿data∘{+⌿'#'=⍺[↓⍉↑(⍴⍺)|⍵×⊂⍳⌈(≢⍺)÷⊃⍵]}¨(1 1)(1 3)(1 5)(1 7)(2 1)
assert 3316272960=part2

data←'eedadn' 'drvtee' 'eandsr' 'raavrd' 'atevrs' 'tsrnev' 'sdttsa' 'rasrtv' 'nssdts' 'ntnada' 'svetve' 'tesnvt' 'vntsnd' 'vrdear' 'dvrsen' 'enarar'
↑data

{⍺,≢⍵}⌸¨↓⍉↑data

∊{0 0⌷⍵[⍒⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data

data←⊃⎕NGET'../../AoCDyalog/data/2016/06.txt'1

⊢part1←∊{0 0⌷⍵[⍒⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data
assert 'qrqlznrl'≡part1

⊢part2←∊{0 0⌷⍵[⍋⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑data
assert 'kgzdfaon'≡part2

_day6←{∊⍺⍺{0 0⌷⍵[⍺⍺⍵[;1];]}¨{⍺,≢⍵}⌸¨↓⍉↑⍵}

⍒_day6 data
⍋_day6 data

data←↑'-?\d+'⎕S{⍎⍵.Match}¨⊃⎕NGET'../../AoCDyalog/data/2018/10.txt'1

pos ← ,/data[;0 1]
vel ← ,/data[;2 3]

bbx ← {+/|-⌿2 2⍴(⌊⌿,⌈⌿)↑⍵} ⍝ Width + height of bounding box

msg ← vel-⍨{vel+⍵}⍣{⍺>⍥bbx⍵}⊢pos ⍝ Add velocity until bounding box no longer decreases.

(w h) ← |-⌿2 2⍴(⌊⌿,⌈⌿)↑msg           ⍝ Width and height of bounding box
(-h+1)(-w+1)↑'*'@(⊖¨msg)⊢143 203⍴' ' ⍝ Prune our display, and make stars

⊢STATE←6 6⍴1 1 1 0 ¯1 2 1 ¯1 0 1 1 3 1 1 0 0 ¯1 4 1 1 0 0 1 1 1 ¯1 5 1 ¯1 2 1 1 3 1 1 0

TAPE ← 12919244⍴0

]dinput
stf ← {
    (pos state) ← ⍵
    args ← (0 3[pos⊃TAPE])+⍳3
    (nv m ns) ← STATE[state;args]
    TAPE[pos] ← nv
    (pos+m) ns
}

_←stf⍣12919244⊢6459622 0  ⍝ Takes ~20s

assert 4287=⎕←+/TAPE

]dinput
:Namespace heapq

    ⍝ Implementation of a heapq using a Leftist Tree
    ⍝ See:
    ⍝    https://en.wikipedia.org/wiki/Leftist_tree
    ⍝    http://typeocaml.com/2015/03/12/heap-leftist-tree/

    Empty ← {0=≢⍵}

    Merge ← { ⍝ Merge leftist trees ⍺ and ⍵
        0=≢⍺:⍵ ⋄ 0=≢⍵:⍺                                  ⍝ If either is a leaf, return the other
        (item left right) ← 1↓⍺
        (⊃⊃item)>⊃⊃(⎕IO+1)⊃⍵: ⍵∇⍺                        ⍝ Flip to ensure smallest is root of merged
        merged ← right∇⍵                                 ⍝ Merge rightwards
        leftRank ← ⊃left
        mergedRank ← ⊃merged
        leftRank≥⊃merged: (1+mergedRank)item left merged ⍝ Right is shorter
        (1+leftRank)item merged left                     ⍝ Left is shorter; make it the new right
    }

    Pop ← { ⍝ Pop off smallest element from a leftist tree ⍵
        0=≢⍵:⍬
        (value left right) ← 1↓⍵
        (left Merge right) value
    }

    Push ← { ⍝ Push a new element ⍵ onto the leftist tree ⍺
        ⍺←⍬
        ⍺ {
            0=≢⍵: ⍺
            1(⊃⍵)⍬ ⍬ Merge ⍺∇1↓⍵
        },⍵
    }

:EndNamespace

q ← heapq.Push ⊂0 'zero'    ⍝ No left arg creates a new heap
q ← q heapq.Push ⊂5 'five'
q ← q heapq.Push ⊂2 'two'

(q v) ← heapq.Pop q
v
(q v) ← heapq.Pop q
v
(q v) ← heapq.Pop q
v

h ← heapq.Push ⊂2 'two'
h heapq.Push← ⊂10 'ten'
h heapq.Push← ⊂9 'nine'

s ← heapq.Push ⊂3 'three'
s heapq.Push← ⊂6 'six'

q ← h heapq.Merge s
q
(q v)←heapq.Pop q
v
(q v)←heapq.Pop q
v
(q v)←heapq.Pop q
v
(q v)←heapq.Pop q
v
(q v)←heapq.Pop q
v

]dinput
:Namespace dict

    ⍝ Basic dictionary

    Create ← {
        keys ← (1500⌶),⍺
        vals ← ,⍵
        {⍵⊣⍵.(Vals Keys Default)←vals keys ⍬}⎕NS''
    }

    Get ← {
        ~⍵ In ⍺: ⍺.Default
        ⍺.Vals[⍺.Keys⍳⍵]
    }

    In ← {⍺∊⍵.Keys}

    _Set ← {⎕IO←0
        ⍝ Monadic operator to upsert dict ⍺⍺ given a 
        ⍝ vector (or scalar) of keys ⍺ and a vector 
        ⍝ (or scalar) of vals ⍵
        ⍺⍺∘{
            k ← 0⌷⍵ ⋄ v ← 1⌷⍵
            i ← ⍺.Keys⍳k
            i=≢⍺.Keys: 1⊣⍺.Keys,←k⊣⍺.Vals,←v ⍝ New key
            ⍺.Vals[i] ← v                    ⍝ Replace existing
            0
        }¨↓⍉↑(,⍺)(,⍵)
    }

:EndNamespace

d ← (⊂'bob') dict.Create 45
'eric' 'frank' 'sue'(d dict._Set) 77 54 28

↑(d.Keys)(d.Vals)
d dict.Get ⊂'frank'
{}(⊂'frank') (d dict._Set) 99
d dict.Get ⊂'frank'

d.Default ← 'Key not found'
d dict.Get ⊂'johnny'

]dinput
:Namespace path
    ⍝ Basic implementation of uniform cost Dijkstra's shortest path
    ⍝ See: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
    
    ⎕IO←0
    _Dijkstra ← {
        (start target) ←⍺ ⍵
        cost ← start ##.dict.Create 0 ⋄ cost.Default ← ⌊/⍬
        cameFrom ← start ##.dict.Create start
        Neigh ← ⍺⍺
        Pick ← {oldCost←cost ##.dict.Get ⊂⍵ ⋄ ⍺<oldCost}                
        _ ← {
            (queue queueItem) ← ##.heapq.Pop ⍵                 ⍝ Next vertex, in increasing cost order
            current ← 1⊃queueItem
            current≡target: ⍬                                  ⍝ Are we there yet?
            newCost ← 1+cost ##.dict.Get current               ⍝ Uniform cost
            valid ← (newCost∘Pick¨n)/n ← Neigh current         ⍝ New, or better?
            _ ← valid (cameFrom ##.dict._Set)(≢valid)⍴current  ⍝ All neighbours came from current
            _ ← valid (cost ##.dict._Set)(≢valid)⍴newCost      ⍝ Any changed costs?
            queue ##.heapq.Push ↓⍉↑((≢valid)⍴newCost)(⊂¨valid) ⍝ Enqueue connected nodes
        }⍣{##.heapq.Empty ⍺} ##.heapq.Push ⊂0 start            ⍝ Repeat until the queue is empty
        cameFrom
    }
    
    _Unwind ← {
        path ← ⍺⍺
        start ← ⍺
        ⍬ {
            ⍵≡start: ⊖⍺
            (⍺,⍵)∇path ##.dict.Get ⍵
        } ⍵
    }
    
:EndNamespace

⊢maze ← ↑⊃⎕NGET'/Users/stefan/work/dyalog/JupyterBook/maze-small.txt'1

graph ← ~'#'=maze

N4 ← {(⍸⍺)∩⍵(+,-)(0 1)(1 0)} ⍝ 4-connected neighborhood

graph N4 ⊂5 7

camefrom ← (⊂0 1) (graph∘N4 path._Dijkstra) ⊂19 20
solution ← (⊂0 1) (camefrom path._Unwind) ⊂19 20

'⎕'@solution⊢maze


