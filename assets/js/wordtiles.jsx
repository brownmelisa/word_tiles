import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect } from 'react-konva';
import _ from "lodash";

export default function word_tiles_init(root, channel) {
    ReactDOM.render(<WordTiles channel={channel} />, root);
}

class WordTiles extends React.Component {
    constructor(props) {
        super(props);
        this.channel = props.channel;
        this.state = {
            print: 1,
            isDragging: false,
            x: 50,
            y: 50
        };
        this.setting = {
            gridSize: 50,
            width: 750,
            height: 750,
        }
        this.create_grid = this.create_grid.bind(this);


        this.channel
            .join()
            .receive("ok", this.got_view.bind(this))
            .receive("error", resp => { console.log("Unable to join", resp); });
        console.log("channel", this.channel);
    }

    got_view(view) {
        console.log("new view", view);
        this.setState(view.game);
    }

    on_increase(_ev) {
        console.log("increase by 1")
        this.channel.push("increase", { num: 1 })
            .receive("ok", this.got_view.bind(this));
    }

    create_grid(context) {
        /*fill the board */
        context.beginPath();
        context.fillStyle = "#976B42"
        context.fill();
        context.closePath();

        let col = 0, row = 0;
        let gridSize = this.setting.gridSize;
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
        let width = this.setting.width, height = this.setting.height;
        return (
            <Stage width={window.innerWidth} height={window.innerHeight}>
                <Layer>
                    <Text
                        text="Draggable Text"
                        x={this.state.x}
                        y={this.state.y}
                        draggable
                        fill={this.state.isDragging ? 'green' : 'black'}
                        onDragStart={() => {
                            this.setState({
                                isDragging: true
                            });
                        }}
                        onDragEnd={e => {
                            this.setState({
                                isDragging: false,
                                x: e.target.x(),
                                y: e.target.y()
                            });
                        }}
                    />
                    <Circle radius={20} x={100} y={100} fill="red" />
                    <Shape
                        x={0}
                        y={0}
                        width={width}
                        height={height}
                        strokeWidth={2}
                        sceneFunc={this.create_grid}
                        fill={"brown"}
                        stroke={'blue'}
                    />
                    <Player_tile />
                </Layer>

            </Stage>

        )
    }
}

function Player_tile(_text) {
    return (
        <Group
            x={100}
            y={200}
            draggable>

            <Rect
                width={30}
                height={30}
                fill={'brown'} />
            <Text
                align={"right"}
                text={"A"}
                padding={8}
                fontSize={18}
                fill={'black'} />
        </Group>);
}



// function Test(param) {
//     let { print: num } = param
//     return (
//         <div>
//             <p>The number:</p>
//             <p>{num}</p>
//         </div>
//     )
// }
