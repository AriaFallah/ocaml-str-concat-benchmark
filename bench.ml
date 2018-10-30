module Bench = Core_bench.Bench
open Core.Std


module Rope = Core.Std.Rope

let main () =
  let short_str = "str" in
  let long_str = String.make 1000 'c' in


  let short_list_long_str = Array.init 5 ~f:(fun _ -> long_str) in
  let short_list_short_str = Array.init 5 ~f:(fun _ -> short_str) in
  let long_list_long_str = Array.init 1000 ~f:(fun _ -> long_str) in
  let long_list_short_str = Array.init 1000 ~f:(fun _ -> short_str) in
  let very_long_list_short_str = Array.init 10000 ~f:(fun _ -> short_str) in

  let add_strs array = fun () ->
    let s : string = Array.fold_right ~init:"" ~f:(fun a b -> a ^ b) array in
    s |> ignore
  in

  let concat_strs array = fun () ->
    let l = Array.fold_right ~init:[] ~f:List.cons array in
    let l = List.rev l in
    let s : string = String.concat ~sep:"" l in
    s |> ignore
  in

  let buffer_strs size array = fun () ->
    let buffer = Buffer.create size in
    Array.fold_right ~init:() ~f:(fun s () -> Buffer.add_string buffer s) array;
    let s : string = Buffer.contents buffer in
    s |> ignore
  in

  let rope_strs array = fun () ->
    let rope = Array.fold_right ~init:Rope.(of_string "") ~f:(fun a b -> Rope.(of_string a ^ b)) array in
    let s : string = Rope.to_string rope in
    s |> ignore
  in

(*   let concat_fair_strs lst = fun () -> String.concat ~sep:"" lst |> ignore in *)

  print_endline "5 strings x 10000 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs short_list_long_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs short_list_long_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 5000 short_list_long_str);
    Bench.Test.create ~name:"Rope"
      (rope_strs short_list_long_str);
  ]);

  print_endline "5 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs short_list_short_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs short_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 15 short_list_short_str);
    Bench.Test.create ~name:"Rope"
      (rope_strs short_list_short_str);
  ]);

  print_endline "1000 strings x 1000 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs long_list_long_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs long_list_long_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 1000000 long_list_long_str);
    Bench.Test.create ~name:"Rope"
      (rope_strs long_list_long_str);
  ]);

  print_endline "1000 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs long_list_short_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs long_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 3000 long_list_short_str);
    Bench.Test.create ~name:"Rope"
      (rope_strs long_list_short_str);
  ]);

  print_endline "10000 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"String.concat"
      (concat_strs very_long_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 30000 very_long_list_short_str);
    Bench.Test.create ~name:"Rope"
      (rope_strs very_long_list_short_str);
  ])


let () = main ()
