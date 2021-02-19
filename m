Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8331F54A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 08:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhBSHIl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 02:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSHIk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 02:08:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC9DF64EC7;
        Fri, 19 Feb 2021 07:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613718479;
        bh=0IwgKLcCN57+liMx+xqKFJRTOI0mvqEbd1JQc1Ng4Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7FLszEWf28OFG18AnvJ567RCAUvF5SnZoFhu2troOhIOEOa4rKOaJ3Ei622scVuH
         hW/dyQjyhpuHF5xu+AwqRNPpM4IEONKKDf8EQs1B4889LYUj3TsawARZ3LVUC3LKlG
         +rFUQrnLcEz58J/O5Qcown12I7z2EIPXyVEmETU1APwd+VFxhfOjEjtobbBCo2Z0ez
         cShQGqBAmfFNLs/PlMw04AciNRIMuvzm+3WZDtlurlZDMxvsZGLp+CkDGipQKosxDW
         GfQw42j+5Wh8BDiU0Qqwv2jlalrFCWo1RGCECCWIsfTfc6kQVk5vEmkXhnPjvOr8sO
         6SHeZlZNCWCiA==
Date:   Fri, 19 Feb 2021 09:07:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Laight <David.Laight@aculab.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4] tpm: fix reference counting for struct tpm_chip
Message-ID: <YC9jwIFUzP+aRal0@kernel.org>
References: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
 <1613435460-4377-2-git-send-email-LinoSanfilippo@gmx.de>
 <20210216125342.GU4718@ziepe.ca>
 <YCvtF4qfG35tHM5e@kernel.org>
 <74bbc76260594a8a8f7993ab66cca104@AcuMS.aculab.com>
 <YC2VM1JI0tECPs7g@kernel.org>
 <20210218012702.GX4718@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218012702.GX4718@ziepe.ca>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 17, 2021 at 09:27:02PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 12:14:11AM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 16, 2021 at 04:31:26PM +0000, David Laight wrote:
> > > ...
> > > > > > +	get_device(&chip->dev);
> > > > > > +	chip->devs.release = tpm_devs_release;
> > > > > > +	chip->devs.devt =
> > > > > > +		MKDEV(MAJOR(tpm_devt), chip->dev_num + TPM_NUM_DEVICES);
> > > > 
> > > > Isn't this less than 100 chars?
> > > 
> > > Still best kept under 80 if 'reasonable'?
> > > 
> > > Really it is just split in the wrong place:
> > > 	chip->devs.devt = MKDEV(MAJOR(tpm_devt),
> > > 					chip->dev_num + TPM_NUM_DEVICES);
> > 
> > 
> > Well it looks crap IMHO. Would be more reasonable to have it in a single 
> > like. And it is legit too, since it is accepted by checkpatch.
> > 
> > You might break the lines within 80 chars if it is somehow "logically"
> > consistent.
> 
> FWIW, I've become kind of tired of the style wishywashyness I've
> mostly been happy to accept anything that clang-format spits out for
> ordinary C constructs.

A. I would not mind if it was already merged. Since it isn't, I don't
   see the point not fixing it.

> It is good enough and universally usable. If devs don't have it linked
> to their editor to format single expression or format selected blocks,
> they are missing out :)
> 
> The community consensus on style is quite unclear. Is 1 or 2 above the
> majority preference? Does this case fall under the new "use more than
> 80 cols if it improves readability?" I have no idea.

B. I need to maintain this, once it's merged.
C. A smaller diff for a critical bug fix. I actually allow style
   compromises for fixes to be backported *when* it makes the overall
   diff smaller.
D. Has more odds to make future changes smaller as the whole thing is
   in a single code line.

> Frankly, for most people writing driver code, if they consistently use
> clang-format their work will be alot better than if they try to do it
> by hand. It takes a lot of experiance to reliably eyeball something
> close to the kernel style..

For me it gives a framework to review patches in multiple subsystems.
If I have to constantly think whether to allow this and that shift
from the kernel coding style, it makes the whole process for me more
fuzzy and chaotic.

As I said (A), it would not be end of the world if this had been
merged already. I also want to state that I do sometimes make mistakes
when reviewing code, and am happy to take critique from that :-)

> Jason

/Jarkko
