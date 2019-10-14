import React from 'react';
import ReactDOM from 'react-dom';
import {Stage, Layer, Rect, Text, Circle} from 'react-konva';
import _ from 'lodash';

let W = 1024;
let H = 768;

export default class Shapes extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      tiles: [
        {x: 100, y: 700, letter: "A", points: 3},
        {x: 200, y: 650, letter: "B", points: 4},
        {x: 300, y: 750, letter: "C", points: 5},
      ],
    };
  }

  // taken from Ref[1]
  handleDragStart(e) {
    e.target.setAttrs(
      {
        shadowOffset: {x: 15, y: 15},
        scaleX: 1.1,
        scaleY: 1.1
      });
  }

  // taken from Ref[1]
  handleDragEnd(e) {
    e.target.to(
      {
        duration: 0.5,
        easing: Konva.Easings.ElasticEaseOut,
        scaleX: 1,
        scaleY: 1,
        shadowOffsetX: 5,
        shadowOffsetY: 5
      });
  }

  render() {
    let squares = _.map(this.state.tiles, (bb, ii) =>
      <Rect key={ii}
            x={bb.x}
            y={H - bb.y}
            width={50}
            height={50}
            fill="red"
            shadowBlur={10}
            draggable
            onDragStart={this.handleDragStart}
            onDragEnd={this.handleDragEnd}
      />);

    return (
      <div>
        We are in the board component
        <Stage width={window.innerWidth} height={window.innerHeight}>
          <Layer>
            {squares}
          </Layer>
        </Stage>
      </div>
    );
  }
}

// REFERENCES:
// [1] https://codesandbox.io/s/github/konvajs/site/tree/master/react-demos/basic_demo?from-embed
