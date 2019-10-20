// Player tiles

import React from 'react';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';


export default class PlayerTiles extends React.Component {
    constructor(props) {
        super(props);

        this.gridSize = 50;
        this.props = props;

        console.log("player tile", this.props);
    }

    handleDragEnd(e) {
        console.log("size", this.gridSize)

        let originalX = e.target.x();
        let originalY = e.target.y();
        let x = Math.floor((originalX + 25) / this.gridSize) * this.gridSize;
        let y = Math.floor((originalY + 25) / this.gridSize) * this.gridSize;

        e.target.to({
            duration: 0.2,
            x: x,
            y: y
        });
        console.log(x, y, originalX, originalY)
    };

    // getTile(x_corr, y_corr, letter) {
    //     // change
    //     console.log("size", this.tile_size)
    //     let tile_size = 50;
    //     return <Group
    //         x={x_corr}
    //         y={y_corr}
    //         draggable
    //         onDragEnd={this.handleDragEnd.bind(this)}>
    //         <Rect
    //             width={tile_size}
    //             height={tile_size}
    //             fill={'brown'} />
    //         <Text
    //             align={"center"}
    //             text={letter}
    //             x={0}
    //             y={0}
    //             padding={18}
    //             fontSize={24}
    //             fill={'black'} />
    //     </Group>
    // }

    // handleDragStart(e) {
    //     e.target.setAttrs({
    //         shadowOffset: {
    //             x: 15,
    //             y: 15
    //         },
    //         scaleX: 1.1,
    //         scaleY: 1.1
    //     });
    // };


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
                        onDragEnd={this.handleDragEnd.bind(this)}>
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




