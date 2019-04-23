import { checkAndSplitValue, checkForLicenseStatus, sortbyDate, formatDate, isLisFacility, handleLicenseEffectiveDate } from 'search/common/commonUtils.js'

describe('check and split value method with different inputs', () => {
  it('should return wildcard tokens attached to both words', () => {
    const input = 'home residence'
    const output = '*home* *residence*'
    expect(checkAndSplitValue(input)).toEqual(output)
  })
  it('should return undefined if empty string is passed', () => {
    const input = undefined
    expect(checkAndSplitValue(input)).toEqual(undefined)
  })
  it('should return undefined if empty string is passed', () => {
    const input = '2870 gateway oaks sacramento, CA, 95833'
    expect(checkAndSplitValue(input)).toEqual('*2870* *gateway* *oaks* *sacramento,* *CA,* *95833*')
  })
  it('should return empty string if empty string is passed', () => {
    const input = ''
    expect(checkAndSplitValue(input)).toEqual('')
  })
  it('should return empty string if special character * is passed', () => {
    const input = '*'
    expect(checkAndSplitValue(input)).toEqual('*\\**')
  })
  it('should return escape characters string if special character ( is passed', () => {
    const input = 'FST FFH (On Hold)'
    const output = '*FST* *FFH* *\\(On* *Hold\\)*'
    expect(checkAndSplitValue(input)).toEqual(output)
  })
  it('should return escape characters string if special character ( is passed', () => {
    const input = 'FST FFH (On Hold) [][][][]][][]][][[]][][][][]['
    const output = '*FST* *FFH* *\\(On* *Hold\\)* *\\[\\]\\[\\]\\[\\]\\[\\]\\]\\[\\]\\[\\]\\]\\[\\]\\[\\[\\]\\]\\[\\]\\[\\]\\[\\]\\[\\]\\[*'
    expect(checkAndSplitValue(input)).toEqual(output)
  })
})

describe('check licenseStatus based on isAllActive flag', () => {
  it('should return empty string', () => {
    const isAllActive = true
    const statusValue = [{id: 8, value: 'Application Denied'}, {id: 7, value: 'Application Withdrawn'}]
    const output = ''
    expect(checkForLicenseStatus(isAllActive, statusValue)).toEqual(output)
  })
  it('should return an array', () => {
    const isAllActive = false
    const statusValue = [{id: 8, value: 'Application Denied'}, {id: 7, value: 'Application Withdrawn'}]
    const output = [8, 7]
    expect(checkForLicenseStatus(isAllActive, statusValue)).toEqual(output)
  })
})

describe('sort by date ', () => {
  it('should return asc order', () => {
    const a = '11/03/2001'
    const b = '04/30/2004'
    const output = -1
    expect(sortbyDate(a, b)).toEqual(output)
  })
  it('should return desc order', () => {
    const a = '11/03/2004'
    const b = '04/30/2001'
    const output = 1
    expect(sortbyDate(a, b)).toEqual(output)
  })
})

describe('format date', () => {
  it('should return formatted date by default ', () => {
    expect(formatDate('1978-12-31')).toEqual('12/31/1978')
  })
  it('should return custom formatted date', () => {
    expect(formatDate('1978-12-31', 'DD/MM/YYYY')).toEqual('31/12/1978')
  })
})

describe('check if facility source is LIS or CWS/CMS', () => {
  it('should return true for LIS facilities', () => {
    expect(isLisFacility('LIS')).toEqual(true)
  })
  it('should return false for CWS/CMS facilities', () => {
    expect(isLisFacility('CWS/CMS')).toEqual(false)
  })
})

describe('check if license effective date or N/A is returned for LIS facilities', () => {
  let lisFacilityWithDate = {
    facility_source: 'LIS',
    license_effective_date: '1978-12-31',
    'status': {
      'id': '1',
      'value': 'Unlicensed'
    }
  }
  let lisFacilityWithoutDate = {
    facility_source: 'LIS',
    status: 'Unlicensed'
  }
  it('should return valid date for LIS facility with license effective date', () => {
    expect(handleLicenseEffectiveDate(lisFacilityWithDate)).toEqual('12/31/1978')
  })
  it('should return N/A for LIS facility without license effective date', () => {
    expect(handleLicenseEffectiveDate(lisFacilityWithoutDate)).toEqual('N/A')
  })
})

describe('check if license effective date or N/A is returned for CWS/CMS facilities', () => {
  let cwsFacilityWithLicensedStatus = {
    facility_source: 'CWS/CMS',
    license_effective_date: '1978-12-31',
    'status': {
      'id': '3',
      'value': 'Licensed'
    }
  }
  let cwsFacilityWithRfaApprovedStatus = {
    facility_source: 'CWS/CMS',
    license_effective_date: '1978-12-31',
    'status': {
      'id': '30',
      'value': 'RFA Approved'
    }
  }
  let cwsFacilityUnlicensedLicense = {
    facility_source: 'CWS/CMS',
    license_effective_date: '1978-12-31',
    'status': {
      'id': '1',
      'value': 'Unlicensed'
    }
  }
  let cwsFacilityWithoutDate = {
    facility_source: 'CWS/CMS',
    'status': {
      'id': '3',
      'value': 'Licensed'
    }
  }
  let cwsFacilityWithoutLicenseStatus = {
    facility_source: 'CWS/CMS',
    license_effective_date: '1978-12-31'
  }
  it('should return valid date for CWS/CMS facility with Licensed status and license effective date', () => {
    expect(handleLicenseEffectiveDate(cwsFacilityWithLicensedStatus)).toEqual('12/31/1978')
  })
  it('should return valid date for CWS/CMS facility with RFA Approved status and license effective date', () => {
    expect(handleLicenseEffectiveDate(cwsFacilityWithRfaApprovedStatus)).toEqual('12/31/1978')
  })
  it('should return N/A for CWS/CMS facility with Unlicensed status and license effective date', () => {
    expect(handleLicenseEffectiveDate(cwsFacilityUnlicensedLicense)).toEqual('N/A')
  })
  it('should return N/A for CWS/CMS facility without effective date', () => {
    expect(handleLicenseEffectiveDate(cwsFacilityWithoutDate)).toEqual('N/A')
  })
  it('should return N/A for CWS/CMS facility without license status', () => {
    expect(handleLicenseEffectiveDate(cwsFacilityWithoutLicenseStatus)).toEqual('N/A')
  })
})
