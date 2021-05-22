class FactoryBurgers::Presenters::ExamplePresenter < FactoryBurgers::Presenters::Base
  presents :user

  def type
    "An example"
  end

  def link_path
    "link/to/#{user.login}"
  end
end
