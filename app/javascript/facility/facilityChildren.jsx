import React from 'react'
import PropTypes from 'prop-types'
import ApiErrorMessages from 'components/common/errors/apiErrorMessages'
import Spinner from 'facility/common/spinner'
import {childrenColumns} from 'facility/common/reactTableHeaders'
import ReactTable from 'react-table'
import { Card, CardBody, CardHeader, CardTitle } from '@cwds/components'

export default class FacilityChildren extends React.Component {
  componentDidMount () {
    const params = {
      'id': this.props.match.params.facility_id
    }
    this.props.facilityChildrenApiCall(params)
  }
  render () {
    const {children, errors, isFetching} = this.props
    const tableTitle = `Children currently placed in facility (${children.length})`
    return (
      <div className='facility-children'>
        <Card>
          <CardHeader>
            <CardTitle className='facilityCardTitle'>{tableTitle}</CardTitle>
          </CardHeader>
          <CardBody>
            <div className='facility-children-block col-xs-12 col-sm-12 col-md-12 col-lg-12'>
              <ApiErrorMessages errors={errors.issue_details}/>
              {isFetching ? <Spinner/>
                : <ReactTable
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
            </div>
          </CardBody>
        </Card>
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
