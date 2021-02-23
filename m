Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6088B3227B6
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Feb 2021 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBWJYv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 04:24:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhBWJYt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 04:24:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34846AF23;
        Tue, 23 Feb 2021 09:24:08 +0000 (UTC)
Date:   Tue, 23 Feb 2021 10:24:06 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: Check for ima-buf template is not required for keys
 tests
Message-ID: <YDTJtl9C9HbRILQb@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210222023421.12576-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222023421.12576-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakmasi,

> ima-buf is the default IMA template used for all buffer measurements.
> Therefore, IMA policy rule for measuring keys need not specify
> an IMA template.
Good catch. But was it alway?
IMHO ima-buf as default was added in dea87d0889dd ("ima: select ima-buf template for buffer measurement") in v5.11-rc1.
But test1() tests 450d0fd51564 ("IMA: Call workqueue functions to measure queued keys") from v5.6-rc1.
Is it safe to ignore it?
BTW template=ima-buf requirement was added in commit b0418c93f ("IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern")

Also, shouldn't we check that there is none of the other templates (e.g. template=ima-ng, ...)?

> Update keys tests to not check for ima template in the policy rule.

> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
> This patch is based
> in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
> in branch ima/selinux.v2.draft.

>  testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index c9eef4b68..a3a7afbf7 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
>  . ima_setup.sh

>  FUNC_KEYCHECK='func=KEY_CHECK'
> -TEMPLATE_BUF='template=ima-buf'
> -REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
> +REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
nit: remove brackets:
REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"

There is
testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy file,
which should be a helper to load proper policy and needs to be updated as well:
-measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
+measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test

I was also thinking to move keyrings to REQUIRED_POLICY, e.g.:

KEYRINGS="keyrings=\.[a-z]+"
REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$KEYRINGS|$KEYRINGS.*$FUNC_KEYCHECK)"

Kind regards,
Petr

>  setup()
>  {
> @@ -33,7 +32,7 @@ check_keys_policy()
>  	local pattern="$1"

>  	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
> -		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
> +		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
>  		return 1
>  	fi
>  	return 0
