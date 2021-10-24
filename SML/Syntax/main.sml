fun assert(value : bool, comment : string) = 
  if value then 
		"true assert"(*"Assertion is valid \"" ^ comment ^ "\"\r\n"*)
	else 
		"Assertion is INVALID \"" ^ comment ^ "\"\r\n";

fun assert_eq(v1: real, v2: real, comment: string) = assert(abs(v1 - v2) < 0.000001, comment);

print "Hello, World\n";

val pi = 3.1415926;
fun area r = pi * r * r;
val area_result = 3.1415926 * 0.5 * 0.5;
(*comment*)
assert_eq(area 5.0, area_result, "");

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

(* 1.函数体类型和返回类型有什么区别 *)

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

fun lengthvec (x, y) = Math.sqrt(x * x, y * y);
