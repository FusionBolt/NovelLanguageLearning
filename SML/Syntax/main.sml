exception ERROR of string option;

fun throwError msg = raise ERROR (SOME msg);

fun assert(value : bool) = 
  if value then
		()
	else 
		throwError("")

fun assert_eq(v1: real, v2: real) = assert(abs(v1 - v2) < 0.000001);



print "Hello, World\n";

val pi = 3.1415926;
fun area r = pi * r * r;
val area_result = 3.1415926 * 5.0 * 5.0;
(*comment*)
assert_eq(area 5.0, area_result);

(*rebind*)
val pi = 0;
area 5.0;

val h''3_H = 1;
val neg_val = ~1;

val +-+-+-+ = 10;

(* error: fun square x = x * x; *)
fun square1(x : real) = x * x; (* parameter type is real *)
fun square2 x : real = x * x; (* return type is real *)
fun square3 x = x * x : real; (* function body type is real *)


"rua" ^ "rrrrrua";
size(" ");

#"a";
#"\n";

chr(97);
ord(#"a");

val char_to_str = str(#"a");
val str_to_char = String.sub("stra", 3);

val or_val = true orelse false;
val and_value = true andalso false;
val not_value = not true; 

fun lengthvec (x, y) = Math.sqrt(x * x + y * y);

val pair_pair = ((1, 2), (3, 4));
val ((x1, y1), (x2, y2)) = pair_pair;

(* () is unit, use "xx.sml" return ()*)



(* record and tuple *)
val emperor =  {
	name = "rec",
	born = 1,
	died = 4,
	quote = "str"
};

val {name=name_v, died=died_v, ...} = emperor;
assert(name_v = "rec");
assert(died_v = 4);

assert(#name emperor = "rec");
assert(#died emperor = 4);

val n_tuple = {1 = "str1", 2 = 4};
assert(#2 n_tuple = 4);

(* n tuple = {1 = x1, 2 = x2, ..., n = xn}*)

type king = {name: string, born: int, died: int, quote: string};
fun lifetime({born, died, ...}: king) = died - born;
fun life(k: king) = #died k - #born k;
(* because of king is a tuple alias, emperor can be passed to life*)
life(emperor);

fun lifetimef({name, born, died, quote}) = died - born;
lifetimef(emperor);




(* infix operators *)
infix xor;
fun (p xor q) = (p orelse q) andalso not (p andalso q);
true xor false xor true; (* ((true xor false) xor true) left combine *)

infix 7 ++;
fun ((x1, y1) ++ (x2, y2)) = (x1 + y1, x2 + y2);
(1, 2) ++ (2, 3);
op++ ((1, 2), (2, 3));
(* 1+～3; parser mistake *)
nonfix xor;
nonfix ++;



(* let *)
fun findroot(a, x, acc) = 
	let val nextx = (a / x + x) / 2.0
	in if abs (x - nextx) < acc * x
		then nextx else findroot(a, nextx, acc)
	end;

findroot(2.0, 1.0, 1.0E~10);


fun nest_fun v = 
	let val other_v = 10
		fun inner_add x = x + other_v
	in inner_add v end;
assert(nest_fun 5 = 15);


local
  fun add_two x1 x2 = x1 + x2
in
  fun add_five x = add_two x 5
end;

(* add two is hidden *)
add_five 10;



(*what difference between the local and nest let*)
(* 函数体类型和返回类型有什么区别 *)


(* decl multi name at the same time *)
val a = 1 and b = 2 and c = 3;
(* set value at the same time *)
val a = b and b = a;
assert(a = 2);
assert(b = 1);

fun pos d = neg(d - 2.0) + 1.0 / d
and neg d = if d > 0.0 then pos(d - 2.0) - 1.0 / d
						else 0.0;
4.0 * pos(201.0);
4.0 * neg(8003.0);