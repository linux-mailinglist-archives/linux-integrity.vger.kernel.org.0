Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6245374D06
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 03:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEFBsb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 21:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhEFBsb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 21:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDFEE613B4;
        Thu,  6 May 2021 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620265654;
        bh=m/FucFqXwnvEgJZYcs2ulmK47101wLuoMnPmPvt7+94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDEdnnG07dODGDPyh1N43aqloKlcg8vcq1JCyYtNVuh3nPz5+e6AlomaiZFK2CDvo
         hhAeL7Vyq2kTxfXLefIpl8kPpDZ6TzMbuVyFsjU7282j1Mg7diHYKRxT949X8IgrlO
         ADG2JCOXOq7EUam6hASIVVf0t2IICw0NfEFMdpOGL/P/NJ+lTsQJm8UhfOD2Ppo1Ad
         HIdlv0ZDK7yN04e2FRqPxv5u9j9JXgYoIN4Ddgbkdjfu7PuLHj0bZB3WIqAHBb1bPm
         L2pxFQ0fxJNXBx1OdC5g9Jc8r472CaHa/WZ5GZ3gnC5Ird7JMx7yzX/qfwWZN95EHC
         svfZipkxquB9A==
Date:   Thu, 6 May 2021 04:47:31 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Simplify locality handling
Message-ID: <YJNKs8bUMGOzFre+@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de>
 <YJAby8mmiJ74qWAh@kernel.org>
 <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 05, 2021 at 01:15:29AM +0200, Lino Sanfilippo wrote:
> Hi,
> 
> On 03.05.21 at 17:50, Jarkko Sakkinen wrote:
> > What the heck is "simplification" and what that has to do with fixing
> > anything? I don't understand your terminology.
> 
> 
> The intention for this patch is not to fix anything. Please read the cover
> letter and the commit message.
> This patch is about making the locality handling easier by not claiming/releasing
> it multiple times over the driver life time, but claiming it once at driver
> startup and only releasing it at driver shutdown.
> 
> Right now we have locality request/release combos in
> 
> - probe_itpm()
> - tpm_tis_gen_interrupt()
> - tpm_tis_core_init()
> - tpm_chip_start()
> 
> and there is still one combo missing for
> 
> - tpm2_get_timeouts()
> 
> which is the reason why we get the "TPM returned invalid status" bug in case
> of TPM2 (and this is the bug which is _incidentally_ fixed by this patch, see
> below).
> 
> And if we are going to enable interrupts, we have to introduce yet another combo,
> for accessing the status register in the interrupt handler, since TPM 2.0
> requires holding the locality for writing to the status register. That makes
> 6 different code places in which we take and release the locality.
> 
> With this patch applied we only take the locality at one place. Furthermore
> with interrupts enabled we dont have to claim the locality for each handler
> execution, saving us countless claim/release combinations at runtime.
> 
> Hence the term "simplification" which is perfectly justified IMO.
> 
> So again, this patch is "only" in preparation for the next patch when interrupts
> are actually enabled and we would have to take the locality in the interrupt
> handler without this patch.

So: what problem this patch does solve?

/Jarkko
