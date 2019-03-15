import React, {Component} from 'react'
import PropTypes from 'prop-types'
import SearchGrid from './searchGrid'
import SearchInput from './searchInput'
import SearchList from './searchList'
import AdvancedSearch from './advancedSearch'
import SearchNotFound from './searchNotFound'
import {checkForValue, checkAndSplitValue, checkForLicenseStatus} from 'search/common/commonUtils'
import {handleInputChange, searchApiCall, handleToggle, handleResetForm, handlePageNumberChange, handleDropDownAndPageNumberChange, searchDictionariesCall, searchUserDataCall} from 'actions/searchActions'
import {connect} from 'react-redux'
import {PageHeader} from 'react-wood-duck'
import BreadCrumb from 'components/common/breadCrumb'
import {getFromValue, floatToNextInt} from 'helpers/commonHelper.jsx'
import Pagination from './pagination'

class Search extends Component {
  componentDidMount () {
    this.props.searchDictionariesCall()
    this.props.searchUserDataCall()
  }

  searchApiCallParams (fromValue, sizeValue) {
    const params = {
      'county.id': {
        query_type: 'term',
        value: checkForValue(this.props.inputData.countyValue)
      },
      'type.id': {
        query_type: 'term',
        value: checkForValue(this.props.inputData.facilityTypeValue)
      },
      'status.id': {
        query_type: 'term',
        value: checkForLicenseStatus(this.props.inputData.isAllActive, this.props.inputData.licenseStatusValue)
      },
      'status.active': {
        query_type: 'term',
        value: this.props.inputData.isAllActive
      },
      license_number: {
        query_type: 'match_phrase',
        value: checkForValue(this.props.inputData.facilityIdValue)
      },
      name: {
        query_type: 'query_string',
        value: checkAndSplitValue(this.props.inputData.facilityNameValue)
      },
      'addresses.address': {
        query_type: 'query_string',
        value: checkAndSplitValue(this.props.inputData.facilityAddressValue)
      }
    }

    const urlParams = {
      fromValue: fromValue,
      sizeValue: sizeValue,
      sort: 'name.for_sort',
      order: 'asc'
    }
    this.props.searchApiCall(params, urlParams)
  }

  onPageNumberInputChange (value) {
    const resultedPageNumbers = floatToNextInt(this.props.totalNoOfResults, this.props.sizeValue)
    if (value === '' || value === '0') {
      value = 1
      this.props.handlePageNumberChange(value)
    } else if (value > resultedPageNumbers) {
      value = resultedPageNumbers
      this.props.handlePageNumberChange(value)
    }
    this.searchApiCallParams(getFromValue(this.props.sizeValue, value), this.props.sizeValue)
  }

  paginationRender () {
    return (
      <Pagination
        totalNoOfFacilities={this.props.totalNoOfResults}
        sizeValue={this.props.sizeValue}
        handleDropDownAndPageNumberChange={this.props.handleDropDownAndPageNumberChange}
        handlePageNumberChange={this.props.handlePageNumberChange}
        pageNumber={this.props.pageNumber}
        searchApiCall={this.searchApiCallParams.bind(this)}
        onPageNumberInputChange={this.onPageNumberInputChange.bind(this)} />
    )
  }

  renderSearchInput () {
    return (
      <SearchInput
        resetForm={this.props.handleResetForm}
        searchApiCall={this.searchApiCallParams.bind(this)}
        handlePageNumberChange={this.props.handlePageNumberChange}
        countyList={this.props.countyTypes}
        facilityTypes={this.props.facilityTypes}
        licenseStatuses={this.props.licenseStatuses}
        countyValue={this.props.inputData.countyValue}
        facilityTypeValue={this.props.inputData.facilityTypeValue}
        licenseStatusValue={this.props.inputData.licenseStatusValue}
        isAllActive={this.props.inputData.isAllActive}
        facilityIdValue={this.props.inputData.facilityIdValue}
        facilityNameValue={this.props.inputData.facilityNameValue}
        facilityAddressValue={this.props.inputData.facilityAddressValue}
        handleInputChange={this.props.handleInputChange}
        sizeValue={this.props.sizeValue} />
    )
  }

  renderAdvanceSearch () {
    const searchResponseHasValues = this.props.searchResults && this.props.searchResults.length > 0
    return (
      searchResponseHasValues && <AdvancedSearch
        paginationRender= {this.paginationRender()}
        handleToggle= {this.props.handleToggle}
        isToggled={this.props.isToggled}
        totalNoOfFacilities={this.props.totalNoOfResults}
        sizeValue={this.props.sizeValue}
        pageNumber={this.props.pageNumber} />
    )
  }

  render () {
    const initialLoad = this.props.searchResults === undefined
    const searchResponseHasValues = this.props.searchResults && this.props.searchResults.length > 0
    return (
      <div className='search_page'>
        <PageHeader
          pageTitle='Facility Search'
          button={null}
        />
        <BreadCrumb />
        <div className='container-fluid'>
          {this.renderSearchInput()}
          {this.renderAdvanceSearch()}
          <div className='result-section'>
            {this.props.isToggled && <SearchGrid searchResults={this.props.searchResults} />}
            {!this.props.isToggled && <SearchList searchResults={this.props.searchResults} />}
            {(!searchResponseHasValues && !initialLoad) && <SearchNotFound errors={this.props.errors.issue_details} errorMessage={this.props.errorMessage} />}
          </div>
          {searchResponseHasValues && <center className='bottom-pagination'>
            {this.paginationRender()}
          </center>
          }
        </div>
      </div>
    )
  }
}

Search.propTypes = {
  inputData: PropTypes.object,
  searchResults: PropTypes.array,
  totalNoOfResults: PropTypes.number,
  isToggled: PropTypes.bool,
  sizeValue: PropTypes.number,
  pageNumber: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  errors: PropTypes.object,
  handleInputChange: PropTypes.func,
  searchApiCall: PropTypes.func,
  handleToggle: PropTypes.func,
  handleResetForm: PropTypes.func,
  handlePageNumberChange: PropTypes.func,
  handleDropDownAndPageNumberChange: PropTypes.func
}

Search.defaultProps = {
  errors: {
    issue_details: undefined
  }
}

function mapStateToProps (state) {
  return {
    countyTypes: state.dictonariesReducer.countyTypes,
    facilityTypes: state.dictonariesReducer.facilityTypes,
    licenseStatuses: state.dictonariesReducer.licenseStatuses,
    inputData: state.searchReducer.inputData,
    searchResults: state.searchReducer.searchResults,
    totalNoOfResults: state.searchReducer.totalNoOfResults,
    isToggled: state.searchReducer.isToggled,
    sizeValue: state.searchReducer.sizeValue,
    pageNumber: state.searchReducer.pageNumber,
    errors: state.searchReducer.errors,
    errorMessage: state.searchReducer.errorMessage
  }
}

export {Search}
export default connect(mapStateToProps, {
  handleInputChange,
  searchApiCall,
  handleToggle,
  handleResetForm,
  handlePageNumberChange,
  handleDropDownAndPageNumberChange,
  searchDictionariesCall,
  searchUserDataCall
})(Search)
