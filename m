Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B057844A61
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 20:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFMSJz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 14:09:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37434 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfFMSJk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so11410596pgr.4
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdHyfYYn/P4YZ/RY4FqzRUe6FdwH0FXQqSlsB54SdhY=;
        b=WYm1N50KkVbQ5oT/ljoGPabfESnEJECE/hUI8KAmJ52KpqVAT/LLwvqct6C+GrUUFV
         xGfAKhX7xvxvArrasgYG7lSbSUnZfhWuPnwumkSl3hCjfy/cT75ahjwg9TIaNhNh7d0R
         XHgZyIq1/aYzI4+WHrGxXC6bU+XUBZNlojFWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdHyfYYn/P4YZ/RY4FqzRUe6FdwH0FXQqSlsB54SdhY=;
        b=E3CyKCBHD7QQNPXG/ulH7EgjvgG3dxKrnfZJ4OOWf+dqsqGVJ44mO506cGZ4VZ4qDw
         MWmmjcO9WSMSexJZvj/XWedgyBrKWSpn/5k0iplYlKTQejk6fHjxcrPqMzyl1F94Js6s
         z1gw9adqZXgTyTv7V4XapmDmpmok3GwevyYTE4FPTZGVUwuO67oVxotAKXO0FvA4hXP4
         I3WLyq6ry3kP+UDTmb3eXVx8KMtkt8J0FFDV+pg6E9nD5VQgSMxMKxg1n+D4h1m5zE04
         zxHmEC0NOugOhJmZayGE2ad/o8LrbGU4+isJBFhx3JqftVwYeLxOke9EmYBRQeqveUrl
         uyTg==
X-Gm-Message-State: APjAAAU93ZpPNQFKJkpGxYGq9iM0d81IOTqTgYD4kQtGZ4EUNefOVK+9
        2WiLZw5VXfaOGHc7xSeCMSU8Pg==
X-Google-Smtp-Source: APXvYqx83m0afnXdbmnktD4D4EiOaZOLzkVkSr8j7uRxRoq8GiaJY0+e8vRFGMgLniHvm9DvfV1aiQ==
X-Received: by 2002:a63:f70b:: with SMTP id x11mr907761pgh.212.1560449379638;
        Thu, 13 Jun 2019 11:09:39 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:39 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 7/8] tpm: add sysfs attributes for tpm2
Date:   Thu, 13 Jun 2019 11:09:30 -0700
Message-Id: <20190613180931.65445-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613180931.65445-1-swboyd@chromium.org>
References: <20190613180931.65445-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add sysfs attributes in TPM2.0 case for:
 - TPM_PT_PERMANENT flags
 - TPM_PT_STARTUP_CLEAR flags
 - lockout-related properties

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This was sent before as https://lkml.kernel.org/r/1469678766-117528-1-git-send-email-apronin@chromium.org
and Jarkko asked that the commit text be filled out more. I'll work with
Andrey to do so, but I'm including it here so we can see if there are
other comments.

 drivers/char/tpm/tpm-sysfs.c | 130 ++++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm.h       |  29 +++++++-
 2 files changed, 148 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 533a260d744e..e9f6f7960023 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -314,7 +314,7 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
 
