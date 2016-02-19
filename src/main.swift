// Copyright (c) 2016 Anarchy Tools Contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/*
 * This is a simply multi-tool front-end for the Anarchy Tools toolset.
 */

#if os(Linux)
import Glibc
#else
import Darwin
#endif

let tools: [Tool] = [BuildTool(), TestTool()]

func showVersion() {
    print("Chaos v\(AppVersion) - Anarchy Tools Front-End\n")
}

func showUsage(withVersion show: Bool = true) {
    if (show) {
        showVersion()
    }
    
    print("usage: chaos [command] [command-options]\n")
    print("commands:")
    for tool in tools {
        print("    \(tool.name) - \(tool.description)")
    }
    print()
}

if Process.arguments.count == 1 {
    print("error: invalid usage")
    showUsage()
    exit(-1)
}

let command = Process.arguments[1]
let args = Process.arguments.dropFirst().dropFirst().map { $0 }

switch command {
case "help", "--help", "-help":
    showUsage(withVersion: true)
    break

default:
    let tool = tools.filter { $0.name == command }.first
    if let tool = tool {
        tool.run()
    }
    else {
        print("unknown command: \(command)")
        showUsage(withVersion: false)
    }
}
