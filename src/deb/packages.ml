(******************************************************************************)
(*  This file is part of the Dose library http://www.irill.org/software/dose  *)
(*                                                                            *)
(*  Copyright (C) 2009-2011 Pietro Abate <pietro.abate@pps.jussieu.fr>        *)
(*                                                                            *)
(*  This library is free software: you can redistribute it and/or modify      *)
(*  it under the terms of the GNU Lesser General Public License as            *)
(*  published by the Free Software Foundation, either version 3 of the        *)
(*  License, or (at your option) any later version.  A special linking        *)
(*  exception to the GNU Lesser General Public License applies to this        *)
(*  library, see the COPYING file for more information.                       *)
(*                                                                            *)
(*  Work developed with the support of the Mancoosi Project                   *)
(*  http://www.mancoosi.org                                                   *)
(*                                                                            *)
(******************************************************************************)

(** Representation of a debian package description item. *)

open ExtLib
open Dose_common
open Dose_extra

include Util.Logging (struct
  let label = "dose_deb.packages"
end)

let parse_multiarch (label, (_, s)) =
  match s with
  | "None" | "none" | "No" | "no" -> `No
  | "Allowed" | "allowed" -> `Allowed
  | "Foreign" | "foreign" -> `Foreign
  | "Same" | "same" -> `Same
  | _ ->
      raise
        (Format822.ParseError ([], label, Printf.sprintf "Wrong value : %s" s))

let parse_source v =
  Dose_pef.Packages.lexbuf_wrapper Dose_pef.Packages_parser.source_top v

let parse_binarylist v =
  Dose_pef.Packages.lexbuf_wrapper Dose_pef.Packages_parser.vpkglist_top v

class package ?(name = ("Package", None)) ?(version = ("Version", None))
  ?(depends = ("Depends", None)) ?(conflicts = ("Conflicts", None))
  ?(provides = ("Provides", None)) ?(recommends = ("Recommends", None))
  ?(architecture = ("Architecture", None)) ?(multiarch = ("Multi-Arch", None))
  ?(source = ("Source", None)) ?(essential = ("Essential", None))
  ?(extra_source_only = ("Extra-Source-Only", None))
  ?(priority = ("Priority", None)) ?(pre_depends = ("Pre-Depends", None))
  ?(suggests = ("Suggests", None)) ?(enhances = ("Enhances", None))
  ?(breaks = ("Breaks", None)) ?(replaces = ("Replaces", None))
  ?(extras = ([], None)) par =
  object
    inherit
      Dose_pef.Packages.package
        ~name
        ~version
        ~depends
        ~conflicts
        ~provides
        ~recommends
        ~extras
        par

    val architecture : string * Dose_pef.Packages_types.architecture =
      let parse =
        Dose_pef.Packages.parse_s ~required:true Dose_pef.Packages.parse_string
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:architecture

    val multiarch : string * Dose_pef.Packages_types.multiarch =
      let parse = Dose_pef.Packages.parse_s ~default:`No parse_multiarch in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:multiarch

    val source
        : string
          * (Dose_pef.Packages_types.name
            * Dose_pef.Packages_types.version option) =
      let parse = Dose_pef.Packages.parse_s ~default:("", None) parse_source in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:source

    val essential : string * bool =
      let parse =
        Dose_pef.Packages.parse_s ~default:false Dose_pef.Packages.parse_bool
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:essential

    val extra_source_only : string * bool =
      let parse =
        Dose_pef.Packages.parse_s ~default:false Dose_pef.Packages.parse_bool
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:extra_source_only

    val priority : string * string =
      let parse =
        Dose_pef.Packages.parse_s ~default:"" Dose_pef.Packages.parse_string
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:priority

    val pre_depends : string * Dose_pef.Packages_types.vpkgformula =
      let parse =
        Dose_pef.Packages.parse_s
          ~default:[]
          Dose_pef.Packages.parse_vpkgformula
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:pre_depends

    val suggests : string * Dose_pef.Packages_types.vpkgformula =
      let parse =
        Dose_pef.Packages.parse_s
          ~default:[]
          Dose_pef.Packages.parse_vpkgformula
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:suggests

    val enhances : string * Dose_pef.Packages_types.vpkgformula =
      let parse =
        Dose_pef.Packages.parse_s
          ~default:[]
          Dose_pef.Packages.parse_vpkgformula
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:enhances

    val breaks : string * Dose_pef.Packages_types.vpkglist =
      let parse =
        Dose_pef.Packages.parse_s ~default:[] Dose_pef.Packages.parse_vpkglist
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:breaks

    val replaces : string * Dose_pef.Packages_types.vpkglist =
      let parse =
        Dose_pef.Packages.parse_s ~default:[] Dose_pef.Packages.parse_vpkglist
      in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:replaces

    method architecture = snd architecture

    method multiarch = snd multiarch

    method essential = snd essential

    method extra_source_only = snd extra_source_only

    method priority = snd priority

    method source = snd source

    method pre_depends = snd pre_depends

    method suggests = snd suggests

    method enhances = snd enhances

    method breaks = snd breaks

    method replaces = snd replaces

    method set_multiarch v = {<multiarch = (fst multiarch, v)>}

    method set_essential v = {<essential = (fst essential, v)>}

    (* this method override the method in the super class *)
    method! pp oc =
      let pp_multiarch = function
        | `No -> "no"
        | `Same -> "same"
        | `Foreign -> "foreign"
        | `Allowed -> "allowed"
      in
      let pp_source = function
        | (source, None) when source <> "" -> source
        | (source, Some version) -> Printf.sprintf "%s (%s)" source version
        | _ -> ""
      in
      Dose_pef.Printer.pp_string_wl oc name ;
      Dose_pef.Printer.pp_string_wl oc version ;
      Dose_pef.Printer.pp_string_wl oc architecture ;
      Dose_pef.Printer.pp_function_wl oc ~tostring:pp_multiarch multiarch ;
      Dose_pef.Printer.pp_yes_wl oc essential ;
      Dose_pef.Printer.pp_string_wl oc priority ;
      Dose_pef.Printer.pp_function_wl oc ~tostring:pp_source source ;
      Dose_pef.Printer.pp_vpkglist_wl oc provides ;
      Dose_pef.Printer.pp_vpkgformula_wl oc depends ;
      Dose_pef.Printer.pp_vpkgformula_wl oc pre_depends ;
      Dose_pef.Printer.pp_vpkglist_wl oc conflicts ;
      Dose_pef.Printer.pp_vpkglist_wl oc breaks ;
      Dose_pef.Printer.pp_vpkgformula_wl oc suggests ;
      Dose_pef.Printer.pp_vpkgformula_wl oc enhances ;
      Dose_pef.Printer.pp_vpkgformula_wl oc recommends ;
      Dose_pef.Printer.pp_vpkglist_wl oc replaces ;
      Printf.fprintf oc "\n"
  end

let parse_package_stanza filter archs extras par =
  let p () =
    let pkg = new package ~extras:(extras, Some [("Type", "bin")]) par in
    (* make sure that the "all" arch is always considered *)
    if archs = [] then pkg
    else if List.mem pkg#architecture ("all" :: archs) then pkg
    else
      raise
        (Dose_pef.Packages.IgnorePackage
           (Printf.sprintf
              "architecture: %s is not included in %s"
              pkg#architecture
              (ExtString.String.join "," ("all" :: archs))))
  in
  try
    if Option.is_none filter then Some (p ())
    else if (Option.get filter) par then Some (p ())
    else None
  with
  | Dose_pef.Packages.IgnorePackage s ->
      let n =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_name
          "Package"
          par
      in
      let v =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_version
          "Version"
          par
      in
      let a =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_string
          "Architecture"
          par
      in
      warning "Ignoring Package (%s,%s,%s) : %s" n v a s ;
      None
  | Format822.ParseError (cl, f, err) ->
      let n =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_name
          "Package"
          par
      in
      let v =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_version
          "Version"
          par
      in
      let a =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_string
          "Architecture"
          par
      in
      let c = Printf.sprintf "Parser Error in Package (%s,%s,%s)" n v a in
      raise (Format822.ParseError (c :: cl, f, err))

(*
let status_filter par =
  try
    let (_,s) = (Dose_pef.Packages.assoc "Status" par) in
    match String.nsplit s " " with
    |[_;_;"installed"] -> true
    |_ -> false
  with Not_found -> false

let arch_filter archlist par =
  try
    let (_,s) = (Dose_pef.Packages.assoc "Architecture" par) in
    List.mem s archlist
  with Not_found -> false
*)

let parse_packages_in ?filter ?(archs = []) ?(extras = []) fname ic =
  info "Parsing Packages file %s..." fname ;
  try
    let stanza_parser = parse_package_stanza filter archs extras in
    Format822.parse_from_ch
      (Dose_pef.Packages.packages_parser fname stanza_parser)
      ic
  with Format822.ParseError (cl, field, errmsg) ->
    fatal
      "Filename %s\n %s\n %s : %s"
      fname
      (String.concat "\n " cl)
      field
      errmsg

let id p = (p#name, p#version, p#architecture)

let ( >% ) p1 p2 = Stdlib.compare (id p1) (id p2)

module Set = struct
  include Set.Make (struct
    type t = package

    let compare x y =
      let c = x >% y in
      if c = 0 && x#architecture <> "all" then
        debug
          "the input contains two packages with the same name, version and \
           architecture (%s,%s,%s). Only the latter will be considered."
          x#name
          x#version
          x#architecture ;
      c
  end)
end

let merge status packages =
  if List.length status > 0 then (
    info "Merging status file" ;
    let merge_aux p1 p2 =
      if p1 >% p2 = 0 then
        let paux = p1#set_essential (p1#essential || p2#essential) in
        paux#set_extras (List.unique (p1#extras @ p2#extras))
      else fatal "Something went wrong while merging status+packages"
    in
    let h = Hashtbl.create (List.length status) in
    List.iter (fun p -> Hashtbl.add h (id p) p) status ;
    let ps =
      List.fold_left
        (fun acc p ->
          try Set.add (merge_aux p (Hashtbl.find h (id p))) acc
          with Not_found -> Set.add p acc)
        Set.empty
        (status @ packages)
    in
    Set.elements ps)
  else packages

let installed_re = Re.Pcre.regexp "[a-z]+[ \t]+[a-z]+[ \t]+installed"

let is_installed pkg =
  try Re.Pcre.pmatch ~rex:installed_re (pkg#get_extra "Status")
  with Not_found -> false

let is_on_hold pkg =
  try
    match String.split (pkg#get_extra "Status") " " with
    | ("hold", _) -> true
    | _ -> false
  with Not_found -> false

let default_extras =
  [ ("Status", None);
    ("Size", None);
    ("Installed-Size", None);
    ("Multi-Arch", None);
    ("Filename", None) ]

(** input_raw [file] : parse a debian Packages file from [file]
    [~archs] determines which which architectures should be considered while
    parsing the Packages file. if ~arch is [] then all archs are cosidered
*)
let input_raw ?filter ?(archs = []) ?(extras = []) =
  let module M = Format822.RawInput (Set) in
  let extras = default_extras @ extras in
  M.input_raw (parse_packages_in ?filter ~archs ~extras)

(** input_raw_in ch : parse a debian Packages file from channel [ch] *)
let input_raw_in ?filter ?(archs = []) ?(extras = []) =
  let module M = Format822.RawInput (Set) in
  let extras = default_extras @ extras in
  M.input_raw_in (parse_packages_in ?filter ~archs ~extras)
