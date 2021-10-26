signature ARITH =
sig
  type t
  val zero : t
  val sum : t * t -> t
  val diff : t * t -> t
end

structure Complex : ARITH =
    struct
    type t = real * real;
    val zero = (0.0, 0.0);
    fun sum ((x, y), (x', y')) = (x + x', y + y') : t;
    fun diff ((x, y), (x', y')) = (x - x', y - y') : t;
    end;

val i = (0.0, 1.0);
val a = (0.3, 0.0);

val b = Complex.sum(a, i);

(* not effect *)
(* fun s_sum ((x, y), (x', y')) = (x + x', y + y');
s_sum(b, b); *)


fun infer_int_compute(x, y) = x * y + 1;
infer_int_compute(2, 3);

fun pair_v x = (x, x);
