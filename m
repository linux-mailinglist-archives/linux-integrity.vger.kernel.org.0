Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1C2931DF
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 01:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbgJSXSH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 19:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388957AbgJSXSH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 19:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603149486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvxuptEVvfZQrWTRClDw/ls0nxuu6Baz4wVB6qJRkTk=;
        b=dC0EMU290Z2zEDrPbWaTBSj50fsZ0CUYJu4KXoXCDPPYa88hPyO0qdz2k3tI40j3whlgkx
        Bf/UoMmtuQYr0wI9eSvcHOE4ThCnhI3e8F1UdlaUoUiWOApbSgSupg8Tc0f7zoYQ5Y7D/+
        4DL9m2dinXN/ULYIf/yUo+YxMAKj0hU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-iPPizuDrNhO63DTUYsVLvg-1; Mon, 19 Oct 2020 19:18:04 -0400
X-MC-Unique: iPPizuDrNhO63DTUYsVLvg-1
Received: by mail-qt1-f200.google.com with SMTP id c4so35683qtx.20
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 16:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=SvxuptEVvfZQrWTRClDw/ls0nxuu6Baz4wVB6qJRkTk=;
        b=lAISFLWi1P5lCeYHZui987ynw8pd5/Vbq7BHkw1ZOUxGU0Bx+yKrMbTapWh6hq038A
         sW8Gy59kNoVyVkVooD9Jal2ChDvxOjLQ8+6s6GR5UpwWkXitWJY1imAu5L5cy5zj0uIH
         8mb8BT3+3XEBo8+KUKf6G7/rxoNpn32XG/NdT9GjlMpQLLUR/7J4EiYiIphajBNCpUYA
         uveBWUUcRDyUGHIwCkJpCLixQy8prS9qPrjRIb70yUT0xnu0vTxvBAKzKaiqqVjR0tvX
         cAo5czmZZTfR0+k3skK/g2qDXjY3YzZp8E62nQ0bki1Tup8hfGEZK51p97+XUmAu+0C6
         YfbA==
X-Gm-Message-State: AOAM532RFFYpFoTVjx/ObkLTfFCFsPXjq7TIcyiDmXV8dRhdm5vNYK2L
        E1bEOwsNaSjz4B/0EcvRczU3B0o48pPM93CYfBZKZd5SRq2XB0PC+eo517w/tJ8NYZK+zZUE5Ee
        beWSZFIoByWRC3GQxY0aVXafq05hY
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr33105qke.271.1603149483998;
        Mon, 19 Oct 2020 16:18:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNEP2BKp0oeI5MTFX5cSR7jZMHtlR7IHDePQiBElSsP2/ZqiVybSsOYDiI7AmZATOwfwMKrw==
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr33095qke.271.1603149483778;
        Mon, 19 Oct 2020 16:18:03 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e39sm35593qtk.32.2020.10.19.16.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:18:03 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
In-reply-to: <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
Date:   Mon, 19 Oct 2020 16:17:59 -0700
Message-ID: <875z75hkk8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

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
> Fixes: 33bafe90824b ("tpm_tis: verify locality released before returning from release_locality")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: added fixes
> ---
>  drivers/char/tpm/tpm_tis_core.c | 47 +--------------------------------
>  1 file changed, 1 insertion(+), 46 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index f3ecde8df47d..431919d5f48a 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -135,58 +135,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
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

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

