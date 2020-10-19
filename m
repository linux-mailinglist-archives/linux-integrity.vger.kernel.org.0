Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF60293215
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbgJSXlm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 19:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbgJSXll (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 19:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603150900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ev37fAVf9bnaicfJTGAp43MToqUIj+kn2w+EG8z2cTg=;
        b=LfWJ+RD3gsFPihBiaqwXBOelLrx8BoBzTCAVx5QPwXKAcnTkSWYwWiRRhPiEfpp3vX8soZ
        wSBbPi8vyzeGj5HTuNQVVpBjvhK2h0azufxe0EfnrmUEqkv6B2fj96ekcHfvptWgWiElio
        2KLweCM6HuM1Q6FRBGLyZnnhqNWLuBs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-NlwMXAQIN2CxR29pFRkXSQ-1; Mon, 19 Oct 2020 19:41:38 -0400
X-MC-Unique: NlwMXAQIN2CxR29pFRkXSQ-1
Received: by mail-qt1-f198.google.com with SMTP id y20so85730qta.6
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 16:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Ev37fAVf9bnaicfJTGAp43MToqUIj+kn2w+EG8z2cTg=;
        b=IuljZLrrN4qis9FFeOI4KCU62HSHZeniu4bUUviIayM8yW0JLuXhGE6hn10bvQ1rYJ
         2qkul9c3Ex6Ex1ax0XfG7OgiBnrqP4T3qdWKAIBiL6avQdV4yjdo4Ofu8oeTgJo/j1Nj
         CTpjEp99LkVyEiCNYoujHVc/ZKiZcNwCj8EoRLXiN+YoWNBux1sxDKkYg3nJKEhNWt+O
         u0G43m2mieBiditM3nAybqdQLwO6UKC/qA+GaIuZU1elB9hNG6VGbaACSC6yDiIAopoH
         gISc7tNcHpC6z4cMhc3ZeZhQ702Ry24curkC1LwUeKZMAnGhR2kpCnWy8/upX1OLlwFk
         5eAA==
X-Gm-Message-State: AOAM531WztX/TOch4qR9HPzdRxc+yFMUgxIS3CtvkTZvGGlkMOULDYRi
        VO1lEadTAp9EzZzVISaDexjrCbiCkokidd/omRI0Z/AMWpcOZg2/OwoOt/+/Uh/oVux9dytvsm/
        e3UiDhlAC1JsgP0oMgIrNz6nmoVdB
X-Received: by 2002:a0c:f188:: with SMTP id m8mr297492qvl.37.1603150898190;
        Mon, 19 Oct 2020 16:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkCH0s6LVcnEYezSxNr0Usk7IvbPQpG0Vl5ucejJT7p1j9JWrFmVWB3LEy9A4K9eBRj4br1Q==
X-Received: by 2002:a0c:f188:: with SMTP id m8mr297479qvl.37.1603150897994;
        Mon, 19 Oct 2020 16:41:37 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a128sm70202qkc.92.2020.10.19.16.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:41:37 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
In-reply-to: <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
Date:   Mon, 19 Oct 2020 16:41:35 -0700
Message-ID: <87zh4hg4wg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

> There are two problems with our current interrupt probing: firstly the
> TPM_CHIP_FLAG_IRQ never gets set initially, so a check for interrupts
> is never done.  Fix this by setting the flag before we generate and
> interrupt for probing.  Secondly our IRQ setup may be ineffective on a
> TPM without legacy access cycles becuase according to the TPM
> Interface Specification the interrupt registers are only writeable in
> the current locality, so issue a request_locality before setting up
> the interrupts.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: improved description
> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 0c07da8cd680..12b657ed3a39 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -809,6 +809,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
>  	}
>  	priv->irq = irq;
>  
> +	/*
> +	 * note writes to the interrupt registers are only effective
> +	 * when the TPM is in the active locality, so we have to
> +	 * request the locality here to get the interrupt set up.
> +	 * This request has no corresponding release, because the
> +	 * locality will be relinquished at the end of the tpm command
> +	 * that probes the interrupts
> +	 */
> +	if (request_locality(chip, 0) != 0) {
> +		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
> +		return -EBUSY;
> +	}
> +
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
>  	if (rc < 0)
> @@ -836,6 +849,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
>  		return rc;
>  
>  	priv->irq_tested = false;
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

