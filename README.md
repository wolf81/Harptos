# Harptos

A small library for handling AD&D dates & times with regards to the Calendar of Harptos as displayed here:

![](docs/images/calendar-of-harptos.jpg?raw=true)

The goal of this library is to provide basic calendar functionality. I plan to use this library in a game I work on, but I believe others might be able to find a use for it as well.


## Requirements

The library is targetted towards iOS, macOS and tvOS platforms and written in Swift. The library will be distributed using Carthage.


## Functionality

My intention is to provide the following functionality:

- Creation of instants with a precision in seconds

- Adding & removing years, days, hours, minutes and seconds to calculate new days

- The library should be easy to use


## Code Structure

First it's important to understand time in AD&D according to the Harptos calender:

- A year exists out of 356 days or 366 days in a leap year
- Leap years occur every 4 years
- A month lasts for 30 days
- Between several months there are festivals that last for a day. 
- For normal years there are 5 festivals in a year, for leap years a 6th festival day is added
- (!) The aforementioned festivals are not part of any month

Because of the distinction between months and festivals, the library makes use of a `HarptosInstantProtocol` protocol to describe a moment (an instant) in time. A `HarptosDate` & `HarptosFestival` classes implement this protocol. 

`Instants` are created through the `HarptosCalendar` class. `Instants` are immutable, but once an Instant is retrieved it's possible to generate new `Instants` based on the existing one by calling modification functions.

A short example is as follows:

```
let date1 = HarptosCalendar.getDateFor(year: 1322, month: 3, day: 5)
let date2 = date1.instantByAdding(days: 1) as! HarptosDate
assert((date1.day + 1) == date2.day)
```

In the above example an immutable object `date1` is created and by calling the `instantByAdding(...)` method we create a new instant with a time that was based on the time of the `date1` object. 

Please note that since the `instantByAdding(...)` function returns an object conforming to `HarptosInstantProtocol`, one needs to typecast the `Instant` to read property values that are not available in the protocol. A `HarptosDate` contains a property `month`, but this property doesn't exist in `HarptosFestival`. When adding or removing time from an instant we could be dealing with objects of either type.

For my own purposes I don't believe I'll need to typecast much, so I don't see this as a big issue. The way I imagine how I'll use this library is as follows:

- At the start of the game I create a date that is appropriate for my setting.
- Every time a user plays a turn, some seconds are added.
- Only when displaying the current date somewhere in the screen, I might need to typecast, so I can show either `21 Hammer 1322 DR 14:05:22` or `Midwinter 1322 23:15:49`, depending on the casted type.

If the conversion is a bit of a hassle, I would probably add some date formatter classes.