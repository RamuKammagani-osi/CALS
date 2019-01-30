import React from 'react'
import Select from 'react-select'
import PropTypes from 'prop-types'

const MultiSelect = ({
  gridClassName,
  label,
  values,
  disabled,
  searchable,
  clearable,
  optionList,
  valueRenderer,
  removeSelected,
  className,
  placeholder,
  onChange,
  labelClassName
}) => {
  return (
    <div className={gridClassName}>
      <label className={labelClassName}>{label}
        <Select
          className={className}
          tabSelectsValue={false}
          disabled={disabled}
          multi
          searchable={searchable}
          clearable={clearable}
          removeSelected={removeSelected}
          value={values.map((val) => val.value)}
          valueRenderer={valueRenderer}
          options={optionList.map((type) => ({label: type.value, value: type.value, id: type.id}))}
          onChange={onChange}
          placeholder={placeholder}
        />
      </label>
    </div>
  )
}

MultiSelect.propTypes = {
  label: PropTypes.string,
  values: PropTypes.array,
  disabled: PropTypes.bool,
  searchable: PropTypes.bool,
  clearable: PropTypes.bool,
  optionList: PropTypes.array,
  valueRenderer: PropTypes.func,
  options: PropTypes.func,
  removeSelected: PropTypes.bool,
  className: PropTypes.string,
  onChange: PropTypes.func
}

MultiSelect.defaultProps = {
  placeholder: '',
  optionList: []
}

export default MultiSelect
