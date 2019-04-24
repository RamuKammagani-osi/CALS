import React from 'react'
import PropTypes from 'prop-types'

const DropDownField = ({gridClassName, id, value, disable, disableNullVal, selectClassName, optionList, onChange, label, labelForAll}) => (
  <div className={gridClassName}>
    <label htmlFor={id}>{label}</label>
    <select value={value} id={id} disabled={disable} onChange={onChange} className={selectClassName}>
      {!disable}
      { !disableNullVal && <option key='' value=''>{labelForAll}</option>}
      {
        optionList.map((item, index) => {
          return (
            <option key={index} value={item.id}>{item.value}</option>
          )
        })
      }
    </select>
  </div>
)
DropDownField.propTypes = {
  value: PropTypes.any
}

DropDownField.defaultProps = {
  optionList: []
}
export {DropDownField}
