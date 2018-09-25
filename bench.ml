open Core_bench

let main () =
  let lst = List.init 1000 (fun _ -> "string") in

  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"string add" (fun () ->
      lst |> List.fold_left (fun a b -> a ^ b) "" |> ignore
    );

    Bench.Test.create ~name:"string concat" (fun () ->
      String.concat "" lst |> ignore
    );

    Bench.Test.create ~name:"buffer add" (fun () ->
      let buf = Buffer.create 100 in
      lst |> List.iter (fun s -> Buffer.add_string buf s);
      buf |> Buffer.to_bytes |> Bytes.to_string |> ignore
    );
  ])

let () = main ()