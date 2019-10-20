import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';
import _ from "lodash";
import PlayerTiles from './playertiles';
import App from './test';

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
            y: 50,
            player_tiles: [
                ["A", -1],
                ["B", -1],
                ["C", -1],
                ["D", -1],
                ["E", -1],
                ["F", -1],
            ]
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
                </Layer>

                <PlayerTiles props={this.state.player_tiles} />

            </Stage>

        )
    }
}

