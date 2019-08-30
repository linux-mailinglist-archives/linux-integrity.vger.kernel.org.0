Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C95A4002
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3Vya (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 17:54:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22491 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfH3Vy3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 17:54:29 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 256D87BDB7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 21:54:28 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id t6so164983qkm.7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 14:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=l8M5VfLTIyhXhOjqX9IRgwW1sSZJqUoGoJtW856hZPA=;
        b=L0+zBUBP/6jo+w8YzGKEGbFUtM5uwVAADrsZcIusfj7SxDtGKlTmVqWG7DGVNAInK2
         f1OnEHTckQLJnjFHEJAzRO1D5a0uoIiP55tEXkrheKWGWSCjWP4IxaGRrIE6Q1Nu3GX+
         7QsYLTRyGYpSsku1bizOj0pJmLzCxIYpZqQv/3cMZpZFENHfBrfdVKZXZP6+a4Gbelny
         KjLviuulkmNaBS29AFr4d/ldpGmJkyMQhI4D70UEF7vGu04vWzP8HDifCiV7EQicjSgZ
         9jX5bGVYCpDkvxl5NOKLrKkkNPBlpErIH5W9+Qb1BmB3Vj7PuA+vnz4VLJHz1mRzP2cy
         yhDw==
X-Gm-Message-State: APjAAAV/aB3h2DlkG+VvmC0sHSvbXzArJDg4YAt3kiqsHpsPKDJjUXgL
        m3CBHkoaJnx447PBOV8xebgP1QULvHc5Od+MUftl79IrNQCv/70lA+3cG8RK3o8KZJm+KbItntP
        hh58YF5oIBZltLb/i3HG97SMhghdA
X-Received: by 2002:ac8:845:: with SMTP id x5mr5146544qth.42.1567202067271;
        Fri, 30 Aug 2019 14:54:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4x7u2LiB6BsuBK15nT/Qv1VARIboK0aXL2heo/OgMEZUiGDq1Iqk3Kl9PkTRNGlpFH3BAIw==
X-Received: by 2002:ac8:845:: with SMTP id x5mr5146526qth.42.1567202067039;
        Fri, 30 Aug 2019 14:54:27 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d25sm3190290qtn.51.2019.08.30.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:54:26 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:54:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/3 v3] tpm: Remove duplicate code from caps_show() in
 tpm-sysfs.c
Message-ID: <20190830215424.4wahtwvbqx4fakso@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190829204947.2591-1-jsnitsel@redhat.com>
 <20190829204947.2591-2-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829204947.2591-2-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 29 19, Jerry Snitselaar wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>Replace existing TPM 1.x version structs with new structs that consolidate
>the common parts into a single struct so that code duplication is no longer
>needed in caps_show().
>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Alexey Klimov <aklimov@redhat.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/char/tpm/tpm-sysfs.c | 44 ++++++++++++++++++------------------
> drivers/char/tpm/tpm.h       | 23 ++++++++-----------
> 2 files changed, 32 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>index d9caedda075b..e0550f0cfd8f 100644
>--- a/drivers/char/tpm/tpm-sysfs.c
>+++ b/drivers/char/tpm/tpm-sysfs.c
>@@ -217,6 +217,7 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
> 			 char *buf)
> {
> 	struct tpm_chip *chip = to_tpm_chip(dev);
>+	struct tpm1_version *version;
> 	ssize_t rc = 0;
> 	char *str = buf;
> 	cap_t cap;
>@@ -232,31 +233,30 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
> 	str += sprintf(str, "Manufacturer: 0x%x\n",
> 		       be32_to_cpu(cap.manufacturer_id));
>
>-	/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
>-	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
>+	/* TPM 1.2 */
>+	if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
> 			 "attempting to determine the 1.2 version",
>-			 sizeof(cap.tpm_version_1_2));
>-	if (!rc) {
>-		str += sprintf(str,
>-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>-			       cap.tpm_version_1_2.Major,
>-			       cap.tpm_version_1_2.Minor,
>-			       cap.tpm_version_1_2.revMajor,
>-			       cap.tpm_version_1_2.revMinor);
>-	} else {
>-		/* Otherwise just use TPM_STRUCT_VER */
>-		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
>-				"attempting to determine the 1.1 version",
>-				sizeof(cap.tpm_version)))
>-			goto out_ops;
>-		str += sprintf(str,
>-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>-			       cap.tpm_version.Major,
>-			       cap.tpm_version.Minor,
>-			       cap.tpm_version.revMajor,
>-			       cap.tpm_version.revMinor);
>+			 sizeof(cap.version2))) {
>+		version = &cap.version2.version;
>+		goto out_print;
> 	}
>+
>+	/* TPM 1.1 */
>+	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
>+			"attempting to determine the 1.1 version",
>+			sizeof(cap.version1))) {
>+		version = &cap.version1;
>+		goto out_ops;
>+	}

Jarkko, does the following change to the above block look good? I'll
submit a v4. With the current patch it is setting version when the
tpm1_getcap fails for 1.1 instead of when it succeeds. I only have
1.2 and 2.0 devices, so I didn't hit it when testing your patch.

+	/* TPM 1.1 */
+	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+			"attempting to determine the 1.1 version",
+			sizeof(cap.version1)))
+		goto out_ops;
+
+	version = &cap.version1;


>+
>+out_print:
>+	str += sprintf(str,
>+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>+		       version->major, version->minor,
>+		       version->rev_major, version->rev_minor);
>+
> 	rc = str - buf;
>+
> out_ops:
> 	tpm_put_ops(chip);
> 	return rc;
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index a7fea3e0ca86..a4f74dd02a35 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -186,19 +186,16 @@ struct	stclear_flags_t {
> 	u8	bGlobalLock;
> } __packed;
>
>-struct	tpm_version_t {
>-	u8	Major;
>-	u8	Minor;
>-	u8	revMajor;
>-	u8	revMinor;
>+struct tpm1_version {
>+	u8 major;
>+	u8 minor;
>+	u8 rev_major;
>+	u8 rev_minor;
> } __packed;
>
>-struct	tpm_version_1_2_t {
>-	__be16	tag;
>-	u8	Major;
>-	u8	Minor;
>-	u8	revMajor;
>-	u8	revMinor;
>+struct tpm1_version2 {
>+	__be16 tag;
>+	struct tpm1_version version;
> } __packed;
>
> struct	timeout_t {
>@@ -243,8 +240,8 @@ typedef union {
> 	struct	stclear_flags_t	stclear_flags;
> 	__u8	owned;
> 	__be32	num_pcrs;
>-	struct	tpm_version_t	tpm_version;
>-	struct	tpm_version_1_2_t tpm_version_1_2;
>+	struct tpm1_version version1;
>+	struct tpm1_version2 version2;
> 	__be32	manufacturer_id;
> 	struct timeout_t  timeout;
> 	struct duration_t duration;
>-- 
>2.21.0
>
