Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA620A779
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406464AbgFYV22 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:28:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406002AbgFYV2Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593120502;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=XdRozyo/0svGEFcBnlTxJ8HbbQTxqID+/mdnfnAHXus=;
        b=ZHPCAtaXYu6ixz2jzyAj57PkDw89RkNgkd2eMPUIDdPcHOi5i7OOx1XZ2yJ8pH7Ks5KZKR
        8oYPkG4B2A4K6os5Cl+kpu+J72WPULOwQ85ygOIM3j1Bf17iiseHdy0KNLEUxGpgMZbc86
        Sxbcjp4vzj/WlO9Pg+hXv1jqawtCiCo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-thBAMr8RMSmnzixNnfidvg-1; Thu, 25 Jun 2020 17:28:20 -0400
X-MC-Unique: thBAMr8RMSmnzixNnfidvg-1
Received: by mail-qv1-f71.google.com with SMTP id bk16so4969104qvb.11
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 14:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XdRozyo/0svGEFcBnlTxJ8HbbQTxqID+/mdnfnAHXus=;
        b=gyzTBa39w+k6zB1Qfb8Akk7fX7ui26NihShTgNry5FTZasq2i90YuMClHQPJkL9tFO
         ByjqhxjZNG3+ySgH/3wZAd3CB3yK89aOrngkKEeEnrcSNdWQJKWWS+o+i5CQh5o2N28z
         Q6z3yqJzcUxFTT+QN0AMnf0lfKkXa/z4ro3oePAGXF+cyuT+z2vVaU93ECb5MuN6YvtQ
         1d1hmB98uz7RfTT2BxXghPKUr9jMwLnCm/fxYPRFu5Nc2bI2RyPNg6ndMVfZVdbGG5sz
         9hYEIXJM6JVKmG885Fv+dLqmgSc1NY0/vRCYKAWS3oyKtHWyaoQAuGQixFoJprov116c
         VMXw==
X-Gm-Message-State: AOAM53103ORjfRtmQ6WC4mS/ZSvIcYOe8P1HZzzRxf9uyy8uJnZnihqL
        gxoHN5RlZfNWJ6lsUWc2ud4pm2Vd6Z4Hrjc1Slwd3luCsU0amv5lBQicAtZoAYauu3ni1mSKMYv
        9QiI2hVVqm4ab28PwtYncE0/3rTiC
X-Received: by 2002:ac8:4509:: with SMTP id q9mr12451258qtn.119.1593120499419;
        Thu, 25 Jun 2020 14:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4UH4iHak3pyUlph9dkPMRkxwYVcLk1fEm0mpzM6sv5K553h1VYnt4HMzAQ4YWX6c3qV0qLg==
X-Received: by 2002:ac8:4509:: with SMTP id q9mr12451234qtn.119.1593120499153;
        Thu, 25 Jun 2020 14:28:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n1sm7574274qtk.10.2020.06.25.14.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:28:18 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:28:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200625212817.rxzjsgecrfpcb6ph@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 25 20, Jarkko Sakkinen wrote:
>Re-allocate context and session buffers when needed. Scale them in page
>increments so that the reallocation is only seldomly required, and thus
>causes minimal stress to the system. Add a static maximum limit of four
>pages for buffer sizes.
>
>Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
>Tested only for compilation.
>v2: TPM2_SPACE_DEFAULT_BUFFER_SIZE
> drivers/char/tpm/tpm2-space.c | 87 ++++++++++++++++++++++++-----------
> include/linux/tpm.h           |  6 ++-
> 2 files changed, 64 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
>index 982d341d8837..b8ece01d6afb 100644
>--- a/drivers/char/tpm/tpm2-space.c
>+++ b/drivers/char/tpm/tpm2-space.c
>@@ -15,6 +15,9 @@
> #include <asm/unaligned.h>
> #include "tpm.h"
>
>+#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
>+#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
>+
> enum tpm2_handle_types {
> 	TPM2_HT_HMAC_SESSION	= 0x02000000,
> 	TPM2_HT_POLICY_SESSION	= 0x03000000,
>@@ -40,16 +43,21 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
>
> int tpm2_init_space(struct tpm_space *space)
> {
>-	space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
>+	space->context_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
>+				     GFP_KERNEL);
> 	if (!space->context_buf)
> 		return -ENOMEM;
>
>-	space->session_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
>+	space->session_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
>+				     GFP_KERNEL);
> 	if (space->session_buf == NULL) {
> 		kfree(space->context_buf);
>+		space->context_buf = NULL;
> 		return -ENOMEM;
> 	}
>
>+	space->context_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
>+	space->session_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
> 	return 0;
> }
>
>@@ -116,11 +124,13 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> 	return 0;
> }
>
>-static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>-			     unsigned int buf_size, unsigned int *offset)
>+static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 **buf,
>+			     unsigned int *buf_size, unsigned int *offset)
> {
>-	struct tpm_buf tbuf;
>+	unsigned int new_buf_size;
> 	unsigned int body_size;
>+	struct tpm_buf tbuf;
>+	void *new_buf;
> 	int rc;
>
> 	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
>@@ -131,31 +141,48 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>
> 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
> 	if (rc < 0) {
>-		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
>-			 __func__, rc);
>-		tpm_buf_destroy(&tbuf);
>-		return -EFAULT;
>+		rc = -EFAULT;
>+		goto err;
> 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
>-		tpm_buf_destroy(&tbuf);
>-		return -ENOENT;
>+		rc = -ENOENT;
>+		goto out;
> 	} else if (rc) {
>-		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
>-			 __func__, rc);
>-		tpm_buf_destroy(&tbuf);
>-		return -EFAULT;
>+		rc = -EFAULT;
>+		goto err;
> 	}
>

