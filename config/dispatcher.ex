defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  match "/sessions/*path" do
    Proxy.forward conn, path, "http://login/sessions/"
  end

  match "/concepts/*path" do
    Proxy.forward conn, path, "http://resource/concepts/"
  end

  match "/tasks/*path" do
    Proxy.forward conn, path, "http://resource/tasks/"
  end

  match "/validation-result-collections/*path" do
    Proxy.forward conn, path, "http://resource/validation-result-collections/"
  end

  # This is where you can call any method of the validation microservice
  match "/validation/*path" do
    Proxy.forward conn, path, "http://validation/"
  end

  # This is a handy endpoint to get the resources "validations" provided by
  # the validation microservice
  match "/validations/*path" do
    Proxy.forward conn, path, "http://validation/"
  end

  match "/validation-results/*path" do
    Proxy.forward conn, path, "http://resource/validation-results/"
  end

  match "/label-roles/*path" do
    Proxy.forward conn, path, "http://resource/label-roles/"
  end

  match "/concept-labels/*path" do
    Proxy.forward conn, path, "http://resource/concept-labels/"
  end

  match "/taxonomies/*path" do
    Proxy.forward conn, path, "http://resource/taxonomies/"
  end

  match "/hierarchies/*path" do
    Proxy.forward conn, path, "http://resource/hierarchies/"
  end

  match "/hierarchy/*path" do
    Proxy.forward conn, path, "http://hierarchyapi/hierarchies/"
  end

  match "/concept-relations/*path" do
    Proxy.forward conn, path, "http://resource/concept-relations/"
  end

  match "/accounts/*path" do
    Proxy.forward conn, path, "http://resource/accounts/"
  end

  match "/users/*path" do
    Proxy.forward conn, path, "http://resource/users/"
  end

  match "/upload/*path" do
		Proxy.forward conn, path, "http://importer:8080/upload"
  end

  match "/comments/*path" do
    Proxy.forward conn, path, "http://commentsapi:8080/comments/"
  end

  match "/kpis/*path" do
    Proxy.forward conn, path, "http://kpisapi/kpis/"
  end

  match "/translate/*path" do
    Proxy.forward conn, path, "http://dictionary/translate/"
  end

  match "/poetry-tasks/*path" do
      Proxy.forward conn, path, "http://resource/poetry-tasks/"
  end

  match "/suggestions/*path" do
      Proxy.forward conn, path, "http://resource/suggestions/"
  end

  match "/mapping-efforts/*path" do
      Proxy.forward conn, path, "http://resource/mapping-efforts/"
  end

  match "/mappings/*path" do
      Proxy.forward conn, path, "http://resource/mappings/"
  end

  match "/indexer/*path" do
      Proxy.forward conn, path, "http://indexer:8080/"
  end

  match "/import-concepts/*path" do
      Proxy.forward conn, path, "http://import-concepts:9000/"
  end

  match "/move-graph/*path" do
    Proxy.forward conn, path, "http://move-graph/"
  end

  match "/export-mapping/*path" do
    Proxy.forward conn, path, "http://export-mapping/"
  end

  match "/mapping-states/*path" do
    Proxy.forward conn, path, "http://resource/mapping-states/"
  end

  match "/cache/*path" do
    Proxy.forward conn, path, "http://resource/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
