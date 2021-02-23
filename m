Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E4322FAC
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Feb 2021 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhBWRcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 12:32:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233707AbhBWRcL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 12:32:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9FCEAC1D;
        Tue, 23 Feb 2021 17:31:28 +0000 (UTC)
Date:   Tue, 23 Feb 2021 18:31:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: Check for ima-buf template is not required for keys
 tests
Message-ID: <YDU77/zetTzs569z@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210222023421.12576-1-nramas@linux.microsoft.com>
 <YDTJtl9C9HbRILQb@pevik>
 <2b7f2f88-7df8-bd31-59cb-fd74bfe555fd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7f2f88-7df8-bd31-59cb-fd74bfe555fd@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> On 2/23/21 1:24 AM, Petr Vorel wrote:

> Hi Petr,


> > > ima-buf is the default IMA template used for all buffer measurements.
> > > Therefore, IMA policy rule for measuring keys need not specify
> > > an IMA template.
> > Good catch. But was it alway?

> > IMHO ima-buf as default was added in dea87d0889dd ("ima: select ima-buf template for buffer measurement") in v5.11-rc1.
> For key measurements ima-buf template was required in the policy rule, but
> with the above commit (dea87d0889dd) it was changed to ima-buf. So we no
> longer need to specify the template in the policy.

> > But test1() tests 450d0fd51564 ("IMA: Call workqueue functions to measure queued keys") from v5.6-rc1.
> > Is it safe to ignore it?
> Even when the key is queued for measurement, ima-buf template will be used
> when the key is dequeued. Not sure if that answers your question.
IMHO template=ima-buf is required from v5.6-rc1 to v5.10, right?
But maybe it's just enough to check that no other template is used as we discuss
below.

> > BTW template=ima-buf requirement was added in commit b0418c93f ("IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern")

> > Also, shouldn't we check that there is none of the other templates (e.g. template=ima-ng, ...)?
> This is a good point - yes: we should check if no other template other than
> ima-buf is specified in the policy rule for measuring keys.
It'd be great if you include it in v2.

...
> > >   FUNC_KEYCHECK='func=KEY_CHECK'
> > > -TEMPLATE_BUF='template=ima-buf'
> > > -REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
> > > +REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
> > nit: remove brackets:
> > REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
> Sure - will remove that.
Thanks!

> > There is
> > testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy file,
> > which should be a helper to load proper policy and needs to be updated as well:
> > -measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> > +measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test

> > I was also thinking to move keyrings to REQUIRED_POLICY, e.g.:

> > KEYRINGS="keyrings=\.[a-z]+"
> > REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$KEYRINGS|$KEYRINGS.*$FUNC_KEYCHECK)"
> "keyrings=" is optional in the policy. If keyrings is specified it should be
> checked.
OK, just optional.

Kind regards,
Petr

> thanks,
>  -lakshmi
