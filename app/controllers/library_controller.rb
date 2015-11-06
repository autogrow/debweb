class LibraryController < ApplicationController

  def index
    @library = Library.new
    @branches = Branch.all.map do |b|
      ["#{b.project.name}: #{b.name}", b.id]
    end

  end

end
