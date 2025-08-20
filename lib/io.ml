let[@inline] get_absolute_file_path file =
  file |> Util.T.unquote |> Filename_unix.realpath
;;

let read_file path =
  let channel = open_in path in
  let len = in_channel_length channel in
  let content = really_input_string channel len in
  close_in channel;
  content
;;

let write_file path content =
  let dated_content =
    Printf.sprintf
      {|// This file was auto-generated. DO NOT modify this file by hand.
// Generated on %s
%s
    |}
      (Util.T.get_current_date ())
      content
  in
  let channel = open_out path in
  output_string channel (dated_content |> String.trim);
  output_string channel "\n";
  close_out channel
;;

let lispify string =
  "(" ^ string ^ ")"
;;
