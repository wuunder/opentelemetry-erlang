%%%------------------------------------------------------------------------
%% Copyright 2019, OpenTelemetry Authors
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% @doc
%% @end
%%%-------------------------------------------------------------------------
-module(otel_meter_noop).

-behaviour(otel_meter).

-export([register_callback/4,
         instrument/5,
         instrument/7]).

%% also act as noop version of instruments
-export([add/3,
         record/3]).

%%

%% handles both noop counter and noop updown counter
add(_Insturment, _Number, _Attributes) ->
    ok.

record(_Insturment, _Number, _Attributes) ->
    ok.

%%

register_callback(_Meter, _Instruments, _Callback, _CallbackArgs) ->
    ok.

instrument(Meter, Name, Kind, ValueType, Opts) ->
    otel_instrument:new(?MODULE, Meter, Kind, Name, maps:get(description, Opts, undefined),
                        maps:get(unit, Opts, undefined), ValueType).

instrument(Meter, Name, Kind, ValueType, Callback, CallbackArgs, Opts) ->
    otel_instrument:new(?MODULE, Meter, Kind, Name, maps:get(description, Opts, undefined),
                        maps:get(unit, Opts, undefined), ValueType, Callback, CallbackArgs).
