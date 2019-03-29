import React from 'react'
import Pagination from 'search/pagination'
import {shallow, mount} from 'enzyme'

describe('Facility Search pagination', () => {
  let paginationCompRendered,
    searchApiCallSpy,
    onPageNumberChangeSpy,
    onTabOrEnterSpy,
    handleDropDownAndPageNumberChangeSpy

  beforeEach(() => {
    const props = {
      paginationClassName: 'top_pagination',
      totalNoOfFacilities: 64,
      sizeValue: 5,
      pageNumber: 2
    }
    searchApiCallSpy = jasmine.createSpy('searchApiCall')
    handleDropDownAndPageNumberChangeSpy = jasmine.createSpy('handleDropDownAndPageNumberChange')
    onPageNumberChangeSpy = jasmine.createSpy('onPageNumberChange')
    onTabOrEnterSpy = jasmine.createSpy('onTabOrEnter')
    paginationCompRendered = shallow(<Pagination {...props}
      searchApiCall={searchApiCallSpy}
      onPageNumberChange={onPageNumberChangeSpy}
      handleDropDownAndPageNumberChange={handleDropDownAndPageNumberChangeSpy}
      onTabOrEnter={onTabOrEnterSpy} />)
  })

  it('verify pagination component render', () => {
    const paginationClassName = paginationCompRendered.find('.fs-pagination')
    expect(paginationClassName.length).toBe(1)
    expect(paginationCompRendered.length).toBe(1)
  })

  it('verify number of facilities dropdown after component render', () => {
    const dropDownFacilities = paginationCompRendered.find('.no_of_facilities')
    dropDownFacilities.simulate('change', {target: {options: {'5': {id: '5', value: '5'}, selectedIndex: 5}}})
    expect(handleDropDownAndPageNumberChangeSpy).toHaveBeenCalledWith(1, 5)
  })

  it('verify onPageNumberChange on page number change ', () => {
    const pageNumberInput = paginationCompRendered.find('.page_number').at(0)
    pageNumberInput.simulate('change', {target: {value: '2'}})
    expect(onPageNumberChangeSpy).toHaveBeenCalledWith('2')
  })

  it('verify onTabOrEnter on tab key down ', () => {
    const pageNumber = paginationCompRendered.find('.page_number').at(0)
    pageNumber.simulate('keydown', {which: 9, target: {value: '2'}})
    expect(onTabOrEnterSpy).toHaveBeenCalledWith('2')
  })

  it('verify onTabOrEnter on enter key down ', () => {
    const pageNumber = paginationCompRendered.find('.page_number').at(0)
    pageNumber.simulate('keydown', {which: 13, target: {value: '2'}})
    expect(onTabOrEnterSpy).toHaveBeenCalledWith('2')
  })

  it('Verify number of pages', () => {
    expect(paginationCompRendered.find('.noOfPages').props().children).toBe(13)
  })

  it('verify dropDown value change number of facilities', () => {
    const dropdownForfacilitiesCount = paginationCompRendered.find('#noOfFacilities')
    dropdownForfacilitiesCount.simulate('change', {target: {options: {'5': {id: '5', value: '5'}, selectedIndex: 5}}})
    expect(handleDropDownAndPageNumberChangeSpy).toHaveBeenCalledWith(1, 5)
    expect(searchApiCallSpy).toHaveBeenCalledWith(0, 5)
  })

  it('verify clicking next button ', () => {
    const searchFacility = paginationCompRendered.find('#nextButton')
    searchFacility.simulate('click')
    expect(onPageNumberChangeSpy).toHaveBeenCalledWith(3)
    expect(searchApiCallSpy).toHaveBeenCalledWith(10, 5)
  })

  it('verify clicking previous button ', () => {
    const searchFacility = paginationCompRendered.find('#previousButton')
    searchFacility.simulate('click')
    expect(onPageNumberChangeSpy).toHaveBeenCalledWith(1)
    expect(searchApiCallSpy).toHaveBeenCalledWith(0, 5)
  })
})
