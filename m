Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A274D27F8C5
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 06:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgJAEts (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 00:49:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41710 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgJAEts (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 00:49:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D06648EE14D;
        Wed, 30 Sep 2020 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601527787;
        bh=Z/x9udoxiaBGdppo5RLOw/mzU62NmIcy5DaeZaPMig4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NMdGEhsez3cWyPQ29nDwI5RpiLfE2u77Pb/8CdIciTZmNvgKAS8F7ltMSOCcQBPgN
         ArD1sYgXpSBK0MaxydW35iz7Dc5qx/U4ixkMQBzaT9zULTTrWj7jVEL0vkrbAHQ0Nz
         F0F15yKTPGFe+LJBwTf29NP5kJQzPqap51pJ8EVQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DyBreY1lsd5s; Wed, 30 Sep 2020 21:49:47 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 467F58EE0E2;
        Wed, 30 Sep 2020 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601527787;
        bh=Z/x9udoxiaBGdppo5RLOw/mzU62NmIcy5DaeZaPMig4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NMdGEhsez3cWyPQ29nDwI5RpiLfE2u77Pb/8CdIciTZmNvgKAS8F7ltMSOCcQBPgN
         ArD1sYgXpSBK0MaxydW35iz7Dc5qx/U4ixkMQBzaT9zULTTrWj7jVEL0vkrbAHQ0Nz
         F0F15yKTPGFe+LJBwTf29NP5kJQzPqap51pJ8EVQ=
Message-ID: <00f787a5108a1ef2613193099c8b7394f4ef5eed.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Wed, 30 Sep 2020 21:49:46 -0700
In-Reply-To: <20201001020152.GB5971@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
         <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
         <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
         <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
         <20201001020152.GB5971@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-01 at 05:01 +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 30, 2020 at 04:03:25PM -0700, James Bottomley wrote:
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
> 
> Side-topic: What is the benefit of using int's in a TPM driver
> anyway? I have never had any interest to dive into this with tpm_crb
> because I don't have the answer.

polling for events that don't immediately happen is a huge waste of
time.  That's why interrupts were invented in the first place.  If you
poll too fast, you consume wakeups which are really expensive to idle
time and if you poll too slowly you wait too long and your throughput
really tanks.  For stuff like disk and network transfers interrupts are
basically essential.  For less high volume stuff, like the TPM, we can
get away with polling, but it's hugely suboptimal if you have a large
number of events to get through ... like updating the IMA log.

> *Perhaps* in some smallest form factor battery run devices you could
> get some gain in run-time power saving but usually in such situations
> you use something similar to TEE to do a measured boot.

It's not about power saving, it's about doing stuff at the right time.

James


