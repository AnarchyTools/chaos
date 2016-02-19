#!/bin/bash

# Copyright (c) 2016 Anarchy Tools Contributors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo -- Running Tests --

./bin/chaos build -my -args > /tmp/chaos_build.tmp

if ! grep "atbuild  build -my -args" /tmp/chaos_build.tmp; then
    echo "** FAILED ** Arguments were passed incorrectly."
    exit 1
else
    echo "PASSED"
fi

./bin/chaos test -my -args "lots of tests" > /tmp/chaos_test.tmp

if ! grep "atbuild  test -my -args lots of tests" /tmp/chaos_test.tmp; then
    echo "** FAILED ** Arguments were passed incorrectly."
    exit 1
else
    echo "PASSED"
fi

