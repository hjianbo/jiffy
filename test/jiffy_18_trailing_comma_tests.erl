% This file is part of Jiffy released under the MIT license.
% See the LICENSE file for more information.

-module(jiffy_18_trailing_comma_tests).


-include_lib("eunit/include/eunit.hrl").
-include("jiffy_util.hrl").


allow_trailing_commas_array_test() ->
    ?assertEqual([1, 2], dec(<<"[1,2,]">>, [allow_trailing_commas])).


allow_trailing_commas_object_test() ->
    ?assertEqual(
        {[{<<"k">>, 1}]},
        dec(<<"{\"k\":1,}">>, [allow_trailing_commas])
    ).


allow_trailing_commas_nested_payload_test() ->
    Json = <<"{\"devices\":[{\"deviceId\":\"new-BDDZZHCS05\","
        "\"services\":[{\"data\":{\"sensor_id\":\"L3_YL_1\","
        "\"value\":\"0.0\",\"totalValue\":\"11.0\",},"
        "\"eventTime\":\"20260304T161500Z\",\"serviceId\":\"L3_YL\"}]}]}">>,
    Expected = {[
        {<<"devices">>, [
            {[
                {<<"deviceId">>, <<"new-BDDZZHCS05">>},
                {<<"services">>, [
                    {[
                        {<<"data">>, {[
                            {<<"sensor_id">>, <<"L3_YL_1">>},
                            {<<"value">>, <<"0.0">>},
                            {<<"totalValue">>, <<"11.0">>}
                        ]}},
                        {<<"eventTime">>, <<"20260304T161500Z">>},
                        {<<"serviceId">>, <<"L3_YL">>}
                    ]}
                ]}
            ]}
        ]}
    ]},
    ?assertEqual(Expected, dec(Json, [allow_trailing_commas])).
