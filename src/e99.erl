-module(e99).
-export([last/1,
		 penultimate/1,
		 nth/2,
		 length/1,
		 reverse/1,
		 is_palindrom/1,
		 flatten/1,
		 compress/1,
		 pack/1,
		 encode/1,
		 encode_modified/1,
		 decode/1,
		 duplicate/1,
		 duplicate_n/2,
		 drop/2,
		 split/2,
		 slice/3,
		 rotate/2,
		 remove_at/2,
		 insert_at/3,
		 range/2,
		 is_prime/1]).

last([Last]) -> Last;
last([_|T]) -> last(T).

penultimate([A, _]) -> A;
penultimate([_|T]) -> penultimate(T).
	
nth(0, [H|_]) -> H;
nth(Pos, [_|T]) -> nth(Pos -1, T).

length(L) -> length(0, L).
length(Length, []) -> Length;
length(Length, [_|T]) -> length(Length + 1, T).

reverse(L) -> reverse([], L).
reverse(R, []) -> R;
reverse(R, [H|T]) -> reverse([H|R], T).

is_palindrom(L) -> 
	case reverse(L) of
		L -> true;
		_ -> false
	end.

flatten([]) -> [];
flatten([[H|T]|Y]) -> flatten([H|T]) ++ flatten(Y);
flatten([H|T]) -> [H|flatten(T)].

compress([]) ->	[];			   
compress([H,H|T]) -> compress([H|T]);
compress([H|T]) -> [H|compress(T)].

pack([H|T], [H|Z]) -> pack([H,H|T], Z);
pack(A, L) -> pack([A | L]).		
pack([]) ->	[];
pack([H,H|T]) -> pack([H, H], T);
pack([[H|T]|Z]) -> [[H|T]|pack(Z)];
pack([H|T]) -> [[H]|pack(T)].

encode([]) -> [];
encode([[H|T]|Z]) -> [[e99:length([H|T]), H]| encode(Z)];
encode(L) -> encode(pack(L)).

encode_modified([]) -> [];
encode_modified([[A]|[H|T]]) -> [A|encode_modified([H|T])];
encode_modified([[H|T]|Z]) -> [[e99:length([H|T]), H]| encode_modified(Z)];
encode_modified(L) -> encode_modified(pack(L)).

decode(0, _) -> [];
decode(Length, A) -> [A|decode(Length - 1, A)].
decode([]) -> [];
decode([[Length,A]|T]) -> decode(Length, A) ++ decode(T).

duplicate([]) -> [];
duplicate([H|T]) -> [H,H|duplicate(T)].

duplicate_n(_, []) -> [];
duplicate_n(0, _) -> [];
duplicate_n(N, [H|T]) -> duplicate_n(N, H) ++ duplicate_n(N, T);
duplicate_n(N, A) -> [A|duplicate_n(N - 1, A)].

drop(_, _, []) -> [];
drop(Nth, Idx, [H|T]) -> 
	case Idx rem Nth of 
		0 when Idx > 0 -> drop(Nth, Idx + 1, T);
		_ -> [H|drop(Nth, Idx + 1, T)]
	end.
drop(_, []) -> [];
drop(Nth, List) -> drop(Nth, 1, List).

split(_, []) -> {[], []};
split(0, List) -> {[], List};
split(Idx, [H|T]) ->
	{Pre, Post} = split(Idx - 1, T),
	{[H|Pre], Post}.

slice(0, _) -> [];
slice(End, [H|T]) -> [H|slice(End - 1, T)].
slice(0, End, [H|T]) -> [H|slice(End - 1, T)];
slice(Begin, End, [_|T]) -> slice(Begin - 1, End -1, T).

rotate(0, L) -> L;
rotate(Pos, [H|T]) when Pos > 0 -> rotate(Pos - 1, [H], T);
rotate(Pos, [H|T]) -> rotate(e99:length(T) + Pos, [H], T).
rotate(0, A, B) -> B ++ e99:reverse(A);
rotate(Pos, A, [H|T]) -> rotate(Pos - 1, [H|A], T).

remove_at(0, [H|T]) -> {T, H};
remove_at(Idx, [H|T]) -> 
	{L, E} = remove_at(Idx - 1, T),
	{[H|L], E}.

insert_at(E, 0, [H|T]) -> [E,H|T];
insert_at(E, Idx, [H|T]) -> [H|insert_at(E, Idx - 1, T)].
	
range(A, A) -> [A];
range(B, E) when B < E -> [B|range(B + 1, E)];
range(B, E) -> [B|range(B - 1, E)].

is_prime(Nb) when Nb =< 1 -> false;
is_prime(Nb) when Nb =< 3 -> true; 
is_prime(Nb) when Nb rem 2 =:= 0; Nb rem 3 =:= 0 -> false;
is_prime(Nb) -> is_prime(Nb, 5).
is_prime(Nb, Test) when Nb rem Test =:= 0; Nb rem (i + 2) =:= 0 -> false;
is_prime(Nb, Test) when Test * Test > Nb -> true;
is_prime(Nb, Test) -> is_prime(Nb, Test + 6).
