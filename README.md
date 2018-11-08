[![Build Status](https://travis-ci.org/samhstn/elm-time-format.svg?branch=master)](https://travis-ci.org/samhstn/elm-time-format)

# Elm Time Format

### Installation

```bash
elm install samhstn/format-time
```

### Documentation

Format time in elm with ease.

Pass a `formatString` along with a `milliseconds` `Int` to return a time formatted `String`.

|`String` to be replaced/formatted|What the `String` will be replaced with|
| --- | --- |
|`"Millis"`|Milliseconds as a `String`|
|`"padMillis"`|Milliseconds as a `String` always with 3 digits|
|`"Second"`|Seconds as a `String`|
|`"padSecond"`|Seconds as a `String` always with 2 digits|
|`"Minute"`|Minutes as a `String`|
|`"padMinute"`|Minutes as a `String` always with 2 digits|
|`"Hour"`|Hours as a `String`|
|`"padHour"`|Hours as a `String` always with 2 digits|
|`"Weekday"`|Weekday as a `String`|
|`"Day"`|Day of month as a `String`|
|`"padDay"`|Day of month as a `String` always with 2 digits|
|`"ordDay"`|Day of month as an ordinal number `String`|
|`"Month"`|Month as a `String`|
|`"Year"`|Year as a `String`|

### Examples:

(example milliseconds can be obtained in js with:

```js
new Date("1 Jan 2018").getTime()
// => 1514764800000
```
)

```elm
import Time exposing (utc)
import Time.Format as Time

{- Time.format example: -}

format = Time.format utc

format "Weekday, Day Month Year at Hour:Minute:Second and Millisms" 1514764800000
-- "Mon, 1 Jan 2018 at 0:0:0 and 0ms"

format "Weekday, padDay Month Year at padHour:padMinute:padSecond and padMillisms" 1514764800000
-- "Mon, 01 Jan 2018 at 00:00:00 and 000ms"

format "Weekday, ordDay Month Year at Hour:Minute:Second and Millisms" 1514764800000
-- "Mon, 1st Jan 2018 at 0:0:0 and 0ms"

{- Time.weekdayToString example: -}

Time.weekdayToString Mon
-- "Mon"

{- Time.monthToString Jan example: -}

Time.weekdayToString Jan
-- "Jan"
```
