defmodule MyApp.ArticleViewSpec do
  use ESpec.Phoenix, view: MyApp.ArticleView, async: true
  alias MyApp.Article

  let :article, do: %Article{id: 1, title: "国木田花丸", body: "未来ずら" }

  describe "show" do
    let :response, do: render_to_string(@view, "show.html", conn: build_conn, article: article)
    it "renders show template" do
      assert response =~ "国木田花丸"
      assert response =~ "未来ずら"
    end
  end
end
