module Tests exposing (all)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Time exposing (Zone(..), utc)
import Time.Format as Time


format : String -> Int -> String
format =
    Time.format utc


all : Test
all =
    describe "Time.Format.format"
        [ test "\"\"" <|
            \() ->
                Expect.equal (format "" 100) ""
        , test "\"Millis\"" <|
            \() ->
                Expect.equal (format "Millis" 10) "10"
        , test "\"padMillis\"" <|
            \() ->
                Expect.equal (format "padMillis" 10) "010"
        , test "\"Second\"" <|
            \() ->
                Expect.equal (format "Second" 1000) "1"
        , test "\"padSecond\"" <|
            \() ->
                Expect.equal (format "padSecond" 1000) "01"
        , test "\"Minute\"" <|
            \() ->
                Expect.equal (format "Minute" (60 * 1000)) "1"
        , test "\"padMinute\"" <|
            \() ->
                Expect.equal (format "padMinute" (60 * 1000)) "01"
        , test "\"Hour\"" <|
            \() ->
                Expect.equal (format "Hour" (60 * 60 * 1000)) "1"
        , test "\"padHour\"" <|
            \() ->
                Expect.equal (format "padHour" (60 * 60 * 1000)) "01"
        , test "\"Day\" 0 millis" <|
            \() ->
                Expect.equal (format "Day" 0) "1"
        , test "\"Day\" 1 day millis" <|
            \() ->
                Expect.equal (format "Day" (24 * 60 * 60 * 1000)) "2"
        , test "\"padDay\"" <|
            \() ->
                Expect.equal (format "padDay" 0) "01"
        , test "\"ordDay\"" <|
            \() ->
                Expect.equal (format "ordDay" 0) "1st"
        , test "\"Month\"" <|
            \() ->
                Expect.equal (format "Month" 0) "Jan"
        , test "\"Month\" Feb" <|
            \() ->
                Expect.equal (format "Month" (32 * 24 * 60 * 60 * 1000)) "Feb"
        , test "\"Year\"" <|
            \() ->
                Expect.equal (format "Year" 0) "1970"
        , test "\"Year\" 1971" <|
            \() ->
                Expect.equal (format "Year" (367 * 24 * 60 * 60 * 1000)) "1971"
        , test "\"Weekday\"" <|
            \() ->
                Expect.equal (format "Weekday" 0) "Thu"
        , test "\"Second, Millis\"" <|
            \() ->
                Expect.equal (format "Second, Millis" 1001) "1, 1"
        , test "\"Weekday, Day Month Year at Hour:Minute:Second and Millisms\"" <|
            \() ->
                let
                    formatStr =
                        "Weekday, Day Month Year at Hour:Minute:Second and Millisms"
                in
                Expect.equal (format formatStr 1514764800000) "Mon, 1 Jan 2018 at 0:0:0 and 0ms"
        , test "\"Weekday, padDay Month Year at padHour:padMinute:padSecond and padMillisms\"" <|
            \() ->
                let
                    formatStr =
                        "Weekday, padDay Month Year at padHour:padMinute:padSecond and padMillisms"
                in
                Expect.equal (format formatStr 1514764800000) "Mon, 01 Jan 2018 at 00:00:00 and 000ms"
        , test "\"Weekday, ordDay Month Year at Hour:Minute:Second and Millisms\"" <|
            \() ->
                let
                    formatStr =
                        "Weekday, ordDay Month Year at Hour:Minute:Second and Millisms"
                in
                Expect.equal (format formatStr 1514764800000) "Mon, 1st Jan 2018 at 0:0:0 and 0ms"
        ]
