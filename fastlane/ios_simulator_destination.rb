#!/usr/bin/env ruby

require "json"
require "open3"

module IOSSimulatorDestination
  class Error < StandardError; end

  DEFAULT_PREFERRED_NAMES = [
    "iPhone 17",
    "iPhone 17 Pro",
    "iPhone 16",
    "iPhone 16 Pro",
    "iPhone 15",
    "iPhone 15 Pro",
    "iPhone SE (3rd generation)"
  ].freeze

  module_function

  def destination(simctl_json: nil, preferred_names: DEFAULT_PREFERRED_NAMES)
    device = best_device(
      simctl_json: simctl_json || available_devices_json,
      preferred_names: preferred_names
    )

    "platform=iOS Simulator,id=#{device.fetch(:udid)}"
  end

  def best_device(simctl_json:, preferred_names: DEFAULT_PREFERRED_NAMES)
    devices = ios_devices(simctl_json)
    raise Error, "No available iOS simulator found" if devices.empty?

    devices.min_by do |device|
      [
        -device.fetch(:runtime_version),
        device_rank(device.fetch(:name), preferred_names),
        device.fetch(:name)
      ]
    end
  end

  def available_devices_json
    output, status = Open3.capture2e(
      "xcrun",
      "simctl",
      "list",
      "devices",
      "available",
      "--json"
    )
    return output if status.success?

    raise Error, "Failed to list iOS simulators: #{output.strip}"
  end

  def ios_devices(simctl_json)
    JSON.parse(simctl_json).fetch("devices", {}).flat_map do |runtime, devices|
      next [] unless runtime.include?("CoreSimulator.SimRuntime.iOS-")

      version = runtime_version(runtime)
      devices.filter_map do |device|
        next unless device["isAvailable"]
        next unless device["udid"] && device["name"]

        {
          name: device.fetch("name"),
          udid: device.fetch("udid"),
          runtime_version: version
        }
      end
    end
  rescue JSON::ParserError => error
    raise Error, "Failed to parse simctl JSON: #{error.message}"
  end

  def runtime_version(runtime)
    match = runtime.match(/iOS-(\d+(?:-\d+)*)\z/)
    return 0 unless match

    match[1].split("-").map(&:to_i).reduce(0) do |value, component|
      (value * 1_000) + component
    end
  end

  def device_rank(name, preferred_names)
    preferred_index = preferred_names.index(name)
    return preferred_index if preferred_index
    return preferred_names.length if name.start_with?("iPhone")
    return preferred_names.length + 1 if name.start_with?("iPad")

    preferred_names.length + 2
  end
end

puts IOSSimulatorDestination.destination if $PROGRAM_NAME == __FILE__
