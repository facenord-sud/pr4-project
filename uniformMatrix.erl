-module(uniformMatrix).
-export([thematrix/1]).
-export([matrix1/2]).
-export([n_length_chunks_fast/2]).

%generates N^2 random uniformly distributed bewteen 0 and 100 numbers
matrix1(L,0)->L;
matrix1(L,N)->matrix1([random:uniform()*100|L],N-1);
matrix1([],N)->matrix1(random:uniform()*100,N-1).

thematrix(Size)->n_length_chunks_fast(matrix1([],Size*Size),Size).


%splits the lists into N chunks(hard to understand but much quicker than the naive way)
n_length_chunks_fast(List,Len) ->
  LeaderLength = case length(List) rem Len of
      0 -> 0;
      N -> Len - N
  end,
  Leader = lists:duplicate(LeaderLength,undefined),
  n_length_chunks_fast(Leader ++ lists:reverse(List),[],0,Len).

n_length_chunks_fast([],Acc,_,_) -> Acc;
n_length_chunks_fast([H|T],Acc,Pos,Max) when Pos==Max ->
    n_length_chunks_fast(T,[[H] | Acc],1,Max);
n_length_chunks_fast([H|T],[HAcc | TAcc],Pos,Max) ->
    n_length_chunks_fast(T,[[H | HAcc] | TAcc],Pos+1,Max);
n_length_chunks_fast([H|T],[],Pos,Max) ->
    n_length_chunks_fast(T,[[H]],Pos+1,Max).
