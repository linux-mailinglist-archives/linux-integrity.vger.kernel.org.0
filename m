Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FAB78096
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jul 2019 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfG1RSM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Jul 2019 13:18:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfG1RSM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jul 2019 13:18:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6SHHI1x071790
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jul 2019 13:18:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u13ptu5xe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jul 2019 13:18:09 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 28 Jul 2019 18:18:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Jul 2019 18:18:04 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6SHI3qK35061904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Jul 2019 17:18:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DBD11C054;
        Sun, 28 Jul 2019 17:18:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C1711C052;
        Sun, 28 Jul 2019 17:18:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.133])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 28 Jul 2019 17:18:02 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Sun, 28 Jul 2019 13:17:47 -0400
In-Reply-To: <20190727044113.3865-1-vt@altlinux.org>
References: <20190727044113.3865-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072817-0008-0000-0000-00000301AF88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072817-0009-0000-0000-0000226F4B22
Message-Id: <1564334267.4245.420.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907280217
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Vitaly,

On Sat, 2019-07-27 at 07:41 +0300, Vitaly Chikunov wrote:
> Run `make check' to execute the tests.
> Currently only ima_hash, ima_sign, and ima_verify are tested.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changelog since v1:
> - Apply suggestions by Petr Vorel:
>  - Rename function names and variables to be more understandable.
>  - Rename tests/functions to tests/functions.sh.
>  - Define exit codes (77, 99, ...) as variables.
> - Added more comments and remove single letter variables (for Mimi Zohar).

Thanks.

> - Move getfattr check into function.
> - Move evmctl run and check into single function.
> - Add sign/verify tests for v1 signatures.
> - Minor improvements.
> - Since I still edit all 5 files I did not split the patch into multiple
>   commits to separate the files, otherwise editing will become too
>   complicated, as I ought to continuously rebase and edit different
>   commits. This was really non-productive suggestion

Ok, but the review will be broken up.  For now, the comments below are
limited to tests/Makefile.am, tests/functions.sh and
tests/ima_hash.test.  Some of the comments are intrusive, so I'm going
to hold off on reviewing the other tests.

> 
> Please test the tests.
> 
>  Makefile.am           |   2 +-
>  configure.ac          |   1 +
>  tests/Makefile.am     |  15 ++++
>  tests/functions.sh    | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/gen-keys.sh     |  90 +++++++++++++++++++++
>  tests/ima_hash.test   |  72 +++++++++++++++++
>  tests/ima_sign.test   | 211 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ima_verify.test |  93 +++++++++++++++++++++
>  8 files changed, 701 insertions(+), 1 deletion(-)
>  create mode 100644 tests/Makefile.am
>  create mode 100755 tests/functions.sh
>  create mode 100755 tests/gen-keys.sh
>  create mode 100755 tests/ima_hash.test
>  create mode 100755 tests/ima_sign.test
>  create mode 100755 tests/ima_verify.test
> 

> diff --git a/tests/Makefile.am b/tests/Makefile.am
> new file mode 100644
> index 0000000..145ea30
> --- /dev/null
> +++ b/tests/Makefile.am
> @@ -0,0 +1,15 @@
> +check_SCRIPTS =
> +TESTS = $(check_SCRIPTS)
> +
> +check_SCRIPTS += ima_hash.test ima_verify.test ima_sign.test
> +
> +# ima_verify depends on results of ima_hash
> +ima_verify.log: ima_sign.log
> +
> +clean-local:
> +	-rm -f *.txt *.out *.sig *.sig2
> +
> +distclean: distclean-keys
> +.PHONY: distclean-keys
> +distclean-keys:
> +	./gen-keys.sh clean

Autotools generates "test-driver".  Should it be added to git-ignore?


> diff --git a/tests/functions.sh b/tests/functions.sh
> new file mode 100755
> index 0000000..8794120
> --- /dev/null
> +++ b/tests/functions.sh
> @@ -0,0 +1,218 @@
> +#!/bin/bash
> +#
> +# ima-evm-utils tests bash functions
> +#
> +# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2, or (at your option)
> +# any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +

Should we be using SPDX, at least for new files?

> +# tests accounting
> +declare -i testspass=0 testsfail=0 testsskip=0/
> +
> +# exit codes (compatible with automake)
> +declare -r OK=0
> +declare -r FAIL=1
> +declare -r HARDFAIL=99 # hard failure no matter testing mode
> +declare -r SKIP=77     # skip test
> +
> +# you can set env VERBOSE=1 to see more output from evmctl
> +V=vvvv
> +V=${V:0:$VERBOSE}
> +V=${V:+-$V}
> +
> +# require particular executables to be present
> +_require() {
> +  ret=
> +  for i; do
> +    if ! type $i; then

"type" is a bashism.

> +      echo "$i is required for test"
> +      ret=1
> +    fi
> +  done
> +  [ $ret ] && exit $HARDFAIL
> +}
> +
> +# only allow color output on tty
> +if tty -s; then
> +     RED=$'\e[1;31m'
> +   GREEN=$'\e[1;32m'
> +  YELLOW=$'\e[1;33m'
> +    BLUE=$'\e[1;34m'
> +    CYAN=$'\e[1;36m'
> +    NORM=$'\e[m'
> +fi
> +
> +# Define FAILEARLY to exit testing on the first error.
> +exit_early() {
> +  if [ $FAILEARLY ]; then
> +    exit $1
> +  fi
> +}

I would group all of the environment variable function checking
together at the top of functions.sh.

> +
> +# Test mode determined by TNEG variable:
> +#   undefined: to positive testing
> +#   defined: negative testing
> +TNEG=
> +TMODE=+
> +
> +# Eval positive test and account its result
> +pos() {
> +  TNEG= TMODE=+
> +  [ "$VERBOSE" ] && echo "Start positive test $*"
> +  eval "$@"
> +  E=$?
> +  [ "$VERBOSE" ] && echo "Stop ($E) positive test $*"
> +  case $E in
> +    0)  testspass+=1 ;;
> +    77) testsskip+=1 ;;
> +    99) testsfail+=1; exit_early 1 ;;
> +    *)  testsfail+=1; exit_early 2 ;;
> +  esac
> +}
> +
> +# Eval negative test and accoutn its result
> +neg() {
> +  TNEG=1 TMODE=-
> +  [ "$VERBOSE" ] && echo "Start negative test $*"
> +  eval "$@"
> +  E=$?
> +  [ "$VERBOSE" ] && echo "Stop ($E) negative test $*"
> +  case $E in
> +    0)  testsfail+=1; exit_early 3 ;;
> +    77) testsskip+=1 ;;
> +    99) testsfail+=1; exit_early 4 ;;
> +    *)  testspass+=1 ;;
> +  esac
> +  TNEG= # Restore default
> +}
> 

The functions "pos" and "neg" are written very concisely, but they are
part of a common set of functions, which are the crux of the tests
scripts.  I'm really hesitant about having common functions that
execute any command passed to it, without any form of verification.

> +# return true if current test is positive
> +_is_positive_test() {
> +  [ -z "$TNEG" ]
> +}
> +
> +# return true if current test is negative
> +_is_negative_test() {
> +  [ "$TNEG" ]
> +}
> +
> +# Color following text to red if it's real error
> +red_if_pos() {
> +  _is_positive_test && echo $@ $RED
> +}
> +
> +norm_if_pos() {
> +  _is_positive_test && echo $@ $NORM
> +}
> +
> +DEL=
> +FOR=
> +# _evmctl_run should be run as `_evmctl_run ... || return'
> +_evmctl_run() {
> +  local cmd=$1 out=$1-$$.out
> +  # Additional parameters:
> +  # FOR: append to text as 'for $FOR'
> +  # DEL: additional files to rm if test failed
> +
> +  set -- evmctl $V ${ENGINE:+--engine $ENGINE} "$@"
> +  echo $YELLOW$TMODE $*$NORM
> +  eval "$@" >$out 2>&1

Here at least the command is limited to "evmctl".

Is there any benefit to using "set --", as opposed to defining a local
variable and executing it?  Is this simply a question of style?

> +  ret=$?
> +
> +  if [ $ret -ge 126 -a $ret -lt 255 ]; then
> +    echo $RED
> +    echo "evmctl $cmd failed hard with ($ret) ${FOR:+for $FOR}"
> +    sed 's/^/  /' $out
> +    echo $NORM
> +    rm $out $DEL
> +    FOR= DEL=
> +    return $SKIP
> +  elif [ $ret -gt 0 ]; then
> +    red_if_pos
> +    echo "evmctl $cmd failed" ${TNEG:+properly} "with ($ret) ${FOR:+for $FOR}"
> +    sed 's/^/  /' $out
> +    norm_if_pos
> +    rm $out $DEL
> +    FOR= DEL=
> +    return $FAIL
> +  elif _is_negative_test; then
> +    echo $RED
> +    echo "evmctl $cmd wrongly succeeded ${FOR:+for $FOR}"
> +    sed 's/^/  /' $out
> +    echo $NORM
> +  else
> +    [ "$VERBOSE" ] && sed 's/^/  /' $out
> +  fi
> +  rm $out
> +  FOR= DEL=
> +  return $OK
> +}
> +
> +_extract_ima_xattr() {
> +  local file=$1 out=$2 pref=$3
> +
> +  getfattr -n user.ima -e hex $file \
> +    | grep ^user.ima= \
> +    | sed s/^user.ima=$pref// \
> +    | xxd -r -p > $out
> +}
> +
> +_test_ima_xattr() {
> +  local file=$1 pref=$2
> +
> +  if ! getfattr -n user.ima -e hex $file | egrep -qx "user.ima=$pref"; then
> +    red_if_pos
> +    echo "Did not find expected hash${FOR:+ for $FOR}:"
> +    echo "    user.ima=$pref"
> +    echo ""
> +    echo "Actual output below:"
> +    getfattr -n user.ima -e hex $file | sed 's/^/    /'
> +    norm_if_pos
> +    rm $file
> +    FOR=
> +    return $FAIL
> +  fi
> +  FOR=
> +}
> +
> +_enable_gost_engine() {
> +  # Do not enable if it's already working (enabled by user)
> +  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
> +    && openssl engine gost >/dev/null 2>&1; then
> +    ENGINE=gost
> +  fi
> +}

