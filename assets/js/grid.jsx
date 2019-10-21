
import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';
import _ from "lodash";


export default class Grid extends React.Component {
    constructor(props) {
        super(props);
        this.context = props.props;
        console.log("context", this.context);
        this.create_grid = this.create_grid.bind(this);
    }

    create_grid(context) {
        /*fill the board */
        context.beginPath();
        context.fillStyle = "#976B42"
        context.fill();
        context.closePath();

        let col = 0, row = 0;
        let gridSize = 50;
        let width = gridSize * 15,
            height = gridSize * 15;
        col = Math.ceil(width / gridSize);
        row = Math.ceil(height / gridSize);
        // draw row
        for (let i = 0; i <= col; i++) {
            context.beginPath();
            context.moveTo(gridSize * i, 0);
            context.lineTo(gridSize * i, height);
            context.stroke();
            context.closePath();
        }
        // Draw colum 
        for (let j = 0; j <= row; j++) {
            context.beginPath();
            context.moveTo(0, gridSize * j);
            context.lineTo(width, gridSize * j);
            context.stroke();
            context.closePath();
        }

    }

    render() {
        return (<Layer>
            <Shape
                x={0}
                y={0}
                width={width}
                height={height}
                strokeWidth={3}
                sceneFunc={this.create_grid}
                fill={"brown"}
                stroke={'blue'}
            />
        </Layer>);
    }
}