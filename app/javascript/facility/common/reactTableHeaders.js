import React from 'react'
import {sortbyDate} from 'search/common/commonUtils'

export const childrenColumns = [
  {
    Header: props => <span> Name <i className="fa fa-angle-down"/></span>,
    accessor: 'child_full_name'
  },
  {
    Header: props => <span>Gender<i className="fa fa-angle-down"/></span>,

    accessor: 'gender'
  },
  {
    Header: props => <span>Date of Birth<i className="fa fa-angle-down"/></span>,
    accessor: 'date_of_birth',
    sortMethod: (a, b) => sortbyDate(a, b)
  },
  {
    id: 'dateOfPlacement',
    Header: props => <span>Date of Placement<i className="fa fa-angle-down"/></span>,
    accessor: 'date_of_placement',
    sortMethod: (a, b) => sortbyDate(a, b)
  },
  {
    Header: props => <span>Child's Social Worker<i className="fa fa-angle-down"/></span>,
    accessor: 'assigned_worker'
  },
  {
    Header: props => <span> County of Origin <i className="fa fa-angle-down"/></span>,
    accessor: 'county_of_origin'
  }
]

export const complaintsColumns = [
  {
    Header: 'Date',
    accessor: 'complaint_date'
  },
  {
    Header: 'Assigned Worker',
    accessor: 'assigned_worker'
  },
  {
    Header: 'Control Number',
    accessor: 'control_number'
  },
  {
    Header: 'Priority',
    accessor: 'priority_level'
  },
  {
    Header: 'Status',
    accessor: 'status'
  },
  {
    Header: 'Approval Date',
    accessor: 'approval_date'
  }
]

export const allegationColumns = [
  {
    Header: '',
    maxWidth: 50,
    accessor: 'index_subcomponent'
  },
  {
    maxWidth: 300,
    Header: 'Type / Code',
    accessor: 'type_code'
  },
  {
    Header: 'Allegation Description',
    maxWidth: 700,
    accessor: 'allegation'
  },
  {
    maxWidth: 200,
    Header: 'Resolution Code',
    accessor: 'resolution_type_description'
  }
]
