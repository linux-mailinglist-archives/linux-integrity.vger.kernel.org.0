Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6264931C741
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 09:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPIUy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 03:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhBPIUw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 03:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9244264E00;
        Tue, 16 Feb 2021 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613463611;
        bh=gEMulqetCqkiHZPOfLwcuL6MR0sA1zLCs/eZgJ12xT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnhCIqqMFXDJaynxRf64mQZkgXUqZJ0PxMu700JgIoXixtE5dGhv+tdfSOIaujaxO
         wE1D08ieCYek3/q/yAhGqyC4rtY736aIiDMaaEnV36M03XmM1tbqlMQIlsJUeuO50J
         /j2+N6EqjgoPxUCkEL2MPj0cZs/40Zz9upmw+zc6vdyqllGDp+gnKNnnZ1N18YoXK4
         rw6TIOSpiaSxeSmN0LUxXbQncwsJcvNzkcQQPopEGNDO7kwntWGaNuM6XnxV8v/IeK
         7UvC5vQCspEMQLjgxhqmREv0u9PdrB42SrJVtEBxj8oEdXR3eGnJ0KX57akVEdxKdA
         n4Rw2O1rhbSWA==
Date:   Tue, 16 Feb 2021 10:19:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM returned invalid status
Message-ID: <YCuALq+IP4jLE6vs@kernel.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
 <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
 <YCZb/wdqEEumhtJa@kernel.org>
 <68f08a0fe3aa7e143f70199008f8cc745a434dff.camel@HansenPartnership.com>
 <YCt1PGgDwapp3cxU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCt1PGgDwapp3cxU@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 09:33:20AM +0200, Jarkko Sakkinen wrote:
> On Sat, Feb 13, 2021 at 10:32:01AM -0800, James Bottomley wrote:
> > On Fri, 2021-02-12 at 12:44 +0200, Jarkko Sakkinen wrote:
> > > On Sun, Feb 07, 2021 at 07:33:54PM -0800, James Bottomley wrote:
> > > > On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> > > > > Hello,
> > > > > 
> > > > > I already posted that beginning of January in reply to "tpm_tis:
> > > > > Clean up locality release", but I didn't really got a reply
> > > > > 
> > > > > With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
> > > > > 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following
> > > > > error:
> > > > 
> > > > Sorry, forgot to cc you.  We're iterating to this as the fix:
> > > > 
> > > > https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> > > > 
> > > > If you want to test it out.
> > > > 
> > > > Thanks,
> > > > 
> > > > James
> > > 
> > > Not true.
> > > 
> > > 1/5 and 2/5 have been already applied.
> > > 
> > > I'm still waiting one remaining fix from Lukasz. That's why I have
> > > not sent any PR's to Linus.
> > 
> > Perhaps you could point Laurent at the patch you think he could try
> > then because I think the backtrace indicates a potentially new problem.
> 
> Sure, that'd be good idea:
> 
> https://patchwork.kernel.org/project/linux-integrity/patch/20210212110600.19216-1-lma@semihalf.com/
> 
> Can you try this out?

I wrote a patch based on v5 (just sent). Does not show up yet in patchwork,
so can not link it here.

/Jarkko
