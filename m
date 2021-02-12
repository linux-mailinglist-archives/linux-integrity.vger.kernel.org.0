Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88237319CD1
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 11:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBLKp0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 05:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhBLKpG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 05:45:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB26864E57;
        Fri, 12 Feb 2021 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613126665;
        bh=CYKV7rR2ualcVyz6afVwyVaYpBpMh0XMLDtYjqXJ7lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGBG2KULxXyJuiYfdBX5L6xMuegd8/MD0zGbnYnMY0dXn4+W9hlu49PcEQli9yik5
         iTiCBbMtuCtlLGvP8CKMtMLuoxqNa91WdwacMlEMpzkR23JiSDpxbRUbQD58Vqbh0c
         Fa3n6/Tr0H9914E2cxOrxjbzL0r5WLzJ2/7Fe3CMxpibgBHKXYX+WhPS63KNzOhHIA
         Jc7x09bk/PbDm4g63Lx/IjdBK1VV3W1iFIkOYPb835Ke40mW1PDwR2yIQk7DhoRdoQ
         pOfMTPTmnuHhLi3y8n3x2XMvnZAaXvk13nsjaz7m9m5AW0zd1NmbbOKJjxL1Pmn+3C
         o8IzfdDn/fQZQ==
Date:   Fri, 12 Feb 2021 12:44:15 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM returned invalid status
Message-ID: <YCZb/wdqEEumhtJa@kernel.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
 <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 07, 2021 at 07:33:54PM -0800, James Bottomley wrote:
> On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> > Hello,
> > 
> > I already posted that beginning of January in reply to "tpm_tis:
> > Clean 
> > up locality release", but I didn't really got a reply
> > 
> > With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
> > 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following error:
> 
> Sorry, forgot to cc you.  We're iterating to this as the fix:
> 
> https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> 
> If you want to test it out.
> 
> Thanks,
> 
> James


Not true.

1/5 and 2/5 have been already applied.

I'm still waiting one remaining fix from Lukasz. That's why I have not sent
any PR's to Linus.

/Jarkko
