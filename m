Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AB3999FA
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 07:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCFbn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 01:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCFbk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 01:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129CD613DA;
        Thu,  3 Jun 2021 05:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622698196;
        bh=lZ29KVCtkxlkoM/36VI4ZBcA1/oG7TivL0xDiXOwx3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVYxP6u1T+A116yYndTWL4qubDouejxMW5ulUQ2J3LG81t163oxWpaFVX7MSrcyyL
         HdGdt2BoTcZVJTSvtcS8xD/uuSEd/wcAHCDDkiWIrUHNiBzGGKzDhCH5aCai50eNkn
         xqBdQEHCnMTbcNz9teWDs7dg4ogZP2Mq2WCpNjYg2qfdZ5KU9gb07EFTIq0NOMywpt
         g7niwa44+gG0qGCRIXxVsO/8xObssVI8hT1rFY50DtNOIEpOJgokru6s5RCWcfTBM/
         t85MSmppQmJlqPjRLNsq29VM6MQ5Kb0LqERzdYkPiZDky4iwRFPDyZGCWpnptGfeSf
         Dt+xXUaC/DidQ==
Date:   Thu, 3 Jun 2021 08:29:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
Message-ID: <20210603052954.ms7s4cmkejpxo2lc@kernel.org>
References: <20210601064507.9989-1-thunder.leizhen@huawei.com>
 <20210601175728.gyi3yepdtvu4hald@kernel.org>
 <277d929b-0602-ffbb-5866-64731a19ff14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277d929b-0602-ffbb-5866-64731a19ff14@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 02, 2021 at 09:11:47AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/2 1:57, Jarkko Sakkinen wrote:
> > On Tue, Jun 01, 2021 at 02:45:07PM +0800, Zhen Lei wrote:
> >> No functional change.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > No change, no need to apply?
> 
> But it can make the code look simpler, easier to read and maintain(The start
> address does not need to appear twice). I think that's why these DEFINE_RES_*
> macros are defined.
> 
> By the way, would it be better to change the letters in 0xFED40000 to lowercase?

I mean "No functional change" does not really tell anything about anything.

Please just describe what the commit does.

/Jarkko

> 
> > 
> > /Jarkko
> > 
> >> ---
> >>  drivers/char/tpm/tpm_tis.c | 6 +-----
> >>  1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> >> index 4ed6e660273a414..d3f2e5364c275f4 100644
> >> --- a/drivers/char/tpm/tpm_tis.c
> >> +++ b/drivers/char/tpm/tpm_tis.c
> >> @@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
> >>  {
> >>  	struct platform_device *pdev;
> >>  	static const struct resource x86_resources[] = {
> >> -		{
> >> -			.start = 0xFED40000,
> >> -			.end = 0xFED40000 + TIS_MEM_LEN - 1,
> >> -			.flags = IORESOURCE_MEM,
> >> -		},
> >> +		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
> >>  	};
> >>  
> >>  	if (!force)
> >> -- 
> >> 2.26.0.106.g9fadedd
> >>
> >>
> >>
> > 
> > .
> > 
> 
> 
