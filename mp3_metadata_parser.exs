defmodule Util do
	defp parser(args) do
		{options, _, _} = OptionParser.parse(args, switches: [file: :string])
		options
	end

	def main(args) do
		options = parser(args)
		file = options[:mp3]
		{:ok, mp3_file} = File.read(file)
		tag        = "TAG"
		author     = pad("Younes Meliani", 30)
		title      = pad("Intro", 30)
		album      = pad("Intro", 30)
		year       = "2011"
		comments   = pad("Copyright: Creative Commons", 30)
		tag_to_write = pad((tag <> author <> title <> album <> year <> comments), 128)
		mp3_size_without_id3 = (byte_size(mp3_file) - 128)
    	<< other_data :: binary-size(mp3_size_without_id3), _ :: binary >> = mp3_file
    	File.write("new.mp3", (other_data <> tag_to_write))
	end

	def id3_v2_info(file) do
		{:ok, mp3_file} = File.read(file)

		<<  tag_id   :: binary-size(3),
			major_v  :: unsigned-integer-size(8),
		    revision :: unsigned-integer-size(8),
		    _        :: bitstring
		>> = mp3_file
		IO.puts """
		    [ID3v2 Info]
		    Tag:            #{tag_id}
		    Major Version:  #{major_v}
		    Revision:       #{revision}
		"""
	end

	def id3_v1_info(file) do
		{:ok, mp3_file} = File.read(file)
		mp3_size_without_id = (byte_size(mp3_file) - 128)
		<<  _           :: binary-size(mp3_size_without_id),
			id3_v1_data :: binary
		>> = mp3_file
		<<	tag      :: binary-size(3),
	        title    :: binary-size(30),
            artist   :: binary-size(30),
            album    :: binary-size(30),
            year     :: binary-size(4),
            comments :: binary-size(30),
            _        :: binary	
		>> = id3_v1_data
		IO.puts """
		    [ID3v1 Info]
		    Tag:            #{tag}
		    Title:          #{title}
		    Artist:         #{artist}
		    Album:          #{album}
		    Year:           #{year}
		    Comments:       #{comments}
		"""
	end

	defp pad(string, wanted_size) do
		String.ljust(string, wanted_size)
	end
end
Util.main(System.argv())
