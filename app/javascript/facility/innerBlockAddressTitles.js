import React from 'react'

const InnerBlockAddressTitles = ({
  classNameTitle,
  title,
  streetApt,
  cityCountry
}) => {
  return (
    <div className={'small_inner_block' + ' ' + classNameTitle}>
      <p>{title}</p>
      <div>{streetApt}</div>
      <div>{cityCountry}</div>
    </div>

  )
}

export {InnerBlockAddressTitles}
