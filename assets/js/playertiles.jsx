// Player tiles

import React from 'react';
import { Stage, Layer, Portal, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';


export default class PlayerTiles extends React.Component {
    constructor(props) {
        super(props);

        this.gridSize = 50;
        this.board_width = 750;
        this.board_height = 750;

        this.player_tiles = props.player_tiles;
        this.board_tiles = props.board_tiles;


        console.log("tile list", this.player_tiles);
        console.log("prop list", this.props);
        console.log("board tile list", this.board_tiles);

    }

    getIndexFromPosition(x, y) {
        return Math.floor(x / 50) + Math.floor(y / 50) * 15;
    }

    onDragEnd(x_original, y_original, i, e) {
        console.log("x, y original", x_original, y_original)

        let x_dragend = e.target.x();
        let y_dragend = e.target.y();
        let x = Math.floor((x_dragend + 25) / this.gridSize) * this.gridSize;
        let y = Math.floor((y_dragend + 25) / this.gridSize) * this.gridSize;
        console.log(x, y)


        if ((0 <= x && x <= this.board_width - this.gridSize) &&
            (0 <= y && y <= this.board_height - this.gridSize)) {
            let board_index = this.getIndexFromPosition(x, y);

            console.log("board index letter", this.board_tiles[board_index], this.board_tiles[board_index][0].length);
            // board_tile index if there is already a tile there.
            if (this.board_tiles[board_index][0].length == 0) {
                console.log("sdfa");
                this.player_tiles[i][1] = this.getIndexFromPosition(x, y);
                this.props.tile_move_handle(this.player_tiles);

                this.board_tiles[board_index] = this.player_tiles[i][0];

                // update board tile
                this.props.board_tile_update_handle(this.board_tiles);

                e.target.to({
                    duration: 0.2,
                    x: x,
                    y: y
                });
            }
            else {
                e.target.to({
                    duration: 0.2,
                    x: x_original,
                    y: y_original
                });
            }
        }
        else {
            e.target.to({
                duration: 0.2,
                x: x_original,
                y: y_original
            });
        }
    };

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
        let player_x = 100;
        let player_y = 800;
        let tile_size = this.gridSize;
        let tile_data = this.player_tiles;
        console.log("list", tile_data);

        return (
            <Layer>
                {[...Array(tile_data.length)].map((_, i) => (
                    <Group
                        key={i}
                        x={player_x + 55 * i}
                        y={player_y}
                        draggable
                        onDragEnd={this.onDragEnd.bind(this,
                            player_x + 55 * i, player_y, i)}>
                        <Rect
                            width={tile_size}
                            height={tile_size}
                            fill={'brown'} />
                        <Text
                            align={"center"}
                            text={tile_data[i][0]}
                            x={0}
                            y={0}
                            padding={18}
                            fontSize={24}
                            fill={'black'} />
                    </Group>
                ))}

                {/* <Portal>
                    <input
                        style={{
                            position: 'absolute',
                            top: 10,
                            left: 10,
                            width: '200px'
                        }}
                        placeholder="DOM input from Konva nodes"
                    />
                </Portal> */}

            </Layer>
        );
    }
}




