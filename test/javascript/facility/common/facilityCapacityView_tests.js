import React from 'react'
import FacilityCapacityView from 'facility/common/facilityCapacityView'
import {shallow, mount} from 'enzyme'

describe('Verify Facility Capacity block', () => {
  const props = {
    facilityData: {
      capacity: 0,
      adjusted_capacity: 0,
      available_beds: 0,
      capacity_last_changed: '12/12/2O12'
    }
  }
  const FacilityCapacityCompShallow = shallow(<FacilityCapacityView {...props} />)
  it('verify Facility Capacity', () => {
    expect(FacilityCapacityCompShallow.find('SmallInnerBlockDetails[title="CAPACITY"]').props().value).toBe(0)
  })
  it('verify Facility Available beds', () => {
    expect(FacilityCapacityCompShallow.find('SmallInnerBlockDetails[title="ADJUSTED CAPACITY"]').props().value).toBe(0)
  })
  it('verify Facility Available beds', () => {
    expect(FacilityCapacityCompShallow.find('SmallInnerBlockDetails[title="AVAILABLE BEDS"]').props().value).toBe(0)
  })
  it('verify Facility Capacity last changed', () => {
    expect(FacilityCapacityCompShallow.find('SmallInnerBlockDetails[title="CAPACITY LAST CHANGED"]').props().value).toBe('12/12/2O12')
  })
  it('should display the N/A label when facility data is undefined', () => {
    const props = {
      facilityData: {
        capacity: 0,
        adjusted_capacity: undefined,
        available_beds: 0,
        capacity_last_changed: '12/12/2O12'
      }
    }
    const FacilityCapacityCompShallow = shallow(<FacilityCapacityView {...props} />)
    expect(FacilityCapacityCompShallow.find('SmallInnerBlockDetails[title="ADJUSTED CAPACITY"]').props().value).toBe('N/A')
  })
})
