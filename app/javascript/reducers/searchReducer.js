import * as Constants from 'constants/actionTypes'
const initialState = {
  inputData: {},
  searchResults: undefined,
  totalNoOfResults: 0,
  isToggled: true,
  sizeValue: 50,
  pageNumber: 1,
  errors: {},
  userCounty: '',
  errorMessage: undefined
}

export const searchReducer = (state = initialState, action) => {
  switch (action.type) {
    case Constants.SEARCH_USER_DATA_FETCH:
      return state
    case Constants.SEARCH_USER_DATA_FETCH_COMPLETE:
      return {...state,
        inputData: {...state.inputData, 'countyValue': state.inputData.countyValue === undefined ? action.payload.user.county_code : state.inputData.countyValue},
        userCounty: action.payload.user.county_code}
    case Constants.SEARCH_RESULTS_FETCH:
      return state
    case Constants.SEARCH_RESULTS_FETCH_COMPLETE:
      return {...state,
        searchResults: action.payload.searchResults,
        totalNoOfResults: action.payload.total,
        errors: {},
        errorMessage: action.payload.errorMessage}
    case Constants.SEARCH_RESULTS_FETCH_ERROR:
      return {...state,
        searchResults: [],
        errors: action.payload.error,
        errorMessage: undefined}
    case Constants.NO_SEARCH_CRITERIA_ERROR:
      return {...state,
        searchResults: [],
        errors: {},
        errorMessage: action.payload.errorMessage}
    case Constants.HANDLE_INPUT_CHANGE:
      return {...state, inputData: {...state.inputData, [action.payload.key]: action.payload.value}}
    case Constants.HANDLE_TOGGLE:
      return {...state, isToggled: !state.isToggled}
    case Constants.HANDLE_RESET_FORM:
      return {...state,
        inputData: {'countyValue': state.userCounty},
        searchResults: undefined,
        totalNoOfResults: 0,
        sizeValue: 50,
        pageNumber: 1,
        isToggled: true}
    case Constants.HANDLE_PAGENUMBER_CHANGE:
      return {...state, pageNumber: action.payload.pageNumber}
    case Constants.HANDLE_DROPDOWN_AND_PAGENUMBER_CHANGE:
      return {...state, sizeValue: action.payload.sizeValue, pageNumber: action.payload.pageNumber}
    default:
      return state
  }
}
