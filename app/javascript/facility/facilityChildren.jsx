import React from 'react'
import PropTypes from 'prop-types'
import Spinner from 'facility/common/spinner'
import {childrenColumns} from 'facility/common/reactTableHeaders'
import ReactTable from 'react-table'
import ControlledExpansionPanels from './common/expansionPanelContainer'

export default class FacilityChildren extends React.Component {
  componentDidMount () {
    const params = {
      'id': this.props.match.params.facility_id
    }
    this.props.facilityChildrenApiCall(params)
  }

  renderReactTable () {
    const { children } = this.props
    return <ReactTable
      id='facility-children-table'
      className='table'
      data={children}
      columns={childrenColumns}
      defaultPageSize={children.length}
      showPagination={false}
      sortable={true}
      defaultSorted={children.length > 0 ? [{
        id: 'dateOfPlacement',
        desc: true
      }] : []}
      resizable
      noDataText=''
    />
  }
  render () {
    const {children, errors, isFetching} = this.props
    return (
      <div className='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        {isFetching ? <Spinner/>
          : <ControlledExpansionPanels children={this.renderReactTable()} errors={errors} summaryHeader='Children In the Facility'/>
        }
      </div>
    )
  }
}

FacilityChildren.propTypes = {
  children: PropTypes.array,
  errors: PropTypes.object,
  match: PropTypes.object
}

FacilityChildren.defaultProps = {
  children: [],
  match: {
    params: {
      id: ''
    }
  },
  errors: {
    issue_details: undefined
  }
}
