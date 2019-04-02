import React from 'react'
import PropTypes from 'prop-types'
import ReactTable from 'react-table'
import Spinner from 'facility/common/spinner'
import {complaintsColumns, allegationColumns} from 'facility/common/reactTableHeaders'
import ControlledExpansionPanels from './common/expansionPanelContainer'
export default class FacilityComplaints extends React.Component {
  componentDidMount () {
    const params = {
      'id': this.props.match.params.facility_id
    }
    this.props.facilityComplaintsApiCall(params)
  }

  renderFacilityComplaints () {
    const { complaints } = this.props
    return (
      <ReactTable
        id='facility-complaints-table'
        className='table'
        data={complaints}
        columns={complaintsColumns}
        defaultPageSize={complaints.length}
        showPagination={false}
        sortable={false}
        resizable={false}
        noDataText=''
        SubComponent={row => {
          return (
            this.renderReactTable(row)
          )
        }
        }
      />
    )
  }

  renderReactTable (row) {
    return (
      <div className='sub-component'>
        <ReactTable
          data={row.original.allegations}
          columns={allegationColumns}
          defaultPageSize={row.original.allegations.length}
          sortable={true}
          resizable={false}
          showPagination={false}
        />
      </div>
    )
  }

  render () {
    const {errors, isFetching} = this.props
    return (
      <div className='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
        {isFetching ? <Spinner/>
          : <ControlledExpansionPanels children={this.renderFacilityComplaints()} errors={errors} summaryHeader='Complaints In the Facility'/>
        }
      </div>
    )
  }
}

FacilityComplaints.propTypes = {
  complaints: PropTypes.array,
  errors: PropTypes.object,
  match: PropTypes.object
}

FacilityComplaints.defaultProps = {
  complaints: [],
  match: {
    params: {
      id: ''
    }
  },
  errors: {
    issue_details: undefined
  }
}
