import React, { Component } from 'react'
import PropTypes from 'prop-types'
import FacilityDetails from 'facility/facilityDetails'
import FacilityAddress from 'facility/facilityAddress'
import Spinner from 'facility/common/spinner'
import FacilitySectionView from 'facility/common/facilitySectionView'
import FacilityCapacityView from 'facility/common/facilityCapacityView'

class FacilityWrapper extends React.Component {
  componentDidMount () {
    const params = {
      id: this.props.match.params.facility_id
    }
    this.props.facilityApiCall(params)
  }

  renderFacilityWrapper () {
    return (
      <div>

        <FacilityDetails
          facilityData={this.props.facilityData}
          facilityName={this.props.facilityName}
          errors={this.props.errors}
        />
        <FacilityCapacityView
          facilityData={this.props.facilityData}
        />
        <FacilityAddress
          facilityAddress={this.props.facilityAddress}
          facilityPhones={this.props.facilityPhones}
          otherFacilityData={this.props.otherFacilityData}
        />
        <FacilitySectionView
          facilityAssignedWorker={this.props.facilityAssignedWorker}
        />
      </div>
    )
  }
  render () {
    return (
      <div>
        {this.props.isFetching ? (
          <Spinner/>
        ) : this.renderFacilityWrapper()}
      </div>
    )
  }
}

FacilityWrapper.propTypes = {
  match: PropTypes.object,
  facilityApiCall: PropTypes.func,
  isFetching: PropTypes.bool,
  facilityData: PropTypes.object,
  facilityAddress: PropTypes.object,
  facilityPhones: PropTypes.object,
  otherFacilityData: PropTypes.object,
  errors: PropTypes.object
}

FacilityWrapper.defaultProps = {
  match: {
    params: {
      id: ''
    }
  }
}

export default FacilityWrapper
