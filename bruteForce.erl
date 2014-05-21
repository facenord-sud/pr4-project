
%bruteForce:brute(n) is what you want top launch

-module(bruteForce).
-export([brute/1]).

% liste de permutation
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L -- [H])].

% factoriel
fac(0) ->
   1;
 fac(X) when X > 0 ->
   X * fac(X-1).

% traerse

gothrew(0, 0, 0, Number, _, _, _, _, _, _) -> Number;
% A = 1..n
% B = entier, position dans la liste de permutation
% C = entier, idem
% N le plut petit nombre jusqu'à présent
% Size = n
% I = matrice pour les poids
% J idem
% K
% Order2 liste de permutations
% Order3
gothrew(A, B, C, N, Size, I, J, K, Order, Fac) -> %io:format("C ~w",[C]),
  Result = matrixElement(A,lists:nth(B, Order),I,[]) + matrixElement(lists:nth(B, Order),
  lists:nth(C, Order), J, []) + matrixElement(lists:nth(C, Order),A,K,[]),
  N1=lists:min([Result,N]),
  io:format("B= ~w C= ~w ~n ",[B,C]),
  if B + 1 > Fac, C + 1 > Fac ->
    gothrew(0, 0, 0, N1,0 ,0 ,0 ,0 ,0 , 0);
  C + 1 > Fac->
    gothrew(A,B+1,1,N1,Size,I,J,K,Order, Fac);
  true ->
    gothrew(A,B,C+1,N1,Size,I,J,K,Order, Fac)

end.

brute(Size)-> I=uniformMatrix:thematrix(Size),
J=uniformMatrix:thematrix(Size),
K=uniformMatrix:thematrix(Size),
Order1=lists:seq(1,Size),
Order=perms(Order1),
gothrew(Order1, 1, 1, 100000, Size, I, J, K, Order, fac(Size)).

matrixElement([],[],M,S) -> sum(S);
matrixElement([H1|T1],[H2|T2],M,S) ->
  B=lists:nth(H1, M),
  C=lists:nth(H2, B),
  matrixElement(T1,T2,M,lists:append(S,[C])).

sum([]) ->
    0;
sum([H|T]) ->
   H+sum(T).
