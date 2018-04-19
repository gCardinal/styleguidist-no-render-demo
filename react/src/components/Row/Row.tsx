import * as React from 'react'
import * as classnames from 'classnames'

export interface RowProps {
    children?: React.ReactNode
    noGutters?: boolean
}

export const Row: React.SFC<RowProps> = (props: RowProps) => {
    const styles = classnames({
        row: true,
        'no-gutters': props.noGutters,
    })

    return <div className={styles}>{props.children}</div>
}

export default Row
