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

extension Tool {
    func run(args: [String] = []) {
        let argstr = args.reduce("") { "\($0) \($1)" }
        system("\(tool) \(argstr)")
    }
}

final class BuildTool : Tool {
    let name = "build"
    let tool = "atbuild"
    let description = "Uses the the `atbuild` tool to build a project."

    func run(args: [String] = []) {
        let argstr = args.reduce("") { "\($0) \($1)" }
        system("\(tool) \(name) \(argstr)")
    }
}

final class TestTool : Tool {
    let name = "test"
    let tool = "atbuild"
    let description = "Uses the the `atbuild` tool to test a project."

    func run(args: [String] = []) {
        let argstr = args.reduce("") { "\($0) \($1)" }
        system("\(tool) \(name) \(argstr)")
    }
}
