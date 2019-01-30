import React from 'react'
import PropTypes from 'prop-types'
import {SmallInnerBlockDetails} from './smallInnerBlockDetails.js'
import {InnerBlockAddressTitles} from './innerBlockAddressTitles.js'
import { Card, CardBody, CardHeader, CardTitle } from '@cwds/components'

const FacilityAddress = ({
  facilityAddress,
  facilityPhones,
  otherFacilityData
}) => (
  <div className='facility-address'>
    <Card>
      <CardHeader>
        <CardTitle className='facilityCardTitle'>Home Information</CardTitle>
      </CardHeader>
      <CardBody>
        <div className='facility-address-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <InnerBlockAddressTitles
                title='Physical Address'
                streetApt={facilityAddress.physicalStreetAddress}
                cityCountry={facilityAddress.physicalAddressCityZipState} />
              <SmallInnerBlockDetails
                title='County Name'
                value={otherFacilityData.county} />
              <SmallInnerBlockDetails
                title='Primary Phone'
                value={facilityPhones.primaryPhoneNumber} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <InnerBlockAddressTitles
                title='Postal Address'
                streetApt={facilityAddress.mailingStreetAddress}
                cityCountry={facilityAddress.mailingAddressCityZipState} />
              <SmallInnerBlockDetails
                title='Alternative Phone'
                value={facilityPhones.alternativePhoneNumber} />
              <SmallInnerBlockDetails
                title='Last Visit Reason'
                value={otherFacilityData.lastVisitReason} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title='Last Visit Date'
                value={otherFacilityData.lastVisitDate} />
            </div>
          </div>
        </div>
      </CardBody>
    </Card>
  </div>
)

FacilityAddress.propTypes = {
  facilityAddress: PropTypes.object,
  facilityPhones: PropTypes.object,
  otherFacilityData: PropTypes.object
}

FacilityAddress.defaultProps = {
  facilityAddress: {
    physicalStreetAddress: '',
    physicalAddressCityZipState: '',
    mailingStreetAddress: '',
    mailingAddressCityZipState: ''
  },
  facilityPhones: {
    primaryPhoneNumber: '',
    alternativePhoneNumber: ''
  },
  otherFacilityData: {
    county: '',
    lastVisitDate: '',
    lastVisitReason: ''
  }
}

export default FacilityAddress
