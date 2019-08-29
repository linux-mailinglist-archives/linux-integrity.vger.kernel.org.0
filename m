Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046C8A29E6
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH2WlP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:41:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36709 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfH2WlP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3108260pfi.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+xDpWo2oT08ou9fvGrkptCYBMIqSmZRdTRAyh6265I=;
        b=liZn92iRtCafxnm52qeNdExgcny6TU1u8BfzV5SbncebW9Zp7PAUMB5kNXXd5NoEoR
         jk7PiECiUIWyLE/c1wwmK0muZVCqomh7tYbdyt2O4PbJDy8zvaWa/NPUbG9y6zvcxE8U
         r4G/RzPwc8GWBR6EqDGPEkTWhV/qVgllKnP1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+xDpWo2oT08ou9fvGrkptCYBMIqSmZRdTRAyh6265I=;
        b=Tx3hx/Pc5+Vtd8P6Kz7DxcMln0pixBV9hJR6XXNshRbW63jDv+2AT0XX+q2LTmcmQX
         X7L1Zc7wPYJbwTmDUfxk3ILnSPA6EOrwoA9CpVPDwdXId/VSO2zFx9quGSn65nEYDB9a
         mssRLowaid7r81GQmsTC97EaO1F2lTAx8Ir81YcuK1+/LuOFNMNw9pEhL6SF7ZMFhS/l
         fnU+mkp3RsbxU8qdRaRYZXmyGtbZOkoHnwgpW4tBpW6uvnQVhCb7s1/hEarwX5eESsz/
         4Cq6C6fuaPtNiC4F2YZ01eZfosN2h3+fCtmozcSgKSp/9k45Q+wYgGuNIE/BpaXVKkjm
         VPPA==
X-Gm-Message-State: APjAAAX2ZXBcmI3TxnjcmCDYTa+sxG+c5cB3klPf15Q2EmVfKBgVd0rK
        eQ3cajVwb1p2FYQiXotoSdLHzCsBfl+IsQ==
X-Google-Smtp-Source: APXvYqzrKxvRLxvbIrIWsf50Jck3LzdfxBPMdj+2uiy/N+MiCUddlCmdimSUnGa5yNW5HutPMZJyEQ==
X-Received: by 2002:a17:90b:8c1:: with SMTP id ds1mr12669187pjb.114.1567118474204;
        Thu, 29 Aug 2019 15:41:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q8sm3882531pjd.28.2019.08.29.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:41:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 2/4] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Thu, 29 Aug 2019 15:41:08 -0700
Message-Id: <20190829224110.91103-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190829224110.91103-1-swboyd@chromium.org>
References: <20190829224110.91103-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On some platforms, the TPM power is managed by firmware and therefore we
don't need to stop the TPM on suspend when going to a light version of
suspend such as S0ix ("freeze" suspend state). Add a chip flag,
TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED, to indicate this so that certain
platforms can probe for the usage of this light suspend and avoid
touching the TPM state across suspend/resume.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm-interface.c | 8 +++++++-
 drivers/char/tpm/tpm.h           | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..0b3def8e8186 100644
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
+	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
+	    !pm_suspend_via_firmware())
+		goto suspended;
 
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

