#!/usr/bin/ruby
$:.unshift(File.dirname(__FILE__)+'/../lib')
require 'statsample'

Statsample::Analysis.store(Statsample::Reliability) do
  
  samples=100
  a=rnorm(samples)
  
  ds=Statsample::Dataset.new
  
  20.times do |i|
    ds["v#{i}"]=a+rnorm(samples,0,0.2)
  end
  
  ds.update_valid_data
  
  rel=Statsample::Reliability::ScaleAnalysis.new(ds)
  summary rel
  
  
  ms=Statsample::Reliability::MultiScaleAnalysis.new(:name=>"Multi Scale analyss") do |m|
    m.scale "Scale 1", ds.clone(%w{v1 v2 v3 v4 v5 v6 v7 v8 v9 v10})
    m.scale "Scale 2", ds.clone(%w{v11 v12 v13 v14 v15 v16 v17 v18 v19})
  end
  
  summary ms
end

if __FILE__==$0
   Statsample::Analysis.run_batch
end

