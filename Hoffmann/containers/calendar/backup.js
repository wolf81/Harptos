import React from 'react';
import _find from 'lodash/find';

import calendar from '../../data/calendar';
import years from '../../data/years';

import Selune from '../../components/selune';

import { Calendar } from '../../styles/calendar';
import { MonthContainer, Month, MonthHeader } from '../../styles/calendar/month';
import { Week } from '../../styles/calendar/week';
import { Day, DayContainer } from '../../styles/calendar/day';



export default ({ match }) => {
  const { year, name: yearName } = _find(years, {
    // Defaulting to 1493 for ... reasons.
    year: parseInt((match.params.year || 1493), 10)
  });

  // Every 4 years is a leap year for this calendar.
  const isLeapYear = year%4 === 0;

  return (
    <Calendar>
      {`${year}DR - ${yearName}`}
      {calendar.months.map(month => (
        <MonthContainer key={month.id}>
          <Month>
            <MonthHeader>{month.name}</MonthHeader>
            {month.weeks.map(week => (
              <Week key={week.id}>
                {week.days.map(day => (
                  <DayContainer key={day.id}>
                    <Day>
                      {day.id}
                      <Selune year={year} month={month.id} day={day.id} />
                    </Day>
                  </DayContainer>
                ))}
              </Week>
            ))}
          </Month>
          {month.holiday && <div>
            <span>{month.holiday.name}</span>
            <Selune year={year} month={month.id} day={31} />
          </div>}
          {isLeapYear && month.id === 7 &&
            <div>
              <span>Shieldmeet</span>
              <Selune year={year} month={month.id} day={32} />
            </div>
          }
        </MonthContainer>
      ))}
    </Calendar>
  )
};