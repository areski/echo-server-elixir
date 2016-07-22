defmodule Echo do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: Echo.TaskSupervisor]]),
      worker(Task, [Echo.Server, :start, [12321]])
    ]

    opts = [strategy: :one_for_one, name: Echo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
