import React from 'react'
import PropTypes from 'prop-types'
import {SmallInnerBlockDetails} from 'facility/smallInnerBlockDetails.js'
import { Card, CardBody, CardHeader, CardTitle } from '@cwds/components'

const FacilityCapacityView = ({
  label1,
  label2,
  label3,
  label4,
  value1,
  value2,
  value3,
  value4
}) => (
  <div className='facility-address'>
    <Card>
      <CardHeader>
        <CardTitle className='facilityCardTitle'>Capacity</CardTitle>
      </CardHeader>
      <CardBody>
        <div className='facility-address-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
          <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title={label1}
                value={value1} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title={label2}
                value={value2} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title={label3}
                value={value3} />
            </div>
          </div>
          <div className='col-xs-12 col-sm-3 col-md-3 col-lg-3'>
            <div className='inner_block'>
              <SmallInnerBlockDetails
                title={label4}
                value={value4} />
            </div>
          </div>
        </div>
      </CardBody>
    </Card>
  </div>
)

FacilityCapacityView.propTypes = {
  label1: PropTypes.string,
  label2: PropTypes.string,
  label3: PropTypes.string,
  label4: PropTypes.string,
  value1: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  value2: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  value3: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  value4: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ])
}

FacilityCapacityView.defaultProps = {
  value1: 'N/A',
  value2: 'N/A',
  value3: 'N/A',
  value4: 'N/A'
}

export default FacilityCapacityView
