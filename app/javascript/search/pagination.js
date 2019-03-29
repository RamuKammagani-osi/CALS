import React from 'react'
import PropTypes from 'prop-types'
import {resultsPerPage} from './common/commonUtils'
import {dictionaryNilSelectValue, floatToNextInt, getFromValue} from 'helpers/commonHelper.jsx'

const Pagination = ({
  searchApiCall,
  sizeValue,
  pageNumber,
  totalNoOfFacilities,
  handleDropDownAndPageNumberChange,
  onPageNumberChange,
  onTabOrEnter
}) => (
  <span className='fs-pagination'>
    <select
      aria-label='Number of Facilities'
      className='no_of_facilities'
      id='noOfFacilities'
      value={sizeValue}
      onChange={(event) => {
        handleDropDownAndPageNumberChange(1, parseInt(dictionaryNilSelectValue(event.target.options)))
        searchApiCall(getFromValue(sizeValue, 1), parseInt(dictionaryNilSelectValue(event.target.options)))
      }}>
      {resultsPerPage.map((noOfResults) =>
        <option key={noOfResults} value={noOfResults}>{noOfResults}</option>
      )}
    </select>
    <button
      id='previousButton'
      disabled={getFromValue(sizeValue, pageNumber) - sizeValue < 0}
      onClick={() => { onPageNumberChange(pageNumber - 1); searchApiCall(getFromValue(sizeValue, pageNumber - 1), sizeValue); window.scrollTo(0, 0) }}
      className='fs-previous btn btn-default'>
      <p>&#8249;</p>
    </button>
    <input
      aria-label='Page Number Input'
      className='page_number'
      type={pageNumber === '' ? 'text' : 'number'}
      value={pageNumber}
      placeholder='Page #'
      onChange={(event) => {
        onPageNumberChange(event.target.value)
      }}
      onKeyDown={(event) => { if (event.which === 9 || event.which === 13) { onTabOrEnter(event.target.value); window.scrollTo(0, 0) } } }/>
    <span>of</span>
    <span className='noOfPages'>{floatToNextInt(totalNoOfFacilities, sizeValue)}</span>
    <button
      id='nextButton'
      disabled={getFromValue(sizeValue, pageNumber) + sizeValue >= totalNoOfFacilities}
      onClick={() => { onPageNumberChange(pageNumber + 1); searchApiCall(getFromValue(sizeValue, pageNumber + 1), sizeValue); window.scrollTo(0, 0) }}
      className='fs-next btn btn-default'>
      <p>&#8250;</p>
    </button>
  </span>
)

Pagination.propTypes = {
  totalNoOfFacilities: PropTypes.number,
  sizeValue: PropTypes.number,
  pageNumber: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  searchApiCall: PropTypes.func,
  onTabOrEnter: PropTypes.func,
  handleDropDownAndPageNumberChange: PropTypes.func,
  onPageNumberChange: PropTypes.func
}
Pagination.defaultProps = {
  totalNoOfFacilities: 0,
  pageNumber: 1,
  sizeValue: 50
}

export default Pagination
