import React, { Component } from 'react'
import PropTypes from 'prop-types'
import PageHeaderWrapperContainer from 'containers/pageHeaderWrapperContainer'
import FacilityWrapperContainer from 'containers/facilityWrapperContainer'
import FacilityChildrenContainer from 'containers/facilityChildrenContainer'
import FacilityComplaintsContainer from 'containers/facilityComplaintsContainer'

export default class Facility extends React.Component {
  componentDidMount () {
    window.scrollTo(0, 0)
  }
  render () {
    return (
      <div className='main_page'>
        <PageHeaderWrapperContainer />
        <div className='body_cwds col-xs-12 col-sm-12 col-md-12 col-lg-12'>
          <FacilityWrapperContainer match={this.props.match}/>
          <FacilityChildrenContainer match={this.props.match}/>
          <FacilityComplaintsContainer match={this.props.match}/>
        </div>
      </div>
    )
  }
}

Facility.propTypes = {
  match: PropTypes.object
}
