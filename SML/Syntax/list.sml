[1, 2];
[(1, "one"), (2, "two")];
[[3], [], [2, 1]];
[]; (*'a list*)

(*
type list priority high than * and ->
int * string list = int * (string list)
int list list = (int list) list
*)


(* right combination *)
1::[2];
[5::[6]] = [[5, 6]];

fun upto (m, n) = if m > n then [] else m :: upto(m + 1, n);

fun prod [] = 1
  | prod (n::ns) = n * (prod ns);

prod[2, 3, 5];

fun maxl [m] : int = m
  | maxl (m::n::ns) = if m > n then maxl(m::ns)
                                else maxl(n::ns);

maxl [1, 2, ~3, 0];

fun factl(n) = prod(upto(1, n));
factl 7;

explode "str" = [#"s", #"t", #"r"];
implode [#"s", #"t", #"r"] = "str";

null [] = true;
hd [1,2,3] = 1;
tl [1,2,3] = [2, 3];

fun my_hd (x::_) = x;
fun my_tl (_::xs) = xs;
my_hd [1,2,3] = hd[1,2,3];
my_tl [1,2,3] = tl[1,2,3];

fun take([], i) = []
  | take(x::xs, i) = if i > 0 then x::take(xs, i-1)
                                else [];

fun drop([], _) = []
  | drop(x::xs, i) = if i > 0 then x::drop(xs, i-1)
                                else x::xs;
length [1,2,3] = 3;
take([1,2,3], 2) = [1,2];
drop([1,2,3], 1) = [2, 3];
rev [1,2,3];

(* a@b: insert a in the b's first*)
[1,2,3] @ [2,3,4] = [1,2,3,2,3,4];
rev[1,2,3];

(* https://smlfamily.github.io/Basis/list.html#SIG:LIST.take:VAL *)

(*concat, zip*)
op=;


infix mem;
fun (x mem []) = false
  | (x mem (y::l)) = (x = y) orelse (x mem l);

fun newmem(x, xs) = if x mem xs then xs else x::xs;

val prices = [("switch", 1999), ("ps4", 3999)];
fun assoc([], a) = []
  | assoc((x, y)::pairs, a) = if a=x then [y]
                                    else assoc(pairs, a);

assoc(prices, "switch");