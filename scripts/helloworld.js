"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
module.exports = (robot) => {
    robot.respond(/is it (xmas|christmas)\s?\?/i, (msg) => {
        var today = new Date();
        msg.reply(today.getDate() === 25 &&
            (today.getMonth() + 1) === 12 ? "YES" : "NO");
    });
};
