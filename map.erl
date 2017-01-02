-module(map).
-export([pmap/2,pmapt/3]).

pmap(Func,X) -> pmapt(Func,X,self()).

pmapt(_,[],Parent) -> Parent ! {self(),[]};
pmapt(Func,[H|T],Parent) -> 
    Pid = spawn(map,pmapt,[Func,T,self()]),
    receive {Pid,R} -> R end,
    C = [Func(H) | R],  
    Parent ! {self(),C}.