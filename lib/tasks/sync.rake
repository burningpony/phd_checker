require 'open3'

# sync task to take last created pg backup, may take a while due to database
# sizes > 100MB
desc 'Captures backup from heroku'
task :capture_backup, [:generate, :app] do |_t, args|
  args.with_defaults(generate: false, app: 'rcg-staging')
  puts "-"*80, 'Capturing database from production...', " v "*27
  begin
    dump_dir = (Rails.root + "db/dumps/").to_s
    dump_path = dump_dir + Time.now.strftime("%m%d%Y_%H%M%S") + ".dump"
    backup_url = Bundler.with_clean_env{Open3.capture2(ENV, "heroku","pg:backups","public-url", "--app", args.app).first.chomp}

    # generate new heroku backup if arg generate true
    system("heroku pg:backups capture", "--app", args.app) if args.generate.to_s == 'true'
    # make directory if it does not exist
    system("mkdir","-p", dump_dir)

    puts "Pulling from #{backup_url}"
    system("curl", "-o", dump_path, backup_url)
  end
end

desc 'Syncs local database with a local backup or grabs from'
task :sync, [:generate, :app] do |task, args|
  puts 'Syncing local database with backup...'

  db_config = Rails.configuration.database_configuration
  database_name = db_config['development']['database']

  dump_location = Rails.root.to_s + "/db/dumps/"

  output, waiters = Open3.pipeline_r(["ls","-t",dump_location],["head","-1"])
  last_dump = output.read.chomp and output.close

  full_dump_path = dump_location + last_dump

  begin
    # looks for most recent dump in dumps folder
    # if there is dump use it, else grab dump from heroku and try again
    restore = ->(){
      if File.exist?(full_dump_path)
        puts "*"*80, "Found #{full_dump_path}", "*"*80
        puts *Open3.capture2("pg_restore", "--verbose", "--clean", "--no-acl", "--no-owner", "-h", "localhost", "-d", database_name, dump_location + last_dump)
      else
        puts " ! "*27, "Could not find a dump file at #{full_dump_path}", " ! "*27
      end
    }

    if last_dump.present?
      restore.()
    else
      puts " ! "*27, 'No local dump found. Invoking capture_backup', " ! "*27
      Rake::Task["capture_backup"].invoke(*args) && restore.()
    end
  end
end
