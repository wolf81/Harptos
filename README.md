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

In AD&D there are normally 365 days a year. There's a leap day added every 4 years. Every month has 30 days and 5 distict festival days exist in between (6 festival days during a leap year). Because of this distinction in festivals and "normal" dates, the library makes use of a `HarptosInstantProtocol` protocol to describe a moment in time. A `HarptosDate` & `HarptosFestival` classes implement this protocol. 

Instants (dates & festivals) are created through the HarptosCalendar class. Instants are immutable, but once an Instant is retrieved it's possible to generate new Instants by calling modification methods.

A short example is as follows:

```
let date1 = HarptosCalendar.getDateFor(year: 1322, month: 3, day: 5)
let date2 = date1.instantByAdding(days: 1) as! HarptosDate
assert((date1.day + 1) == date2.day)

```

Please note that since the `instantByAdding(...)` function returns an object conforming to `HarptosInstantProtocol`, one needs to typecast the Instant to the correct type. The casting is required because e.g. a day after 30 Hammer (a HarptosDate) the Midwinter festival (a HarptosFestival) occurs, which is not part of the Hammer month.

I believe the typecasting should not be a problem most of the time. The way I intend to use the library myself is to create a start date and from then on just add seconds after every play turn. Only when needing to display the `HarptosInstant`, the typecasting could be useful, though possibly not required if the provided string conversions for festivals and dates are sufficient.

I'm considering to allow consumers of the library to provide their own formatters for dates and festivals which could then be returned through the `description` property.
