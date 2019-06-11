# frozen_string_literal: true

require_relative '../config/boot'

module ReleaseManager
  def self.logger
    return @logger unless @logger.nil?

    Helpers::File.create_dir(LOG_DIR) unless Helpers::File.dir_exists?(LOG_DIR)

    stdout_logger = Logger.new(STDOUT)
    stdout_logger.level = Logger::DEBUG

    file_logger = Logger.new(File.open(LOG_DIR.join('release_manager.log'), 'a'))
    file_logger.level = Logger::DEBUG

    @logger = Common::MultiLogger.new(file_logger, stdout_logger)
  end
end
