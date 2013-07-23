require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Open library" do
  before do
    [Book, BookCopy, User, Reservation].each {|model| model.all.destroy!}
    @isbn = "9788131722428"
    @title = "The Pragmatic Programmer"
    @author = "Hunt"
  end

  it "should add book" do
    photo_remote_url = "http://bks4.books.google.co.in/books?id=kvZEJ9-Hqb0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
    google_api_response = {
      "items" => [{
      "volumeInfo" => {
      "title" => @title,
      "authors" => [ @author ],
      "industryIdentifiers" => [{
      "type" => "ISBN_10",
      "identifier" => "8131722422"
    },
      {
      "type" => "ISBN_13",
      "identifier" => "9788131722428"
    }],
      "imageLinks" => {
      "smallThumbnail" => "http://bks4.books.google.co.in/books?id=kvZEJ9-Hqb0C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
      "thumbnail" => photo_remote_url}}}]
    }
    google_api_url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{@isbn}&fields=items(volumeInfo(authors,description,imageLinks,industryIdentifiers,title))"
    stub_request(:get, google_api_url).to_return({:body => google_api_response.to_json, headers: {"content-type" => "application/json; charset=UTF-8"}})

    visit "/donate"
    fill_in "ISBN", with: "#{@isbn}\n"
    expect(page).to have_content @title
    expect(page).to have_content @author
    expect(page).to have_content "A copy of this book has been added."

    expect(Book.all.size).to eq(1)
    book_added = Book.last
    expect(book_added.isbn).to eq(@isbn)
    expect(book_added.title).to eq(@title)
    expect(book_added.author).to eq(@author)
    expect(book_added.photo_remote_url).to eq("http://bks4.books.google.co.in/books?id=kvZEJ9-Hqb0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
    expect(book_added.book_copies.size).to eq(1)
  end

  it "should add book copy" do
    @book = Book.create(isbn: @isbn,
                        title: "The Pragmatic Programmer",
                        author: "Hunt",
                        photo_remote_url: "http://bks4.books.google.co.in/books?id=kvZEJ9-Hqb0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
    BookCopy.create(book: @book)

    visit "/donate"
    fill_in "ISBN", with: "#{@isbn}\n"
    expect(page).to have_content @title
    expect(page).to have_content @author
    expect(page).to have_content "This book has 1 copies."
    fill_in "copies_to_add", with: 3
    click_button "Add"
    expect(page).to have_content "This book has 4 copies."
  end
end
