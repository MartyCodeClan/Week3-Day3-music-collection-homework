require('pg')
require_relative('../db/music_sql_runner')

class Album

attr_reader :id
attr_accessor :title, :genre

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES
        ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def get_artist
    sql = "SELECT * FROM artists WHERE id = #{@artist_id};"
    artist = SqlRunner.run(sql)[0]
    # binding.pry
    return Artist.new(artist)
    # nil
  end

  def update
    sql = "UPDATE albums SET (title, genre) = ('#{@title}','#{@genre}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id};"
    SqlRunner.run(sql)
  end
  



end

# go over difference between find method and delete methods
# why is id getting an ever larger number. shouldn't the delete calls in the console get rid of this?