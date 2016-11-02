class TerminologyController < ApplicationController
  def index
    @terms = Term.order(name: :asc)
  end
end
