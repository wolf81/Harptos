import React from 'react';
import _find from 'lodash/find';
import { MuiThemeProvider } from '@material-ui/core/styles';

import { rally } from '../../styles/theme';
import calendar from '../../data/calendar';
import years from '../../data/years';

import Bar from '../../components/bar';
import Months from '../../components/month/month-container';

export default ({ match }) => {
  const { year:yearParam = 1493, month:monthParam = 1 } = match.params;

  const year = _find(years, y => y.year == yearParam); // eslint-disable-line eqeqeq
  const month = _find(calendar.months, m => m.id == monthParam); // eslint-disable-line eqeqeq

  return (
    <MuiThemeProvider theme={rally}>
      <Bar year={year} month={month} />
      <Months months={calendar.months} />
    </MuiThemeProvider>
  )
};
