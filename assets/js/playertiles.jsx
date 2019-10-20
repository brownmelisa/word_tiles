// Player tiles

import React from 'react';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';


export default class PlayerTiles extends React.Component {
    constructor(props) {
        super(props);

        this.gridSize = 50;
        this.board_width = 750;
        this.board_height = 750;
        this.props = props;

        console.log("player tile", this.props);
    }

    onDragEnd(x_original, y_original, e) {
        console.log("x, y original", x_original, y_original)

        let x_dragend = e.target.x();
        let y_dragend = e.target.y();
        let x = Math.floor((x_dragend + 25) / this.gridSize) * this.gridSize;
        let y = Math.floor((y_dragend + 25) / this.gridSize) * this.gridSize;
        console.log(x, y)

        if ((0 <= x && x <= this.board_width - this.gridSize) &&
            (0 <= y && y <= this.board_height - this.gridSize)) {
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

    };



    render() {
        let player_x = 100;
        let player_y = 800;
        let tile_size = this.gridSize;
        let tile_data = this.props.props;
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
                            player_x + 55 * i, player_y)}>
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




