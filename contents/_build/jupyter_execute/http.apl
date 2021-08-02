⎕IO ← 0
]box on
]rows on

hc ← ⎕SE.SALT.Load'HttpCommand'

⎕ ← resp ← hc.Get 'https://api.kanye.rest/'

{(⍵[;0]∊⊂'Content-Type')⌿⍵} resp.Headers

body ← ⎕JSON resp.Data

]map body  ⍝ list the fields

body.quote

(hc.GetJSON 'GET' 'https://api.kanye.rest/').Data.quote

(hc.GetJSON 'GET' 'https://api.kanye.rest/').Data.quote

url ← 'https://skruger.cloudant.com/airaccidents/_all_docs'
(params←⎕NS⍬).(include_docs limit) ← 'true' 3

resp ← hc.Get url params

body ← ⎕JSON resp.Data
]map body

]map body.rows[0].doc

body.rows[0].doc.⍙Event⍙32⍙Date

1(⎕JSON⍠'Compact' 0)body.rows[0].doc

(hc.GetJSON 'GET' (url,'?include_docs=true&limit=3')).Data.rows.doc

⎕ ← body ← ⎕JSON⍠'M' ⊢ resp.Data

url ← 'https://skruger.cloudant.com/airaccidents/_design/make/_view/by-make'
(params ← ⎕NS⍬).(limit reduce key) ← 1 'false' '"Cessna"'
resp ← hc.Get url params
⎕ ← body ← ⎕JSON⍠'M' ⊢ resp.Data

url ← 'https://skruger.cloudant.com/airaccidents/5b97c6d78b17b37ceff620baf9657693'
resp ← hc.Get url
⎕ ← body ← ⎕JSON⍠'M' ⊢ resp.Data

url ← 'https://skruger.cloudant.com/airaccidents/_design/make/_view/by-make?group=true'
(params ← ⎕NS⍬).keys ← 'Cessna' 'Boeing' 'Airbus' ⍝ Request body payload; will be JSON-encoded
body ← (hc.GetJSON 'POST' url params).Data

1(⎕JSON⍠'Compact' 0)body.rows

1 hc.GetJSON 'GET' 'https://api.kanye.rest/'

1 hc.Get 'https://username:password@example.com'

page ← (_←hc.Get 'https://www.dyalog.com/student-competition.htm').Data

xml ← ⎕XML page

(tags attributes) ← (⊂1 3)⌷↓⍉xml

anchors ← ((,'a')∘≡¨tags)/attributes

(names vals) ← ↓⍉⊃⍪/anchors

pdfs ← vals/⍨{'.pdf'∘≡¯4↑⍵}¨vals
↑3↑pdfs

⎕ ← base ← ⊃⌽⊃('base'∘≡¨tags)/attributes

↑3↑base∘,¨pdfs

]dinput
PastTasks ← {
    (tags attributes) ← (⊂1 3)⌷↓⍉⎕XML(hc.Get ⍵).Data
    (names vals) ← ↓⍉⊃⍪/((,'a')∘≡¨tags)/attributes ⍝ Names and values of attributes of anchor tags
    pdfs ← vals/⍨{'.pdf'∘≡¯4↑⍵}¨vals
    base ← ⊃⌽⊃('base'∘≡¨tags)/attributes
    base∘,¨pdfs
}

↑PastTasks 'https://www.dyalog.com/student-competition.htm'

]dinput
PastTasksRE ← {
    body ← (hc.Get ⍵).Data
    pdfs ← '<a href="(.+?\.pdf)"'⎕S'\1'⊢body
    base ← '<base href="(.+?)"'⎕S'\1'⊢body
    base,¨pdfs
}

↑PastTasksRE 'https://www.dyalog.com/student-competition.htm'


