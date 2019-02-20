import React from 'react'
import PropTypes from 'prop-types'
import {SmallInnerBlockDetails} from 'facility/smallInnerBlockDetails.js'

const FacilitySectionView = ({
  facilityAssignedWorker
}) => (
  <div className='facility-address'>
    <div className='facility-address-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
      <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='LICENSING / APPROVAL WORKER'
            value={facilityAssignedWorker.assignedWorkerFullName} />
        </div>
      </div>
      <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='LICENSING / APPROVAL WORKER PHONE NUMBER'
            value={facilityAssignedWorker.assignedWorkerPhoneNumber} />
        </div>
      </div>
      <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
        <div className='inner_block'>
          <SmallInnerBlockDetails
            title='LICENSING / APPROVAL WORKER EMAIL'
            value={facilityAssignedWorker.assignedWorkerEmail} />
        </div>
      </div>
    </div>
  </div>
)

FacilitySectionView.propTypes = {
  facilityAssignedWorker: PropTypes.object.isRequired
}
FacilitySectionView.defaultProps = {
  facilityAssignedWorker: {
    assignedWorkerFullName: 'N/A',
    assignedWorkerPhoneNumber: 'N/A',
    assignedWorkerEmail: 'N/A'
  }
}

export default FacilitySectionView
