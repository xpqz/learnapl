⎕IO ← 0
]box on
]rows on
assert ← {⍺ ← 'assertion failure' ⋄ 0∊⍵: ⍺ ⎕signal 8 ⋄ shy ← 0}

×⍨¨1+⍳9  ⍝ Square elements via each (but see below!)

×⍨1+⍳9  ⍝ Square elements via scalar pervasion

⎕ ← V ← (1 2 3 4)(1 2)(3 4 5 6 7)(,2)(5 4 3 2 1)
≢¨V ⍝ Tally-each

+⌿1 2 3 4 5 6 7 8 9 ⍝ sum-reduce-first integers 1-9

1+2+3+4+5+6+7+8+9

-⌿1 2 3 4 5 6 7 8 9 ⍝ difference-reduction -- take care: right to left fold!

1-2-3-4-5-6-7-8-9

⎕ ← m ← 3 3⍴9?9
+⌿m

+/m

+⌿[1]m

2+⌿1 2 3 4 5 6 7 8 9

+⌿1 2 3 4 5 6 7 8 9 ⍝ Sum-reduce first
+⍀1 2 3 4 5 6 7 8 9 ⍝ Sum-scan first

+⌿1
+⌿1 2
+⌿1 2 3
+⌿1 2 3 4
+⌿1 2 3 4 5
+⌿1 2 3 4 5 6
+⌿1 2 3 4 5 6 7 
+⌿1 2 3 4 5 6 7 8
+⌿1 2 3 4 5 6 7 8 9

2÷⍨⍣=10 ⍝ Divide by 2 until we reach a fixed point

 {⍞ ← ?10}⍣{6=⍺} 0 ⍝ Keep generating random numbers between 1 and 10 until we get a 6

]dinput
Sum ← {
    ⍺ ← 0        ⍝ Left arg defaults to 0 if not given
    0=≢⍵: ⍺      ⍝ If right arg is empty, return left arg
    (⍺+⊃⍵)∇1↓⍵   ⍝ Add head to acc, recur over tail
}

⎕ ← mysum ← Sum 1 2 3 4 5 6 7 8 9
assert mysum=+/1 2 3 4 5 6 7 8 9

]dinput
Sscan ← {
    ⍺ ← ⍬              ⍝ Left arg defaults to ⍬ if not given
    0=≢⍵: ⍺            ⍝ If right arg is empty, return left arg
    (⍺,⊃⍵+⊃¯1↑⍺)∇1↓⍵   ⍝ Append the sum of the head and the last element of acc and recur on tail
}

⎕ ← myscan ← Sscan 1 2 3 4 5 6 7 8 9
assert myscan≡+⍀1 2 3 4 5 6 7 8 9

]dinput
Fib ← { ⍝ Tail-recursive Fibonacci.
    ⍺ ← 0 1
    ⍵=0: ⊃⍺
    (1↓⍺,+/⍺)∇⍵-1
}

Fib¨⍳10 ⍝ The 10 first Fibonacci numbers

]dinput
Quicksort ← {
    1≥≢⍵: ⍵
    S ← {⍺⌿⍨⍺ ⍺⍺ ⍵}
    ⍵((∇<S),=S,(∇>S))⍵⌷⍨?≢⍵
}

Quicksort ⎕←20?20

]dinput
bsearch ← {⎕IO←0
    _bs_ ← {                 ⍝ Operator: ⍺,⍵ - lower,upper index. ⍺⍺ - item, ⍵⍵ - array
        ⍺>⍵: ⍬               ⍝ If lower index has moved past upper, item's not present
        mid ← ⌈0.5×⍺+⍵       ⍝ New midpoint  
        ⍺⍺=mid⊃⍵⍵: mid       ⍝ Check if item is at the new midpoint
        ⍺⍺<mid⊃⍵⍵: ⍺∇¯1+mid  ⍝ Drill into lower half
        ⍵∇⍨1+mid             ⍝ Upper half
    }
    0 (⍺ _bs_ (,⍵)) ¯1+≢,⍵
}

5 bsearch 0 2 3 5 8 12 75
5 bsearch 0 2 3 5 8 12
5 bsearch 5 5
5 bsearch 5
]display 1 bsearch 0 2 3 5 8 12

]dinput
prefix1 ← {⎕IO←0
    p ← ⍵
    pi ← 0⍴⍨≢⍵
    j ← 0
    {
        0=≢⍵: pi
        i ← ⊃⍵ ⍝ head
        pi[i] ← j⊢←1+{⍵<0:⍵⋄p[⍵]=p[i]:⍵⋄0≤⍵-1:∇pi[⍵-1]⋄¯1} j ⍝ while j>=0 and p[j] != p[i]
        ∇1↓⍵ ⍝ tail
    } 1+⍳¯1+≢⍵ ⍝ for i in range(1, m)
}

prefix1 'CAGCATGGTATCACAGCAGAG'

]dinput
prefix2 ← {⎕IO←0
    p ← ⍵
    pi ← 0⍴⍨≢⍵
    j ← 0
    0 {
        ⍺=≢⍵: pi
        i ← ⍺⊃⍵ ⍝ Note: pick ⍺, not first
        pi[i] ← j⊢←1+{⍵<0:⍵ ⋄ p[⍵]=p[i]:⍵ ⋄ 0≤⍵-1:∇ pi[⍵-1] ⋄ ¯1} j
        (⍺+1)∇ ⍵ ⍝ Note: no tail!
    } 1+⍳¯1+≢⍵
}

prefix2 'CAGCATGGTATCACAGCAGAG'

data ← ⊃⊃⎕NGET'../kmp.txt'1 ⍝ From http://rosalind.info/problems/kmp/
≢data ⍝ LONG STRING!

'cmpx'⎕CY'dfns' ⍝ Load `cmpx` - comparative benchmarking

cmpx 'prefix1 data' 'prefix2 data'

data ← ⍳100000 ⍝ A loooot of numbers
cmpx 'data ⍳ 17777' '17777 bsearch data' ⍝ Look for the number 17777

randInts ← 100000 ? 100000 
cmpx 'randInts⍳1' 'randInts⍳19326' 'randInts⍳46729'

find←randInts∘⍳
cmpx 'find 1' 'find 19326' 'find 46729'

cmpx 'data⍸1' 'data⍸19326' 'data⍸46729'

⎕ ← nesty ← (1 2 3 (3 4 (5 6)) 7)

-nesty

(1 2) 3 + 4 (5 6)
(1 1⍴5) - 1 (2 3)


