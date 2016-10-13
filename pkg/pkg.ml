#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  let build = (Pkg.build ~cmd:(fun c os files ->
      OS.Cmd.run @@ Cmd.(Pkg.build_cmd c os
                         % "-plugin-tag"
                         % "package(ppx_driver.ocamlbuild)"
                         %% of_list files)) ()) in

  Pkg.describe "cancellable" ~build @@ fun c ->
  Ok [ Pkg.mllib "src/cancellable.mllib";
       Pkg.test ~args:Cmd.(v "inline-test-runner" % "cancellable") "test/test";]
