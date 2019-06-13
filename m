Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037E1440F2
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfFMQKr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391481AbfFMQKr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 12:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F290AE36;
        Thu, 13 Jun 2019 16:10:46 +0000 (UTC)
Date:   Thu, 13 Jun 2019 18:10:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ima/ima_measurements.sh: Require builtin IMA tcb
 policy
Message-ID: <20190613161042.GA24675@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
 <20190611193021.17651-4-pvorel@suse.cz>
 <1560352011.4578.43.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560352011.4578.43.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

thanks a lot for your review.

> On Tue, 2019-06-11 at 21:30 +0200, Petr Vorel wrote:
> > Although custom policy which contains tcb can be loaded via dracut,

> ^which may contain the equivalent measurement tcb rules
I'm going to address this in v4.

> > systemd or later manually from user space, detecting it would require
> > IMA_READ_POLICY=y. In order to simplify the check and avoid false
> > positives lets ignore this option and require builtin IMA tcb policy.

> This test is for adding new measurements to the measurement list.
Sure. So what should I change in commit message?


> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../kernel/security/integrity/ima/tests/ima_measurements.sh    | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > index 328affc43..a3aa24d8a 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > @@ -57,7 +57,8 @@ setup()
> >  	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
> >  		"Cannot find digest index (template: '$template')"

> > -	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
> > +	grep -q -e ima_policy=[a-z_]*tcb -e ima_tcb -e ima_appraise_tcb /proc/cmdline || \
> > +		tst_brk TCONF "IMA measurement tests require builtin IMA tcb policy (ima_policy=tcb or ima_policy=appraise_tcb kernel parameter)"
> >  }


> "appraise_tcb" doesn't provide the necessary measurement rules.
> "ima_policy=" isn't order specific.  The check would be for "|tcb", "|
> tcb", "tcb|", "tcb |", or just "=tcb".  The deprecated "ima_tcb"
> option is fine too.
Going to change in v4.

> Mimi

Kind regards,
Petr

