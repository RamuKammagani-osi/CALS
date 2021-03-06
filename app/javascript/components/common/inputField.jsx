import FormField from './formField'
import PropTypes from 'prop-types'
import React from 'react'

const InputField = ({
  errors,
  gridClassName,
  id,
  label,
  labelClassName,
  maxLength,
  onBlur,
  onChange,
  placeholder,
  required,
  type,
  value,
  step,
  disabled
}) => {
  const formFieldProps = {
    disabled: disabled,
    errors: errors,
    gridClassName: gridClassName,
    id: id,
    label: label,
    labelClassName: labelClassName,
    required: required
  }

  return (
    <FormField {...formFieldProps}>
      <input id={id} type={type} placeholder={placeholder} step={step}
        value={value} onChange={onChange} maxLength={maxLength} onBlur={onBlur}
        aria-required={required} required={required} disabled={disabled}
      />
    </FormField>
  )
}

InputField.defaultProps = {
  type: 'text',
  mask: ''
}

InputField.propTypes = {
  disabled: PropTypes.bool,
  errors: PropTypes.object,
  gridClassName: PropTypes.string,
  id: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  labelClassName: PropTypes.string,
  maxLength: PropTypes.string,
  onBlur: PropTypes.func,
  onChange: PropTypes.func.isRequired,
  placeholder: PropTypes.string,
  required: PropTypes.bool,
  type: PropTypes.string,
  value: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ])
}
export default InputField
