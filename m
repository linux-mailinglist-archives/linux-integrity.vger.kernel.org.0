Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A77A08E8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Sep 2023 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjINPTn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Sep 2023 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPTn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Sep 2023 11:19:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F81FCC
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 08:19:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8928C433C7;
        Thu, 14 Sep 2023 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694704778;
        bh=Sfb09tzNbf/Qui/U4XUPOg2u9uMVk/i1HofbEHg2kJg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=l3Ble89Y5FKse5Wts6Dd0gSgrVw/amW0t0ZLQCWyBQrf2uLk1O2lUyJ0mdoaVva20
         w5OSiwt90ba8MZT7lxixyTBO1WMx6Ng3toYAJu+QMBJr10Ae+Rz7jBvGn8cgeiEkaM
         fRFh0TLSeTAE4HveLZe4HHYM9c5KojDn21IeJKykl5N8Y3ItwiqSAOLKGxdvqZhVSi
         hBQiP8fU58cCfeXHK8CMHh6c+38nMfVWGHRv+EVeHNgFT1MsNpsOLn1vRJHW7PtLk+
         PC9LNV9IhJt18L4+s/nPA+HlrGiLVsvbiF7q0zJqT51ASdYexDtydT0M/RljEHCAXl
         XaiBtnuuFqAtQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 14 Sep 2023 18:19:35 +0300
Message-Id: <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: don't flush never initialized work
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Beulich" <jbeulich@suse.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
In-Reply-To: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Sep 14, 2023 at 5:28 PM EEST, Jan Beulich wrote:
> tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
> called, in which case tpm_tis_remove() unconditionally calling
> flush_work() is triggering a warning for .func still being NULL.
>
> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandle=
d IRQs")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
> An alternative would be to move INIT_WORK(), but where to put it is far
> more difficult to tell for an outsider than simply making the flush call
> conditional.
>
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1022,7 +1022,8 @@ void tpm_tis_remove(struct tpm_chip *chi
>  		interrupt =3D 0;
> =20
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> -	flush_work(&priv->free_irq_work);
> +	if (priv->free_irq_work.func)
> +		flush_work(&priv->free_irq_work);
> =20
>  	tpm_tis_clkrun_enable(chip, false);
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Jan, I'm about to leave to vacation but will be back after next week.

Do you think that the fix can hold up unti that?

The feature is opt-in as I documented to kernel-parameters.txt:

	tpm_tis.interrupts=3D [HW,TPM]
			Enable interrupts for the MMIO based physical layer
			for the FIFO interface. By default it is set to false
			(0). For more information about TPM hardware interfaces
			defined by Trusted Computing Group (TCG) see
			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profil=
e-ptp-specification/

I'd prefer to apply this right after I'm back and not on rush but
will listen to other reasoning :-) Thanks.

BR, Jarkko



