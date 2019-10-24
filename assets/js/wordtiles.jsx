import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star } from 'react-konva';
import _ from "lodash";
import PlayerTiles from './playertiles';
import Board from './board';

export default function word_tiles_init(root, channel) {
  ReactDOM.render(<WordTiles channel={channel} />, root);
}

class WordTiles extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;

    // let temp_tiles = [...Array(225)].map(() => ["", ""])
    // temp_tiles[0][0] = "A";
    // temp_tiles[10][1] = "DW";
    // temp_tiles[112][1] = "DW";


    // temp_tiles[15][1] = "DW";
    // temp_tiles[143][1] = "DW";
    // temp_tiles[123][1] = "DW";
    // temp_tiles[213][1] = "DW";
    // this.state = {
    //   board: temp_tiles,
    //   player_tiles: [
    // ["A", -1],
    //   ["B", -1],
    //   ["C", -1],
    //   ["D", -1],
    //   ["E", -1],
    //   ["F", -1],
    //   ]
    // };

    this.state = {
      board: [],
      letters_left: 0,
      print: 0,
      player_tiles: []
    };


    this.setting = {
      canvas_height: 850,
      canvas_width: 800,
      gridSize: 50,
      board_width: 750,
      board_height: 750,
    }

    this.handle_tile_move = this.handle_tile_move.bind(this);
    this.board_tile_update_handle = this.board_tile_update_handle.bind(this);

    this.channel
      .join()
      .receive("ok", this.got_view.bind(this))
      .receive("error", resp => { console.log("Unable to join", resp); });
    console.log("channel", this.channel);

    // line add for genserver
    this.channel.on("update", this.got_view.bind(this));
  }

  got_view(view) {
    let new_player_tile_list = view.game.player_tiles.map((ele) => ([ele, -1]));
    let temp_state = _.assign({}, view.game, {
      player_tiles: new_player_tile_list
    })
    this.setState(temp_state);
    console.log("new state", this.state);
  }

  handle_tile_move(update_tile_list) {

    let temp_state = _.assign({}, this.state, {
      player_tiles: update_tile_list,
    });
    this.setState(temp_state);
    console.log("tile moved", this.state);
  }

  // wait to push to server.
  play_word() {
    console.log("channel play word", this.channel);
    this.channel.push("play_word", { player_tiles: this.state.player_tiles })
      .receive("ok", this.got_view.bind(this));
  }

  board_tile_update_handle(board_tile_list) {

    let temp_state = _.assign({}, this.state, {
      player_tiles: board_tile_list,
    });
    this.setState(temp_state);
    console.log(this.state);
  }

  // for testing purpose
  on_increase(_ev) {
    console.log("increase by 1")
    this.channel.push("increase", { num: 1 })
      .receive("ok", this.got_view.bind(this));
  }

  render() {
    console.log("dfasdf", this.state.player_tiles)
    return (
      <div>
        <div>
          <Stage width={this.setting.canvas_width} height={this.setting.canvas_height}>

            <Board
              setting={this.setting}
              board={this.state.board}
            />

            <PlayerTiles
              player_tiles={_.assign({}, this.state.player_tiles)}
              board={_.assign({}, this.state.board)}
              setting={this.setting}
              tile_move_handle={this.handle_tile_move}
              board_tile_update_handle={this.board_tile_update_handle}
            />
          </Stage>
        </div>
        <div >
          <button onClick={this.play_word.bind(this)}>
            Play Word
          </button>
        </div>
        <div className="row">
          <button onClick={this.on_increase.bind(this)}>
            Increase by 1
          </button>
          <Text>{this.state.print}</Text>
        </div>
      </div>
    );
  }
}
