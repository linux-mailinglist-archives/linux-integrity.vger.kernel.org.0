Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5C22FC54
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgG0Wm2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 18:42:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39604 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0Wm2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:42:28 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF4B320B4908;
        Mon, 27 Jul 2020 15:42:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF4B320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595889747;
        bh=GI6YXWIoH8eVA94ey3P1oE/k0mlafeONb0MAgMXUNdk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RmNycXPgeMiXk3qwaBe4Mb6q37FcITawCjII5wl5nieQZt5tHnffIPGNWLcMuz8qO
         RO42LVBdZSJhbUF2Y59g68r+qtCAVrzynxWBG+nSFweXWx0/uysQLtIYCmXK9DZwXa
         nb1HiFOYY7r9L7B5G6Jtgl33U8w5gHj1Es7MXfzU=
Subject: Re: [PATCH v5 4/4] IMA: Add test for kexec cmdline measurement
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20200727223041.13110-1-pvorel@suse.cz>
 <20200727223041.13110-5-pvorel@suse.cz>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <1d18419e-413d-ecca-8d99-342aa4ad36f7@linux.microsoft.com>
Date:   Mon, 27 Jul 2020 18:42:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727223041.13110-5-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

This patch removes the test of the `--reuse-cmdline` option of kexec.
Go ahead and merge this, and then I'll post a patch that adds 
`--reuse-cmdline` back.

Thank you,
Lachlan

On 7/27/20 6:30 PM, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
>
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> [ pvorel: improved setup, various LTP API cleanup ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v4->v5:
>
> * added kexec.policy, please check it (for lazy people, I still plan
> some automatic mechanism for loading policies on CONFIG_IMA_WRITE_POLICY)
>
> * rewritten checks in setup:
>    - simplify secure boot bootctl verification
>    - try dmesg when bootctl not available
>    - check on failure also ^appraise.*func=KEXEC_KERNEL_CHECK policy
>    - improve logic for func=KEXEC_CMDLINE check (instead of requiring
> 	policy to be readable check only when readable, otherwise TWARN, ...)
>    - TWARN on failures in setup => TWARN is kind of error as it exit with
> 	non-zero, but these cases are failures thus don't hide them)
>
> * added cleanup commit (adding helpers)
>
> * various LTP API cleanup:
>    - added setup into separate function
>    - reuse test code with kexec_test()
>
> Kind regards,
> Petr
>
>   runtest/ima                                   |   1 +
>   .../kernel/security/integrity/ima/README.md   |   8 ++
>   .../integrity/ima/datafiles/kexec.policy      |   1 +
>   .../security/integrity/ima/tests/ima_kexec.sh | 111 ++++++++++++++++++
>   4 files changed, 121 insertions(+)
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/kexec.policy
>   create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
>
> diff --git a/runtest/ima b/runtest/ima
> index 309d47420..5f4b4a7a1 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -4,4 +4,5 @@ ima_policy ima_policy.sh
>   ima_tpm ima_tpm.sh
>   ima_violations ima_violations.sh
>   ima_keys ima_keys.sh
> +ima_kexec ima_kexec.sh
>   evm_overlay evm_overlay.sh
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 732cd912f..d4644ba39 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -36,6 +36,14 @@ CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
>   
>   Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
>   
> +### IMA kexec test
> +
> +`ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,
> +see example in `kexec.policy`.
> +
> +The test attempts to kexec the existing running kernel image.
> +To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
> +
>   ## EVM tests
>   
>   `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/kexec.policy b/testcases/kernel/security/integrity/ima/datafiles/kexec.policy
> new file mode 100644
> index 000000000..58d66369e
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/kexec.policy
> @@ -0,0 +1 @@
> +measure func=KEXEC_CMDLINE
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> new file mode 100755
> index 000000000..fbad9b425
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that kexec cmdline is measured correctly.
> +# Test attempts to kexec the existing running kernel image.
> +# To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
> +
> +TST_NEEDS_CMDS="grep kexec sed"
> +TST_CNT=2
> +TST_NEEDS_DEVICE=1
> +TST_SETUP="setup"
> +
> +. ima_setup.sh
> +
> +IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
> +
> +measure()
> +{
> +	local cmdline="$1"
> +	local algorithm digest expected_digest found
> +
> +	printf "$cmdline" > file1
> +	grep "kexec-cmdline" $ASCII_MEASUREMENTS > file2
> +
> +	while read found
> +	do
> +		algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
> +		digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
> +
> +		expected_digest=$(compute_digest $algorithm file1)
> +
> +		if [ "$digest" = "$expected_digest" ]; then
> +			return 0
> +		fi
> +	done < file2
> +
> +	return 1
> +}
> +
> +setup()
> +{
> +	local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> +	local res=TBROK
> +	local sb_enabled
> +
> +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> +		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
> +	fi
> +
> +	if check_policy_readable; then
> +		require_ima_policy_content '^measure.*func=KEXEC_CMDLINE'
> +		res=TFAIL
> +	fi
> +
> +	tst_res TINFO "loading kernel $IMA_KEXEC_IMAGE, cmdline: $cmdline"
> +	if kexec -s -l $IMA_KEXEC_IMAGE --reuse-cmdline 2>err; then
> +		ROD kexec -su
> +		if ! measure "$cmdline"; then
> +			if [ "$res" = TBROK ]; then
> +				tst_res TWARN "policy not readable, it might not contain required measure func=KEXEC_CMDLINE"
> +			fi
> +			tst_brk $res "unable to find a correct entry for --reuse-cmdline"
> +		fi
> +		return
> +	fi
> +
> +	if tst_cmd_available bootctl; then
> +		if bootctl status 2>/dev/null | grep -qi 'Secure Boot: enabled'; then
> +			sb_enabled=1
> +		fi
> +	elif tst_cmd_available dmesg; then
> +		if dmesg | grep -qi 'Secure boot enabled'; then
> +			sb_enabled=1
> +		fi
> +	fi
> +	if [ "$sb_enabled" ]; then
> +		tst_res TWARN "secure boot is enabled, kernel image may not be signed"
> +	fi
> +
> +	if check_ima_policy_content '^appraise.*func=KEXEC_KERNEL_CHECK'; then
> +		tst_res TWARN "'func=KEXEC_KERNEL_CHECK' appraise policy loaded, kernel image may not be signed"
> +	fi
> +
> +	tst_brk TBROK "kexec failed: $(cat err)"
> +}
> +
> +kexec_test()
> +{
> +	local cmdline="$1"
> +	local param="$2"
> +
> +	EXPECT_PASS_BRK kexec -s -l $IMA_KEXEC_IMAGE $param=$cmdline
> +	ROD kexec -su
> +	if ! measure "$cmdline"; then
> +		tst_brk TFAIL "unable to find a correct entry for $param=$cmdline"
> +	fi
> +	tst_res TPASS "kexec cmdline for $param=$cmdline was measured correctly"
> +}
> +
> +test()
> +{
> +	case $1 in
> +	1) kexec_test 'foo' '--append';;
> +	2) kexec_test 'bar' '--command-line';;
> +	esac
> +}
> +
> +tst_run

