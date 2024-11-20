class Api::V1::SleepRecordSerializer
    include JSONAPI::Serializer
      
    attributes :id, :clock_in_time, :clock_out_time
end