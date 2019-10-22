import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle } from 'react-konva';
import _ from 'lodash';

// export default function start(node) {
//   ReactDOM.render(<Shapes />, document.getElementById('root'));
// }

let W = 1024;
let H = 768;
let R = 50;
let G = 2;

export default class Shapes extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      balls: [
        {x: 100, y: 700, dx: 0, dy: -1},
        {x: 200, y: 650, dx: 0, dy: -1},
        {x: 300, y: 750, dx: 0, dy: -1},
      ],
    };

    window.setInterval(this.tick.bind(this), 50);
  }

  tick() {
    let balls = _.map(this.state.balls, ({x, y, dx, dy}) => {
      if (y + dy < R/2) {
        dy = -dy;
      }
      else {
        dy -= G;
      }
      y += dy;

      if ((x + dx < R / 2) || (x + dx > W - (R/2))) {
        dx = -dx;
      }
      x += dx;

      return {x, y, dx, dy};
    });
    this.setState(_.assign({}, this.state, {balls}));
  }

  push(bb) {
    let balls = _.map(this.state.balls, (ball, ii) =>
      (ii == bb ? _.assign({}, ball, {dx: ball.dx + 10}) : ball));
    this.setState(_.assign({}, this.state, {balls}));
  }

  render() {
    let circles = _.map(this.state.balls, (bb, ii) =>
      <Circle key={ii} radius={R} x={bb.x} y={H - bb.y} fill="red"
              onClick={() => this.push(ii)} />);

    return <div>
      <Stage width={W} height={H}>
        <Layer>
          {circles}
        </Layer>
      </Stage>
    </div>;
  }
}
