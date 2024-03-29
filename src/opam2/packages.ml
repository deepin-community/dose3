(******************************************************************************)
(*  This file is part of the Dose library http://www.irill.org/software/dose  *)
(*                                                                            *)
(*  Copyright (C) 2009-2015 Pietro Abate <pietro.abate@pps.jussieu.fr>        *)
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

open ExtLib
open Dose_common
open Dose_extra

include Util.Logging (struct
  let label = "dose_opam.packages"
end)

type options =
  Dose_pef.Packages_types.architecture
  * Dose_pef.Packages_types.architecture list
  * Dose_pef.Packages_types.buildprofile list

type request =
  { install : Dose_pef.Packages_types.vpkg list;
    remove : Dose_pef.Packages_types.vpkg list;
    upgrade : Dose_pef.Packages_types.vpkg list;
    dist_upgrade : bool;
    switch : string;
    switches : string list;
    profiles : string list;
    preferences : string
  }

let default_request =
  { install = [];
    remove = [];
    upgrade = [];
    dist_upgrade = false;
    switch = "";
    switches = [];
    profiles = [];
    preferences = ""
  }

let matchswitch switches = function
  | [] -> true
  | (true, _) :: _ as al -> List.exists (fun (_, a) -> List.mem a switches) al
  | (false, _) :: _ as al ->
      List.for_all (fun (_, a) -> not (List.mem a switches)) al

let matchos profiles = function
  | [] -> true
  | ll -> List.exists (List.for_all (fun (c, p) -> c = List.mem p profiles)) ll

let select (switch, switches, profiles) (v, al, pl) =
  if matchswitch (switch :: switches) al && matchos profiles pl then [v] else []

let vpkglist_filter options l = List.flatten (List.map (select options) l)

let vpkgformula_filter options ll =
  List.filter_map
    (fun l -> match vpkglist_filter options l with [] -> None | l -> Some l)
    ll

let parse_req =
  Dose_pef.Packages.lexbuf_wrapper Dose_pef.Packages_parser.vpkglist_top

let parse_request_stanza par =
  try
    { install = Dose_pef.Packages.parse_s ~default:[] parse_req "install" par;
      remove = Dose_pef.Packages.parse_s ~default:[] parse_req "remove" par;
      upgrade = Dose_pef.Packages.parse_s ~default:[] parse_req "upgrade" par;
      dist_upgrade =
        Dose_pef.Packages.parse_s
          ~default:false
          Dose_pef.Packages.parse_bool
          "dist_upgrade"
          par;
      switch =
        Dose_pef.Packages.parse_s
          ~required:true
          Dose_pef.Packages.parse_string
          "switch"
          par;
      switches =
        Dose_pef.Packages.parse_s
          ~default:[]
          Dose_pef.Packages.parse_string_list
          "switches"
          par;
      profiles =
        Dose_pef.Packages.parse_s
          ~default:[]
          Dose_pef.Packages.parse_string_list
          "profiles"
          par;
      preferences =
        Dose_pef.Packages.parse_s
          ~default:""
          Dose_pef.Packages.parse_string
          "preferences"
          par
    }
  with Format822.ParseError (cl, f, err) ->
    let c = "Parser Error in Preamble" in
    raise (Format822.ParseError (c :: cl, f, err))

class package ?(name = ("package", None)) ?(version = ("version", None))
  ?(depends = ("depends", None)) ?(conflicts = ("conflicts", None))
  ?(provides = ("provides", None)) ?(depopts = ("depopts", None))
  ?(switch = ("switches", None)) ?(installedlist = ("installed", None))
  ?(pinnedlist = ("pinned", None)) ?(baselist = ("base", None))
  ?(extras = ([], None)) par =
  object
    inherit
      Dose_pef.Packages.package
        ~name
        ~version
        ~depends
        ~conflicts
        ~provides
        ~recommends:depopts
        ~extras
        par

    val switch : string * string list =
      let p =
        Dose_pef.Packages.parse_string_list ~rex:Dose_pef.Packages.comma_regexp
      in
      let parse = Dose_pef.Packages.parse_s ~default:["all"] p in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:switch

    val installedlist : string * string list =
      let p =
        Dose_pef.Packages.parse_string_list ~rex:Dose_pef.Packages.comma_regexp
      in
      let parse = Dose_pef.Packages.parse_s ~default:[] p in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:installedlist

    val baselist : string * string list =
      let p =
        Dose_pef.Packages.parse_string_list ~rex:Dose_pef.Packages.comma_regexp
      in
      let parse = Dose_pef.Packages.parse_s ~default:[] p in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:baselist

    val pinnedlist : string * string list =
      let p =
        Dose_pef.Packages.parse_string_list ~rex:Dose_pef.Packages.comma_regexp
      in
      let parse = Dose_pef.Packages.parse_s ~default:[] p in
      Dose_pef.Packages.get_field_value ~parse ~par ~field:pinnedlist

    method switch = snd switch

    method installedlist = snd installedlist

    method baselist = snd baselist

    method pinnedlist = snd pinnedlist

    method depopts = snd recommends

    method! pp oc =
      Dose_pef.Printer.pp_string_wl oc name ;
      Dose_pef.Printer.pp_string_wl oc version ;
      Dose_pef.Printer.pp_string_list_wl oc switch ;
      Dose_pef.Printer.pp_string_list_wl oc installedlist ;
      Dose_pef.Printer.pp_string_list_wl oc pinnedlist ;
      Dose_pef.Printer.pp_string_list_wl oc baselist ;
      Dose_pef.Printer.pp_vpkglist_wl oc provides ;
      Dose_pef.Printer.pp_vpkgformula_wl oc depends ;
      Dose_pef.Printer.pp_vpkgformula_wl oc recommends ;
      Dose_pef.Printer.pp_vpkglist_wl oc conflicts ;
      Printf.fprintf oc "\n"
  end

(* a stanza is not considered if the intersection between the
   active switch and the not available switches for a package is
   empty *)
let parse_package_stanza ((switch, switches, _profiles) as options)
    ?(extras = []) par =
  try
    let pkg_switch =
      let p =
        Dose_pef.Packages.parse_string_list ~rex:Dose_pef.Packages.comma_regexp
      in
      let f = Dose_pef.Packages.parse_s ~default:["all"] p in
      f "switches" par
    in
    if
      not
        (List.mem "all" pkg_switch
        || List.exists (fun s -> List.mem s pkg_switch) (switch :: switches))
    then
      raise
        (Dose_pef.Packages.IgnorePackage
           (Printf.sprintf
              "None of the active switches [%s] are available [%s]"
              (ExtString.String.join "," (switch :: switches))
              (ExtString.String.join "," pkg_switch)))
    else
      let pkg =
        let depends =
          let f =
            Dose_pef.Packages.parse_s
              ~default:[]
              Dose_pef.Packages.parse_builddepsformula
          in
          ("depends", Some (vpkgformula_filter options (f "depends" par)))
        in
        let depopts =
          let f =
            Dose_pef.Packages.parse_s
              ~default:[]
              Dose_pef.Packages.parse_builddepsformula
          in
          ("depopts", Some (vpkgformula_filter options (f "depopts" par)))
        in
        let conflicts =
          let f =
            Dose_pef.Packages.parse_s
              ~default:[]
              Dose_pef.Packages.parse_builddepslist
          in
          ("conflicts", Some (vpkglist_filter options (f "conflicts" par)))
        in
        let provides =
          let f =
            Dose_pef.Packages.parse_s
              ~default:[]
              Dose_pef.Packages.parse_builddepslist
          in
          ("provides", Some (vpkglist_filter options (f "provides" par)))
        in
        (* let extras = List.map (fun (f,v) -> (f,(Format822.dummy_loc,v))) extras in *)
        new package
          ~depends
          ~conflicts
          ~provides
          ~depopts
          ~extras:(extras, None)
          par
      in
      Some pkg
  with
  | Dose_pef.Packages.IgnorePackage s ->
      let n =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_name
          "package"
          par
      in
      let v =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_version
          "version"
          par
      in
      warning "Ignoring Package (%s,%s) : %s" n v s ;
      None
  | Format822.ParseError (cl, f, err) ->
      let n =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_name
          "package"
          par
      in
      let v =
        Dose_pef.Packages.parse_s
          ~default:"?"
          Dose_pef.Packages.parse_version
          "version"
          par
      in
      let c = Printf.sprintf "Parser Error in Package (%s,%s)" n v in
      raise (Format822.ParseError (c :: cl, f, err))

(* parse the entire file while filtering out unwanted stanzas.
 * Depopts is alsways false while parsing opam files *)
let rec packages_parser ?(request = false) (req, acc) p =
  let options = (req.switch, req.switches, req.profiles) in
  match
    Format822_parser.stanza_822 Format822_lexer.token_822 p.Format822.lexbuf
  with
  | None -> (req, acc) (* end of file *)
  | Some stanza when request = true ->
      let req = parse_request_stanza stanza in
      packages_parser (req, acc) p
  | Some stanza -> (
      match parse_package_stanza options stanza with
      | None -> packages_parser (req, acc) p
      | Some st -> packages_parser (req, st :: acc) p)

(* this function raise Format822.ParseError *)
let input_raw_in ic =
  Format822.parse_from_ch
    (packages_parser ~request:true (default_request, []))
    ic

let input_raw file =
  try
    let ch =
      match file with
      | "-" -> IO.input_channel stdin
      | _ -> Input.open_file file
    in
    let l = input_raw_in ch in
    let _ = Input.close_ch ch in
    l
  with
  | Input.File_empty -> (default_request, [])
  | Format822.ParseError (cl, field, errmsg) ->
      fatal
        "Filename %s\n %s\n %s : %s"
        file
        (String.concat "\n " cl)
        field
        errmsg
