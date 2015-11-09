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

  def rescan
    Debfile.all.each {|d| d.destroy }
    @service = ::Services::LibraryScanner.new(@library)
    redirect_to library_path, flash: { success: "Rescanned the library" }
  end

end
