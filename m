Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6532EFD5
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhCEQQC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 11:16:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhCEQPc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 11:15:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A08AACBF;
        Fri,  5 Mar 2021 16:15:31 +0000 (UTC)
Date:   Fri, 5 Mar 2021 17:15:29 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: Allow only ima-buf template for key measurement
Message-ID: <YEJZIQqa1arYKwK+@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210303203254.12856-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303203254.12856-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

for my record: previous version was
https://patchwork.ozlabs.org/project/ltp/patch/20210222023421.12576-1-nramas@linux.microsoft.com/

> ima-buf is the default IMA template used for all buffer measurements.
> Therefore, IMA policy rule for measuring keys need not specify
> an IMA template.  But if a template is specified for key measurement
> rule then it must be only ima-buf.

> Update keys tests to not require a template to be specified for
> key measurement rule, but if a template is specified verify it is
> only ima-buf.
Good, but there are some issues, see below.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
...
> +	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
> +
>  	check_keys_policy "$pattern" > $tmp_file || return
>  	keycheck_lines=$(cat $tmp_file)
>  	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
> @@ -101,6 +103,8 @@ test2()

>  	tst_res TINFO "verify measurement of certificate imported into a keyring"

> +	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
> +
>  	check_keys_policy "$pattern" >/dev/null || return

>  	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 59a7ffeac..01ebec2b6 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -107,6 +107,22 @@ check_ima_policy_cmdline()
>  	return 1
>  }

> +check_policy_template()
> +{
> +	local template="$1"
> +	local func="$2"
> +	grep -E "template=" $TST_TMPDIR/policy.txt | while read line
> +	do
> +		ima_template=$(echo $line | grep $template)
> +		if [ -z "$ima_template" ]; then
instead of putting it into variable, why not just using grep?
if ! echo $line | grep -q $template; then

> +			tst_res TCONF "Only $template can be specified for $func"
> +			return 1
Have you test it? This will not work. There is ${PIPESTATUS[@]} bash/zsh
array, thus 1 is in $pipestatus[1]. But that's bashism, which will not work on
dash busybox ash, ...

You need to do:
while read line; do
	if ! echo $line | grep -q $template; then
		tst_res TCONF "only $template can be specified for $func"
		return 1
	fi
done < $TST_TMPDIR/policy.txt
return 0

*BUT* on vanilla 5.11 with and SLES 5.3.18-47-default with many backports when
testing with this wrong policy:
measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-ng


ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
ima_keys 1 TCONF: Only template=ima-buf can be specified for func=KEY_CHECK
ima_keys 1 TINFO: keyrings: '\.ima|\.evm|\.builtin_trusted_keys|\.blacklist|key_import_test'
ima_keys 1 TINFO: templates: 'ima-ng'
ima_keys 1 TPASS: specified keyrings were measured correctly
           ^
first test passes. Why? Is that correct?
I haven't tested any other templates.

ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
ima_keys 2 TCONF: Only template=ima-buf can be specified for func=KEY_CHECK
errno: No such file or directory (2)
ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring

> +		fi
> +	done

Besides that, I'd like to put check_policy_template() into ima_keys.sh because
1) is so far needed only in ima_keys.sh 2) it expects $TST_TMPDIR/policy.txt.
Functions in ima_setup.sh which are used for more tests should not expect any
function was called before.

dm-crypt measurement tests from Tushar Sugandhi will require these, I'll put it
into ima_setup.sh during rebase and probably add policy file as a function parameter.

Kind regards,
Petr
