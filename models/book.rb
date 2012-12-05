class Book
  include DataMapper::Resource

  property :id, Serial, :required => true
  property :isbn, String, :index => true, :required => true, :length => 255
  property :title, String, :required => true, :length => 255
  property :author, String, :required => true, :length => 255
  property :photo_remote_url, String, :length => 255
  has n, :book_copies
  has n, :reservation

  def self.create_from_openlibrary(isbn)
    params = details_from_google(isbn) || details_from_openlibrary(isbn)
    Book.new(params).tap do |b|
      b.book_copies << BookCopy.new
    end if params
  end

  def self.details_from_openlibrary(isbn)
    details = ::Openlibrary::Data.find_by_isbn(isbn)
    {}.tap do |p|
      p[:isbn]   = details.identifiers["isbn_13"] ? details.identifiers["isbn_13"][0] : isbn
      p[:title]  = details.title
      p[:author] = details.authors.map{|a| a["name"]}.join(", ") if details.authors
      p[:photo_remote_url] = details.cover["medium"] if details.cover
    end if details
  end

  def self.details_from_google(isbn)
    response = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}&fields=items(volumeInfo(authors,description,imageLinks,industryIdentifiers,title))".to_uri.get.deserialise["items"][0]
    return unless response
    response = response["volumeInfo"]
    {}.tap do |p|
      p[:isbn] = isbn
      p[:title] = response["title"]
      p[:author] = response["authors"].join(", ")
      p[:photo_remote_url] = response["imageLinks"]["thumbnail"] if response["imageLinks"]
    end
  end
end
