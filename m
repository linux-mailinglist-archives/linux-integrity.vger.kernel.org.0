Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E791280357
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgJAP63 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 11:58:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49098 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732213AbgJAP63 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 11:58:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4E89F8EE17F;
        Thu,  1 Oct 2020 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601567908;
        bh=rSPPZ8/oZgy5hChynAOVFoajICqrGtoregQlaW4X26g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HY+J6TicjkT5Cb7ZUkSE+jHyQbVZfVmVUjLivWFdMHXXOJWbIV28CeUqAMHIya0Fh
         wwB3F5lR+BqX5wtIfc94+GMcYyvTeB0dosvQKOcmloL2kwemYHD2HcazRbluB8L0Dz
         R0x8drfsHkscfod4JkOYqgl3gUiW018qv7+H5jtc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zM40LH2b4MAa; Thu,  1 Oct 2020 08:58:27 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D7FE78EE0DA;
        Thu,  1 Oct 2020 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601567907;
        bh=rSPPZ8/oZgy5hChynAOVFoajICqrGtoregQlaW4X26g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fXdYWB5UuX4qRuKZlmWpF5DJxtQIoy+3WWPT8WPlh9JPt8XGzQ5jpfHoP3/siEXmZ
         nHUuz7F5yYzGRUQ4WEHmv8fHZggrA0WO/JSeaRqBx91YilT93OcIhaFFxOG3HkrJ8+
         lvkNKQJbqaHei6KaSXAfu56vxW1XDfdtkwiQrPcw=
Message-ID: <635963b53711cdf9c7e1b6534eeb3f172969d1b2.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Laurent Bigonville <bigon@debian.org>
Date:   Thu, 01 Oct 2020 08:58:25 -0700
In-Reply-To: <87h7reddat.fsf@jsnitsel.users.ipa.redhat.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
         <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
         <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
         <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
         <87h7reddat.fsf@jsnitsel.users.ipa.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 17:01 -0700, Jerry Snitselaar wrote:
> James Bottomley @ 2020-09-30 16:03 MST:
> 
> > On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
> > > James Bottomley @ 2020-09-29 15:32 MST:
> > > 
> > > > The current release locality code seems to be based on the
> > > > misunderstanding that the TPM interrupts when a locality is
> > > > released: it doesn't, only when the locality is acquired.
> > > > 
> > > > Furthermore, there seems to be no point in waiting for the
> > > > locality to be released.  All it does is penalize the last TPM
> > > > user.  However, if there's no next TPM user, this is a
> > > > pointless wait and if there is a next TPM user, they'll pay the
> > > > penalty waiting for the new locality (or possibly not if it's
> > > > the same as the old locality).
> > > > 
> > > > Fix the code by making release_locality as simple write to
> > > > release with no waiting for completion.
> > [...]
> > > My recollection is that this was added because there were some
> > > chips that took so long to release locality that a subsequent
> > > request_locality call was seeing the locality as already active,
> > > moving on, and then the locality was getting released out from
> > > under the user.
> > 
> > Well, I could simply dump the interrupt code, which can never work
> > and we could always poll.
> > 
> > However, there also appears to be a bug in our locality requesting
> > code.  We write the request and wait for the grant, but a grant
> > should be signalled by not only the ACCESS_ACTIVE_LOCALITY being 1
> > but also the ACCESS_REQUEST_USE going to 0.  As you say, if we're
> > slow to relinquish, ACCESS_ACTIVE_LOCALITY could already be 1 and
> > we'd think we were granted, but ACCESS_REQUEST_USE should stay 1
> > until the TPM actually grants the next request.
> > 
> > If I code up a fix is there any chance you still have access to a
> > problem TPM?  Mine all seem to grant and release localities fairly
> > instantaneously.
> > 
> > James
> 
> Sorry, I seemed to make a mess of it. I don't have access to a system
> where it occurred, but cc'ing Laurent since he reported the problem
> and might still have access to the system.
> 
> I'd say fix up the check for locality request to look at
> ACCESS_REQUEST_USE, and go with this patch to clean up locality
> release. Hopefully Laurent still has access and can test. I do have a
> laptop now where I should be able to test the other bits in your
> patchset since this is one of the models that hit interrupt storm
> problem when Stefan's 2 patches were originally applied. Lenovo
> applied a fix to their bios, but this should still have the older one
> version that has the issue. I'm on PTO this week, but I will try to
> spend some time in the next couple days reproducing and then trying
> your patches.

Thanks.  I think the patch to fix to request access is very simple ...
it's just to check the request bit has gone to zero, so I've attached
it below.  It seems to work fine for me.

James

---

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 0a86cf392466..5e56e8c67791 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -168,7 +168,8 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	if (rc < 0)
 		return false;
 
-	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
+	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID
+		       | TPM_ACCESS_REQUEST_USE)) ==
 	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
 		priv->locality = l;
 		return true;

