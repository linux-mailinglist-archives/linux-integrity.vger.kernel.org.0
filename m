Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489B21ABF2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 02:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgGJAW1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAW1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 20:22:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5FBC08C5DC
        for <linux-integrity@vger.kernel.org>; Thu,  9 Jul 2020 17:22:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so1715346pgk.4
        for <linux-integrity@vger.kernel.org>; Thu, 09 Jul 2020 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckUCzQFimvD7NIA+QWWbpWCLSB8Zqmc22c9Qilpan44=;
        b=ckgoHMtuW/ok71oWR0jOY1AL7WiG2m/KZ0cSVRSnnNLRJGV4T3oyqnZe4i6+5CiH6T
         ZUv0jWl8XzBU6YDr5Zat6lHWAaAMqb4UBToJjBPAwJSzaOjfQww1OsjiKl3BAS9eiUKv
         iWhKmfG3dMoPDC0aGyfFjaEzw5XakcyXRvrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckUCzQFimvD7NIA+QWWbpWCLSB8Zqmc22c9Qilpan44=;
        b=lj/GMhimBYl3TImoQZ9eEaxbZEzpH9ktO1qtP4ImDZg5eAvOOc0ckhpP9F4Wvk8mI5
         bj1ixiRplRp5ftVXQKAUO1YzW52y7Fv6XIWVvfdlRSvnlvvU1+jyLiIogRi6Ewk9aImO
         GVhltauEca77/q7+N61XGlPsYKM5khAv1nJPmSiYBMX+EMGMgVGj3865eal57GipzOK6
         xEETePJVBbb5G+nF+5wKGXCYQPXaI9xhRDzvqevwIN0eILqsp1jdrDKFVIirieG71Z78
         EgeibLwCBYwSTUrvSMyMhMlxLHaz43F0dTovzCAW+KEiGalAHwOzRUVRHzCPzXCAPGH6
         Y0oA==
X-Gm-Message-State: AOAM533hTQaFm7nk41Y6/gsT3pdtonqXw6v3VoGEljDR67ddzw/7/ZnO
        ZKg73mo2YTekV83PmUQG/T/kDg==
X-Google-Smtp-Source: ABdhPJyJ1Zl/XnIDYWubLFLNW5SV+UOx5qKUJXZPfzwDdsESHi5oJ223rZL0TXg/zVt4L12uoNyf4A==
X-Received: by 2002:a63:4c48:: with SMTP id m8mr57041634pgl.290.1594340546587;
        Thu, 09 Jul 2020 17:22:26 -0700 (PDT)
Received: from andrey-Z390.lan (c-67-164-102-32.hsd1.ca.comcast.net. [67.164.102.32])
        by smtp.gmail.com with ESMTPSA id i63sm3840181pfc.22.2020.07.09.17.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:22:26 -0700 (PDT)
From:   Andrey Pronin <apronin@chromium.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Andrey Pronin <apronin@chromium.org>
Subject: [PATCH] tpm: avoid accessing cleared ops during shutdown
Date:   Thu,  9 Jul 2020 17:22:09 -0700
Message-Id: <20200710002209.6757-1-apronin@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch prevents NULL dereferencing when using chip->ops while
sending TPM2_Shutdown command if both tpm_class_shutdown handler and
tpm_del_char_device are called during system shutdown.

Both these handlers set chip->ops to NULL but don't check if it's
already NULL when they are called before using it.

This issue was revealed in Chrome OS after a recent set of changes
to the unregister order for spi controllers, such as:
  b4c6230bb0ba spi: Fix controller unregister order
  f40913d2dca1 spi: pxa2xx: Fix controller unregister order
and similar for other controllers.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---
 drivers/char/tpm/tpm-chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8c77e88012e9..a410ca40a3c5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
 	down_write(&chip->ops_sem);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
@@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
 
 	/* Make the driver uncallable. */
 	down_write(&chip->ops_sem);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
-- 
2.25.1

