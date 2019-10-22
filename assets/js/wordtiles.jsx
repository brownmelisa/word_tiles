import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';
import _ from "lodash";
import PlayerTiles from './playertiles';
import Grid from './grid';
import ReactStuff from './react_buttom';

export default function word_tiles_init(root, channel) {
  ReactDOM.render(<WordTiles channel={channel} />, root);
}

class WordTiles extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;

    let temp_tiles = [...Array(225)].map(() => ["", ""])
    temp_tiles[0][0] = "A";
    temp_tiles[10][1] = "DW";
    temp_tiles[112][1] = "DW";


    temp_tiles[15][1] = "DW";
    temp_tiles[143][1] = "DW";
    temp_tiles[123][1] = "DW";
    temp_tiles[213][1] = "DW";
    console.log("board tiles list", temp_tiles);

    this.state = {
      board_tiles: temp_tiles,
      player_tiles: [
        ["A", -1],
        ["B", -1],
        ["C", -1],
        ["D", -1],
        ["E", -1],
        ["F", -1],
      ]
    };

    console.log("state", this.state);

    this.setting = {
      gridSize: 50,
      board_width: 750,
      board_height: 750,
    }

    this.handle_tile_move = this.handle_tile_move.bind(this);
    this.board_tile_update_handle = this.board_tile_update_handle.bind(this);

    // this.state = {
    //   board: [],
    //   letters_left: 0,
    //   print: 0,
    //   tiles: [
    //     { x: 100, y: 700, letter: "A", points: 3 },
    //     { x: 200, y: 650, letter: "B", points: 4 },
    //     { x: 300, y: 750, letter: "C", points: 5 },
    //   ],
    // };

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

  handle_tile_move(update_tile_list) {

    let temp_state = _.assign({}, this.state, {
      player_tiles: update_tile_list,
    });
    this.setState(temp_state);
    console.log(this.state);
  }

  board_tile_update_handle(board_tile_list) {

    let temp_state = _.assign({}, this.state, {
      player_tiles: board_tile_list,
    });
    this.setState(temp_state);
    console.log(this.state);
  }

  render() {
    return (
      <div>
        <div>
          <Stage width={window.innerWidth} height={window.innerHeight}>

            <Grid
              setting={this.setting}
              board_tiles={this.state.board_tiles}
            />

            <PlayerTiles
              player_tiles={this.state.player_tiles}
              board_tiles={this.state.board_tiles}
              setting={this.setting}
              tile_move_handle={this.handle_tile_move}
              board_tile_update_handle={this.board_tile_update_handle}
            />
          </Stage>
        </div>
        <div >
          <button >
            dafs
                     </button>
        </div>
      </div>

    );
  }

}


            // <div>
            //     <button>
            //         Button
            //     </button>
            // </div>

