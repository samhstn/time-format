module Time.Format exposing
    ( format
    , monthToString
    , weekdayToString
    )

{-| Format time in elm with ease.

@docs format
@docs monthToString
@docs weekdayToString

-}

import Time exposing (Month(..), Weekday(..), Zone(..))


{-| monthToString returns Month as a `String`

Example:
monthToString Jan
-- "Jan"

-}
monthToString : Month -> String
monthToString month =
    case month of
        Jan ->
            "Jan"

        Feb ->
            "Feb"

        Mar ->
            "Mar"

        Apr ->
            "Apr"

        May ->
            "May"

        Jun ->
            "Jun"

        Jul ->
            "Jul"

        Aug ->
            "Aug"

        Sep ->
            "Sep"

        Oct ->
            "Oct"

        Nov ->
            "Nov"

        Dec ->
            "Dec"


{-| weekdayToString returns Weekday as a `String`

Example:
weekdayToString Mon
-- "Mon"

-}
weekdayToString : Weekday -> String
weekdayToString weekday =
    case weekday of
        Mon ->
            "Mon"

        Tue ->
            "Tue"

        Wed ->
            "Wed"

        Thu ->
            "Thu"

        Fri ->
            "Fri"

        Sat ->
            "Sat"

        Sun ->
            "Sun"


{-| Formats date from milliseconds based on a format string.
Strings which will be substitued with correct time:

"Millis"
"padMillis"
"Second"
"padSecond"
"Minute"
"padMinute"
"Hour"
"padHour"
"Weekday"
"Day"
"padDay"
"ordDay"
"Month"
"Year"

(example milliseconds can be obtained in js with:

```js
new Date("1 Jan 2018").getTime()
// => 1514764800000
```

)

Examples:
import Time exposing (utc)
import Time.Format as Time

format = Time.format utc

format "Weekday, Day Month Year at Hour:Minute:Second and Millisms" 1514764800000
-- "Mon, 1 Jan 2018 at 0:0:0 and 0ms"

format "Weekday, padDay Month Year at padHour:padMinute:padSecond and padMillisms" 1514764800000
-- "Mon, 01 Jan 2018 at 00:00:00 and 000ms"

format "Weekday, ordDay Month Year at Hour:Minute:Second and Millisms" 1514764800000
-- "Mon, 1st Jan 2018 at 0:0:0 and 0ms"

-}
format : Zone -> String -> Int -> String
format zone formatStr millis =
    let
        posix =
            Time.millisToPosix millis

        formatFunc =
            \f ->
                String.fromInt (f zone posix)
    in
    replace "padMillis" (formatFunc Time.toMillis |> String.padLeft 3 '0') formatStr
        |> replace "Millis" (formatFunc Time.toMillis)
        |> replace "padSecond" (formatFunc Time.toSecond |> String.padLeft 2 '0')
        |> replace "Second" (formatFunc Time.toSecond)
        |> replace "padMinute" (formatFunc Time.toMinute |> String.padLeft 2 '0')
        |> replace "Minute" (formatFunc Time.toMinute)
        |> replace "padHour" (formatFunc Time.toHour |> String.padLeft 2 '0')
        |> replace "Hour" (formatFunc Time.toHour)
        |> replace "padDay" (formatFunc Time.toDay |> String.padLeft 2 '0')
        |> replace "ordDay" (Time.toDay zone posix |> toOrd)
        |> replace "Day" (formatFunc Time.toDay)
        |> replace "Month" (monthToString (Time.toMonth zone posix))
        |> replace "Year" (formatFunc Time.toYear)
        |> replace "Weekday" (weekdayToString (Time.toWeekday zone posix))


toOrd : Int -> String
toOrd n =
    case n of
        1 ->
            "1st"

        2 ->
            "2st"

        3 ->
            "3rd"

        21 ->
            "21st"

        22 ->
            "22st"

        23 ->
            "23rd"

        31 ->
            "31st"

        _ ->
            String.fromInt n ++ "th"


replace : String -> String -> String -> String
replace substr newstr str =
    String.split substr str
        |> String.join newstr
