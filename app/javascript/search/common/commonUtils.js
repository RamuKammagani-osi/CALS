import React from 'react'
import Moment from 'moment'
import escapeElastic from 'elasticsearch-sanitize'

export const isLisFacility = value => value === 'LIS'

export const respectiveStreetAddressOrNA = (addresses, addressType) => {
  const addressObject = addresses && addresses.find(o => o.type === addressType)
  if (addressObject && addressObject.address.street_address) {
    return addressObject.address.street_address + ','
  } else {
    return 'N/A'
  }
}

export const cityStateZipOfRespectiveAddressOrNA = (addresses, addressType) => {
  const addressObject = addresses && addresses.find(o => o.type === addressType)
  if (addressObject) {
    const cityStateString = checkForValueOrBlank(addressObject.address.city) + ', ' + checkForValueOrBlank(addressObject.address.state) + ' ' + checkForValueOrBlank(addressObject.address.zip_code)
    return cityStateString === ',  ' ? '' : cityStateString
  } else {
    return 'N/A'
  }
}

export const checkForValueOrBlank = (value) => {
  return value || ''
}

export const checkForValue = (value) => {
  return value || undefined
}

export const checkAndSplitValue = (value) => {
  if (value !== undefined || '') {
    const filteredSet = ['']
    const query = value.split(' ').filter((val) => !filteredSet.includes(val)).map((val) => '*' + escapeElastic(val) + '*').join(' ')
    return query
  }
  return undefined
}

export const getArrayOfId = (array) => {
  if (array && array.length > 0) {
    return array.map((e) => (e.id))
  }
  return undefined
}

export const checkForLicenseStatus = (isAllActive, statusValue) => {
  return isAllActive ? '' : getArrayOfId(statusValue)
}

export const respectiveNumberOrNA = (phones, phoneRelation) => {
  const phoneObject = phones && phones.find(o => o.relation === phoneRelation)
  if (phoneObject && Boolean(phoneObject.number)) {
    return formatPhoneNumberForDashes(phoneObject.number)
  } else {
    return 'N/A'
  }
}

export const respectiveFullAddressOrNA = (addresses, addressType) => {
  const addressObject = addresses && addresses.find(o => o.type === addressType)
  if (addressObject) {
    const stringForFullAddress = checkForValueOrBlank(addressObject.address.street_address) + ', ' + checkForValueOrBlank(addressObject.address.city) + ', ' + checkForValueOrBlank(addressObject.address.state) + ' ' + checkForValueOrBlank(addressObject.address.zip_code)
    return stringForFullAddress === ', ,  ' ? '' : stringForFullAddress
  } else {
    return 'N/A'
  }
}

export const checkforDateOrNa = (date) => {
  if (date) {
    return date.split(' ')[0].replace(/(\d{4})-(\d{2})-(\d{2})/, '$2/$3/$1')
  }
  return 'N/A'
}

export const sortbyDate = (a, b) => {
  const dateA = new Date(a).getTime()
  const dateB = new Date(b).getTime()
  return dateA > dateB ? 1 : -1
}

export const formatPhoneNumberForDashes = (phone) => {
  return phone.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3')
}

export const checkForNA = (object) => {
  return (object && object.value) ? object.value : 'N/A'
}

export const checkForObjectAndValue = (object, key) => {
  return (object && object[key]) ? object[key] : 'N/A'
}

export const checkNameorNA = (object) => {
  return (object && object.name) ? object.name : 'N/A'
}

export const checkPhoneNumberOrNA = (object, objectPhoneNumberRelation) => {
  return object ? respectiveNumberOrNA(object.phones, objectPhoneNumberRelation) : 'N/A'
}

export const checkfullNameorNA = (object) => {
  return object ? `${object.first_name} ${object.last_name}` : 'N/A'
}

export const checkNullOrEmptyValue = (value) => {
  return (value === null || value === '') ? 'N/A' : value
}

export const primaryPhoneRelation = 'primary'

export const alternativePhoneRelation = 'alternate'

export const physicalAddressType = 'Residential'

export const mailingAddressType = 'Mailing'

export const cwsStatuses = ['Licensed', 'RFA Approved']

export const resultsPerPage = ['5', '10', '25', '50', '100']

export const NoSearchResultsErrorMessage = 'No results were found with the selected search criteria, please refine your search criteria and try again.'

export const NoSearchCriteriaMessage = 'Please select search criteria and try again.'

export const handleLicenseEffectiveDate = (result) => {
  const source = result.facility_source
  const date = result.license_effective_date
  if (isLisFacility(source)) {
    return checkforDateOrNa(date)
  }
  const cwsStatus = result.status
  if (cwsStatus && cwsStatuses.indexOf(cwsStatus.value) >= 0) {
    return checkforDateOrNa(date)
  }
  return 'N/A'
}

export const handleStatus = (status) => {
  switch (status) {
    case 'SUBMITTED':
      return 'Submitted'
    case 'IN_PROGRESS':
      return 'In-Progress'
    case 'DRAFT':
      return 'Draft'
    default:
      return ''
  }
}

export const defaultDateFormat = 'MM/DD/YYYY'

export const formatDate = (date, format) => { return Moment(date).local().format(format || defaultDateFormat) }
