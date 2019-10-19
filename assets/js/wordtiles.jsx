import React from 'react';
import ReactDOM from 'react-dom';
import _ from "lodash";
import Shapes from './shapes';
import $ from "jquery";

export default function word_tiles_init(root, channel) {
    ReactDOM.render(<WordTiles channel={channel} />, root);
}

// Client-Side state for Hangman is:
// {
//    skel:  List of letters and _ indicating where good guesses go.
//    goods: Set of letters, good guesses
//    bads:  Set of letters, bad guesses
//    lives: Int               // initial lives
// }

class WordTiles extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      board: [],
      letters_left: 0,
      print: 0,
      tiles: [
        {x: 100, y: 700, letter: "A", points: 3},
        {x: 200, y: 650, letter: "B", points: 4},
        {x: 300, y: 750, letter: "C", points: 5},
      ],
    };

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

  blank_board_template() {
    return {position: 1, bonus: "DL", letter: ""};
  }

  render() {

    // let test = _.times(225, () => this.blank_board_template());
    let blanks = _.map(this.state.board, (board_item, index) => {
      return (
        <div className="grid-item" key={index}>
          {board_item.bonus}
        </div>
      )});
    console.log("printing blanks", blanks);

    return (
      <div>
        <div className="row">
          <Test print={this.state.print} />
        </div>
        <div className="row">
          <button onClick={this.on_increase.bind(this)}>
            Increase by 1
          </button>
        </div>

        <div>
          <div className="grid-container">
            {blanks}
            <button className="play-btn">Play</button>
          </div>
        </div>
      </div>)
  }
}

function Test(param) {
  let { print: num } = param;
  return (
    <div>
      <p>The number:</p>
      <p>{num}</p>
    </div>
  )
}

// TODO:
// buttons: submit, draw letters
// tray of tiles
// allow player to move tiles from tray to board

