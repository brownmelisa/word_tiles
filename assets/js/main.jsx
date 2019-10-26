import React from 'react';
import ReactDOM from 'react-dom';
import { Stage, Layer, Circle, Text, Group, Shape, Tag, Rect, Star, Label } from 'react-konva';
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
    this.state = {
      board: [],
      letters_left: 0,
      print: "",
      player_tiles: [],
      current_player: "",
      chat_message: "",
      chat_display: ""
    };

    this.setting = {
      canvas_height: 850,
      canvas_width: 800,
      gridSize: 50,
      board_width: 750,
      board_height: 750,
    }

    this.handle_tile_move = this.handle_tile_move.bind(this);

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
  }

  // wait to push to server.
  play_word() {
    let temp = this.state.player_tiles;
    let placedtiles = temp.filter(([_, index]) => { return index > 0 });
    let letters = placedtiles.map(([ll, _]) => (ll));
    let pos = placedtiles.map(([_, pos]) => pos);

    this.channel.push("play_word", { letters: letters, position: pos })
      .receive("ok", this.got_view.bind(this));
  }

  // board_tile_update_handle(board_tile_list) {

  //   let temp_state = _.assign({}, this.state, {
  //     player_tiles: board_tile_list,
  //   });
  //   this.setState(temp_state);
  // }


  handleChatSubmit(_ev) {
    this.channel.push("chat_message", { msg: this.state.chat_message })
      .receive("ok", this.got_view.bind(this));
  }

  render() {
    console.log("main renders player tiles", this.state)
    let curr_tile = this.state.player_tiles.slice();
    return (
      <div>
        <div>
          <text style={{ fontSize: "2em" }}>
            Turn to move: Player>>> {this.state.current_player}
          </text>
        </div>
        <div>
          <Stage width={this.setting.canvas_width} height={this.setting.canvas_height}>
            <Board
              setting={this.setting}
              board={this.state.board}
            />
            <PlayerTiles
              player_tiles={curr_tile}
              board={_.assign({}, this.state.board)}
              setting={this.setting}
              tile_move_handle={this.handle_tile_move}
            />
          </Stage>
        </div>
        <div className="row">
          <div className="column">
            <button onClick={this.play_word.bind(this)}>
              Play Word
            </button>
          </div>
        </div>
        <div>
          <label>
            Chat message:
          <textarea value={this.state.chat_message} onChange={() => this.setState({ chat_message: event.target.value })} />
          </label>
          <button onClick={this.handleChatSubmit.bind(this)}>
            chat
          </button>
        </div>
        <div>
          <label>
            <p>Chatroom:</p>
            <p>{this.state.chat_display}</p>
          </label>
        </div>
      </div>

    );
  }
}


