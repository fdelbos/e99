-module(e99_tests).
-include_lib("eunit/include/eunit.hrl").

last_test() ->
	4 = e99:last([1, 2, 3, 4]).

penultimate_test() ->
	4 = e99:penultimate([1, 2, 3, 4, 5]).

nth_test() ->
	5 = e99:length([1, 2, 3, 4, 5]).

reverse_test() ->
	[5, 4, 3, 2, 1] = e99:reverse([1, 2, 3, 4, 5]).

is_palindrom_test() ->
	true = e99:is_palindrom([1, 2, 3, 4, 5, 4, 3, 2, 1]).

flatten_test() ->
	[1, 1, 2, 3, 5, 8] = e99:flatten([[1, 1], 2, [3, [5, 8]]]).

compress_test() ->
	[1, 2, 3, 1, 4, 5] = e99:compress([1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5]).

pack_test() ->
	[[1, 1, 1, 1], [2], [3, 3], [1, 1], [4], [5, 5, 5, 5]] = e99:pack([1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5]).

encode_test() ->
	[[4, 1], [1, 2], [2, 3], [2, 1], [1, 4], [4, 5]] = e99:encode([1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5]).
	
encode_modified_test() ->
	[[4, 1], 2, [2, 3], [2, 1], 4, [4, 5]] = e99:encode_modified([1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5]).
	
decode_test() ->
	[1, 1, 1, 1, 2, 3, 3, 1, 1, 4, 5, 5, 5, 5] = e99:decode([[4, 1], [1, 2], [2, 3], [2, 1], [1, 4], [4, 5]]).

duplicate_test() ->
	[a, a, b, b, c, c, c, c, d, d] = e99:duplicate([a, b, c, c, d]).

duplicate_n_test() ->
	[a, a, a, b, b, b, c, c, c, c, c, c, d, d, d] = e99:duplicate_n(3, [a, b, c, c, d]).

drop_test() ->
	[a, b, d, e, g, h, j, k] = e99:drop(3, [a, b, c, d, e, f, g, h, i, j, k]).

split_test() ->
	{[a, b, c], [d, e, f, g, h, i, j, k]} = e99:split(3, [a, b, c, d, e, f, g, h, i, j, k]).

slice_test() ->
	[d, e, f, g] = e99:slice(3, 7, [a, b, c, d, e, f, g, h, i, j, k]).

rotate_test() ->
	[d, e, f, g, h, i, j, k, a, b, c] = e99:rotate(3, [a, b, c, d, e, f, g, h, i, j, k]),
	[j, k, a, b, c, d, e, f, g, h, i] = e99:rotate(-2, [a, b, c, d, e, f, g, h, i, j, k]).

remove_at_test() ->
	{[a, c, d], b} = e99:remove_at(1, [a, b, c, d]).

insert_at_test() ->
	[a, new, b, c, d] = e99:insert_at(new, 1, [a, b, c, d]).

range_test() ->
	[9, 8, 7, 6, 5, 4] = e99:range(9, 4),
	[4, 5, 6, 7, 8, 9] = e99:range(4, 9).

is_prime_test() ->
	false = e99:is_prime(77),
	true = e99:is_prime(7).
