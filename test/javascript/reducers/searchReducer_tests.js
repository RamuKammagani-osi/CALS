import {searchReducer} from 'reducers/searchReducer'
import {countyTypes, facilityTypes, licenseStatuses, user} from '../helpers/constants'
import {
  searchApiCall,
  searchUserDataCall,
  fetchUserDataSuccess,
  handleInputChange,
  handleDropDownChange,
  handleDropDownAndPageNumberChange,
  handlePageNumberChange,
  handleResetForm,
  handleToggle,
  fetchSuccess,
  fetchFailure,
  fetchNoSearchCriteria
} from 'actions/searchActions'

import {NoSearchResultsErrorMessage, NoSearchCriteriaMessage} from 'search/common/commonUtils'

describe('Verify searchReducer', () => {
  let initialState

  beforeEach(() => {
    initialState = {
      inputData: { },
      searchResults: undefined,
      totalNoOfResults: 0,
      isToggled: true,
      sizeValue: 50,
      pageNumber: 1,
      errors: {},
      userCounty: '',
      searchStatus: '',
      errorMessage: undefined
    }
  })

  it('default returns initial state', () => {
    expect(searchReducer(undefined, {})).toEqual(initialState)
  })

  it('input change returns updated state with inputData', () => {
    const inputChangeAction = handleInputChange('facilityNameValue', 'good home')

    const outputState = initialState
    outputState.inputData = {
      facilityNameValue: 'good home'
    }

    expect(searchReducer(undefined, inputChangeAction)).toEqual(outputState)
  })

  it('fetch call completion returns updated state with search results', () => {
    const fetchSuccessAction = fetchSuccess({
      searchResults: {id: 5, name: 'John'},
      total: 1
    })

    const outputState = initialState
    outputState.searchResults = {id: 5, name: 'John'}
    outputState.totalNoOfResults = 1
    outputState.searchStatus = '1-1 of 1'

    expect(searchReducer(undefined, fetchSuccessAction)).toEqual(outputState)
  })

  it('Search user data fetch call returns initial state', () => {
    const searchUserDataCallAction = searchUserDataCall()

    const outputState = initialState
    expect(searchReducer(undefined, searchUserDataCallAction)).toEqual(outputState)
  })

  it('Search user data fetch call success returns user data', () => {
    const fetchUserDataSuccessAction = fetchUserDataSuccess({user})
    const outputState = initialState

    outputState.inputData = {'countyValue': user.county_code}
    outputState.userCounty = user.county_code
    expect(searchReducer(undefined, fetchUserDataSuccessAction)).toEqual(outputState)
  })

  it('fetch call completion returns updated state no search results and a error message', () => {
    const fetchSuccessAction = fetchSuccess({
      searchResults: [],
      total: 0,
      errorMessage: NoSearchResultsErrorMessage
    })

    const outputState = initialState
    outputState.searchResults = []
    outputState.totalNoOfResults = 0
    outputState.errorMessage = NoSearchResultsErrorMessage
    outputState.searchStatus = '1-0 of 0'

    expect(searchReducer(undefined, fetchSuccessAction)).toEqual(outputState)
  })

  it('fetch call failure returns updated state with api errors', () => {
    const errorResponse = {
      'issue_details': [ {
        'incident_id': '95100850-f514-4365-9b93-6cbd28adcf27',
        'type': 'unexpected_exception',
        'user_message': 'There was an error processing your request. It has been logged with unique incident id',
        'technical_message': 'Bad Request',
        'stack_trace': 'gov.ca.cwds.rest.api.DoraException: Forbidden\\n\\'
      } ]
    }
    const fetchFailureAction = fetchFailure({
      error: errorResponse
    })

    const outputState = initialState
    outputState.searchResults = []
    outputState.errors = errorResponse
    outputState.errorMessage = undefined

    expect(searchReducer(undefined, fetchFailureAction)).toEqual(outputState)
  })

  it('fetch call failure returns updated state with no search search criteria and a error message', () => {
    const fetchNoSearchCriteriaAction = fetchNoSearchCriteria({
      errorMessage: NoSearchCriteriaMessage
    })

    const outputState = initialState
    outputState.searchResults = []
    outputState.errorMessage = NoSearchCriteriaMessage

    expect(searchReducer(undefined, fetchNoSearchCriteriaAction)).toEqual(outputState)
  })

  it('toggle returns new toggle state', () => {
    const handleToggleAction = handleToggle()

    const outputState = initialState
    outputState.isToggled = false

    expect(searchReducer(undefined, handleToggleAction)).toEqual(outputState)
  })

  it('reset form returns initial State', () => {
    const handleResetFormAction = handleResetForm()

    const inputState = {
      inputData: {facilityNameValue: 'good home'},
      searchResults: {id: 5, name: 'John'},
      totalNoOfResults: 200,
      sizeValue: 10,
      pageNumber: 2,
      isToggled: false,
      userCounty: '',
      errors: {},
      errorMessage: undefined
    }

    const resetState = {
      inputData: {countyValue: ''},
      searchResults: undefined,
      totalNoOfResults: 0,
      isToggled: true,
      sizeValue: 50,
      pageNumber: 1,
      userCounty: '',
      errors: {},
      errorMessage: undefined
    }

    expect(searchReducer(inputState, handleResetFormAction)).toEqual(resetState)
  })

  it('page number change updates state page number', () => {
    const handlePageNumberChangeAction = handlePageNumberChange(4)

    const outputState = initialState
    outputState.pageNumber = 4

    expect(searchReducer(undefined, handlePageNumberChangeAction)).toEqual(outputState)
  })

  it('page number with dropdown change', () => {
    const handleDropDownAndPageNumberChangeAction = handleDropDownAndPageNumberChange(2, 20)

    const outputState = initialState
    outputState.sizeValue = 20
    outputState.pageNumber = 2

    expect(searchReducer(undefined, handleDropDownAndPageNumberChangeAction)).toEqual(outputState)
  })
})
