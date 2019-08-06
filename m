Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867FE83D32
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2019 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfHFWHx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 18:07:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40957 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfHFWHx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 18:07:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so42244351pfp.7
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yp39iSDiHsvaqQ+V6c31HHn1q9RV6+/SR9JS6bJ76M=;
        b=kmuoZfqWKtsBp3o3fVOVcDaWAuTSACpIL2N7EmKeieZgU8QkmSIhrTJGg0rinb9r0N
         E/Yt0MVNCPJUULHHl6++mKQo5yi9zD4YN7/XaMicDiYA7D1ANM3/7PoHvbyQclmerWCI
         +qyStL2BOUbneAx1vdDaYfQxMnv65Ek33I6s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yp39iSDiHsvaqQ+V6c31HHn1q9RV6+/SR9JS6bJ76M=;
        b=G/A0xUo8kTBoHI71A2KeJ+DQSSsNg8eprQ59AhdAF80V/pNfDgk+Tg4rVqzAiPcx4f
         LoUAcDjeaDL0Uqva4YGbnqSmcKcHynaGkU+yBhOkrMTz5XA7BAZcm3ezCa6BJrQkoRTF
         5J2OJvnHGZ/MEXRruxlnNCYUOQeBAm/3h+zQbch1+zl5aCF+CS0aXz/mNiYsoR/u8Eug
         KGq2wOq0QAWObxbzfq6y9oiYFIhl8saY15dppT2UXE2DiAXdMUAlBq7dkrQcvLmPwTPS
         nDMxd3RyBzMXXQFq0vOaITSPE/sH/5H8uxCfqpN5TlkhUZN0OBWMs0x/qjAmzhHTYr3i
         6wdQ==
X-Gm-Message-State: APjAAAW7jUfeZ+NfSdBuEsHFbEi6vE6Ynk/7GgX1cxyoV8xkC50gSpy1
        oK4sKXcKFsacxKmq/FHIJHFJLw==
X-Google-Smtp-Source: APXvYqx6lgCKd4PA8HLEjTxGg9c+g7VMEbw+wvSX0EcJ29Ge48iD0QDOl6YFqACwtwH+9oO/uNjTlA==
X-Received: by 2002:a17:90a:3548:: with SMTP id q66mr5343352pjb.17.1565129272895;
        Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p7sm98982509pfp.131.2019.08.06.15.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v3 1/4] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Tue,  6 Aug 2019 15:07:47 -0700
Message-Id: <20190806220750.86597-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190806220750.86597-1-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On some platforms, the TPM power is managed by firmware and therefore we
don't need to stop the TPM on suspend when going to a light version of
suspend such as S0ix ("freeze" suspend state). Add a chip flag to
indicate this so that certain platforms can probe for the usage of this
light suspend and avoid touching the TPM state across suspend/resume.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm-interface.c | 8 +++++++-
 drivers/char/tpm/tpm.h           | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..9bf3ddee6c8c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
 
@@ -395,7 +396,11 @@ int tpm_pm_suspend(struct device *dev)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
-		return 0;
+		goto suspended;
+
+	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED)
+		if (!pm_suspend_via_firmware())
+			goto suspended;
 
 	if (!tpm_chip_start(chip)) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -406,6 +411,7 @@ int tpm_pm_suspend(struct device *dev)
 		tpm_chip_stop(chip);
 	}
 
+suspended:
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_suspend);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39..28f73331aa2e 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -162,6 +162,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
 	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
Sent by a computer through tubes

