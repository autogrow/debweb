class LibraryController < ApplicationController

  def index
    @library = Library.new

    @service = ::Services::LibraryScanner.new(@library)
    @service.process

    @debfiles = Debfile.all

    @branches = Branch.all.map do |b|
      ["#{b.project.try(:name) || 'none'}: #{b.name}", b.id]
    end

  end

end
