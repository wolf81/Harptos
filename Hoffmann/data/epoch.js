import _floor from 'lodash/floor';
import _reduce from 'lodash/reduce';

import calendar from './calendar';

const yearEpoch = year => (year * 525600) + (_floor(year / 4) * 1440);

const monthEpoch = (month, year) => _reduce(calendar.months, (sum, m) => {
  let monthMinutes = 0;
  if(m.id < month) {
    monthMinutes += month.holiday
      ? 1440 * 31  // 44640
      : 1440 * 30  // 43200;

    if(m.id === 7 && year % 4 === 0) {
      monthMinutes += 1440;
    }
  }
  return monthMinutes + sum;
}, 0);

const dayEpoch = day => day * 1440;

export const epoch = (year, month, day) => {
  return yearEpoch(year) + monthEpoch(month, year) + dayEpoch(day);
};
