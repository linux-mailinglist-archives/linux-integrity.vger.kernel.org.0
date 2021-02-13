Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996731AD93
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBMScp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Feb 2021 13:32:45 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:59002 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhBMScn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Feb 2021 13:32:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E4B26128026E;
        Sat, 13 Feb 2021 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1613241122;
        bh=YYvWfoR+Cc4TMMU3BMYF+pPdEXWwhmPsMs848IAtLX8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HScxP2+XVxELs/PxNmMEEu9v9J8DPpN3Bxn/G0GTuKZWPMv1FFBDbev+lQFTQElwj
         muPUpVrSFaBuoznxRFdt7ceohP42/NgqpsWSkqFEbm5cpZLTZsWXBT2ymVBN0CYBFo
         3+L5DDPHGZGs3Xj6Ewnye7vcfr4a/S0sFWqzfTl8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3YCLuBbZEjxi; Sat, 13 Feb 2021 10:32:02 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 897531280267;
        Sat, 13 Feb 2021 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1613241122;
        bh=YYvWfoR+Cc4TMMU3BMYF+pPdEXWwhmPsMs848IAtLX8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HScxP2+XVxELs/PxNmMEEu9v9J8DPpN3Bxn/G0GTuKZWPMv1FFBDbev+lQFTQElwj
         muPUpVrSFaBuoznxRFdt7ceohP42/NgqpsWSkqFEbm5cpZLTZsWXBT2ymVBN0CYBFo
         3+L5DDPHGZGs3Xj6Ewnye7vcfr4a/S0sFWqzfTl8=
Message-ID: <68f08a0fe3aa7e143f70199008f8cc745a434dff.camel@HansenPartnership.com>
Subject: Re: TPM returned invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org
Date:   Sat, 13 Feb 2021 10:32:01 -0800
In-Reply-To: <YCZb/wdqEEumhtJa@kernel.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
         <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
         <YCZb/wdqEEumhtJa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-02-12 at 12:44 +0200, Jarkko Sakkinen wrote:
> On Sun, Feb 07, 2021 at 07:33:54PM -0800, James Bottomley wrote:
> > On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> > > Hello,
> > > 
> > > I already posted that beginning of January in reply to "tpm_tis:
> > > Clean up locality release", but I didn't really got a reply
> > > 
> > > With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
> > > 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following
> > > error:
> > 
> > Sorry, forgot to cc you.  We're iterating to this as the fix:
> > 
> > https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> > 
> > If you want to test it out.
> > 
> > Thanks,
> > 
> > James
> 
> Not true.
> 
> 1/5 and 2/5 have been already applied.
> 
> I'm still waiting one remaining fix from Lukasz. That's why I have
> not sent any PR's to Linus.

Perhaps you could point Laurent at the patch you think he could try
then because I think the backtrace indicates a potentially new problem.

James


