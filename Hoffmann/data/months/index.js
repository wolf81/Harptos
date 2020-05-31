import _sortBy from 'lodash/sortBy';

import hammer from './hammer';
import alturiak from './alturiak';
import ches from './ches';
import tarsakh from './tarsakh';
import mirtul from './mirtul';
import kythorn from './kythorn';
import flamerule from './flamerule';
import eleasis from './eleasis';
import eleint from './eleint';
import marpenoth from './marpenoth';
import uktar from './uktar';
import nightal from './nightal';

export default _sortBy({
  hammer,
  alturiak,
  ches,
  tarsakh,
  mirtul,
  kythorn,
  flamerule,
  eleasis,
  eleint,
  marpenoth,
  uktar,
  nightal,
}, ['id']);
