pragma circom 2.1.0;

include "array_access.circom";
include "circomlib/circuits/bitify.circom";

template TestArrayAccess() {
    log("\n********** TEST ArrayAccess **********\n");

    var k = 4;
    var n = 2;
    var arr[1<<k][2] = [[69, 60], [93, 85], [20, 3], [63, 89], [57, 61], [11, 7], [94, 39], [67, 71], [64, 73], [98, 39], [31, 80], [27, 94], [62, 34], [66, 42], [79, 17], [58, 25]];

    var out[1<<k][2];
    signal bin_dec[1<<k][k];
    for (var i=0; i<(1<<k); i++) {
        bin_dec[i] <== Num2Bits(k)(i);
        out[i] = ArrayAccess(k, n)(arr, bin_dec[i]);
    }

    var RESULT = 1;
    for (var i=0; i<(1<<k); i++) {
        var check = (out[i][0] == arr[i][0] && out[i][1] == arr[i][1]);
        log("Test", i, "->", check);
        RESULT = RESULT && check;
    }
    log("\nRESULT: ", RESULT, "\n");
}

component main = TestArrayAccess();