Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6919985E
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgCaOZe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 10:25:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729891AbgCaOZe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 10:25:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VE2rPx012897
        for <linux-integrity@vger.kernel.org>; Tue, 31 Mar 2020 10:25:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022qy7x2g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Mar 2020 10:25:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 31 Mar 2020 15:25:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 15:25:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02VEPRqA55574586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 14:25:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58ACCAE051;
        Tue, 31 Mar 2020 14:25:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 916D3AE055;
        Tue, 31 Mar 2020 14:25:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.186.34])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 14:25:26 +0000 (GMT)
Subject: Re: [PATCH v8 1/2] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 31 Mar 2020 10:25:24 -0400
In-Reply-To: <20200327042515.22315-2-vt@altlinux.org>
References: <20200327042515.22315-1-vt@altlinux.org>
         <20200327042515.22315-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033114-0020-0000-0000-000003BEFA6D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033114-0021-0000-0000-000022179B6D
Message-Id: <1585664724.5188.572.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Fri, 2020-03-27 at 07:25 +0300, Vitaly Chikunov wrote:
> Run `make check' to execute the tests.
> This commit only adds ima_hash test.

> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thank you for breaking up the patch based on tests. "ima_hash.test"
may be executed by running "make check", but obviously also by
invoking it directly.

A couple of comments/questions inline below.

> diff --git a/tests/functions.sh b/tests/functions.sh
> new file mode 100755
> index 0000000..16c8d89
> --- /dev/null
> +++ b/tests/functions.sh
> @@ -0,0 +1,272 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
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
> +# Tests accounting
> +declare -i testspass=0 testsfail=0 testsskip=0
> +
> +# Exit codes (compatible with automake)
> +declare -r OK=0
> +declare -r FAIL=1
> +declare -r HARDFAIL=99 # hard failure no matter testing mode
> +declare -r SKIP=77
> +
> +# You can set env VERBOSE=1 to see more output from evmctl
> +V=vvvv
> +V=${V:0:$VERBOSE}
> +V=${V:+-$V}
> +
> +# Exit if env FAILEARLY is defined.
> +# Used in expect_{pass,fail}.
> +exit_early() {
> +  if [ $FAILEARLY ]; then

Throughout variables are not double quoted, though the tests
themselves turn off globbing (set -f).  shellcheck doesn't detect that
globbing has been turned off.  It complains about each variable usage
that is not double quoted.

> +    exit $1
> +  fi
> +}
> +
> +# Require particular executables to be present
> +_require() {
> +  ret=
> +  for i; do
> +    if ! type $i; then
> +      echo "$i is required for test"
> +      ret=1
> +    fi
> +  done
> +  [ $ret ] && exit $HARDFAIL
> +}
> +
> +# Only allow color output on tty
> +if [ -t 1 ]; then
> +     RED=$'\e[1;31m'
> +   GREEN=$'\e[1;32m'
> +  YELLOW=$'\e[1;33m'
> +    BLUE=$'\e[1;34m'
> +    CYAN=$'\e[1;36m'
> +    NORM=$'\e[m'
> +fi
> +
> +# Test mode determined by TFAIL variable:
> +#   undefined: to success testing
> +#   defined: failure testing
> +TFAIL=
> +TMODE=+ # mode character to prepend running command in log
> +declare -i TNESTED=0 # just for sanity checking
> +
> +# Run positive test (one that should pass) and account its result
> +expect_pass() {
> +  local ret
> +
> +  if [ $TNESTED -gt 0 ]; then
> +    echo $RED"expect_pass should not be run nested"$NORM
> +    testsfail+=1
> +    exit $HARDFAIL
> +  fi
> +  TFAIL=
> +  TMODE=+
> +  TNESTED+=1
> +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START positive test: $@"

Unless VERBOSE is set as an environment variable, it isn't defined.
 This isn't an issue when using [[ ... ]], but should it be
initialized: VERBOSE="${VERBOSE:-0}"?

> +  "$@"
> +  ret=$?
> +  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) positive test: $@"
> +  TNESTED+=-1
> +  case $ret in
> +    0)  testspass+=1 ;;
> +    77) testsskip+=1 ;;
> +    99) testsfail+=1; exit_early 1 ;;
> +    *)  testsfail+=1; exit_early 2 ;;
> +  esac
> +  return $ret
> +}
> +
> +# Eval negative test (one that should fail) and account its result
> +expect_fail() {
> +  local ret
> +
> +  if [ $TNESTED -gt 0 ]; then
> +    echo $RED"expect_fail should not be run nested"$NORM
> +    testsfail+=1
> +    exit $HARDFAIL
> +  fi
> +
> +  TFAIL=yes
> +  TMODE=-
> +  TNESTED+=1
> +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START negative test: $@"
> +  "$@"
> +  ret=$?
> +  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) negative test: $@"
> +  TNESTED+=-1
> +  case $ret in
> +    0)  testsfail+=1; exit_early 3 ;;
> +    77) testsskip+=1 ;;
> +    99) testsfail+=1; exit_early 4 ;;
> +    *)  testspass+=1 ;;
> +  esac
> +  # Restore defaults (as in positive tests)
> +  # for tests to run without wrappers
> +  TFAIL=
> +  TMODE=+
> +  return $ret
> +}
> +
> +# return true if current test is positive
> +_is_expect_pass() {
> +  [ ! $TFAIL ]
> +}
> +
> +# return true if current test is negative
> +_is_expect_fail() {
> +  [ $TFAIL ]
> +}
> +
> +# Show blank line and color following text to red
> +# if it's real error (ie we are in expect_pass mode).
> +red_if_failure() {
> +  if _is_expect_pass; then
> +    echo $@ $RED
> +    COLOR_RESTORE=1
> +  fi
> +}
> +
> +# For hard errors
> +red_always() {
> +  echo $@ $RED

A few functions - "red_always", "red_if_failure", "color_restore" -
 use "$@", but none of the function callers pass any parameters.  Is
there a reason for the "$@" or just something left over from
debugging?

> +  COLOR_RESTORE=1
> +}
> +
> +color_restore() {
> +  [ $COLOR_RESTORE ] && echo $@ $NORM
> +  COLOR_RESTORE=
> +}
> +
> +ADD_DEL=
> +ADD_TEXT_FOR=
> +# _evmctl_run should be run as `_evmctl_run ... || return'
> +_evmctl_run() {
> +  local op=$1 out=$1-$$.out
> +  local text_for=${FOR:+for $ADD_TEXT_FOR}
> +  # Additional parameters:
> +  # ADD_DEL: additional files to rm on failure
> +  # ADD_TEXT_FOR: append to text as 'for $ADD_TEXT_FOR'
> +
> +  cmd="evmctl $V $EVMCTL_ENGINE $@"
> +  echo $YELLOW$TMODE $cmd$NORM
> +  $cmd >$out 2>&1
> +  ret=$?
> +
> +  # Shell special and signal exit codes (except 255)
> +  if [ $ret -ge 126 -a $ret -lt 255 ]; then
> +    red_always
> +    echo "evmctl $op failed hard with ($ret) $text_for"
> +    sed 's/^/  /' $out
> +    color_restore
> +    rm $out $ADD_DEL
> +    ADD_DEL=
> +    ADD_TEXT_FOR=
> +    return $HARDFAIL
> +  elif [ $ret -gt 0 ]; then
> +    red_if_failure
> +    echo "evmctl $op failed" ${TFAIL:+properly} "with ($ret) $text_for"
> +    # Show evmctl output only in verbose mode or if real failure.
> +    if _is_expect_pass || [ "$VERBOSE" ]; then
> +      sed 's/^/  /' $out
> +    fi
> +    color_restore
> +    rm $out $ADD_DEL
> +    ADD_DEL=
> +    ADD_TEXT_FOR=
> +    return $FAIL
> +  elif _is_expect_fail; then
> +    red_always
> +    echo "evmctl $op wrongly succeeded $text_for"
> +    sed 's/^/  /' $out
> +    color_restore
> +  else
> +    [ "$VERBOSE" ] && sed 's/^/  /' $out
> +  fi
> +  rm $out
> +  ADD_DEL=
> +  ADD_TEXT_FOR=
> +  return $OK
> +}
> +
> +# Extract xattr $attr from $file into $out file skipping $pref'ix
> +_extract_xattr() {
> +  local file=$1 attr=$2 out=$3 pref=$4
> +
> +  getfattr -n $attr -e hex $file \
> +    | grep "^$attr=" \
> +    | sed "s/^$attr=$pref//" \
> +    | xxd -r -p > $out
> +}
> +
> +# Test if xattr $attr in $file matches $pref'ix
> +# Show error and fail otherwise.
> +_test_xattr() {
> +  local file=$1 attr=$2 pref=$3
> +  local text_for=${ADD_TEXT_FOR:+ for $ADD_TEXT_FOR}
> +
> +  if ! getfattr -n $attr -e hex $file | egrep -qx "$attr=$pref"; then
> +    red_if_failure
> +    echo "Did not find expected hash$text_for:"
> +    echo "    $attr=$pref"
> +    echo ""
> +    echo "Actual output below:"
> +    getfattr -n $attr -e hex $file | sed 's/^/    /'
> +    color_restore
> +    rm $file
> +    ADD_TEXT_FOR=
> +    return $FAIL
> +  fi
> +  ADD_TEXT_FOR=
> +}
> +
> +# Try to enable gost-engine if needed.
> +_enable_gost_engine() {
> +  # Do not enable if it's already working (enabled by user)
> +  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \

Interesting /dev/null usage here as a filename.

> +    && openssl engine gost >/dev/null 2>&1; then
> +    EVMCTL_ENGINE="--engine gost"
> +    OPENSSL_ENGINE="-engine gost"
> +  fi
> +}
> +
> +# Show test stats and exit into automake test system
> +# with proper exit code (same as ours).
> +_report_exit() {
> +  if [ $testsfail -gt 0 ]; then
> +    echo "================================="
> +    echo " Run with FAILEARLY=1 $0 $@"
> +    echo " To stop after first failure"
> +    echo "================================="
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
> +
> diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> new file mode 100755
> index 0000000..30aec19
> --- /dev/null
> +++ b/tests/ima_hash.test
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
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
> +_require evmctl openssl getfattr
> +
> +trap _report_exit EXIT
> +set -f # disable globbing
> +
> +check() {
> +  local alg=$1 pref=$2 chash=$3 hash
> +  local file=$alg-hash.txt
> +
> +  rm -f $file
> +  touch $file
> +  # Generate hash with openssl, if it's failed skip test,
> +  # unless it's negative test, then pass to evmctl
> +  cmd="openssl dgst $OPENSSL_ENGINE -$alg $file"
> +  echo - $cmd
> +  hash=$(set -o pipefail; $cmd 2>/dev/null | cut -d' ' -f2)
> +  if [ $? -ne 0 ] && _is_expect_pass; then
> +    echo $CYAN"$alg test is skipped"$NORM
> +    rm $file
> +    return $SKIP
> +  fi
> +  if [ "$chash" ] && [ "$chash" != "$hash" ]; then
> +    red_always

Only when "ima_hash.test" is invoked directly, the output is colored
red.  Really confusing.

> +    echo "Invalid hash for $alg from openssl"
> +    echo "Expected: $chash"
> +    echo "Returned: $hash"
> +    color_restore
> +    rm $file
> +    return $HARDFAIL
> +  fi
> +
> +  ADD_TEXT_FOR=$alg ADD_DEL=$file \
> +    _evmctl_run ima_hash --hashalgo $alg --xattr-user $file || return
> +  ADD_TEXT_FOR=$alg \
> +    _test_xattr $file user.ima $pref$hash || return
> +  rm $file
> +  return $OK
> +}
> +
> +# check args: algo hdr-prefix canonic-hash
> +expect_pass check  md4        0x01 31d6cfe0d16ae931b73c59d7e0c089c0
> +expect_pass check  md5        0x01 d41d8cd98f00b204e9800998ecf8427e
> +expect_pass check  sha1       0x01 da39a3ee5e6b4b0d3255bfef95601890afd80709
> +expect_fail check  SHA1       0x01 # uppercase
> +expect_fail check  sha512-224 0x01 # valid for pkcs1
> +expect_fail check  sha512-256 0x01 # valid for pkcs1
> +expect_fail check  unknown    0x01 # nonexistent
> +expect_pass check  sha224     0x0407 d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f
> +expect_pass check  sha256     0x0404 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
> +expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b
> +expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
> +expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
> +expect_fail check  sm3        0x01
> +expect_fail check  sm3-256    0x01
> +_enable_gost_engine
> +expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> +expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> +expect_pass check  md_gost12_512 0x0413 8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a
> +expect_pass check  streebog512   0x0413 8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a
> +

Nice!  The code is very concisely written.

Reviewing this patch would be a lot easier, if it was broken up into
smaller pieces.  For example, and this is only an example, the initial
patch could define the base ima_hash.test, a subsequent patch could
add coloring for the base ima_hash.test, another patch could introduce
"make check" and add its coloring.  There's all sorts of ways to break
up this patch to simplify review.

Mimi

