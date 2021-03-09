Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5627332257
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhCIJvX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Mar 2021 04:51:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:53872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhCIJvW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Mar 2021 04:51:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66748ACC6;
        Tue,  9 Mar 2021 09:51:21 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:51:19 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: Allow only ima-buf template for key measurement
Message-ID: <YEdFF2g6Z1KJiJ5b@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210303203254.12856-1-nramas@linux.microsoft.com>
 <YEJZIQqa1arYKwK+@pevik>
 <33ba6274-e7ef-27de-b481-5a702136c0df@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ba6274-e7ef-27de-b481-5a702136c0df@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> On 3/5/21 8:15 AM, Petr Vorel wrote:

> Hi Petr,

> A small change is needed:

> In the while loop, for each line of the KEY_CHECK policy, we need to check
> if a "template" is specified, and if it is then verify if it is "ima-buf".

> > You need to do:
> > while read line; do
> > 	if ! echo $line | grep -q $template; then
> > 		tst_res TCONF "only $template can be specified for $func"
> > 		return 1
> > 	fi
> > done < $TST_TMPDIR/policy.txt
> > return 0

> Please see the change below:

> while read line; do
> 	if echo $line | grep -q 'template=' && ! echo $line | grep -q $template ;
> then
> 		tst_res TCONF "only $template can be specified for $func"
> 		return 1
> 	fi
> done < $TST_TMPDIR/policy.txt
> return 0
Good catch!

> With check_policy_template() moved from ima_setup.sh to ima_keys.sh, the
> test works fine

> When the policy contains the following
>    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
>    measure func=KEY_CHECK keyrings=.builtin_trusted_keys

I guess we should update datafiles/ima_keys/keycheck.policy to contain both
lines.

> the test passes:

> ima_keys 1 TINFO: verify key measurement for keyrings and templates
> specified in IMA policy
> ima_keys 1 TINFO: keyrings: 'key_import_test|\.builtin_trusted_keys'
> ima_keys 1 TINFO: templates: 'ima-buf'
> ima_keys 1 TPASS: specified keyrings were measured correctly


> But if the policy is changed to below:
>    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
>    measure func=KEY_CHECK keyrings=.builtin_trusted_keys template=ima-sig

> the test fails as expected.

> ima_keys 1 TINFO: verify key measurement for keyrings and templates
> specified in IMA policy
> ima_keys 1 TCONF: only template=ima-buf can be specified for func=KEY_CHECK

> I'll post the updated patch shortly.

Thanks a lot!

> thanks,
>  -lakshmi

Kind regards,
Petr
