Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0423EEDD
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGOP3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 10:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:58244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgHGOP2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 10:15:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9D2DAC41;
        Fri,  7 Aug 2020 14:15:45 +0000 (UTC)
Date:   Fri, 7 Aug 2020 16:15:24 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
Message-ID: <20200807141524.GA3247@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200807112929.8984-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807112929.8984-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

...
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
>  # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
>  test1()
>  {
> -	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
> +	local keyrings keycheck_lines keycheck_line templates
> +	local policy="func=KEY_CHECK"
> +	local test_file="file.txt"

>  	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"

> -	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
> +	require_ima_policy_content $policy
> +	keycheck_lines=$(check_ima_policy_content $policy "")
>  	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
While working on this patchset, I wonder, why we don't check for
'func=KEY_CHECK.*keyrings' in single grep call instead of grepping it twice.
IMHO single grep call is enough. Or am I missing something?

Kind regards,
Petr
