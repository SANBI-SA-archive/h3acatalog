defmodule H3acatalog.PageControllerTest do
  use H3acatalog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "H3acatalog to Phoenix!"
  end
end
