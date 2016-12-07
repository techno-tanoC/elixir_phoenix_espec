defmodule MyApp.ArticleSpec do
  use ESpec.Phoenix, model: true, async: true
  alias MyApp.Article

  subject do: Article.changeset(%Article{}, attrs).valid?

  describe "changeset" do
    context "with valid attributes" do
      let :attrs, do: %{title: "国木田花丸", body: "未来ずら"}
      it do: is_expected |> to(be_true)
    end

    context "with invalid attributes" do
      let :attrs, do: %{}
      it do: is_expected |> to(be_false)
    end
  end
end
