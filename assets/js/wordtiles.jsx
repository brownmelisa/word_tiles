import React from 'react';
import ReactDOM from 'react-dom';
import _ from "lodash";

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
    // constructor(props) {
    //     super(props);

    //     this.channel = props.channel;
    //     this.state = {
    //         print: 1
    //     };

    //     this.channel
    //         .join()
    //         .receive("ok", this.got_view.bind(this))
    //         .receive("error", resp => { console.log("Unable to join", resp); });
    // }

    // got_view(view) {
    //     console.log("new view", view);
    //     this.setState(view.game);
    // }

    // on_increase(_ev) {
    //     console.log("increase by 1")
    //     this.channel.push("increase", {})
    //         .receive("ok", this.got_view.bind(this));
    // }
    render() {
        return (<div></div>)
    }
    // render() {
    //     return (
    //         <div>
    //             <div className="row">
    //                 <Test print={this.state.print} />
    //             </div>
    //             <div className="row">
    //                 <button onClick={this.on_increase}>
    //                     Increase by 1
    //                 </button>
    //             </div>
    //         </div>)
    // }

}
function Test(param) {
    let { num } = param
    return (
        <div>
            <p>The number</p>
            <p>{num}</p>
        </div>
    )
}