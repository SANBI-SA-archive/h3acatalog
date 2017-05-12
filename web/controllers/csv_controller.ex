defmodule H3acatalog.CsvController do
  use H3acatalog.Web, :controller

  alias H3acatalog.Repo
  alias H3acatalog.Study
  alias H3acatalog.Individual

  def index(conn, _params) do
    filepaths = Path.wildcard("./uploads/*.csv")

    files = %{}
    files = Enum.reduce filepaths, %{}, fn file, acc ->
      #Map.put(acc, Path.basename(file), Path.extname(file))
      #Map.put(acc, Path.basename(file), File.stat!(file).size)
      ctime = File.stat!(file).ctime
      date = elem(ctime, 0)
      year = Integer.to_string(elem(date, 0))
      month = Integer.to_string(elem(date, 1))
      day = Integer.to_string(elem(date, 2))
      time = elem(ctime, 1)
      hour = Integer.to_string(elem(time, 0))
      min = Integer.to_string(elem(time, 1))
      sec  = Integer.to_string(elem(time, 2))
      t = year <> "-" <> month <> "-" <> day <> " " <> hour <> ":" <> min <> ":" <> sec
      Map.put(acc, Path.basename(file), t)
    end

    studies = Repo.all(Study)
    individuals = Repo.all(Individual)

    render(conn, "index.html", files: files, studies: studies, individuals: individuals)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def upload(conn, %{"upload" => %{"csv" => csv}}) do 
    extension = Path.extname(csv.filename)
    if extension == ".csv" do
      {:ok, data, _conn} = Plug.Conn.read_body(conn)
      H3acatalog.Csv.store(%{filename: "#{csv.filename}", path: csv.path})
    end
    render(conn, "index.html")
  end

  def import(conn, %{"file" => file}) do
    # some useful csv files code snippets at https://forums.pragprog.com/forums/322/topics/11945
    path = "./uploads/" <> file

    File.stream!(Path.expand(path))
    |> Stream.drop(1)
    |> Stream.map(&parse_line/1)
    |> Stream.each(fn row ->
      _process_csv_row(file, row)
    end)
    |> Stream.run

    conn
    |> put_flash(:info, "CSV imported successfully.")
    |> redirect(to: csv_path(conn, :index))
  end

  defp parse_line(line) do
    line 
    |> String.trim
    |> String.split(",")
  end

  defp _process_csv_row(file, row) do
    study_params = %{
      study_id: Enum.at(row, 0),
      ega_id: Enum.at(row, 1),
      acronym: Enum.at(row, 2),
      title: Enum.at(row, 3),
      description: Enum.at(row, 4)
    }
    individual_params = %{
      individual_id: Enum.at(row, 0),
      study_id: Enum.at(row, 1),
      species: Enum.at(row, 2),
      sex: Enum.at(row, 3),
      ethnicity: Enum.at(row, 4)
    }
    case file do
      "study.csv" -> _process_study(study_params)
      "individual.csv" -> _process_individual(individual_params)
    end
  end

  defp _process_study(study_params) do
    study = case Repo.get_by(Study, study_id: study_params[:study_id]) do
      nil -> %Study{}
      study -> study
    end
    |> Study.changeset(study_params)
    |> Repo.insert_or_update!
  end

  defp _process_individual(individual_params) do
    individual = case Repo.get_by(Individual, individual_id: individual_params[:individual_id]) do
      nil -> %Individual{}
      individual -> individual
    end
    |> Individual.changeset(individual_params)
    |> Repo.insert_or_update!
  end

end

