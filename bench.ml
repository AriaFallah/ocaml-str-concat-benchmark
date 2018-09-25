open Core_bench

let main () =
  let short_str = "str" in
  let long_str = String.make 1000 'c' in

  let short_list_long_str = List.init 5 (fun _ -> long_str) in
  let short_list_short_str = List.init 5 (fun _ -> short_str) in
  let long_list_long_str = List.init 1000 (fun _ -> long_str) in
  let long_list_short_str = List.init 1000 (fun _ -> short_str) in
  let very_long_list_short_str = List.init 10000 (fun _ -> short_str) in

  let add_strs lst = fun () -> lst |> List.fold_left (fun a b -> a ^ b) "" |> ignore in
  let concat_strs lst = fun () -> String.concat "" lst |> ignore in
  let buffer_strs size lst = fun () ->
    let buf = Buffer.create size in
      lst |> List.iter (fun s -> Buffer.add_string buf s);
      buf |> Buffer.contents |> ignore
  in

  print_endline "5 strings x 10000 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs short_list_long_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs short_list_long_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 5000 short_list_long_str);
  ]);

  print_endline "5 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs short_list_short_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs short_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 15 short_list_short_str);
  ]);

  print_endline "1000 strings x 1000 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs long_list_long_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs long_list_long_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 1000000 long_list_long_str);
  ]);

  print_endline "1000 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"^ operator"
      (add_strs long_list_short_str);
    Bench.Test.create ~name:"String.concat"
      (concat_strs long_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 3000 long_list_short_str);
  ])

  print_endline "10000 strings x 3 length";
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"String.concat"
      (concat_strs very_long_list_short_str);
    Bench.Test.create ~name:"Buffer"
      (buffer_strs 30000 very_long_list_short_str);
  ])
  

let () = main ()