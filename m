Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8466A3B93
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH3QJH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 12:09:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfH3QJG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 12:09:06 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362A2970E2
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 16:09:06 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id z2so7860183qkf.2
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 09:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uMER6VkxPQYhKi/OQwHki0hPwLUf4iWX0DkiisKckaA=;
        b=Am0K/AAUzABZRWt9/lON0W8YEFBjh91T3fYjtFRmSOqFyTBg+dqaxSRNQe/VixeZFb
         e6Ur4OGsjDdt9V3n8CkXNkaIEHjsEfNkavJeS+UQasQkWAxLyQtP//jDq+LOPE5pb0Ny
         HsKzZVeChqSx/NO//HrTlLXGvIcXQyTiJV7tvSZmL0QyeNqoTPrhhOw9xqqx4hMXR65Y
         om2wIBrSm/pA4qpWZkniiQ71IXEFOuDRPSLUFdKIvmCD9VAz8C+NuWomHmN+/DhAPa/n
         cK780FL4mqdmspszqVvA+uFMcPE8NAfZJkGE+0qUCu985obRjOBlNKmX77IFfDfNcTMg
         aGgw==
X-Gm-Message-State: APjAAAVR6L63q5LiSuqL8EnaLmmWqTmuOH4I2O/8kAE4Gly4i+tVjSFO
        IUr5fMq+walClFCb4hGckWgR+jM5jc9oOF5gouJLXZeglVgu5q+6gUBDQa0u12lztoTseDIoMyN
        EedF6aTLw9f3NUz+low8KdiTyWtU0
X-Received: by 2002:ac8:3525:: with SMTP id y34mr6618246qtb.140.1567181345499;
        Fri, 30 Aug 2019 09:09:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO7CrM9ykz1tnwBIhlgh637Q2EDJz8NrJCLBv0bo7Kj+zkwWvlY5SwsmvjF8h37LOJohCSng==
X-Received: by 2002:ac8:3525:: with SMTP id y34mr6618223qtb.140.1567181345241;
        Fri, 30 Aug 2019 09:09:05 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q62sm3211852qkb.69.2019.08.30.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:09:04 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:09:02 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Remove duplicate code from caps_show() in
 tpm-sysfs.c
Message-ID: <20190830160902.iip5jr4yiqcjpz45@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190829143807.30647-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829143807.30647-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 29 19, Jarkko Sakkinen wrote:
>Replace existing TPM 1.x version structs with new structs that consolidate
>the common parts into a single struct so that code duplication is no longer
>needed in caps_show().
>
>Cc: Alexey Klimov <aklimov@redhat.com>
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
>Jerry, Alexey: Plese include this to the next version of your patches.
>This a low priority patch alone so it does not need to be merge upfront.
> drivers/char/tpm/tpm-sysfs.c | 44 ++++++++++++++++++------------------
> drivers/char/tpm/tpm.h       | 23 ++++++++-----------
> 2 files changed, 32 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>index edfa89160010..8064fea2de59 100644
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

Actually looking at this again, this seems wrong. The version assignment here should be below this if, or in an else block, yes?

>+		goto out_ops;
>+	}
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
>2.20.1
>