-static struct attribute *tpm_dev_attrs[] = {
+static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
 	&dev_attr_enabled.attr,
@@ -328,22 +328,132 @@ static struct attribute *tpm_dev_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group tpm_dev_group = {
-	.attrs = tpm_dev_attrs,
+static const struct attribute_group tpm1_dev_group = {
+	.attrs = tpm1_dev_attrs,
 };
 
-void tpm_sysfs_add_device(struct tpm_chip *chip)
+struct tpm2_prop_flag_dev_attribute {
+	struct device_attribute attr;
+	u32 property_id;
+	u32 flag_mask;
+};
+
+struct tpm2_prop_u32_dev_attribute {
+	struct device_attribute attr;
+	u32 property_id;
+};
+
+static ssize_t tpm2_prop_flag_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
-	/* XXX: If you wish to remove this restriction, you must first update
-	 * tpm_sysfs to explicitly lock chip->ops.
-	 */
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return;
+	struct tpm2_prop_flag_dev_attribute *pa =
+		container_of(attr, struct tpm2_prop_flag_dev_attribute, attr);
+	u32 flags;
+	ssize_t rc;
+
+	rc = tpm2_get_tpm_pt(to_tpm_chip(dev), pa->property_id, &flags,
+			     "reading property");
+	if (rc)
+		return 0;
+
+	return sprintf(buf, "%d\n", !!(flags & pa->flag_mask));
+}
+
+static ssize_t tpm2_prop_u32_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpm2_prop_u32_dev_attribute *pa =
+		container_of(attr, struct tpm2_prop_u32_dev_attribute, attr);
+	u32 value;
+	ssize_t rc;
+
+	rc = tpm2_get_tpm_pt(to_tpm_chip(dev), pa->property_id, &value,
+			     "reading property");
+	if (rc)
+		return 0;
+
+	return sprintf(buf, "%u\n", value);
+}
 
