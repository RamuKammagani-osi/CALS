import {dictonariesReducer} from 'reducers/dictonariesReducer'
import {countyTypes, facilityTypes, licenseStatuses, user} from '../helpers/constants'
import { fetchDictionarySuccess, searchDictionariesCall } from 'actions/searchActions'
describe('Verify dictonariesReducer', () => {
  let initialState
  beforeEach(() => {
    initialState = {
      countyTypes: [],
      facilityTypes: [],
      licenseStatuses: []
    }
  })

  it('Search dictionary fetch call returns initial state', () => {
    const searchDictionariesCallAction = searchDictionariesCall()

    const outputState = initialState
    expect(dictonariesReducer(undefined, searchDictionariesCallAction)).toEqual(outputState)
  })

  it('Search dictionary fetch call success returns countyTypes, facilityTypes, licenseStatuses', () => {
    const fetchDictionarySuccessAction = fetchDictionarySuccess({countyTypes, facilityTypes, licenseStatuses})

    const outputState = initialState
    outputState.countyTypes = countyTypes
    outputState.facilityTypes = facilityTypes
    outputState.licenseStatuses = licenseStatuses
    expect(dictonariesReducer(undefined, fetchDictionarySuccessAction)).toEqual(outputState)
  })
})