Would it be worthwhile to still output something here since it is changing
the value of rc returned from tpm_transmit_cmd()? Wondering if it would
be useful for debugging to know what the returned error was. Other than
that question looks good to me pending what is decided on using PAGE_SIZE.

Regards,
Jerry

> 	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
>-	if ((*offset + body_size) > buf_size) {
>-		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
>-		tpm_buf_destroy(&tbuf);
>-		return -ENOMEM;
>+	/* We grow the buffer in page increments. */
>+	new_buf_size = PFN_UP(*offset + body_size);
>+
>+	if (new_buf_size > TPM2_SPACE_MAX_BUFFER_SIZE) {
>+		rc = -ENOMEM;
>+		goto err;
> 	}
>
>-	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
>+	if (new_buf_size > *buf_size) {
>+		new_buf = krealloc(*buf, new_buf_size, GFP_KERNEL);
>+		if (!new_buf) {
>+			rc = -ENOMEM;
>+			goto err;
>+		}
>+
>+		*buf = new_buf;
>+		*buf_size = new_buf_size;
>+	}
>+
>+	memcpy(*buf + *offset, &tbuf.data[TPM_HEADER_SIZE], body_size);
> 	*offset += body_size;
>+
>+out:
> 	tpm_buf_destroy(&tbuf);
>-	return 0;
>+	return rc;
>+
>+err:
>+	dev_warn(&chip->dev, "%s: ret=%d\n", __func__, rc);
>+
>+	tpm_buf_destroy(&tbuf);
>+	return rc;
> }
>
> void tpm2_flush_space(struct tpm_chip *chip)
>@@ -311,8 +338,10 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
> 	       sizeof(space->context_tbl));
> 	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
> 	       sizeof(space->session_tbl));
>-	memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
>-	memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);
>+	memcpy(chip->work_space.context_buf, space->context_buf,
>+	       space->context_size);
>+	memcpy(chip->work_space.session_buf, space->session_buf,
>+	       space->session_size);
>
> 	rc = tpm2_load_space(chip);
> 	if (rc) {
>@@ -492,7 +521,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
> 			continue;
>
> 		rc = tpm2_save_context(chip, space->context_tbl[i],
>-				       space->context_buf, PAGE_SIZE,
>+				       &space->context_buf,
>+				       &space->context_size,
> 				       &offset);
> 		if (rc == -ENOENT) {
> 			space->context_tbl[i] = 0;
>@@ -509,7 +539,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
> 			continue;
>
> 		rc = tpm2_save_context(chip, space->session_tbl[i],
>-				       space->session_buf, PAGE_SIZE,
>+				       &space->session_buf,
>+				       &space->session_size,
> 				       &offset);
>
> 		if (rc == -ENOENT) {
>@@ -557,8 +588,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> 	       sizeof(space->context_tbl));
> 	memcpy(&space->session_tbl, &chip->work_space.session_tbl,
> 	       sizeof(space->session_tbl));
>-	memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
>-	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
>+	memcpy(space->context_buf, chip->work_space.context_buf,
>+	       space->context_size);
>+	memcpy(space->session_buf, chip->work_space.session_buf,
>+	       space->session_size);
>
> 	return 0;
> out:
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 03e9b184411b..9ea39e8f7162 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -92,10 +92,12 @@ enum tpm_duration {
> #define TPM_PPI_VERSION_LEN		3
>
> struct tpm_space {
>+	u8  *context_buf;
>+	u8  *session_buf;
>+	u32 context_size;
>+	u32 session_size;
> 	u32 context_tbl[3];
>-	u8 *context_buf;
> 	u32 session_tbl[3];
>-	u8 *session_buf;
> };
>
> struct tpm_bios_log {
>-- 
>2.25.1
>

