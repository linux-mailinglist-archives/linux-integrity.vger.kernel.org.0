Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631252805CC
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbgJARsS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 13:48:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50392 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732096AbgJARsO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 13:48:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C00498EE17F;
        Thu,  1 Oct 2020 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601574493;
        bh=yyQtM2HOCVDSQKrqkAPCX1u/r94Og6zmdRH85vSSZN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GwV+m9iWAStHqXBdenvtgr7x/ra0wAEQJFh5c3h41sUQvIR4lYhRdkLOq7ri1/6TT
         z1TfDLCQdP++wHtht7bBzkgYogI5z6z1KX2fyolV2De5RQoxfM5Syh726AsISeMxc8
         eocLAeEYflJ1XNJ3aTuyvWsfwtA6MImWc0/BSmlc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Jm6kdGcLeir; Thu,  1 Oct 2020 10:48:13 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 46D358EE0DA;
        Thu,  1 Oct 2020 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601574493;
        bh=yyQtM2HOCVDSQKrqkAPCX1u/r94Og6zmdRH85vSSZN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GwV+m9iWAStHqXBdenvtgr7x/ra0wAEQJFh5c3h41sUQvIR4lYhRdkLOq7ri1/6TT
         z1TfDLCQdP++wHtht7bBzkgYogI5z6z1KX2fyolV2De5RQoxfM5Syh726AsISeMxc8
         eocLAeEYflJ1XNJ3aTuyvWsfwtA6MImWc0/BSmlc=
Message-ID: <42476348690ecc7c002a3f420d35ad38abb7d600.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Thu, 01 Oct 2020 10:48:12 -0700
In-Reply-To: <00f787a5108a1ef2613193099c8b7394f4ef5eed.camel@HansenPartnership.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
         <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
         <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
         <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
         <20201001020152.GB5971@linux.intel.com>
         <00f787a5108a1ef2613193099c8b7394f4ef5eed.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 21:49 -0700, James Bottomley wrote:
> On Thu, 2020-10-01 at 05:01 +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 30, 2020 at 04:03:25PM -0700, James Bottomley wrote:
> > > On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
> > > > James Bottomley @ 2020-09-29 15:32 MST:
> > > > 
> > > > > The current release locality code seems to be based on the
> > > > > misunderstanding that the TPM interrupts when a locality is
> > > > > released: it doesn't, only when the locality is acquired.
> > > > > 
> > > > > Furthermore, there seems to be no point in waiting for the
> > > > > locality to be released.  All it does is penalize the last
> > > > > TPM user.  However, if there's no next TPM user, this is a
> > > > > pointless wait and if there is a next TPM user, they'll pay
> > > > > the penalty waiting for the new locality (or possibly not if
> > > > > it's the same as the old locality).
> > > > > 
> > > > > Fix the code by making release_locality as simple write to
> > > > > release with no waiting for completion.
> > > [...]
> > > > My recollection is that this was added because there were some
> > > > chips that took so long to release locality that a subsequent
> > > > request_locality call was seeing the locality as already
> > > > active, moving on, and then the locality was getting released
> > > > out from under the user.
> > > 
> > > Well, I could simply dump the interrupt code, which can never
> > > work and we could always poll.
> > 
> > Side-topic: What is the benefit of using int's in a TPM driver
> > anyway? I have never had any interest to dive into this with
> > tpm_crb because I don't have the answer.
> 
> polling for events that don't immediately happen is a huge waste of
> time.  That's why interrupts were invented in the first place.  If
> you poll too fast, you consume wakeups which are really expensive to
> idle time and if you poll too slowly you wait too long and your
> throughput really tanks.  For stuff like disk and network transfers
> interrupts are basically essential.  For less high volume stuff, like
> the TPM, we can get away with polling, but it's hugely suboptimal if
> you have a large number of events to get through ... like updating
> the IMA log.

I suppose I should also add that for annoying TPMs that crash if you
poll too often, like the Atmel and my Nuvoton, using interrupts would
be a huge facilitator because you only touch the status register when
you know something has changed and the TPM is expecting you to check.  
Not that this will actually help me: my ACPI tables imply my TPM has no
interrupt line, unfortunately.

James


