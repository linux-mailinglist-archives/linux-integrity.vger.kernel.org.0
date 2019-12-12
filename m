Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95F11D69F
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfLLTCi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 14:02:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730168AbfLLTCh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 14:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576177356;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=XcFbRVCsyxHupHOtsNLBIA0LcJLABJSzMIEewCpz8m4=;
        b=Tx15YGPULV2Yl5WS33IR+LjeJrlxTp9N4aCvDMEFzTGaTdMZIkkukHdl35WDH9lOnZCW9G
        tR7EWPvWni9YlHt1bk6U3gj8wZmZ7TjsCWOJrpIiarvPc/WkSdaN0yespzE35fy+g/rN3D
        Sq8CE4DX3v4o9ilw6q4wmULzFIffasU=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-1qXGsd0vMHOqWkNXFrbrSA-1; Thu, 12 Dec 2019 14:02:35 -0500
X-MC-Unique: 1qXGsd0vMHOqWkNXFrbrSA-1
Received: by mail-yw1-f71.google.com with SMTP id j137so71616ywa.8
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 11:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=XcFbRVCsyxHupHOtsNLBIA0LcJLABJSzMIEewCpz8m4=;
        b=tq8wUAKhI1k81imBmcBxWWuuzs2BQhZpQKFkwBncevlmlt8P9iNuxvOSsRAUC+KK/h
         h4AmamVPRXrFMVvlkngVoQTVlQ6UQmwcE2if/8/EaoCOK87Z49mOqQZivvSU5O9P4GSf
         n3Q9OTUr8lWeBuqg/Ux4Zt3NcARNip4G4LydN/JJUOxEOkcZ5SfC9STLtyTeBIvgziSM
         S+BwuGY5ktXPlnti3NKSp6S1ZaLd8VTPuItGVb0jfmCr3AmGj8pB+JdyKfNGt/Vc95TR
         X7RxFKrykrWE/wChM4N66BDBeU+urFo5vo2Vpi4O1RfuMGk74WYOrxNfL5EUD62s30u2
         S31w==
X-Gm-Message-State: APjAAAVZZPdXbuPKeIIZpb3f4qSCBUu/H+w8WwggKHJbVi+x7CRgi6qQ
        p2oVZNCMQ/JYY+6wjtGKpedJiX56mO+K9FH7rK36Y/zPi9tfXtUD1BobDdtbyQ3VGvw4oYm+XAK
        ZrHtwFpcAdow09lqSDfWEcjmYon5V
X-Received: by 2002:a25:8001:: with SMTP id m1mr5136935ybk.362.1576177354556;
        Thu, 12 Dec 2019 11:02:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzouNjYUFmgPVvxvlvvL7zW40dcXVygGF5u3+d8h8FgVbxKbRiHMwK8i5hOgmYIwALpsIbCsg==
X-Received: by 2002:a25:8001:: with SMTP id m1mr5136905ybk.362.1576177354182;
        Thu, 12 Dec 2019 11:02:34 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a22sm2991450ywh.93.2019.12.12.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:02:33 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:02:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle flush
Message-ID: <20191212190221.yrwxchc6kuhfpjzb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1576173515.15886.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1576173515.15886.7.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Dec 12 19, James Bottomley wrote:
>The original code, before it was moved into security/keys/trusted-keys
>had a flush after the blob unseal.  Without that flush, the volatile
>handles increase in the TPM until it becomes unusable and the system
>either has to be rebooted or the TPM volatile area manually flushed.
>Fix by adding back the lost flush, which we now have to export because
>of the relocation of the trusted key code may cause the consumer to be
>modular.
>
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm.h                    | 1 -
> drivers/char/tpm/tpm2-cmd.c               | 1 +
> include/linux/tpm.h                       | 1 +
> security/keys/trusted-keys/trusted_tpm2.c | 1 +
> 4 files changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index b9e1547be6b5..5620747da0cf 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -218,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 		    struct tpm_digest *digests);
> int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>-void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
> 			u32 *value, const char *desc);
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index fdb457704aa7..13696deceae8 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -362,6 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
> 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> 	tpm_buf_destroy(&buf);
> }
>+EXPORT_SYMBOL_GPL(tpm2_flush_context);
>
> struct tpm2_get_cap_out {
> 	u8 more_data;
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 0d6e949ba315..03e9b184411b 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -403,6 +403,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
> extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
> extern struct tpm_chip *tpm_default_chip(void);
>+void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> #else
> static inline int tpm_is_tpm2(struct tpm_chip *chip)
> {
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index a9810ac2776f..08ec7f48f01d 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -309,6 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> 		return rc;
>
> 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
>+	tpm2_flush_context(chip, blob_handle);
>
> 	return rc;
> }
>-- 
>2.16.4
>

