Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2832931D5
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 01:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgJSXQj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 19:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728436AbgJSXQi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 19:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603149397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuMO8w3E3xYyZIyoaePiFMSHnlQSgOV2aS0NxjehVRI=;
        b=KhyoZ7gJE9OTBUUeoE1NRLJ2V9gEdzZ09gCczBIt0kJ+bjP2vCZvNq68SfPTLp2Q7rhwBL
        assKynJDfH21oDioHE+mqkq/YZfm6BXAr7dvM/r5EK3+1Ldo/dgfga35+bLuqN7eThYUnc
        1HgUNj6vtObXw4JkLzNy1oGp8LUYi6U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-F7_QgQPDM0u5k4eyQpbD4w-1; Mon, 19 Oct 2020 19:16:35 -0400
X-MC-Unique: F7_QgQPDM0u5k4eyQpbD4w-1
Received: by mail-qt1-f197.google.com with SMTP id i39so59834qtb.1
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 16:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=CuMO8w3E3xYyZIyoaePiFMSHnlQSgOV2aS0NxjehVRI=;
        b=AKJhP/ubs/AT4LrmfQEFC8C0gIAEeqRuO6sq3gnDgJse7zxMgfqVBIY7Z4JLGGNdvi
         b1ziSM1gDwtwrLKQs8gLm2O4Q/zvqWHT4zvrg5FYA+YmHbaorIa5IQNsWPLURJnRk6ih
         NF0k9hwtqNe9RjRavUHKZASEhyS0XQsCDomJ7sMsCE9hr+p+iDL6MAZsq61LLT3Mplma
         qmCJQ4sINv3c7p++2JAMuNdNELTN+menL0ro5jxjiiv2d21XiW4n9yTyzdqHOVtqzoiW
         sckZUbdQEGqq/USFKD8psg7H4ewuj/wO81FqPb739NqzA7d8uRlzw9oZfpdYlOLiLq/1
         gJhg==
X-Gm-Message-State: AOAM533W9aY/BRS19PGqStAUsbfwaFUFinoom5PO5Pob4yBXmV8Z9snB
        4b3lEZ9x9uzcUhEIbQEvD5es95x2iLWkYY647nrbX1MG69ZplznF+I4+rF7JXr3Lf16N+SCtmHY
        hOY9mzRbQUu7kgZPecpokMPdOeccb
X-Received: by 2002:ad4:5808:: with SMTP id dd8mr144406qvb.58.1603149394720;
        Mon, 19 Oct 2020 16:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjUqcTB1Fq05W+CiAA+qg3TCAsHwa3i+Jm6B3teEMMC694tVC8X7gnewGQ6i8ZeOy0m687eg==
X-Received: by 2002:ad4:5808:: with SMTP id dd8mr144380qvb.58.1603149394421;
        Mon, 19 Oct 2020 16:16:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o193sm61858qke.12.2020.10.19.16.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:16:33 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality
 acquisition
In-reply-to: <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
Date:   Mon, 19 Oct 2020 16:16:32 -0700
Message-ID: <878sc1hkmn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

> The TPM TIS specification says the TPM signals the acquisition of
> locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
> TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check the
> former not the latter, so check both.  Adding the check on
> TPM_ACCESS_REQUEST_USE should fix the case where the locality is
> re-requested before the TPM has released it.  In this case the
> locality may get released briefly before it is reacquired, which
> causes all sorts of problems. However, with the added check,
> TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
> the locality is granted.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: added this patch
> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..f3ecde8df47d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -125,7 +125,8 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	if (rc < 0)
>  		return false;
>  
> -	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
> +	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID
> +		       | TPM_ACCESS_REQUEST_USE)) ==
>  	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
>  		priv->locality = l;
>  		return true;

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

