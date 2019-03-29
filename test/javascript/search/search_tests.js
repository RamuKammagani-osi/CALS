import React from 'react'
import {Search} from 'search/search'
import {shallow, mount} from 'enzyme'
import { BrowserRouter } from 'react-router-dom'

describe('Verify Search component', () => {
  let handleToggleSpy, searchComp, handleChangeSpy, handleInputChangeSpy, searchApiCallSpy,
    handleResetFormSpy, handlePageNumberChangeSpy, handleDropDownAndPageNumberChangeSpy, searchDictionariesCallSpy, searchUserDataCallSpy

  beforeEach(() => {
    handleToggleSpy = jasmine.createSpy('handleToggle')
    handleResetFormSpy = jasmine.createSpy('handleResetForm')
    searchApiCallSpy = jasmine.createSpy('searchApiCall')
    handleInputChangeSpy = jasmine.createSpy('handleInputChange')
    handlePageNumberChangeSpy = jasmine.createSpy('handlePageNumberChange')
    handleDropDownAndPageNumberChangeSpy = jasmine.createSpy('handleDropDownAndPageNumberChange')
    searchDictionariesCallSpy = jasmine.createSpy()
    searchUserDataCallSpy = jasmine.createSpy()

    const props = {
      totalNoOfResults: 13,
      pageNumber: 2,
      sizeValue: 5,
      isToggled: true,
      inputData: {
        'countyValue': '19'
      },
      facilityTypes: [
        {
          id: '',
          value: ''
        }
      ],
      countyTypes: [
        {
          id: '',
          value: ''
        }
      ],
      licenseStatuses: [
        {
          id: '',
          value: ''
        }
      ],
      searchResults: [
        {
          assigned_worker: 'Kari Gutierrez',
          county: 'Marin',
          district_office: 'NO. CAL SC/RES',
          fac_capacity: 7,
          fac_email_address: null,
          fac_last_visit_date: '1991-12-10',
          fac_lic_eff_date: '1992-02-22',
          fac_licensee_name: 'TERRIER PROGRAMS, INC.',
          fac_licensee_type: 'C',
          fac_mail_city: 'MODESTO',
          fac_mail_state: 'CA',
          fac_mail_street_addr: '767 GLEN EAGLES DRIVE',
          fac_mail_zip_code: '95350',
          fac_name: "DEPUTY DOG'S GROUP HOME",
          fac_nbr: 193600008,
          fac_orig_appl_rec_date: '1983-02-02',
          fac_res_city: 'MODESTO',
          fac_res_state: 'CA',
          fac_res_street_addr: '767 GLEN EAGLES DRIVE',
          fac_res_zip_code: '95350',
          facility_telephone: '8183366556',
          last_visit_reason: "Renewal (Fac.'s w/Expir.)",
          status: 'Licensed',
          type: 'Foster Family Home (Confidential - Do not release)'
        }
      ],
      handleToggle: handleToggleSpy,
      handleResetForm: handleResetFormSpy,
      searchApiCall: searchApiCallSpy,
      handleInputChange: handleInputChangeSpy,
      handlePageNumberChange: handlePageNumberChangeSpy,
      handleDropDownAndPageNumberChange: handleDropDownAndPageNumberChangeSpy,
      searchDictionariesCall: searchDictionariesCallSpy,
      searchUserDataCall: searchUserDataCallSpy
    }

    searchComp = mount(<BrowserRouter><Search {...props} /></BrowserRouter>)
  })

  it('Verify Search component render', () => {
    expect(searchComp.length).toBe(1)
  })

  it('verify page number input element is rendered', () => {
    expect(searchComp.find('.page_number').hostNodes().length).toBe(2)
  })

  it('verify handlePageNumberChange with no input  ', () => {
    const pageNumber = searchComp.find('.page_number').at(0)
    pageNumber.simulate('keydown', {which: 13, target: {value: ''}})
    expect(handlePageNumberChangeSpy).toHaveBeenCalledWith(1)
  })

  describe('#onPageChange', () => {
    it('when entered value is more than available pages', () => {
      const pageNumberInput = searchComp.find('.page_number').at(0)
      pageNumberInput.simulate('change', {target: {value: '4'}})
      expect(handlePageNumberChangeSpy).toHaveBeenCalledWith(3)
    })

    it('when entered value is equal to zero', () => {
      const pageNumberInput = searchComp.find('.page_number').at(0)
      pageNumberInput.simulate('change', {target: {value: '0'}})
      expect(handlePageNumberChangeSpy).toHaveBeenCalledWith(1)
    })

    it('when entered value is empty string', () => {
      const pageNumberInput = searchComp.find('.page_number').at(0)
      pageNumberInput.simulate('change', {target: {value: ' '}})
      expect(handlePageNumberChangeSpy).toHaveBeenCalledWith(1)
    })

    it('when entered value is one of the page numbers', () => {
      const pageNumberInput = searchComp.find('.page_number').at(0)
      pageNumberInput.simulate('change', {target: {value: '2'}})
      expect(handlePageNumberChangeSpy).toHaveBeenCalledWith('2')
    })
  })

  it('verify onclick for toggle button', () => {
    const searchFacility = searchComp.find('#search')
    searchFacility.simulate('submit')
    const handleToggleButton = searchComp.find('#toggle_button')
    handleToggleButton.simulate('click')
    expect(handleToggleSpy).toHaveBeenCalled()
  })

  it('verify dropDown value change number of facilities', () => {
    const dropdownForfacilitiesCount = searchComp.find('#noOfFacilities').at(1)
    dropdownForfacilitiesCount.simulate('change', {target: {options: {'5': {id: '5', value: '5'}, selectedIndex: 5}}})

    const expectedQuery = {
      'county.id': {query_type: 'term', value: '19'},
      'type.id': {query_type: 'term', value: undefined},
      'status.id': { query_type: 'term', value: undefined },
      'status.active': { query_type: 'term', value: undefined },
      'license_number': {query_type: 'match_phrase', value: undefined},
      'name': {query_type: 'query_string', value: undefined},
      'addresses.address': {query_type: 'query_string', value: undefined}
    }

    expect(searchApiCallSpy).toHaveBeenCalledWith(
      expectedQuery,
      {fromValue: 0, sizeValue: 5, sort: 'name.for_sort', order: 'asc'}
    )
  })

  it('verify county dropdown value change ', () => {
    const countyDropDownChange = searchComp.find('#county_select').hostNodes()
    countyDropDownChange.simulate('change', {target: {options: {'19': {id: '19', value: 'Los Angeles'}, selectedIndex: 19}}})
    expect(handleInputChangeSpy).toHaveBeenCalledWith('countyValue', 'Los Angeles')
  })
  it('verify clicking reset button calls resetForm method', () => {
    const resetForm = searchComp.find('#reset')
    resetForm.simulate('click')
    expect(handleResetFormSpy).toHaveBeenCalled()
  })

  it('verify clicking search button calls handleOnSubmit method', () => {
    const searchFacility = searchComp.find('#search')
    searchFacility.simulate('submit')

    const expectedQuery = {
      'county.id': {query_type: 'term', value: '19'},
      'type.id': {query_type: 'term', value: undefined},
      'status.id': { query_type: 'term', value: undefined },
      'status.active': { query_type: 'term', value: undefined },
      'license_number': {query_type: 'match_phrase', value: undefined},
      'name': {query_type: 'query_string', value: undefined},
      'addresses.address': {query_type: 'query_string', value: undefined}
    }

    expect(searchApiCallSpy).toHaveBeenCalledWith(
      expectedQuery,
      {fromValue: 0, sizeValue: 5, sort: 'name.for_sort', order: 'asc'}
    )
  })

  it('verify error messages', () => {
    const props = {
      errors: {
        'issue_details': [ {
          'incident_id': '95100850-f514-4365-9b93-6cbd28adcf27',
          'type': 'unexpected_exception',
          'user_message': 'There was an error processing your request. It has been logged with unique incident id',
          'technical_message': 'Bad Request',
          'stack_trace': 'gov.ca.cwds.rest.api.DoraException: Forbidden\\n\\'
        } ]
      },
      inputData: {
        'countyValue': '10'
      },
      facilityTypes: [
        {
          id: '',
          value: ''
        }
      ],
      countyTypes: [
        {
          id: '',
          value: ''
        }
      ],
      licenseStatuses: [
        {
          id: '',
          value: ''
        }
      ],
      searchResults: [],
      handlePageNumberChange: handlePageNumberChangeSpy,
      searchApiCall: searchApiCallSpy,
      searchDictionariesCall: searchDictionariesCallSpy,
      searchUserDataCall: searchUserDataCallSpy

    }
    searchComp = mount(<BrowserRouter><Search {...props} /></BrowserRouter>)
    const searchFacility = searchComp.find('#search')
    searchFacility.simulate('submit')
    expect(searchComp.text()).toContain('Message: There was an error processing your request')
  })
})
