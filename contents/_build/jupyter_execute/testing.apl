⎕IO ← 0
]box on
]rows on

≡ ⍝ usage: expectedoutput ≡ f input.  prints 1 for ok and 0 for failure

:Namespace unittest
    ⎕IO ← 0
    run←{
        tests ← 'test_.+'⎕S'&'⎕NL ¯3
        0=≢tests: 'no tests found'
        ↑{⍺,('.'/⍨30-≢⍺),⍵⊃'[FAIL]' '[OK]'}⌿↑tests (⍎¨tests,¨⊂' ⍬')
    }
:EndNamespace

unittest.run⍬

upper←1∘⎕C
isupper←{⍵≡1⎕C⍵}
split←≠⊆⊢         ⍝ Won't complain about a non-string separator, but hey, why should it?

unittest.test_upper←{'FOO'≡#.upper 'foo'}

unittest.run⍬

unittest.test_isupper←{(#.isupper 'FOO')∧~#.isupper 'Foo'}

unittest.run⍬

unittest.test_isupper2←{(#.isupper 'FOO')∧~#.isupper 'BAR'} ⍝ Failing test

unittest.run⍬

unittest.test_split←{'hello' 'world'≡' '#.split 'hello world'}

unittest.run⍬

unittest.test_split⍬

_test←{(⊢/↑⍵)≡⍤0 0⊢⍺⍺/¯1↓⍤1⊢↑⍵}

split _test (' ' ('hello world') ('hello' 'world')) (',' ('hello,world') ('hello' 'world'))

split_testdata←(' ' ('hello world') ('hello' 'world')) (',' ('hello,world') ('hello' 'world'))

split _test split_testdata

:Namespace datatest
    ⎕IO ← 0
    _test←{(⊢/↑⍵)≡⍤0 0⊢⍺⍺/¯1↓⍤1⊢↑⍵}
    run←{ ⍝ ⍵ -- ns containing functions to be tested
        params ← '_'(≠⊆⊢)¨'[^_]+_testdata'⎕S'&'⎕NL¯2.1    ⍝ https://aplcart.info/?q=%E2%8E%95NL#
        0=≢params: 'no test parameter sets found'
        funs ← ⊃¨↓¯1↓⍤1↑params                            ⍝ Corresponding functions defined?
        testable ← funs/⍨funs∊⍵.⎕NL¯3
        result←⍵∘{(⍺.⍎⍵)_test ⍎⍵,'_testdata'}¨testable    ⍝ Run the tests
        ↑{⍺,('.'/⍨30-≢⍺),'[',(⍕+/⍵),'/',(⍕≢⍵),']'}⌿↑testable result ⍝ Format
    }
:EndNamespace

datatest.split_testdata←(' ' ('hello world') ('hello' 'world')) (',' ('hello,world') ('hello' 'world')) ⍝ dyadic function
datatest.isupper_testdata←(⍬ ('FOO') 1) (⍬ ('Foo') 0) (⍬ (,'F') 1) ⍝ monadic function

datatest.run ⎕THIS


