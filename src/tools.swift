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

#if os(Linux)
import Glibc
#else
import Darwin
#endif

protocol Tool {
    func run(args: [String])
    
    /// The name used to invoke the command within `chaos`.
    var name: String { get }
    
    /// The name of the CLI tool to run.
    var tool: String { get }
    
    /// A short description to be provided when help is requested for `chaos`.
    var description: String { get }
}

class ATBuildTool : Tool {
    let tool = "atbuild"
    let name: String
    let description: String
    
    private init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    func run(args: [String]) {
        precondition(args.count > 0)
        
        // Assume the tool path is the same directory as the `chaos` tool.
        var path = args[0]
        path.removeRange(path.endIndex.advancedBy(-5)..<path.endIndex)
        let options = args.dropFirst().dropFirst().map { $0 }.reduce("") { "\($0) \($1)" }
        system("\(path)\(tool) \(name) \(options)")
    }
}

final class BuildTool : ATBuildTool {
    init() {
        super.init(name: "build", description: "Uses the the `atbuild` tool to build a project.")
    }
}

final class TestTool : ATBuildTool {
    init() {
        super.init(name: "test", description: "Uses the the `atbuild` tool to test a project.")
    }
}
