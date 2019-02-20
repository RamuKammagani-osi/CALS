import * as Constants from 'constants/actionTypes'

const initialState = {
  countyTypes: [],
  facilityTypes: [],
  licenseStatuses: []
}

export const dictonariesReducer = (state = initialState, action) => {
  switch (action.type) {
    case Constants.SEARCH_DICTIONARIES_FETCH:
      return state
    case Constants.SEARCH_DICTIONARIES_FETCH_COMPLETE:
      return {...state,
        countyTypes: action.payload.countyTypes,
        facilityTypes: action.payload.facilityTypes,
        licenseStatuses: action.payload.licenseStatuses}
    default:
      return state
  }
}
