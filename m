Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40005293211
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbgJSXkj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 19:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbgJSXkj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 19:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603150838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hdeBqu05QKsBNi900Hdxv2vV0GrjZPBoqKkxF6m/nE=;
        b=UtHNNNE4pM4Sdu9gnEC+Qd5R4XcCZwx64b0v6iiijPV0Dc9MF35Rv5R8hv+eA8FdF/Qik8
        nRlzGNAIoEDSgeruRmH8izL0pVcL+4zBOw/njZmoFqBuXgwMUXqSSAEcmVfpedcCke5puA
        CDNkmUxgi7CejIpQ6QgFty7ucOpzbSo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-26exbKR0OY-ibhaPzQ-NLA-1; Mon, 19 Oct 2020 19:40:36 -0400
X-MC-Unique: 26exbKR0OY-ibhaPzQ-NLA-1
Received: by mail-qk1-f200.google.com with SMTP id y77so9645qkb.8
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 16:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2hdeBqu05QKsBNi900Hdxv2vV0GrjZPBoqKkxF6m/nE=;
        b=WgLta23gK9gYzJHYJ3tVQ0NL+Yj+0Hr+ag179iKGBHr36AEQ6vQydfhcZTgXiKClWz
         /NofV4hrwzrG2HNA1NtbxCIXNpb6WsLmH+MY559kGZhI5O1u7N4OgL3ARxq/6NY/VPFy
         ERJyDJ/0FTwRtRft0Mxtj/WIpPb7o661SYXTq0QF0PsJcLY2BrY+BvhjP5JxSXxCp+bG
         jopbcW3zNlso8l02y/L0iH2DUx4n2+Ty4wrPdvG7xG59ufHgvxK0z4yrRwndjbr18ATv
         FdkKthX4IuLp2HPlClY12HQ3Gv2db3PIqQl5xxPc5afE5izT1lfk2okHgKmZf2lfgB3X
         MzWA==
X-Gm-Message-State: AOAM532iXyKL6c+gobfslFbDj0WkUeTDHtusV2B3X61FmTdxnf8MqjSB
        KL8WrKaP9nAwIhuWf8R2FIoLYVuPmmsT+tZ7kAMWM9YnJh83VzmL9JUDko+R73g+uyqxsZaGQqc
        INb0DmSOr0DfvCJ4FRLJToar8E0RX
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr1884785qtf.85.1603150836005;
        Mon, 19 Oct 2020 16:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXdUv7YyH4g7arau9Zsp067cW2vKkGjPVTQAw1T95XNnlFWDgZxin12bDr6kCKpiRNWI1vdw==
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr1884773qtf.85.1603150835815;
        Mon, 19 Oct 2020 16:40:35 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g16sm71398qke.90.2020.10.19.16.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:40:34 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 5/5] Revert "tpm: Revert "tpm_tis_core: Turn on the
 TPM before probing IRQ's""
In-reply-to: <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
Date:   Mon, 19 Oct 2020 16:40:33 -0700
Message-ID: <873629hjim.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

> Revert the patch aa4a63dd9816 which stops interrupt probing from
> working, now that it should be safe to allow interrupt probing on all
> systems without incurring interrupt storms.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 12b657ed3a39..23b60583928b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1117,6 +1117,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  			goto out_err;
>  		}
>  
> +		tpm_chip_start(chip);
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
>  			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> @@ -1128,6 +1129,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		} else {
>  			tpm_tis_probe_irq(chip);
>  		}
> +		tpm_chip_stop(chip);
>  	}
>  
>  	rc = tpm_chip_register(chip);


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

