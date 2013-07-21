require File.dirname(__FILE__) + '/spec_helper.rb'

feature "Reservation", :js => true do
  before do
    @book = Book.create(isbn: "9788131722428",
                title: "The Pragmatic Programmer",
                author: "Hunt",
                photo_remote_url: "http://bks4.books.google.co.in/books?id=kvZEJ9-Hqb0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
    @book_copy = BookCopy.create(book: @book)
    @user = User.create(employee_id: 19891, first_name: "Katta", last_name: "Durai")
  end

  scenario "successfull reservation" do
    visit '/'
    expect(page).to have_content 'Tell me who you are'
    fill_in("Employee ID", with: "#{@user.employee_id}\n")
    expect(page).to have_content "Welcome #{@user.first_name}"
    expect(page).to have_content "Pick & Scan"
    fill_in("ISBN", with: "#{@book.isbn}\n")
    expect(page).to have_content "Thank you!"
    expect(page).to have_content "Thats it #{@user.first_name} #{@user.last_name}! You can take the book along with you, please return the book as soon as you are done with it"
    reservation = Reservation.last
    expect(reservation.state).to eq('issued')
    expect(reservation.book_id).to eq(@book_copy.id)
    expect(reservation.user_id).to eq(@user.id)
  end

  after do
    [@book, @book_copy, @user].each{|m| m.destroy!}
  end
end
