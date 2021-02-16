Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC831C6DD
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 08:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBPHeP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 02:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhBPHeL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 02:34:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A9CB64E00;
        Tue, 16 Feb 2021 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613460810;
        bh=o08EfIuJSvpIA0Uahd7oM1LNOAvu2CwRQ/ojnCE7e8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZqiTcPxswCF5pPqddJSCBP8y9aWSCBdYOn2Zo4G4CJtH+zknrcor7bR8uLXbTX/q
         erWLyQaiuC5EgFLv/j2NgfEWEoG9/BBmr3fUPeKwQlyjRC5IElmEUEbxDHHBlWsVrr
         iqJD7Yf5IfzdSa1CH9E5ydb7dJ4jK/d1E62ugIkZzvvovg1K+nYUFC7ZMlq/XNF7aR
         ohvdLAYwOMQPzqk6vIIxv0EyYQKL79EZlU6VI6yM2eZaDdS8gLkpx2Lbe0DXd+A5EN
         8fPgUTDdFelmaOVQDrICC0a9PUFm2c77EEjVPJLeTx5LpkoIgOcBfNLkGF3NWxHTmc
         pZVUTpLzJRT+g==
Date:   Tue, 16 Feb 2021 09:33:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM returned invalid status
Message-ID: <YCt1PGgDwapp3cxU@kernel.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
 <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
 <YCZb/wdqEEumhtJa@kernel.org>
 <68f08a0fe3aa7e143f70199008f8cc745a434dff.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f08a0fe3aa7e143f70199008f8cc745a434dff.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 13, 2021 at 10:32:01AM -0800, James Bottomley wrote:
> On Fri, 2021-02-12 at 12:44 +0200, Jarkko Sakkinen wrote:
> > On Sun, Feb 07, 2021 at 07:33:54PM -0800, James Bottomley wrote:
> > > On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> > > > Hello,
> > > > 
> > > > I already posted that beginning of January in reply to "tpm_tis:
> > > > Clean up locality release", but I didn't really got a reply
> > > > 
> > > > With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
> > > > 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following
> > > > error:
> > > 
> > > Sorry, forgot to cc you.  We're iterating to this as the fix:
> > > 
> > > https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> > > 
> > > If you want to test it out.
> > > 
> > > Thanks,
> > > 
> > > James
> > 
> > Not true.
> > 
> > 1/5 and 2/5 have been already applied.
> > 
> > I'm still waiting one remaining fix from Lukasz. That's why I have
> > not sent any PR's to Linus.
> 
> Perhaps you could point Laurent at the patch you think he could try
> then because I think the backtrace indicates a potentially new problem.

Sure, that'd be good idea:

https://patchwork.kernel.org/project/linux-integrity/patch/20210212110600.19216-1-lma@semihalf.com/

Can you try this out?

/Jarkko
