Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3627B27F5A1
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 01:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgI3XD1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 19:03:27 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38656 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730307AbgI3XD1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 19:03:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4A33B8EE14D;
        Wed, 30 Sep 2020 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601507007;
        bh=LAuOd04jx3CIyVzCHSM7x40x1VPlUa+QTWLYfd7LP5U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rgpx33YGV4nDr9tPrINQGzV5noKeOKP+Beyx6VhEVTdxJ3Kr85xyKhkFAepjf/wha
         DQGlyJekecav0Yyv+JuUdaS+oaBGazz3eQLAETKQBIUjvGorET2B4d9Iz7QM1IJEP3
         +Xwjd7CCi9o3ERDeorwPScLTG9HbW9EFv4JK4WpA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tIEZVc-1cLdB; Wed, 30 Sep 2020 16:03:27 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 69BEF8EE0E2;
        Wed, 30 Sep 2020 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601507006;
        bh=LAuOd04jx3CIyVzCHSM7x40x1VPlUa+QTWLYfd7LP5U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JAatqOQbR67hkJTyARm25V3+t9Li9G71C2iAfgk8OqLdK2VHxLU3afgFTxEiCKQPD
         PpmWi/RbP8K76+rCSorpEd8FYlWoMpm+57JvSbVzwUKegojxLgkBNKEXOYpcAUppgN
         XRa7MXAcjy/A8rm/e/xE901pFw9o5JS5Zc3BfKdc=
Message-ID: <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Wed, 30 Sep 2020 16:03:25 -0700
In-Reply-To: <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
         <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
         <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
> James Bottomley @ 2020-09-29 15:32 MST:
> 
> > The current release locality code seems to be based on the
> > misunderstanding that the TPM interrupts when a locality is
> > released: it doesn't, only when the locality is acquired.
> > 
> > Furthermore, there seems to be no point in waiting for the locality
> > to be released.  All it does is penalize the last TPM
> > user.  However, if there's no next TPM user, this is a pointless
> > wait and if there is
> > a
> > next TPM user, they'll pay the penalty waiting for the new locality
> > (or possibly not if it's the same as the old locality).
> > 
> > Fix the code by making release_locality as simple write to release
> > with no waiting for completion.
[...]
> My recollection is that this was added because there were some chips
> that took so long to release locality that a subsequent
> request_locality call was seeing the locality as already active,
> moving on, and then the locality was getting released out from under
> the user.

Well, I could simply dump the interrupt code, which can never work and
we could always poll.

However, there also appears to be a bug in our locality requesting
code.  We write the request and wait for the grant, but a grant should
be signalled by not only the ACCESS_ACTIVE_LOCALITY being 1 but also
the ACCESS_REQUEST_USE going to 0.  As you say, if we're slow to
relinquish, ACCESS_ACTIVE_LOCALITY could already be 1 and we'd think we
were granted, but ACCESS_REQUEST_USE should stay 1 until the TPM
actually grants the next request.

If I code up a fix is there any chance you still have access to a
problem TPM?  Mine all seem to grant and release localities fairly
instantaneously.

James



