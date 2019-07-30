Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1977A319
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfG3I1s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 04:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbfG3I1s (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 04:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FB8EAD26;
        Tue, 30 Jul 2019 08:27:46 +0000 (UTC)
Date:   Tue, 30 Jul 2019 10:27:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190730082742.GA10234@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190729042035.7833-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190729042035.7833-1-vt@altlinux.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

only v1 runs without failure, when running v2 and v3 sign_verify fails:
(testing on on bash 5.0.7 on openSUSE and 5.0.3 on Debian)

evmctl is ../src/evmctl
openssl is /usr/bin/openssl
xxd is /usr/bin/xxd
getfattr is /usr/bin/getfattr
[1;33m- evmctl ima_sign --rsa --sigfile --hashalgo md5 --key test-rsa1024.key --xattr-user md5.txt~[m
evmctl ima_sign failed properly with (255) 
- openssl dgst -sha1 sha1.txt
- openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
[1;33m+ evmctl ima_sign --rsa --sigfile --hashalgo sha1 --key test-rsa1024.key --xattr-user sha1.txt[m
[1;33m+ evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa sha1.txt[m
[1;31m
evmctl ima_verify failed with (1) 
  Failed to d2i_X509_fp key file: test-rsa1024.pub
  openssl: error:0D0680A8:asn1 encoding routines:asn1_check_tlen:wrong tag
  openssl: error:0D07803A:asn1 encoding routines:asn1_item_embed_d2i:nested asn1 error
[m
[1;33m- evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa /dev/null,sha1.txt[m
evmctl ima_verify failed properly with (255) 
- openssl dgst -sha1 sha1.txt
- openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
[1;33m+ evmctl sign --rsa --hashalgo sha1 --key test-rsa1024.key --xattr-user sha1.txt[m
[1;31m
evmctl sign failed with (255) 
  Failed to read UUID. Root access might require.
  errno: No data available (61)
[m
- openssl dgst -sha256 sha256.txt
- openssl dgst -sha256 -sign test-rsa1024.key -hex sha256.txt
[1;33m+ evmctl ima_sign --rsa --sigfile --hashalgo sha256 --key test-rsa1024.key --xattr-user sha256.txt[m
[1;33m+ evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa sha256.txt[m
[1;31m
evmctl ima_verify failed with (1) 
  Failed to d2i_X509_fp key file: test-rsa1024.pub
  openssl: error:0D0680A8:asn1 encoding routines:asn1_check_tlen:wrong tag
  openssl: error:0D07803A:asn1 encoding routines:asn1_item_embed_d2i:nested asn1 error
[m
[1;33m- evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa /dev/null,sha256.txt[m
evmctl ima_verify failed properly with (255) 
- openssl dgst -sha256 sha256.txt
- openssl dgst -sha256 -sign test-rsa1024.key -hex sha256.txt
[1;33m+ evmctl sign --rsa --hashalgo sha256 --key test-rsa1024.key --xattr-user sha256.txt[m
[1;31m
evmctl sign failed with (255) 
  Failed to read UUID. Root access might require.
  errno: No data available (61)

...
> --- /dev/null
> +++ b/tests/functions.sh
> @@ -0,0 +1,269 @@
> +#!/bin/bash
I'd still vote for /bin/sh and posix syntax. evmctl can be cross compiled for
embedded device. Than, it'd have to be run on the target, which can be tiny
linux customised distro with busybox shell. That's why POSIX shell syntax
instead of relying on bash.

Debian also has nice script that can be used to check for non-portable shell code:
https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl

> +# SPDX-License-Identifier: GPL-2.0
This is the correct SPDX for GPL v2+:
# SPDX-License-Identifier: GPL-2.0-or-later

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
SPDX license identifier replaces GPL verbose text. These 2 paragraphs can be
deleted.

> +
> +# Tests accounting
> +declare -i testspass=0 testsfail=0 testsskip=0
> +
> +# Exit codes (compatible with automake)
> +declare -r OK=0
Can you please omit 'declare -r'? It's nice to have read only variables, but
it's a bashism (not working in busybox nor in dash).

> +declare -r FAIL=1
> +declare -r HARDFAIL=99 # hard failure no matter testing mode
> +declare -r SKIP=77     # skip test
Also comment "skip test" might be omitted (it's obvious).

> +
> +# You can set env VERBOSE=1 to see more output from evmctl
> +V=vvvv
> +V=${V:0:$VERBOSE}
> +V=${V:+-$V}
Maybe it's just me but it's not really readable.

> +
> +# Exit if env FAILEARLY is defined.
> +# Used in expect_{pass,fail}.
> +exit_early() {
> +  if [ $FAILEARLY ]; then
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
> +if tty -s; then
BTW I'd prefer the output to file to be plain text (I have vim plugin to show
colors, but not everybody has). Now it does not (forcing by red_always ?).
[ -t 1 ] will do the check.
Or, you could even have variable to allow user to chose, example from LTP [1]

tst_color_enabled()
{
	[ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0" ] && return 0
	[ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ] && return 1
	[ -t 1 ] || return 0
	return 1
}

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
Bashism, use [ ]
> +  "$@"
> +  ret=$?
> +  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) positive test: $@"
> +  TNESTED+=-1
> +  case $ret in
> +    0)  testspass+=1 ;;
Bashism, use testspass=$((testspass+1))
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
IMHO it's safer to quote whole string (here ok, but on some circumstances shell
handles quoted and unquoted string differently):
echo "$REDexpect_fail should not be run nested $NORM"

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
> +  TFAIL= # Restore defaults for tests run without wrappers
> +  TMODE=+
I guess you wanted TMODE=
> +  return $ret
> +}
...

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
> +  cmd="evmctl $V ${ENGINE:+--engine $ENGINE} $@"
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
I'd reset terminal inside coloring functions (color_restore() and $NORM).
red()
{
	printf '\033[1;31m'
	echo "$@"
	printf '\033[0m'
}

red "evmctl $op failed hard with ($ret) $text_for"

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
...

> diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> new file mode 100755
> index 0000000..718b868
> --- /dev/null
> +++ b/tests/ima_hash.test
> @@ -0,0 +1,71 @@
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
Bashism, use . 

Maybe

. $(dirname $0)/functions.sh

and in functions.sh
export PATH="../src:$PATH"

(that reduces duplicity, but then you'd need to source it also in tests/gen-keys.sh)

> +_require evmctl openssl getfattr
> +
> +trap _report_exit EXIT
> +set -f # disable globbing
> +
> +check() {
> +  local alg=$1 pref=$2 hash=$3
> +  local file=$alg-hash.txt
> +
> +  rm -f $file
> +  touch $file
> +  # Generate hash with openssl, if it's failed skip test,
> +  # unless it's negative test, then pass to evmctl
> +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
Why not set ENGINE once at the beginning of the script (or in functions.sh if
needed on more places)?

...
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
...

> +# Convert test $type into evmctl op prefix
> +op() {
> +  if [ $1 = ima ]; then
> +    echo ima_
> +  fi
Maybe just
[ "$1" = "ima" ] && echo "ima_"

> +}
> +
> +# Convert test $type into xattr name
> +xattr() {
> +  if [ $1 = ima ]; then
> +    echo user.ima
> +  else
> +    echo user.evm
> +  fi
Maybe just:
[ "$1" = "ima" ] && echo "user.ima" || echo "user.evm"

...
> +# Run and test {ima_,}sign operation
> +check_sign() {
> +  # Arguments are passed via global vars:
> +  # TYPE (ima or evm),
> +  # KEY,
> +  # ALG (hash algo),
> +  # PREF (signature header prefix),
> +  # OPTS (additional options for evmctl),
> +  # FILE (working file to sign).
> +  local "$@"
Not sure if this works everywhere as you expect.
In most of the cases you set these global variables anyway, so cleaner would be
to use getopts (instead overwriting global variables).
> +  local KEY=${KEY%.*}.key
> +  local FILE=${FILE:-$ALG.txt}
I'd use lower case for local variables.
> +
> +  # Normalize key filename
> +  KEY=test-${KEY#test-}
> +
> +  # Append suffix to files for negative tests, because we may
> +  # leave only good files for verify tests.
> +  _is_expect_fail && FILE+='~'
> +
> +  rm -f $FILE
> +  if ! touch $FILE; then
> +    red_always
> +    echo "Can't create test file: $FILE"
> +    color_restore
> +    return $HARDFAIL
> +  fi
> +
> +  if _is_expect_pass; then
> +    if [ ! -e $KEY ]; then
> +      red_always
> +      echo "Key $KEY does not exist."
> +      color_restore
> +      return $HARDFAIL
> +    fi
> +
> +    # Can openssl work with this digest?
> +    cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$ALG $FILE"
> +    echo - $cmd
> +    if ! $cmd >/dev/null; then
> +      echo $CYAN"$ALG ($KEY) test is skipped (openssl is unable to digest)"$NORM
> +      return $SKIP
> +    fi
> +
> +    # Can openssl sign with this digest and key?
> +    cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$ALG -sign $KEY -hex $FILE"
> +    echo - $cmd
> +    if ! $cmd >/dev/null; then
> +      echo $CYAN"$ALG ($KEY) test is skipped (openssl is unable to sign)"$NORM
> +      return $SKIP
> +    fi
> +  fi
> +
> +  # Fix keyid in the prefix.
> +  if [[ $PREF =~ K ]]; then
Bashism, could you please use grep instead of [[ =~ ]]?
...


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_ansi_color.sh
