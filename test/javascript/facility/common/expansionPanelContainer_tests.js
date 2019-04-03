import React from 'react'
import ControlledExpansionPanel from 'facility/common/expansionPanelContainer'
import {shallow, mount} from 'enzyme'
import { ExpansionPanel } from '@material-ui/core'

describe('Verify expansion panel', () => {
  const props = {
    errors: {issue_details: undefined},
    children: 'Hello',
    summaryHeader: 'Hello from Summary'
  }
  const VerifyExpansionPanelMount = mount(<ControlledExpansionPanel {...props} />)
  it('Verify expansion panel exists', () => {
    expect(VerifyExpansionPanelMount.find('ExpansionPanel').length).toBe(1)
  })
  it('verify expansion panel summary exists', () => {
    expect(VerifyExpansionPanelMount.find('ExpansionPanelSummary').length).toBe(1)
  })
  it('verify expansion details exists', () => {
    expect(VerifyExpansionPanelMount.find('ExpansionPanelDetails').length).toBe(1)
  })
  it('verify expansion panel expanded props', () => {
    expect(VerifyExpansionPanelMount.find('ExpansionPanel').props().expanded).toBe(true)
  })
  it('verify expansion panel expanded onChange', () => {
    VerifyExpansionPanelMount.setState({
      expanded: true
    })
    VerifyExpansionPanelMount.find(ExpansionPanel).props().onChange()
    VerifyExpansionPanelMount.update()
    expect(VerifyExpansionPanelMount.find('ExpansionPanel').props().expanded).toBe(false)
  })
})
