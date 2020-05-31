import React from 'react';

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton'

import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import faArrowAltSquareLeft from '@fortawesome/fontawesome-pro-light/faArrowAltSquareLeft';
import faArrowAltSquareRight from '@fortawesome/fontawesome-pro-light/faArrowAltSquareRight';

import { withStyles } from '@material-ui/core/styles';

const Bar = ({ year, month, classes }) => (
  <AppBar position="sticky" color="default">
    <Toolbar className={classes.toolbar}>
      <IconButton>
        <FontAwesomeIcon icon={faArrowAltSquareLeft} />
      </IconButton>
      <Typography variant="title" color="inherit">
        {`${year.year}DR - ${year.name}`}
      </Typography>
      <IconButton>
        <FontAwesomeIcon icon={faArrowAltSquareRight} />
      </IconButton>
    </Toolbar>
  </AppBar>
);

export default withStyles({
  toolbar: {
    display: 'flex',
    justifyContent: 'space-between'
  }
})(Bar);
