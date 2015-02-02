#!/bin/bash

#Copyright (c) 2013 Intel Corporation.
#
#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:
#
#* Redistributions of works must retain the original copyright notice, this list
# of conditions and the following disclaimer.
#* Redistributions in binary form must reproduce the original copyright notice,
#  this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#* Neither the name of Intel Corporation nor the names of its contributors
#  may be used to endorse or promote products derived from this work without
#  specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION BE LIABLE FOR ANY DIRECT,
#INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
#OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#Authors:
#       IVAN CHEN <yufeix.chen@intel.com>
#       Yin, Haichao <haichaox.yin@intel.com>

local_path=$(cd $(dirname $0);pwd)
source $local_path/Common
xpk_path=$local_path/../testapp
originalVersionOneApp="update_original_versionOne_tests"
higherVersionApp="update_versionOne_Higher_tests"

# func_check_xwalkservice

# no matter exist the testapp or not, uninstall it first
# update_original_versionOne_tests app pkgid is same as update_versionOne_Higher_tests app
# but must know is that when install update_versionOne_Higher_tests app, the app name is update_versionOne_Higher_tests rather than update_original_versionOne_tests
getPkgid $originalVersionOneApp
get_uninstall=`pkgcmd -u -n  $pkg_id -q`

getPkgid $higherVersionApp
get_uninstall=`pkgcmd -u -n  $pkg_id -q`

# install original xpk
install_origin_xpk  $xpk_path/$originalVersionOneApp.xpk $originalVersionOneApp

# update valid xpk and check DB
update_valid_xpk $xpk_path/$higherVersionApp.xpk 3 $higherVersionApp $app_id

exit 0
