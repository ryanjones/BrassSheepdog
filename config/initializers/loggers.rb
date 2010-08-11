#configure sms logger
require 'log4r'
include Log4r
#create the logger
sms_logger = Log4r::Logger.new "sms_logger"
#define the level
sms_logger.level = INFO
# define the outputter
file_outputter = FileOutputter.new('sms', :trunc => "false", :filename => "log/sms.log")
# specify the format for the message.
file_outputter.formatter = PatternFormatter.new(:pattern => "[%l] %d :: %m")
# assign the outputter
sms_logger.outputters = file_outputter