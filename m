Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE027F412
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgI3VTk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 17:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgI3VTk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 17:19:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601500778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gFhJE6hLRdr+kGwoLh7Dsp5/CknAtmiRGnow1AIgzI=;
        b=fiJgZUtll/SnGnZuw/do8qIxyMybbph8Jw/+OwuJUylRr7yVsfmk9u80AaZuU4eJ4GCQt5
        m36IbDC6RUy9ITh50APEnZsW4fKhUciZL71xMpQIei1LaN7UY23u/qb3V1bqxXpucY2qYT
        aqBX0EvVyQvAJfcbPVGuNDoxc/G5afM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-IEWxaOjoOkW0Dt7dPENIyw-1; Wed, 30 Sep 2020 17:19:36 -0400
X-MC-Unique: IEWxaOjoOkW0Dt7dPENIyw-1
Received: by mail-oo1-f70.google.com with SMTP id k18so1548619oou.1
        for <linux-integrity@vger.kernel.org>; Wed, 30 Sep 2020 14:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=8gFhJE6hLRdr+kGwoLh7Dsp5/CknAtmiRGnow1AIgzI=;
        b=paqQD7Z8dD4ZgZ9vnpmlN/vFWOsl/zpEuDf90vs7ZpsPFgLv3GW1riobHMxIUNFtZq
         yRuCVxhHf3eRUhiTydarh1jVah6pSr68mF05QhaVn0CnVLIPfyjhETutcbbdmTBlW0r4
         y+gVmc1wGedYnoQgmw2QiSx6AxQlFSkpT/FMbLjp/Hy2RnsFgYwUm2i4PWfgy98GpFi8
         mY66YTvOQuywy3efc/VNFv4OLzmxVIc4ct8y/f/rbLk9otU/5lWG4aVQI8hugyD9/vcn
         ZzP2kQQxvqEH88P5wV+M/lzDcxe3l+0CYwMi84iK2JdYdZ3k52Q4VRNsoI/6ghM8P2lR
         INtg==
X-Gm-Message-State: AOAM531om05IiKruNJX9a3jgt4drwSqrzdayAkUbNZ+xjJTD0wZSLe1F
        s8g6WaRmO6aKLfWt5ax+oi7xcF57/zjDHhF8yGIRw1XUOHXEpqquTHYvvNtMYq230IRMR+8QPJI
        4IpcUrwG490ox8zKa0V2cP2n1OP0d
X-Received: by 2002:a4a:6255:: with SMTP id y21mr3313247oog.19.1601500775333;
        Wed, 30 Sep 2020 14:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtIe2N4Cts8qwfo9ZZkZwGDRu7mdtl/Ld0aasNvAOWF4umRMd+UmwWm0V8dM1lEuRn8K8DNg==
X-Received: by 2002:a4a:6255:: with SMTP id y21mr3313229oog.19.1601500775066;
        Wed, 30 Sep 2020 14:19:35 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t22sm661465otq.44.2020.09.30.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:19:34 -0700 (PDT)
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com> <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
In-reply-to: <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
Date:   Wed, 30 Sep 2020 14:19:32 -0700
Message-ID: <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-09-29 15:32 MST:

> The current release locality code seems to be based on the
> misunderstanding that the TPM interrupts when a locality is released:
> it doesn't, only when the locality is acquired.
>
> Furthermore, there seems to be no point in waiting for the locality to
> be released.  All it does is penalize the last TPM user.  However, if
> there's no next TPM user, this is a pointless wait and if there is a
> next TPM user, they'll pay the penalty waiting for the new locality
> (or possibly not if it's the same as the old locality).
>
> Fix the code by making release_locality as simple write to release
> with no waiting for completion.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 47 +--------------------------------
>  1 file changed, 1 insertion(+), 46 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..a9fa40714c64 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -134,58 +134,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	return false;
>  }
>  
> -static bool locality_inactive(struct tpm_chip *chip, int l)
> -{
> -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int rc;
> -	u8 access;
> -
> -	rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
> -	if (rc < 0)
> -		return false;
> -
> -	if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY))
> -	    == TPM_ACCESS_VALID)
> -		return true;
> -
> -	return false;
> -}
> -
>  static int release_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	unsigned long stop, timeout;
> -	long rc;
>  
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> -	stop = jiffies + chip->timeout_a;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> -again:
> -		timeout = stop - jiffies;
> -		if ((long)timeout <= 0)
> -			return -1;
> -
> -		rc = wait_event_interruptible_timeout(priv->int_queue,
> -						      (locality_inactive(chip, l)),
> -						      timeout);
> -
> -		if (rc > 0)
> -			return 0;
> -
> -		if (rc == -ERESTARTSYS && freezing(current)) {
> -			clear_thread_flag(TIF_SIGPENDING);
> -			goto again;
> -		}
> -	} else {
> -		do {
> -			if (locality_inactive(chip, l))
> -				return 0;
> -			tpm_msleep(TPM_TIMEOUT);
> -		} while (time_before(jiffies, stop));
> -	}
> -	return -1;
> +	return 0;
>  }
>  
>  static int request_locality(struct tpm_chip *chip, int l)

My recollection is that this was added because there were some chips
that took so long to release locality that a subsequent request_locality
call was seeing the locality as already active, moving on, and then the
locality was getting released out from under the user.

