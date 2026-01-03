defmodule Trot.LiveReloadTest do
  use ExUnit.Case, async: true
  import Trot.TestHelper

  setup do
    tempfile = Path.relative_to_cwd("lib/tmp-test-#{:binary.encode_hex(:rand.bytes(16))}.ex")
    :ok = File.touch!(tempfile)
    on_exit(fn -> File.rm!(tempfile) end)
  end

  test "reloading maintains the requested URL" do
    conn = test_conn(:get, "/foo") |> Trot.LiveReload.call([env: :dev])
    assert conn.status == 302
    assert Plug.Conn.get_resp_header(conn, "location") |> List.first == "/foo"
  end

  test "reloading does not happen outside of dev" do
    conn = test_conn(:get, "/")
    assert Trot.LiveReload.call(conn, [env: :production]) == conn
  end
end
