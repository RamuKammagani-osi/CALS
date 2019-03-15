import React from 'react'
import PropTypes from 'prop-types'
import {searchResultStatus} from 'helpers/commonHelper.jsx'

const AdvancedSearch = ({
  paginationRender,
  handleToggle,
  isToggled,
  totalNoOfFacilities,
  sizeValue,
  pageNumber
}) => (
  <div className='advance-search'>
    <p className='search-results-label'>{searchResultStatus(sizeValue, pageNumber, totalNoOfFacilities)}</p>
    {paginationRender}
    <span className='toggle_result'>
      <span id='toggle_button' onClick={handleToggle} className={`${isToggled ? 'line_off-icon' : 'line_on-icon'} ` + `navbar-brand`} alt={'list'} role='presentation'/>
      <span onClick={handleToggle} className={`${isToggled ? 'grid_on-icon' : 'grid_off-icon'} ` + `navbar-brand`} alt={'grid'} role='presentation'/>
    </span>
  </div>
)

AdvancedSearch.propTypes = {
  paginationRender: PropTypes.element,
  handleToggle: PropTypes.func,
  isToggled: PropTypes.bool
}

AdvancedSearch.defaultProps = {
  isToggled: true
}

export default AdvancedSearch
