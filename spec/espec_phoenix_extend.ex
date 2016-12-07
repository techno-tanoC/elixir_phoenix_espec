defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias MyApp.Repo
    end
  end

  def controller do
    quote do
      alias MyApp
      import MyApp.Router.Helpers

      @endpoint MyApp.Endpoint
    end
  end

  def view do
    quote do
      import MyApp.Router.Helpers
    end
  end

  def channel do
    quote do
      alias MyApp.Repo

      @endpoint MyApp.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
