Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399B6217BE
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfEQL2v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 07:28:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728659AbfEQL2v (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 07:28:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CC28AD5D;
        Fri, 17 May 2019 11:28:50 +0000 (UTC)
Date:   Fri, 17 May 2019 13:28:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter =?iso-8859-2?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20190517112848.GA27606@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <20190517065116.GA8170@dell5510>
 <1558091974.4507.60.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558091974.4507.60.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Fri, 2019-05-17 at 08:51 +0200, Petr Vorel wrote:

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > index 0ffc3c02247d..ebe4b4c360e4 100755
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > @@ -88,6 +88,14 @@ test2()
> > >  	tst_res TINFO "verify PCR values"
> > >  	tst_check_cmds evmctl

> > > +	local tpm_description="/sys/class/tpm/tpm0/device/description"
> > > +	if [ -f "$tpm_description" ]; then
> > > +		if grep -q "^\TPM 2.0" $tpm_description; then

> > I guess the backslash in "^\TPM 2.0" is a typo.
> > If yes, no need to repost, I'll fix it when applying your patch.
> > + I'd prefer join 2 ifs into single one, but that's just matter of preference,
> > not important.

> Thank you for fixing it.  I'd just like to hear from others first, if
> this is correct way to differentiate between TPM 1.2 and TPM 2.0.
Oh, yes, let's wait for a feedback.

> Mimi

Kind regards,
Petr
