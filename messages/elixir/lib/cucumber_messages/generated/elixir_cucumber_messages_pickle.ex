# credo:disable-for-this-file
defmodule(CucumberMessages.Pickle) do
  @moduledoc(false)
  (
    defstruct(id: "", uri: "", name: "", language: "", steps: [], tags: [], ast_node_ids: [], __uf__: [])
    (
      @spec(encode(struct) :: {:ok, iodata} | {:error, any})
      def(encode(msg)) do
        try do
          {:ok, encode!(msg)}
        rescue
          e ->
            {:error, e}
        end
      end
      @spec(encode!(struct) :: iodata | no_return)
      def(encode!(msg)) do
        [] |> encode_id(msg) |> encode_uri(msg) |> encode_name(msg) |> encode_language(msg) |> encode_steps(msg) |> encode_tags(msg) |> encode_ast_node_ids(msg) |> encode_unknown_fields(msg)
      end
      []
      [defp(encode_id(acc, msg)) do
        field_value = msg.id()
        if(field_value == "") do
          acc
        else
          [acc, "\n", Protox.Encode.encode_string(field_value)]
        end
      end, defp(encode_uri(acc, msg)) do
        field_value = msg.uri()
        if(field_value == "") do
          acc
        else
          [acc, <<18>>, Protox.Encode.encode_string(field_value)]
        end
      end, defp(encode_name(acc, msg)) do
        field_value = msg.name()
        if(field_value == "") do
          acc
        else
          [acc, <<26>>, Protox.Encode.encode_string(field_value)]
        end
      end, defp(encode_language(acc, msg)) do
        field_value = msg.language()
        if(field_value == "") do
          acc
        else
          [acc, "\"", Protox.Encode.encode_string(field_value)]
        end
      end, defp(encode_steps(acc, msg)) do
        case(msg.steps()) do
          [] ->
            acc
          values ->
            [acc, Enum.reduce(values, [], fn value, acc -> [acc, "*", Protox.Encode.encode_message(value)] end)]
        end
      end, defp(encode_tags(acc, msg)) do
        case(msg.tags()) do
          [] ->
            acc
          values ->
            [acc, Enum.reduce(values, [], fn value, acc -> [acc, "2", Protox.Encode.encode_message(value)] end)]
        end
      end, defp(encode_ast_node_ids(acc, msg)) do
        case(msg.ast_node_ids()) do
          [] ->
            acc
          values ->
            [acc, Enum.reduce(values, [], fn value, acc -> [acc, ":", Protox.Encode.encode_string(value)] end)]
        end
      end]
      defp(encode_unknown_fields(acc, msg)) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc -> case(wire_type) do
          0 ->
            [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]
          1 ->
            [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]
          2 ->
            len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
            [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]
          5 ->
            [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
        end end)
      end
    )
    (
      @spec(decode(binary) :: {:ok, struct} | {:error, any})
      def(decode(bytes)) do
        try do
          {:ok, decode!(bytes)}
        rescue
          e ->
            {:error, e}
        end
      end
      (
        @spec(decode!(binary) :: struct | no_return)
        def(decode!(bytes)) do
          parse_key_value(bytes, struct(CucumberMessages.Pickle))
        end
      )
      (
        @spec(parse_key_value(binary, struct) :: struct)
        defp(parse_key_value(<<>>, msg)) do
          msg
        end
        defp(parse_key_value(bytes, msg)) do
          {field, rest} = case(Protox.Decode.parse_key(bytes)) do
            {0, _, _} ->
              raise(%Protox.IllegalTagError{})
            {1, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = delimited
              field = {:id, value}
              {field, rest}
            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = delimited
              field = {:uri, value}
              {field, rest}
            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = delimited
              field = {:name, value}
              {field, rest}
            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = delimited
              field = {:language, value}
              {field, rest}
            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = CucumberMessages.Pickle.PickleStep.decode!(delimited)
              field = {:steps, msg.steps() ++ List.wrap(value)}
              {field, rest}
            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = CucumberMessages.Pickle.PickleTag.decode!(delimited)
              field = {:tags, msg.tags() ++ List.wrap(value)}
              {field, rest}
            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              <<delimited::binary-size(len), rest::binary>> = bytes
              value = delimited
              field = {:ast_node_ids, msg.ast_node_ids() ++ List.wrap(value)}
              {field, rest}
            {tag, wire_type, rest} ->
              {value, new_rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)
              field = {msg.__struct__.unknown_fields_name, [value | msg.__struct__.unknown_fields(msg)]}
              {field, new_rest}
          end
          msg_updated = struct(msg, [field])
          parse_key_value(rest, msg_updated)
        end
      )
      []
    )
    @spec(defs() :: %{required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}})
    def(defs()) do
      %{1 => {:id, {:default, ""}, :string}, 2 => {:uri, {:default, ""}, :string}, 3 => {:name, {:default, ""}, :string}, 4 => {:language, {:default, ""}, :string}, 5 => {:steps, :unpacked, {:message, CucumberMessages.Pickle.PickleStep}}, 6 => {:tags, :unpacked, {:message, CucumberMessages.Pickle.PickleTag}}, 7 => {:ast_node_ids, :unpacked, :string}}
    end
    @spec(defs_by_name() :: %{required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}})
    def(defs_by_name()) do
      %{ast_node_ids: {7, :unpacked, :string}, id: {1, {:default, ""}, :string}, language: {4, {:default, ""}, :string}, name: {3, {:default, ""}, :string}, steps: {5, :unpacked, {:message, CucumberMessages.Pickle.PickleStep}}, tags: {6, :unpacked, {:message, CucumberMessages.Pickle.PickleTag}}, uri: {2, {:default, ""}, :string}}
    end
    @spec(required_fields() :: [])
    def(required_fields()) do
      []
    end
    @spec(unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}])
    def(unknown_fields(msg)) do
      msg.__uf__()
    end
    @spec(unknown_fields_name() :: :__uf__)
    def(unknown_fields_name()) do
      :__uf__
    end
    @spec(clear_unknown_fields(struct) :: struct)
    def(clear_unknown_fields(msg)) do
      struct!(msg, [{unknown_fields_name(), []}])
    end
    @spec(syntax() :: atom)
    def(syntax()) do
      :proto3
    end
    [@spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}), [def(default(:id)) do
      {:ok, ""}
    end, def(default(:uri)) do
      {:ok, ""}
    end, def(default(:name)) do
      {:ok, ""}
    end, def(default(:language)) do
      {:ok, ""}
    end, def(default(:steps)) do
      {:error, :no_default_value}
    end, def(default(:tags)) do
      {:error, :no_default_value}
    end, def(default(:ast_node_ids)) do
      {:error, :no_default_value}
    end], def(default(_)) do
      {:error, :no_such_field}
    end]
  )
  []
end