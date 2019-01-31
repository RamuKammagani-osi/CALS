import React from 'react'
import PropTypes from 'prop-types'
import ReactTable from 'react-table'
import ApiErrorMessages from 'components/common/errors/apiErrorMessages'
import Spinner from 'facility/common/spinner'
import {complaintsColumns, allegationColumns} from 'facility/common/reactTableHeaders'
import { Card, CardBody, CardHeader, CardTitle } from '@cwds/components'

export default class FacilityComplaints extends React.Component {
  componentDidMount () {
    const params = {
      'id': this.props.match.params.facility_id
    }
    this.props.facilityComplaintsApiCall(params)
  }

  render () {
    const {complaints, errors, isFetching} = this.props
    const tableTitle = `Complaint History (${complaints.length})`
    return (
      <div className='facility-children'>
        <Card>
          <CardHeader>
            <CardTitle className='facilityCardTitle'>{tableTitle}</CardTitle>
          </CardHeader>
          <CardBody>
            <div className='facility-children-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
              <ApiErrorMessages errors={errors.issue_details}/>
              {isFetching
                ? <Spinner/>
                : <ReactTable
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
                    const subTableTitle = `Allegations (${row.original.allegations.length})`
                    return (
                      <div className='sub-component' >
                        <Card>
                          <CardHeader>
                            <CardTitle className='facilityCardTitle'>{subTableTitle}</CardTitle>
                          </CardHeader>
                          <CardBody>
                            <ReactTable
                              data={row.original.allegations}
                              columns={allegationColumns}
                              defaultPageSize={row.original.allegations.length}
                              sortable={true}
                              resizable={false}
                              showPagination={false}
                            />
                          </CardBody>
                        </Card>
                      </div>
                    )
                  }
                  }
                />
              }
            </div>
          </CardBody>
        </Card>
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