+#define TPM2_PROP_FLAG_ATTR(_name, _property_id, _flag_mask)           \
+	struct tpm2_prop_flag_dev_attribute attr_tpm2_prop_##_name = { \
+		__ATTR(_name, S_IRUGO, tpm2_prop_flag_show, NULL),     \
+		_property_id, _flag_mask                               \
+	}
+
+#define TPM2_PROP_U32_ATTR(_name, _property_id)                        \
+	struct tpm2_prop_u32_dev_attribute attr_tpm2_prop_##_name = {  \
+		__ATTR(_name, S_IRUGO, tpm2_prop_u32_show, NULL),      \
+		_property_id                                           \
+	}
+
+TPM2_PROP_FLAG_ATTR(owner_auth_set,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_OWNER_AUTH_SET);
+TPM2_PROP_FLAG_ATTR(endorsement_auth_set,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_ENDORSEMENT_AUTH_SET);
+TPM2_PROP_FLAG_ATTR(lockout_auth_set,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_LOCKOUT_AUTH_SET);
+TPM2_PROP_FLAG_ATTR(disable_clear,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_DISABLE_CLEAR);
+TPM2_PROP_FLAG_ATTR(in_lockout,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_IN_LOCKOUT);
+TPM2_PROP_FLAG_ATTR(tpm_generated_eps,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_TPM_GENERATED_EPS);
+
+TPM2_PROP_FLAG_ATTR(ph_enable,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_PH_ENABLE);
+TPM2_PROP_FLAG_ATTR(sh_enable,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_SH_ENABLE);
+TPM2_PROP_FLAG_ATTR(eh_enable,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_EH_ENABLE);
+TPM2_PROP_FLAG_ATTR(ph_enable_nv,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_PH_ENABLE_NV);
+TPM2_PROP_FLAG_ATTR(orderly,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_ORDERLY);
+
+TPM2_PROP_U32_ATTR(lockout_counter, TPM2_PT_LOCKOUT_COUNTER);
+TPM2_PROP_U32_ATTR(max_auth_fail, TPM2_PT_MAX_AUTH_FAIL);
+TPM2_PROP_U32_ATTR(lockout_interval, TPM2_PT_LOCKOUT_INTERVAL);
+TPM2_PROP_U32_ATTR(lockout_recovery, TPM2_PT_LOCKOUT_RECOVERY);
+
+#define ATTR_FOR_TPM2_PROP(_name) (&attr_tpm2_prop_##_name.attr.attr)
+static struct attribute *tpm2_dev_attrs[] = {
+	ATTR_FOR_TPM2_PROP(owner_auth_set),
+	ATTR_FOR_TPM2_PROP(endorsement_auth_set),
+	ATTR_FOR_TPM2_PROP(lockout_auth_set),
+	ATTR_FOR_TPM2_PROP(disable_clear),
+	ATTR_FOR_TPM2_PROP(in_lockout),
+	ATTR_FOR_TPM2_PROP(tpm_generated_eps),
+	ATTR_FOR_TPM2_PROP(ph_enable),
+	ATTR_FOR_TPM2_PROP(sh_enable),
+	ATTR_FOR_TPM2_PROP(eh_enable),
+	ATTR_FOR_TPM2_PROP(ph_enable_nv),
+	ATTR_FOR_TPM2_PROP(orderly),
+	ATTR_FOR_TPM2_PROP(lockout_counter),
+	ATTR_FOR_TPM2_PROP(max_auth_fail),
+	ATTR_FOR_TPM2_PROP(lockout_interval),
+	ATTR_FOR_TPM2_PROP(lockout_recovery),
+	&dev_attr_durations.attr,
+	&dev_attr_timeouts.attr,
+	NULL,
+};
+
+static const struct attribute_group tpm2_dev_group = {
+	.attrs = tpm2_dev_attrs,
+};
+
+void tpm_sysfs_add_device(struct tpm_chip *chip)
+{
 	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
 	 * is called before ops is null'd and the sysfs core synchronizes this
 	 * removal so that no callbacks are running or can run again
 	 */
+	/* FIXME: update tpm_sysfs to explicitly lock chip->ops for TPM 2.0
+	 */
 	WARN_ON(chip->groups_cnt != 0);
-	chip->groups[chip->groups_cnt++] = &tpm_dev_group;
+	chip->groups[chip->groups_cnt++] =
+		(chip->flags & TPM_CHIP_FLAG_TPM2) ?
+		&tpm2_dev_group : &tpm1_dev_group;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2cce072f25b5..c58140f86839 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -144,7 +144,34 @@ enum tpm2_capabilities {
 };
 
 enum tpm2_properties {
-	TPM_PT_TOTAL_COMMANDS	= 0x0129,
+	TPM_PT_TOTAL_COMMANDS		= 0x0129,
+	TPM2_PT_NONE			= 0,
+	TPM2_PT_GROUP			= 0x100,
+	TPM2_PT_FIXED			= TPM2_PT_GROUP,
+	TPM2_PT_VAR			= TPM2_PT_GROUP * 2,
+	TPM2_PT_PERMANENT		= TPM2_PT_VAR + 0,
+	TPM2_PT_STARTUP_CLEAR		= TPM2_PT_VAR + 1,
+	TPM2_PT_LOCKOUT_COUNTER		= TPM2_PT_VAR + 14,
+	TPM2_PT_MAX_AUTH_FAIL		= TPM2_PT_VAR + 15,
+	TPM2_PT_LOCKOUT_INTERVAL	= TPM2_PT_VAR + 16,
+	TPM2_PT_LOCKOUT_RECOVERY	= TPM2_PT_VAR + 17,
+};
+
+enum tpm2_attr_permanent {
+	TPM2_ATTR_OWNER_AUTH_SET	= BIT(0),
+	TPM2_ATTR_ENDORSEMENT_AUTH_SET	= BIT(1),
+	TPM2_ATTR_LOCKOUT_AUTH_SET	= BIT(2),
+	TPM2_ATTR_DISABLE_CLEAR		= BIT(8),
+	TPM2_ATTR_IN_LOCKOUT		= BIT(9),
+	TPM2_ATTR_TPM_GENERATED_EPS	= BIT(10),
+};
+
+enum tpm2_attr_startup_clear {
+	TPM2_ATTR_PH_ENABLE		= BIT(0),
+	TPM2_ATTR_SH_ENABLE		= BIT(1),
+	TPM2_ATTR_EH_ENABLE		= BIT(2),
+	TPM2_ATTR_PH_ENABLE_NV		= BIT(3),
+	TPM2_ATTR_ORDERLY		= BIT(31),
 };
 
 enum tpm2_startup_types {
-- 
Sent by a computer through tubes

