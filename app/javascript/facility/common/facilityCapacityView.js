import React from 'react'
import PropTypes from 'prop-types'
import {SmallInnerBlockDetails} from 'facility/smallInnerBlockDetails.js'

const FacilityCapacityView = ({
  facilityData
}) => (
  <div className='facility-address'>
    <div className='facility-address-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
      <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='CAPACITY'
            value={facilityData.capacity} />
        </div>
      </div>
      <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='ADJUSTED CAPACITY'
            value={facilityData.adjusted_capacity} />
        </div>
      </div>
      <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='AVAILABLE BEDS'
            value={facilityData.available_beds} />
        </div>
      </div>
      <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='CAPACITY LAST CHANGED'
            value={facilityData.capacity_last_changed} />
        </div>
      </div>
    </div>
  </div>
)

FacilityCapacityView.propTypes = {
  facilityData: PropTypes.object.isRequired
}

FacilityCapacityView.defaultProps = {
  facilityData: {
    capacity: 'N/A',
    adjusted_capacity: 'N/A',
    available_beds: 'N/A',
    capacity_last_changed: 'N/A'
  }
}

export default FacilityCapacityView
