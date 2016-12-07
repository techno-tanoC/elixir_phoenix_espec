defmodule MyApp.ArticleControllerSpec do
  use ESpec.Phoenix, controller: true, async: true
  alias MyApp.Repo
  alias MyApp.Article
  # alias MyApp.ArticleController

  let :attrs, do: %{title: "国木田花丸", body: "未来ずら"}
  let :assigns, do: conn.assigns

  describe "show" do
    context "when id is existent" do
      let! :article, do: Article |> struct(attrs) |> Repo.insert!
      let :conn, do: get build_conn, article_path(build_conn, :show, article.id)

      it "returns 200" do
        conn.status |> should(eq 200)
        IO.inspect conn
      end

      it "assigns chosen resource" do
        assigns.article |> should(eq article)
      end
    end

    context "when id is nonexistent" do
      let :conn, do: get build_conn, article_path(build_conn, :show, -1)
      it "returns 404" do
        assert_error_sent 404, fn -> conn end
      end
    end
  end

  describe "create" do
    context "with vlid attributes" do
      let :conn, do: post build_conn, article_path(build_conn, :create), article: attrs

      it "returns 302" do
        conn.status |> should(eq 302)
      end

      it "redirects to certain page" do
        assert redirected_to(conn) == article_path(build_conn, :index)
      end

      it "creates a article" do
        expect(&conn/0) |> to(change(fn -> Article |> Repo.all |> Enum.count end, 0, 1))
      end
    end

    context "with invalid attributes" do
      let! :conn, do: post build_conn, article_path(build_conn, :create), article: %{}

      it "assigns invalid changeset" do
        assert assigns.changeset.errors
      end

      it "doesn't create articles" do
        expect(&conn/0) |> to_not(change(fn -> Article |> Repo.all |> Enum.count end))
      end
    end
  end
end
