import React from 'react'

const SmallInnerBlockDetails = ({
  classNameTitle,
  title,
  value
}) => {
  return (
    <div className={'small_inner_block' + ' ' + classNameTitle}>
      <p>{title}</p>
      <p>{value}</p>
    </div>

  )
}

SmallInnerBlockDetails.defaultProps = {
  value: 'N/A',
  classNameTitle: ''
}

export {SmallInnerBlockDetails}
