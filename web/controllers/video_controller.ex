defmodule TwitchDiscovery.VideoController do
  use TwitchDiscovery.Web, :controller

  alias TwitchDiscovery.Video

  plug :scrub_params, "video" when action in [:create, :update]

  def index(conn, _params) do
    videos = Repo.all(Video)
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Video.changeset(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Video.changeset(%Video{}, video_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Video created successfully.")
      |> redirect(to: video_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    changeset = Video.changeset(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Repo.get!(Video, id)
    changeset = Video.changeset(video, video_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Video updated successfully.")
      |> redirect(to: video_path(conn, :index))
    else
      render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    Repo.delete!(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end
end
