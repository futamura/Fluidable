#!/usr/bin/env ruby

require "json"
require "minitest/autorun"
require_relative "ios_simulator_destination"

class IOSSimulatorDestinationTest < Minitest::Test
  def test_uses_available_device_id_from_newest_ios_runtime
    simctl_json = JSON.generate(
      "devices" => {
        "com.apple.CoreSimulator.SimRuntime.iOS-18-6" => [
          {
            "name" => "iPhone 16",
            "udid" => "OLD-IPHONE",
            "isAvailable" => true
          }
        ],
        "com.apple.CoreSimulator.SimRuntime.iOS-26-5" => [
          {
            "name" => "iPhone 17",
            "udid" => "UNAVAILABLE-IPHONE",
            "isAvailable" => false
          },
          {
            "name" => "iPad (A16)",
            "udid" => "LATEST-IPAD",
            "isAvailable" => true
          },
          {
            "name" => "iPhone 17 Pro",
            "udid" => "LATEST-IPHONE",
            "isAvailable" => true
          }
        ]
      }
    )

    assert_equal(
      "platform=iOS Simulator,id=LATEST-IPHONE",
      IOSSimulatorDestination.destination(simctl_json: simctl_json)
    )
  end

  def test_falls_back_to_available_ipad_on_newest_runtime
    simctl_json = JSON.generate(
      "devices" => {
        "com.apple.CoreSimulator.SimRuntime.iOS-17-5" => [
          {
            "name" => "iPhone 15",
            "udid" => "OLD-IPHONE",
            "isAvailable" => true
          }
        ],
        "com.apple.CoreSimulator.SimRuntime.iOS-26-5" => [
          {
            "name" => "iPad (A16)",
            "udid" => "LATEST-IPAD",
            "isAvailable" => true
          }
        ]
      }
    )

    assert_equal(
      "platform=iOS Simulator,id=LATEST-IPAD",
      IOSSimulatorDestination.destination(simctl_json: simctl_json)
    )
  end

  def test_raises_when_no_available_ios_simulator_exists
    simctl_json = JSON.generate(
      "devices" => {
        "com.apple.CoreSimulator.SimRuntime.iOS-26-5" => [
          {
            "name" => "iPhone 17",
            "udid" => "UNAVAILABLE-IPHONE",
            "isAvailable" => false
          }
        ],
        "com.apple.CoreSimulator.SimRuntime.watchOS-26-5" => [
          {
            "name" => "Apple Watch",
            "udid" => "WATCH",
            "isAvailable" => true
          }
        ]
      }
    )

    error = assert_raises(IOSSimulatorDestination::Error) do
      IOSSimulatorDestination.destination(simctl_json: simctl_json)
    end
    assert_match(/No available iOS simulator/, error.message)
  end
end
