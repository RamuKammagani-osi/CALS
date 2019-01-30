import React from 'react'
import PropTypes from 'prop-types'
import {SmallInnerBlockDetails} from './smallInnerBlockDetails'
import ApiErrorMessages from 'components/common/errors/apiErrorMessages'
import {facilityDetailsDefaults} from 'constants/defaultFields'
import { Card, CardBody, CardHeader, CardTitle } from '@cwds/components'

const FacilityDetails = ({
  facilityData,
  facilityName,
  errors
}) => (
  <div className='facility-details'>
    <ApiErrorMessages errors={errors.issue_details}/>
    <Card>
      <CardHeader>
        <CardTitle className='facilityCardTitle'>Summary</CardTitle>
      </CardHeader>
      <CardBody>
        <div className='facility_blocks col-xs-12 col-sm-12 col-md-12 col-lg-12'>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title='Facility / Home Name'
                value={facilityName} />
              <SmallInnerBlockDetails
                title='Name of Licensee / Parents'
                value={facilityData.licensee_name} />
              <SmallInnerBlockDetails
                title='Assigned Oversight Agency'
                value={facilityData.district_office} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title='License Number / Family ID'
                value={facilityData.license_number} />
              <SmallInnerBlockDetails
                title='License / Approval Effective Date'
                value={facilityData.license_effective_date} />
              <SmallInnerBlockDetails
                title='Status'
                value={facilityData.status} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title='Facility / Home Type'
                value={facilityData.type} />
              <SmallInnerBlockDetails
                title='Application Received Date'
                value={facilityData.original_application_recieved_date} />
            </div>
          </div>
        </div>
      </CardBody>
    </Card>
  </div>
)

FacilityDetails.propTypes = {
  facilityData: PropTypes.object,
  errors: PropTypes.object
}

FacilityDetails.defaultProps = {
  facilityData: facilityDetailsDefaults,
  errors: {
    issue_details: undefined
  }

}

export default FacilityDetails
