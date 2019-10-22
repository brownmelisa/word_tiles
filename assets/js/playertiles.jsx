// Player tiles

import React from 'react';
import { Stage, Layer, Portal, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';


export default class PlayerTiles extends React.Component {
    constructor(props) {
        super(props);

        console.log("player tile start");

        this.player_tiles = props.player_tiles;
        this.board = props.board;

        this.setting = props.setting;
        this.gridSize = this.setting.gridSize;
        this.board_width = this.setting.board_width;
        this.board_height = this.setting.board_height;

        console.log("player_tiles list", this.player_tiles);
        console.log("board list", this.board);
    }

    getIndexFromPosition(x, y) {
        return Math.floor(x / 50) + Math.floor(y / 50) * 15;
    }

    onDragEnd(x_original, y_original, i, e) {

        console.log("on drag end prop", this.props);

        let x_dragend = e.target.x();
        let y_dragend = e.target.y();
        let x = Math.floor((x_dragend + 25) / this.gridSize) * this.gridSize;
        let y = Math.floor((y_dragend + 25) / this.gridSize) * this.gridSize;


        if ((0 <= x && x <= this.board_width - this.gridSize) &&
            (0 <= y && y <= this.board_height - this.gridSize)) {
            let board_index = this.getIndexFromPosition(x, y);
            console.log("on drag end prop", this.props);

            // board_tile index if there is already a tile there.
            if (this.props.board[board_index].letter.length == 0) {
                this.props.player_tiles[i][1] = this.getIndexFromPosition(x, y);
                this.props.tile_move_handle(this.props.player_tiles);

                // this.board[board_index][0] = this.player_tiles[i][0];

                // update board tile
                // this.props.board_tile_update_handle(this.board);

                e.target.to({
                    duration: 0.2,
                    x: x + 2.5,
                    y: y + 2.5
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

    render() {
        let player_x = 100;
        let player_y = 775;
        let tile_size = this.gridSize - 5;
        let tile_data = this.props.player_tiles;
        // console.log("player tiles", Object.keys(tile_data).length, tile_size);

        return (
            <Layer>
                {[...Array(Object.keys(tile_data).length)].map((_, i) => (
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
            </Layer>
        );
    }
}





