import {searchResultStatus} from 'helpers/commonHelper'

describe('Common Helper', () => {
  describe('search result status', () => {
    it('returns search result status', () => {
      const pageSize = 50; const pageNumber = 1; const totalCount = 5234
      expect(searchResultStatus(pageSize, pageNumber, totalCount)).toEqual('1-50 of 5,234')
    })
    it('returns search result status after rounding size value equal to total results', () => {
      const pageSize = 50; const pageNumber = 105; const totalCount = 5234
      expect(searchResultStatus(pageSize, pageNumber, totalCount)).toEqual('5,201-5,234 of 5,234')
    })
  })
})
