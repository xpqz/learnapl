⎕IO ← 0
]box on -s=min
]rows on

{⍺⍵}⌸'bill' 'bob' 'bill' 'eric' 'bill' 'bob' 'eric' 'sue'

{⍺ (≢⍵)}⌸'bill' 'bob' 'bill' 'eric' 'bill' 'bob' 'eric' 'sue'

names ← 'bill' 'bob' 'bill' 'eric' 'bill' 'bob' 'eric' 'sue'
{⍺⍵}⌸names
names{⍺⍵}⌸⍳≢names

scores←'London Irish,31-22' 'Wasps,17-49' 'Gloucester,26-31' 'Worcester Warriors,17-21' 'Bristol,48-3' 'Leicester Tigers,15-25' 'Harlequins,27-27' 'Newcastle Falcons,22-10' 'Exeter Chiefs,7-20' 'Northampton Saints,0-0' 'Bath,44-52' 'Sale,20-13' 'London Irish,0-0' 'Leicester Tigers,36-31' 'Wasps,34-5' 'Gloucester,19-22' 'Bristol,29-17' 'Worcester Warriors,0-0'

table←⎕CSV ('-'⎕R','⊢scores)''4
teams←⊣/table
scores←table[;1 2]

teams{⍺⍵}⌸scores

{⍵⌷⍨⊂0~⍨⊢/0,⊢⌸⍵} 'Mississippi' ⍝ Most frequent from APLCart

⊢⌸ 'Mississippi'

{⍵}⌸ 'Mississippi'

0,⊢⌸ 'Mississippi'

{⍵⌷⍨⊂0~⍨⊢/⊢⌸⍵} 'Mississippi'

{⍵⌷⍨⊂0~⍨⊢/⊢⌸⍵} '' ⍝ Note: DOMAIN ERROR

{⍵⌷⍨⊂0~⍨⊢/0,⊢⌸⍵} ''

⊢/0,⊢⌸'Mississippi'

0~⍨⊢/⊢⌸ 'Mississippi'

{⍵⌷⍨⊂0~⍨⊢/0,⊢⌸⍵} 'Mississippi'

{⍵⌷⍨⊂0~⍨⊢/0,⊢⌸⍵}'abc'

{⎕IO←1⋄⍵⌷⍨⊂0~⍨⊢/0,⊢⌸⍵}'abc'

{⍵⌷⍨⊂¯1~⍨⊢/¯1,⊢⌸⍵}'abc' ⍝ Whilst this works....
{⍵⌷⍨⊂¯1~⍨⊢/¯1,⊢⌸⍵}'Mississippi' ⍝ This breaks!

x←'Supercalifragilisticexpialidocious'

{⍺⍵}⌸x
{⍺ (≢⍵)}⌸x
{≢⍵}⌸x
{⍺}⌸x

x←'abcdefghijk'
y←10+11 2⍴⍳22

x{⍺⍵}⌸y
x{⍺ (≢⍵)}⌸y
x{≢⍵}⌸y
x{⍺}⌸y
x{⍺(+/,⍵)}⌸y
x{⍺(⌈/,⍵)}⌸y
x{⍺(⌊/,⍵)}⌸y
