Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4107A0987
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Sep 2023 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjINPmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Sep 2023 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbjINPmf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Sep 2023 11:42:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4C115
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 08:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF710C433C7;
        Thu, 14 Sep 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694706150;
        bh=cm79zBBrYWeUj+lE/udPPmTsTno8E4H7W3ZJmG1QPkM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CxD3X1l7GN4VipFAAqbimZcM/4mWTzYnHdaxTKW99qbFIYn0blOnrLCSR0lz8foXy
         5vdhU91NrNPEiPxYZeq7Opaw1zqlmBJDzCKvSk/PAg4sP1AmF2p2Yuc/V6pZt9QkYW
         7zbiHKHZZAwuHV7jKKM8edxTJKoLDcFQGq+lNSFmA7JiUx0rIqqgF+o/tYifaDNO8l
         oiMJQd71JUJ8xPs5vGX6cBDQZiyUfzQZJoN6HWpCxMqoLJ3wSOLXR2K95c2HYCBGo0
         W4np2IL8LtZqSubKE5iYDJDWfFi8srCwLD5X6hYvX26koblfgYilTz2UGX5+cToepo
         LRasj3AFpJwLw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 14 Sep 2023 18:42:27 +0300
Message-Id: <CVIR6WGM46EU.PZVB1C9B4WAJ@suppilovahvero>
Subject: Re: [PATCH] tpm_tis: don't flush never initialized work
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Beulich" <jbeulich@suse.com>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
 <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
 <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
In-Reply-To: <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Sep 14, 2023 at 6:29 PM EEST, Jan Beulich wrote:
> On 14.09.2023 17:19, Jarkko Sakkinen wrote:
> > On Thu Sep 14, 2023 at 5:28 PM EEST, Jan Beulich wrote:
> >> tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
> >> called, in which case tpm_tis_remove() unconditionally calling
> >> flush_work() is triggering a warning for .func still being NULL.
> >>
> >> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhan=
dled IRQs")
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> ---
> >> An alternative would be to move INIT_WORK(), but where to put it is fa=
r
> >> more difficult to tell for an outsider than simply making the flush ca=
ll
> >> conditional.
> >>
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -1022,7 +1022,8 @@ void tpm_tis_remove(struct tpm_chip *chi
> >>  		interrupt =3D 0;
> >> =20
> >>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> >> -	flush_work(&priv->free_irq_work);
> >> +	if (priv->free_irq_work.func)
> >> +		flush_work(&priv->free_irq_work);
> >> =20
> >>  	tpm_tis_clkrun_enable(chip, false);
> >> =20
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > Jan, I'm about to leave to vacation but will be back after next week.
> >=20
> > Do you think that the fix can hold up unti that?
>
> There's no rush from my pov, as I have helped myself. Nevertheless ...
>
> > The feature is opt-in as I documented to kernel-parameters.txt:
> >=20
> > 	tpm_tis.interrupts=3D [HW,TPM]
> > 			Enable interrupts for the MMIO based physical layer
> > 			for the FIFO interface. By default it is set to false
> > 			(0). For more information about TPM hardware interfaces
> > 			defined by Trusted Computing Group (TCG) see
> > 			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-pr=
ofile-ptp-specification/
>
> ... I'm not doing anything non-default. The issue here is that part of
> interrupt cleanup occurs without interrupt setup having happened. So
> I'm inclined to think that the warning is independent of (and perhaps
> more likely to observe without) use of that optional functionality.
>
> Jan

Ah, you're absolutely right!

I'll apply and test this properly after I'm back. Thanks for finding
the bug and fixing  it.

BR, Jrakko
