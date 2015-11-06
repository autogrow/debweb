class LibraryController < ApplicationController

  def index
    @library = Library.new

    @service = ::Services::LibraryScanner.new(@library)
    @service.process

    @debfiles = Debfile.all

    @branches = Branch.all.map do |b|
      ["#{b.project.name}: #{b.name}", b.id]
    end

  end

end
