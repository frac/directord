#   Copyright Peznauts <kevin@cloudnull.com>. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"); you may
#   not use this file except in compliance with the License. You may obtain
#   a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#   License for the specific language governing permissions and limitations
#   under the License.

from multiprocessing.managers import MakeProxyType
from multiprocessing.managers import SyncManager

from directord import datastores


BaseDictProxy = MakeProxyType(
    "BaseDictProxy",
    (
        "__contains__",
        "__delitem__",
        "__getitem__",
        "__iter__",
        "__len__",
        "__setitem__",
        "clear",
        "copy",
        "empty",
        "get",
        "items",
        "keys",
        "pop",
        "popitem",
        "prune",
        "set",
        "setdefault",
        "update",
        "values",
    ),
)
BaseDictProxy._method_to_typeid_ = {
    "__iter__": "Iterator",
}
SyncManager.register("document", datastores.BaseDocument, BaseDictProxy)
