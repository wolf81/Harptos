import _map from 'lodash/map';
import _times from 'lodash/times';

import months from './months';

export default {
  months: _map(months, month => ({
    ...month,
    weeks: _times(3, week => ({
      id: week,
      days: _times(10, day => ({
        id: day+(week*10)+1,
      })),
    })),
  })),
};
