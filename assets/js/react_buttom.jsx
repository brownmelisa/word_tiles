import React from 'react';
import { Stage, Layer, Portal, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';


export default class ReactStuff extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (<div>
            <button onClick>
                Play word
            </button>
        </div>);
    }
}