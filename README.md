![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/wolf81/Harptos.svg) [![Build Status](https://travis-ci.org/wolf81/Harptos.svg?branch=master)](https://travis-ci.org/wolf81/Harptos) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Supported platforms](https://img.shields.io/static/v1.svg?label=platform&message=macOS%20|%20tvOS%20|%20iOS&color=lightgrey) [![docs](https://wolf81.github.io/HarptosDocs/badge.svg)](https://wolf81.github.io/HarptosDocs/) [![Codecov](https://img.shields.io/codecov/c/github/wolf81/Harptos.svg)](https://codecov.io/gh/wolf81/Harptos)

# Harptos

A small library for handling AD&D dates & times with regards to the Calendar of Harptos as displayed here:

![](https://raw.githubusercontent.com/wolf81/Harptos/master/calendar-of-harptos.jpg)

The goal of this library is to provide basic calendar functionality. I plan to use this library in a game I work on, but I believe others might be able to find a use for it as well.


## Requirements

The library is targetted towards iOS, macOS and tvOS platforms and written in Swift. The library is available using Carthage.


## Functionality

The goal of the library is to provide the following functionality:

- Allow creation of time objects based on the Calendar of Harptos

- The precision of time formats should be in seconds, since a round of play time in AD&D lasts for 6 seconds

- Allow manipulation of time objects (adding and removing days, hours, minutes, seconds, etc...)

- Allow formatting of time objects using custom format strings

Finally the library should also be easy to use.


## Usage

First it's important to understand time in AD&D according to the Harptos calender:

- A year exists out of 356 days or 366 days in a leap year
- Leap years occur every 4 years
- A month lasts for 30 days
- Between several months there are festivals that last for a day. 
- For normal years there are 5 festivals in a year, for leap years a 6th festival day is added
- The 5 (or 6 in leap years) special festivals that are added every year fall between months

### Creation of `HarptosTime` objects

Use the `HarptosCalendar` to create `HarptosTime` objects based on a date or a festival:

```swift
let date = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30, hour: 1, minute: 5, second: 2)
let festival = HarptosCalendar.getTimeFor(year: 1200, festival: .midwinter) 
```

### Manipulation of `HarptosTime` objects

In order to manipulate `HarptosTime` objects, use the appropriate methods on the `HarptosTime` objects:

```swift
let time1 = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 24, hour: 5, minute: 33, second: 5) // 1200 01 24 - 05:33:05
let time2 = time1.timeByAdding(days: 1) // 1200 01 25 - 05:33:05
```

For going in the past, use negative values, e.g.:

```swift
let time1 = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 24, hour: 5, minute: 33, second: 5) // 1200 01 24 - 05:33:05
let time2 = time1.timeByAdding(minutes: -30) // // 1200 01 24 - 05:03:05
```

### Using custom format strings with `HarptosTime` objects

It's possible to provide your own format strings. In order to do so, create a `HarptosTimeFormatter` and provide it with format strings for months and festivals:

```swift
let formatter = HarptosTimeFormatter(monthFormat: "dd MMM', 'YYYY 'DR'", festivalFormat: "M', 'Y")
let date = HarptosCalendar.getTimeFor(year: 1200, month: 1, day: 30, hour: 1, minute: 5, second: 2)
let dateString = formatter.string(from: date) // 30 Hammer, 1200 DR

let festival = HarptosCalendar.getTimeFor(year: 1322, festival: .moonfeast)
let festivalString = formatter.string(from: festival) // Moonfeast, The Year of Lurking Death
```

Format strings exist for hours, minutes, seconds, days, months and years. Festivals share format strings with months. Place text between single quotes to prevent formatting for some part of the format string.


## API documentation

For the API docs, please [check out the HarptosDocs website](https://wolf81.github.io/HarptosDocs/).