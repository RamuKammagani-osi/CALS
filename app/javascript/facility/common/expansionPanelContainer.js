import React from 'react'
import PropTypes from 'prop-types'
import ApiErrorMessages from 'components/common/errors/apiErrorMessages'
import { withStyles } from '@material-ui/core/styles'
import ExpansionPanel from '@material-ui/core/ExpansionPanel'
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails'
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary'
import Typography from '@material-ui/core/Typography'
import ExpandMoreIcon from '@material-ui/icons/ExpandMore'

const styles = theme => ({
  root: {
    width: '100%',
    padding: '18px'
  },
  heading: {
    fontSize: '2rem',
    fontWeight: theme.typography.fontWeightRegular
  }
})

class ControlledExpansionPanels extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      expanded: true
    }
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange () {
    this.setState({
      expanded: !this.state.expanded
    })
  };

  render () {
    const { classes, summaryHeader, errors, children } = this.props
    const { expanded } = this.state

    return (
      <div className={classes.root}>
        <ExpansionPanel expanded={expanded} onChange={this.handleChange}>
          <ExpansionPanelSummary expandIcon={<ExpandMoreIcon />}>
            <Typography className={classes.heading}>{summaryHeader}</Typography>
          </ExpansionPanelSummary>
          <ExpansionPanelDetails>
            <ApiErrorMessages errors={errors.issue_details}/>
            {children}
          </ExpansionPanelDetails>
        </ExpansionPanel>
      </div>
    )
  }
}

ControlledExpansionPanels.propTypes = {
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(ControlledExpansionPanels)