With gost provided as an Openssl engine, is it possible to be able to
execute the first command without the gost engine enabled?  With
commit 782224f33cd7 ("ima-evm-utils: Rework openssl init"), I'm now
wondering if the "--engine e' option is still needed?

> +
> +# Show test stats and exit into automake test system
> +# with proper exit code (same as ours).
> +_report_exit() {
> +  if [ $testsfail -gt 0 ]; then
> +    echo "=============================="
> +    echo "Run with FAILEARLY=1 $0 $@"
> +    echo "To stop after first failure"
> +    echo "=============================="
> +  fi
> +  [ $testspass -gt 0 ] && echo -n $GREEN || echo -n $NORM
> +  echo -n "PASS: $testspass"
> +  [ $testsskip -gt 0 ] && echo -n $YELLOW || echo -n $NORM
> +  echo -n " SKIP: $testsskip"
> +  [ $testsfail -gt 0 ] && echo -n $RED || echo -n $NORM
> +  echo " FAIL: $testsfail"
> +  echo $NORM
> +  if [ $testsfail -gt 0 ]; then
> +    exit $FAIL
> +  elif [ $testspass -gt 0 ]; then
> +    exit $OK
> +  else
> +    exit $SKIP
> +  fi
> +}


> diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> new file mode 100755
> index 0000000..d4bfe19
> --- /dev/null
> +++ b/tests/ima_hash.test
> @@ -0,0 +1,72 @@
> +#!/bin/bash
> +#
> +# evmctl ima_hash tests
> +#
> +# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2, or (at your option)
> +# any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +
> +cd $(dirname $0)
> +PATH=../src:$PATH
> +source ./functions.sh
> +_require evmctl openssl
> +
> +# Check with constant
> +check_const() {

This function comment doesn't provide any more details than the
function name.  Please either rename this function (eg. check_xattr)
or expand the function comment.

> +  local alg=$1 pref=$2 hash=$3 file=$4
> +
> +  FOR=$alg DEL=$file 

Why not use ALG=$alg and FILE=$file as the global variable names?

> +    _evmctl_run ima_hash --hashalgo $alg --xattr-user $file || return
> +  FOR=$alg \
> +    _test_ima_xattr $file $pref$hash || return
> +  rm $file
> +  return $OK
> +}
> +
> +check() {
> +  local alg=$1 pref=$2 hash=$3
> +  local file=$alg-hash.txt
> +
> +  rm -f $file
> +  touch $file
> +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
> +  echo - $cmd
> +  hash=$(set -o pipefail; eval "$cmd" 2>/dev/null | cut -d' ' -f2)

Is there a reason for not executing $cmd directly?  Is it safer
calling "pipefail" and "eval"?  Is this a question of style?

> +  if [ $? -ne 0 ] && _is_positive_test; then
> +    echo $CYAN"$alg test is skipped"$NORM
> +    rm $file
> +    return $SKIP
> +  fi
> +  check_const $alg $pref "$hash" $file
> +}
> +
> +# check args: algo prefix hex-hash

The first keyword - test type - is missing in the comment above.  It
would be clearer if instead of "pos" or "neg", the key words included
the words "pass" and "fail", to indicate that the test is expected to
pass or fail.

Mimi

> +pos check md4    0x01
> +pos check md5    0x01
> +pos check sha1   0x01
> +neg check SHA1   0x01 # uppercase
> +neg check sha512-224 0x01 # valid for pkcs1
> +neg check sha512-256 0x01 # valid for pkcs1
> +neg check unknown 0x01 # nonexistent
> +pos check sha224 0x0407
> +pos check sha256 0x0404
> +pos check sha384 0x0405
> +pos check sha512 0x0406
> +pos check rmd160 0x0403
> +neg check sm3     0x01
> +neg check sm3-256 0x01
> +_enable_gost_engine
> +pos check md_gost12_256 0x0412
> +pos check streebog256   0x0412
> +pos check md_gost12_512 0x0413
> +pos check streebog512   0x0413
> +
> +_report_exit
> 

