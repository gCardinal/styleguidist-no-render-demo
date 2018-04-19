import * as classnames from 'classnames'
import * as React from 'react'
import * as CSSModule from 'react-css-modules'

import * as style from './Button.css'
import * as loader from './img/loader.gif'

export interface ButtonProps {
    /**
     * Style the button as a submit button
     * @default false
     */
    submit?: boolean

    children?: React.ReactNode

    /**
     * Click handler
     */
    onClick?: (selected?: any) => void

    /**
     * Sets the button as inactive, reducing its opacity
     * @default false
     */
    inactive?: boolean

    /**
     * Display a loading wheel on the right of the label
     * @default false
     */
    isLoading?: boolean
}

/**
 * Details 1
 */
export const Button: React.SFC<ButtonProps> = (props: ButtonProps) => {
    const styles = classnames({
        button: true,
        regular: !props.submit,
        submit: props.submit,
        inactive: props.inactive,
    })

    let isLoading = null

    if (props.isLoading) {
        isLoading = <span styleName='spinner'><img src={loader} /></span>
    }

    return <a styleName={styles} onClick={props.onClick}>{props.children} {isLoading}</a>
}

/**
 * Details 2
 */
export default CSSModule(Button, style, { allowMultiple: true })
