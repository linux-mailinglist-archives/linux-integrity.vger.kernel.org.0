Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522D51F6B0A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFKPaQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 11:30:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgFKPaP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 11:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71E46AD60;
        Thu, 11 Jun 2020 15:30:17 +0000 (UTC)
Date:   Thu, 11 Jun 2020 17:30:11 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     ltp@lists.linux.it, zohar@linux.ibm.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] IMA: Add a test to verify measurment of keys
Message-ID: <20200611153011.GA25057@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

thank you for updating LTP!

I have few comments below.
Mostly just tiny details, which I could fix before merge.

> Add a testcase that verifies that the IMA subsystem has correctly
> measured keys added to keyrings specified in the IMA policy file.

> Additionally, add support for handling a new IMA template descriptor,
> namely ima-buf[1], in the IMA measurement tests.
Great, thanks!

> [1]: https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use

...
> +++ b/runtest/ima
> @@ -4,3 +4,4 @@ ima_policy ima_policy.sh
>  ima_tpm ima_tpm.sh
>  ima_violations ima_violations.sh
>  evm_overlay evm_overlay.sh
> +ima_keys ima_keys.sh
Please move evm_overlay after ima_keys.
EVM tests require specific configuration, that's why I put it on the end.
Or before ima_policy.sh (see comment below).

> diff --git a/testcases/kernel/security/integrity/ima/tests/compute_digest.sh b/testcases/kernel/security/integrity/ima/tests/compute_digest.sh
> new file mode 100644
Please use 755 (shell libraries which are sources can be 644, but this is
meant to be executed).

> index 000000000..85f6bf3da
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/compute_digest.sh
Could you please move this to ima_setup.sh? That's the file we keep helper
functions. (BTW in LTP shell based tests it's usually foo_lib.sh, I named this
ima_setup.sh instead of ima_lib.sh, because it was first meant as tmpfs related
setup and still it does, although I later I added other helper functions there.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -0,0 +1,72 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that keys are measured correctly based on policy.
> +
> +TST_NEEDS_CMDS="awk cut"
You missed xxd, which is IMHO less common than awk and cut, therefore it should
be specified.

> +TST_SETUP="setup"
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +
> +. ima_setup.sh
> +. compute_digest.sh
> +
> +setup()
> +{
> +    TEST_FILE="$PWD/test.txt"
This suggest that file tested in test2 (second commit) requires to be the
same. Is it true? If not, I'd set just local variable in each test function.
> +}
> +
> +# Based on https://lkml.org/lkml/2019/12/13/564.
Maybe also mention the commit?
450d0fd51564 ("IMA: Call workqueue functions to measure queued keys")

> +test1()
> +{
> +	local keyrings keycheck_line templates
> +
> +	tst_res TINFO "verifying key measurement for keyrings and \
> +templates specified in ima policy file"
Could you please keep string on single line? We prefer it over to 80 chars per
line rule (although I admit that super long string in check_policy_writable is awfull).
> +
> +	IMA_POLICY="$IMA_DIR/policy"
Could you please move IMA_POLICY to ima_setup.sh and remove the same definition
from ima_policy.sh?
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
BTW to read IMA policy requires CONFIG_IMA_READ_POLICY=y. Maybe there could be
just some hint, because 

grep: /sys/kernel/security/ima/policy: Permission denied
ima_keys 1 TCONF: ima policy does not specify "func=KEY_CHECK"

Could we have here something like
cat $IMA_POLICY > /dev/null || tst_res TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"


> +
> +	keycheck_line=$(grep "func=KEY_CHECK" $IMA_POLICY)
> +	if [ -z "$keycheck_line" ]; then
> +		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
> +	fi
Could we prepare policy example in
testcases/kernel/security/integrity/ima/datafiles/keycheck.policy?

I'm trying IMA tests to prepare themselves, otherwise most of the tests would be
TCONF. And the idea is that test has everything prepared when run as part of
runtest file or also on it's own. But here is getting complicated. Unless there is
CONFIG_IMA_WRITE_POLICY=y, we cannot load it in the test. And if we require
loading it before, then ima_policy.sh TCONF.

Not sure if we should have 2 versions of correct IMA policy.
in test2 in ima_policy.sh try to load first keycheck.policy and if it fails then
the old measure.policy. That way we would also avoid testing kernel version
(this functionality can be backported). We could also print support for new
feature. And try load keycheck.policy in ima_keys.sh, in case it's run on it's
own (not part of other tests in runtest file).

I understand if you don't want to play with this, I can add this after merging
your test. But providing keycheck.policy would help.

> +
> +	if echo "$keycheck_line" | grep -q "*keyrings*"; then
> +		tst_brk TCONF "ima policy does not specify a keyrings to check"
> +	fi
> +
> +	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
> +		sed "s/\./\\\./g" | cut -d'=' -f2)
> +	if [ -z "$keyrings" ]; then
> +		tst_brk TCONF "ima policy has a keyring key-value specifier, \
> +but no specified keyrings"
+ also here put on single line.
> +	fi
> +
> +	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
> +		cut -d'=' -f2)
> +
> +	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line
> +	do
> +		local digest expected_digest algorithm
> +
> +		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
> +		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
> +
> +		echo "$line" | cut -d' ' -f6 | xxd -r -p > $TEST_FILE
> +
> +		expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
> +			tst_brk TCONF "cannot compute digest for $algorithm"
> +
> +		if [ "$digest" != "$expected_digest" ]; then
> +			tst_res TFAIL "incorrect digest was found for the \
> +$(echo "$line" | cut -d' ' -f5) keyring"
Here as well. Maybe add $keyring and use it as variable.
> +		fi
> +	done
> +
> +	tst_res TPASS "specified keyrings were measured correctly"
> +}
...

Kind regards,
Petr
