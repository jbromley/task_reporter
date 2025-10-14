defmodule TaskReporter.Commits do
  @gitlab_url "https://gitlab.appliedinvention.com/api/v4"
  @project_id 874
  @token System.get_env("GITLAB_TOKEN")

  # TODO Get all commits from all projects
  def list_recent_commits(branch \\ "master", author_email) do
    url =
      "#{@gitlab_url}/projects/#{@project_id}/repository/commits" <>
      "?ref_name=#{branch}&per_page=100&author=#{URI.encode(author_email)}"

    headers = [{"PRIVATE-TOKEN", @token}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, commits} = Jason.decode(body)
        Enum.map(commits, &format_commit/1)

      {:error, reason} ->
        IO.inspect(reason, label: "GitLab API Error")
        []
    end
  end

  defp format_commit(commit) do
    %{
      "date" => commit["committed_date"],
      "message" => commit["title"],
      "branch" => commit["short_id"]
    }
  end
end

