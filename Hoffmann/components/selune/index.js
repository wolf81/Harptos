import React from 'react';

import { epoch } from '../../data/epoch';

const moonPhase = (year, month, day) => {
  // 43200 + 600 + 30
  const phase = 1 - ((epoch(year, month, day) - epoch(1372, 1, 1)) % 43830) / 43830;

  console.log(`${day}/${month}/${year}: ${phase}`);

  if(phase <= 0.25) return { arc: 20 - 20 * phase * 4, sweep: [1, 0] };
  if(phase <= 0.50) return { arc: 20 * (phase - 0.25) * 4, sweep: [0, 0] };
  if(phase <= 0.75) return { arc: 20 - 20 * (phase - 0.50) * 4, sweep: [1, 1] };
  if(phase <= 1) return { arc: 20 * (phase - 0.75) * 4, sweep: [0, 1] };
};

export default ({ year, month, day }) => {
  const phase = moonPhase(year, month, day);

  return (
    <svg viewBox="0 0 200 200">
      <path fill="#000" stroke="#FFF" strokeWidth={1} d="m100,0 a20,20 0 1,1 0,150 a20,20 0 1,1 0,-150" />
      <path fill="#D6D5C0" d={`m100,0 a${phase.arc},20 0 1,${phase.sweep[0]} 0,150 a20,20 0 1,${phase.sweep[1]} 0,-150`} />
    </svg>
  )
};
