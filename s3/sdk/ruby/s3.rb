# Load the required libraries
require 'aws-sdk-s3'     # AWS SDK for interacting with Amazon S3
require 'securerandom'   # Used to generate random UUIDs
require 'pry'            # Debugging tool

# Read the bucket name from the environment variable
bucket_name = ENV['BUCKET_NAME']

# Define the AWS region where the bucket will be created
region = 'us-east-1'

# Create an S3 client configured for the specified region
client = Aws::S3::Client.new(region: region)

# Create a new S3 bucket
params = { bucket: bucket_name }
params[:create_bucket_configuration] = { location_constraint: region } unless region == 'us-east-1'
client.create_bucket(params)

# Print a confirmation message after the bucket is created
puts "Bucket #{bucket_name} created."

# Generate a random number between 1 and 6
# This determines how many files will be created and uploaded
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

# Loop through the number of files to create and upload each one
number_of_files.times do |i|
  puts "i: #{i}"

  # Define the file name and temporary local file path
  filename = "file_#{i}.txt"
  output_path = "/tmp/#{filename}"

  # Create a local file and write a random UUID into it
  File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)
  end

  # Open the file in read-binary mode and upload it to the S3 bucket
  File.open(output_path, 'rb') do |f|
    client.put_object(
      bucket: bucket_name,
      key: filename,
      body: f
    )
  end

  # 'Print a message confirming the upload'
  puts "Uploaded #{filename} to #{bucket_name}"
end