Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26D44A73
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfFMSKY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 14:10:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37165 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfFMSJe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so11486063pfa.4
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVbmGCXMlUq2A1hktcADs+0IfWfAQ2M2FW/CfDBhtLg=;
        b=FAbijmMdOArgULwBkXsBJp3YbUW1/Wrzaqs6dcYUYMl82wQ5JDMEWbDHYL6JEOFTK6
         3jUCluBlQdC0v3nbnxUgF8unfFjlPoH9r457SeTA879FsDsaanaiuHYZPar9Mowen66B
         eWsg52ZG0Viw9c+nueScpWKxFYh2vdQF+vZQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVbmGCXMlUq2A1hktcADs+0IfWfAQ2M2FW/CfDBhtLg=;
        b=bTLJsS9XdD7X5e4XCOaWU8oQf+B4v0WdygVtwHpI68FWWN7W1paqKf0an+8bROA8Qy
         EJ+Ev17ajXRYJ5OPesU4iyrq+NDk0qTX/PPHuhzkj665zcY+94rPdfQ2E3IUsLcnrRvd
         OcN4tDdZKwXG/bAJ2mk94zvXoTntaWZLhCIYkY/907VlfxPSANIMywL5vxzxsHLmTMJY
         XmZfl8AmYBBoje6ZoFYT3aChNf2jaHXaai211CxlnXQnX+GE8NjcMAuI/0akq5zVCzxc
         xW+PnE6VuWfcTPsLScFFHo5Jaha52FXCZcw8B5c1bPkCzvze+vjZw/iPJH8UoeY8CIZc
         /h5Q==
X-Gm-Message-State: APjAAAW5Q91/qV6azf2yo+fZC1LPo4by3ovdMGVaHtpBdlDmzTfFiQBv
        rFbUZ1ppqQX+t6+XoEId1Toz8Q==
X-Google-Smtp-Source: APXvYqyrMSrLzGbPNmpEqq+83phzC38yETj3P78gr8NXQrfb8K/U7PH0ROe9UTKCnF6fg+nejUXM+Q==
X-Received: by 2002:a63:6ec1:: with SMTP id j184mr15876956pgc.225.1560449373537;
        Thu, 13 Jun 2019 11:09:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/8] tpm: block messages while suspended
Date:   Thu, 13 Jun 2019 11:09:24 -0700
Message-Id: <20190613180931.65445-2-swboyd@chromium.org>
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

Other drivers or userspace may initiate sending a message to the tpm
while the device itself and the controller of the bus it is on are
suspended. That may break the bus driver logic.
Block sending messages while the device is suspended.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I don't think this was ever posted before.

 drivers/char/tpm/tpm-interface.c | 16 ++++++++++++++--
 include/linux/tpm.h              |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ae1030c9b086..7232527652e8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -86,6 +86,11 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
+	if (test_bit(0, &chip->is_suspended)) {
+		dev_warn(&chip->dev, "blocking transmit while suspended\n");
+		return -EAGAIN;
+	}
+
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
@@ -403,14 +408,19 @@ int tpm_pm_suspend(struct device *dev)
 		return 0;
 
 	if (!tpm_chip_start(chip)) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 			tpm2_shutdown(chip, TPM2_SU_STATE);
-		else
+			set_bit(0, &chip->is_suspended);
+		} else {
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+		}
 
 		tpm_chip_stop(chip);
 	}
 
+	if (!rc)
+		set_bit(0, &chip->is_suspended);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_suspend);
@@ -426,6 +436,8 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	clear_bit(0, &chip->is_suspended);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1b5436b213a2..48df005228d0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -132,6 +132,8 @@ struct tpm_chip {
 	int dev_num;		/* /dev/tpm# */
 	unsigned long is_open;	/* only one allowed */
 
+	unsigned long is_suspended;
+
 	char hwrng_name[64];
 	struct hwrng hwrng;
 
-- 
Sent by a computer through tubes

