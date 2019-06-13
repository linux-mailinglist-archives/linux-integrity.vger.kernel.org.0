Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7044A57
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfFMSJp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 14:09:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfFMSJl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so3441649pls.6
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdCawkMT0anxJW8FSDZK6m/NJostd3XTSkOzgfPQn0Q=;
        b=mf5jaB7kX+XRVtnRvHZffXHsZAw7gJ6kkjtfXgdPXKTbY/WZISAN5HhkoRUYxrqVOz
         CIUmVOEmHGLJEeueaKOt+V8g/AwI/FqSKGjQ4vCa4h9ULh8uQprslzbr5s0hRGeLAN1N
         pK56wF3q2TA4A9DnlabXxMaG1pipZUkRFqrds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdCawkMT0anxJW8FSDZK6m/NJostd3XTSkOzgfPQn0Q=;
        b=iLGpyAWhQQBYjhdvjYd1FGx5anDwA6ldJX/fX44uoRML8TrW2D/plaIknWE4onQpyh
         eg8dZYTLNeZZEqlcDkJgljNF4V3GRND/1JKnROHv8nt83J7ipnZIpaCwGYZqIRuIdT2T
         AvnFdvB0zuG7KcZN4bcmNDq9zhcEto8Uui2g6i98bPcWKLN3vcdajNMoPgagkFNVMGuj
         5mMn/Ke6CkEfroS1vrv7oXa0wGd1NEbU0SHbI7VXUKYRPhhZa9sXMqhbuE9Sp4p1L8g5
         6mAf0MwJ/Ai3us8IlkMlKWpT+NnJoMM5soptMAjlxnhCMXJK/KUIa4r1QRAjWL9V1VRV
         NPgQ==
X-Gm-Message-State: APjAAAU6rxcaOaGh+byWz4bWHR+V35OSjQhV493eJlGjOpku+9xGbPqR
        hqUithSClkhzgOlD3N2AMFE6Fw==
X-Google-Smtp-Source: APXvYqw3skyj71cKVk7V0TEm8qi1kLdrqArdUhAr2oBHZ0u8bpdELGgi5uziIcTe0bxflQtpvA4PjA==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr52052469plb.164.1560449380605;
        Thu, 13 Jun 2019 11:09:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 8/8] tpm: add legacy sysfs attributes for tpm2
Date:   Thu, 13 Jun 2019 11:09:31 -0700
Message-Id: <20190613180931.65445-9-swboyd@chromium.org>
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

Userland scripts and tests rely on certain sysfs attributes
present in the familiar location:
/sys/class/tpm/tpm0/device/enabled
/sys/class/tpm/tpm0/device/owned

This change:
1) Adds two RO properties to sysfs for tpm in TPM2.0 case:
   - owned: set to 1 if storage hierarchy is enabled
     (TPMA_STARTUP_CLEAR.shEnable == 1)
   - enabled: set to 1 if an owner authorizaton is set
     (TPMA_PERMANENT.ownerAuthSet == 1)
2) Makes the sysfs attributes available at the legacy location:
   the attributes are now created under /sys/class/tpm/tpm0/,
   so symlinks are created in /sys/class/tpm/tpm0/device.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This probably isn't necessary, but it's sent so if anyone wants to test
out ChromeOS userspace they can easily do so. I believe Jason rejected
this in https://lkml.kernel.org/r/20160715032145.GE9347@obsidianresearch.com/

 drivers/char/tpm/tpm-chip.c  | 4 ++--
 drivers/char/tpm/tpm-sysfs.c | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8804c9e916fd..43f99f4c4c8a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -492,7 +492,7 @@ static void tpm_del_legacy_sysfs(struct tpm_chip *chip)
 {
 	struct attribute **i;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
 		return;
 
 	sysfs_remove_link(&chip->dev.parent->kobj, "ppi");
@@ -510,7 +510,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	struct attribute **i;
 	int rc;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
 		return 0;
 
 	rc = __compat_only_sysfs_link_entry_to_kobj(
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index e9f6f7960023..fe3683f82d48 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -413,6 +413,12 @@ TPM2_PROP_FLAG_ATTR(ph_enable_nv,
 TPM2_PROP_FLAG_ATTR(orderly,
 		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_ORDERLY);
 
+/* Aliases for userland scripts in TPM2 case */
+TPM2_PROP_FLAG_ATTR(enabled,
+		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_SH_ENABLE);
+TPM2_PROP_FLAG_ATTR(owned,
+		    TPM2_PT_PERMANENT, TPM2_ATTR_OWNER_AUTH_SET);
+
 TPM2_PROP_U32_ATTR(lockout_counter, TPM2_PT_LOCKOUT_COUNTER);
 TPM2_PROP_U32_ATTR(max_auth_fail, TPM2_PT_MAX_AUTH_FAIL);
 TPM2_PROP_U32_ATTR(lockout_interval, TPM2_PT_LOCKOUT_INTERVAL);
@@ -431,6 +437,8 @@ static struct attribute *tpm2_dev_attrs[] = {
 	ATTR_FOR_TPM2_PROP(eh_enable),
 	ATTR_FOR_TPM2_PROP(ph_enable_nv),
 	ATTR_FOR_TPM2_PROP(orderly),
+	ATTR_FOR_TPM2_PROP(enabled),
+	ATTR_FOR_TPM2_PROP(owned),
 	ATTR_FOR_TPM2_PROP(lockout_counter),
 	ATTR_FOR_TPM2_PROP(max_auth_fail),
 	ATTR_FOR_TPM2_PROP(lockout_interval),
-- 
Sent by a computer through tubes

