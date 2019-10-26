
import React from 'react';
import { Stage, Layer, Portal, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';
import _ from "lodash";


export default class Board extends React.Component {
  constructor(props) {
    super(props)
    this.create_grid = this.create_grid.bind(this);
    this.getBonusTileList = this.getBonusTileList.bind(this);
    this.getPlayedTileList = this.getPlayedTileList.bind(this);

    this.setting = props.setting;
    this.board = props.board;

    this.gridSize = this.setting.gridSize;
    this.tile_size = this.gridSize - 5;

  }

  create_grid(context) {
    /*fill the board */
    context.beginPath();
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

  getPlayedTileList() {
    console.log("in board played tile", this.props.board);
    console.log(this.props.board.length);
    let board = this.props.board;
    let playedTileList = [];
    for (let i = 0; i < board.length; i++) {
      if (board[i].letter.length > 0) {
        playedTileList.push([i, board[i][0]]);
      }
    }
    return playedTileList;
  }

  getBonusTileList() {
    let board = this.props.board;

    let bonusTileList = [];

    for (let i = 0; i < board.length; i++) {
      if (board[i].bonus.length > 0) {
        bonusTileList.push([i, board[i].bonus]);
      }
    }
    return bonusTileList;
  }


  render() {
    let width = this.setting.board_width, height = this.setting.board_height;
    // let tile_size = this.gridSize;
    return (
      <Layer>
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

        <PlayedTileRender
          tile_size={this.tile_size}
          played={this.getPlayedTileList()} />

        <BonusTileRender
          tile_size={this.tile_size}
          bonus={this.getBonusTileList()} />
      </Layer >

    );
  }
}
// playedTileList is in form of [[index, letter]...]
function PlayedTileRender(prop) {
  let playedTileList = prop.played;
  let tile_size = prop.tile_size;
  // let [x_pos, y_pos] = indexToPosition(playedTileList[i][0]);
  // console.log("played tile list", x_pos, y_pos);
  return [...Array(playedTileList.length)].map((_, i) => {
    let [x_pos, y_pos] = indexToPosition(playedTileList[i][0]);
    return (
      < Group
        key={i}
        x={x_pos + 2.5}
        y={y_pos + 2.5}
      >
        <Rect
          width={tile_size}
          height={tile_size}
          fill={'brown'} />
        <Text
          align={"center"}
          text={playedTileList[i][1]}
          x={0}
          y={0}
          padding={14}
          fontSize={20}
          fill={'black'} />
      </Group >
    )
  })
}

// bonus tile is in form of [[index, letter]...]
function BonusTileRender(prop) {
  let bonusTile = prop.bonus;
  let tile_size = prop.tile_size;
  // let [x_pos, y_pos] = indexToPosition(playedTileList[i][0]);
  // console.log("played tile list", x_pos, y_pos);
  return [...Array(bonusTile.length)].map((_, i) => {
    let [x_pos, y_pos] = indexToPosition(bonusTile[i][0]);
    return (
      < Group
        key={i}
        x={x_pos + 2.5}
        y={y_pos + 2.5}
        padding={14}
      >
        <Rect
          width={tile_size}
          height={tile_size}
          fill={'yellow'} />
        <Text
          align={"center"}
          text={bonusTile[i][1]}
          x={0}
          y={0}
          padding={12}
          fontSize={20}
          fill={'red'} />
      </Group >
    )
  })
}

function indexToPosition(index) {
  let y_pos = Math.floor(index / 15);
  let x_pos = index - y_pos * 15;
  return [x_pos * 50, y_pos * 50];
}

