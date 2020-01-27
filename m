Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5E14AB4A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0Utt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 15:49:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgA0Utt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 15:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580158188;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=eOdBLphukmJU4mzfUFyXShD49tL7waQ2ooxqyy/1xSY=;
        b=O0Og5NkHyVdIpzAbXWSfuqtM3iJLfeIBFKw7zgR7e0vsjK9b44vJIFZ8DOJm6sSTPD1ABG
        xhUmLrovENq0p6WsOIPwBw3ebL0vpMwJ4yoZ1bUJmE+VVX72Z0UiFAZPtwAqjrdDQMa12i
        EnpE0y3fNPRsveaqGzTepmJuPRaa/Ts=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-lqmo9Sj5MGCLO9t9QaQ5KA-1; Mon, 27 Jan 2020 15:49:44 -0500
X-MC-Unique: lqmo9Sj5MGCLO9t9QaQ5KA-1
Received: by mail-yw1-f71.google.com with SMTP id p193so8787349ywp.16
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 12:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eOdBLphukmJU4mzfUFyXShD49tL7waQ2ooxqyy/1xSY=;
        b=E7XfKMI/q12IcQ3vDVwkHuV5KUZMJ6EylJaqKuK8OrqHk4AXzZIw626Gy9B2cPMsXE
         hSG3/MiEcfBUk2uf43tCuNUqFQ097JdVXqPCWXQ5cjxL/rm/L+DvASFCgCKA2aOM/78r
         fmVTfVQ+xbkQNRiQF8ofignvm9oS0oLCTFlWKqu0hJZEPamucvf8G9rzaD87AxOypRhs
         Z89SyldWpA/zj5Y1iE502fckpeTK6pAj0Komhb+nqX1yOPdlIBhZhLXpEXWB0JhVSu1B
         XsMQyRFD4wiv9f1v4qs68fnTDfBzQYsbT32Q+0uya3NwKIDTPt610g2oYLtJ4twKD7QB
         hUmQ==
X-Gm-Message-State: APjAAAVvujRhHuyHtT5R4hYrzv76Y9XzsZ7DL1O7sLhqWlW2h1D0WwyH
        Tm9HITzAgwyD85/C5cxuq0BP0og9f41n4vhyDREfzeO4hSrXUosoiDjPejW2NUF1mXhi1txMdgg
        5FcirJ8hLCS1q1RxOKU77JEn7MWdR
X-Received: by 2002:a81:6d13:: with SMTP id i19mr13118084ywc.461.1580158184072;
        Mon, 27 Jan 2020 12:49:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIxgvudpxq5FJW0DOdzpF/weeH63baE9/zI41VqoRhfH8WAhIODUXGb9+7F2QnEZEwxlEdeQ==
X-Received: by 2002:a81:6d13:: with SMTP id i19mr13118074ywc.461.1580158183807;
        Mon, 27 Jan 2020 12:49:43 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n1sm7173736ywe.78.2020.01.27.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 12:49:43 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:49:41 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Message-ID: <20200127204941.2ewman4y5nzvkjqe@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jan 27 20, Mimi Zohar wrote:
>The boot aggregate is a cumulative SHA1 hash over TPM registers 0 - 7.
>NIST has depreciated the usage of SHA1 in most instances.  Instead of
>continuing to use SHA1 to calculate the boot_aggregate, use the
>configured IMA default hash algorithm.
>
>Although the IMA measurement list boot_aggregate template data contains
>the hash algorithm followed by the digest, allowing verifiers (e.g.
>attesttaion servers) to calculate and verify the boot_aggregate, the
>verifiers might not have the knowledge of what constitutes a good value
>based on a different hash algorithm.
>
>Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>---
> security/integrity/ima/ima_init.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
>index 195cb4079b2b..b1b334fe0db5 100644
>--- a/security/integrity/ima/ima_init.c
>+++ b/security/integrity/ima/ima_init.c
>@@ -27,7 +27,7 @@ struct tpm_chip *ima_tpm_chip;
> /* Add the boot aggregate to the IMA measurement list and extend
>  * the PCR register.
>  *
>- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
>+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
>  * assuming a TPM chip exists, and zeroes if the TPM chip does not
>  * exist.  Add the boot aggregate measurement to the measurement
>  * list and extend the PCR register.
>@@ -51,14 +51,14 @@ static int __init ima_add_boot_aggregate(void)
> 	int violation = 0;
> 	struct {
> 		struct ima_digest_data hdr;
>-		char digest[TPM_DIGEST_SIZE];
>+		char digest[TPM_MAX_DIGEST_SIZE];
> 	} hash;
>
> 	memset(iint, 0, sizeof(*iint));
> 	memset(&hash, 0, sizeof(hash));
> 	iint->ima_hash = &hash.hdr;
>-	iint->ima_hash->algo = HASH_ALGO_SHA1;
>-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
>+	iint->ima_hash->algo = ima_hash_algo;
>+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
>
> 	if (ima_tpm_chip) {
> 		result = ima_calc_boot_aggregate(&hash.hdr);
>-- 
>2.7.5
>

Tested the patches on the Dell and no longer spits out the error messages on boot.
/sys/kernel/security/ima/ascii_runtime_measurements shows the boot aggregate.

Is there something else I should look at to verify it is functioning properly?

Regards,
Jerry

