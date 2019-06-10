Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AAC3BF10
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfFJWBr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jun 2019 18:01:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41551 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfFJWBq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jun 2019 18:01:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so5727925pgg.8
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jun 2019 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LW8NlLySeRobf2Ci7HrTXkKdA8X2Rlykte27NhFtAPM=;
        b=Kc5jwzAtTkGRKlstomNioaLlQ8J9mk8zkp5jLofb9ds2NEOxowbB/Yj9N9oCRokEGi
         kjyG9XuTfOcfr3i9YzvY3g4TV22KQjxGIT4JxrRc3lGLcmlciBmsEqG5Bwaqhc3zyGpU
         uAN/pDTYnp07GWZaAk1DT3YROR6eL/qD1kD8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LW8NlLySeRobf2Ci7HrTXkKdA8X2Rlykte27NhFtAPM=;
        b=IRzTwmJ4ruNW9PFMfVwV7NtQUI+DbZRQbEYf81Dcnbf5qkCxAVpWAeOHaz5hgHR5/G
         3uhyOv858R0mVtIsDRn4iXVF6PW8HuGVrNgmlwSwazzci/LvdsPsbfMxmhE4OlvVtaOc
         BU0TGeOAwpoJatNPgyHtXp2tYX2ytyXvTZhM+CAJF6SuokNClIfxVKUONlMgUh+XQBPm
         mBZI5Oip7XZVppgm6jn3mU2qWESPAqMRbbZ1DQrHs3kiMnk+dlkO7SCo6JQ38REHbFoC
         l1ipYMzeN0CeEpbZH/6XJ3R+58FKKf0gOdezaV3Eg/FXd9FQgkJXr8TPBWWPMI84jtzt
         BxWA==
X-Gm-Message-State: APjAAAWUoh8KrhxjavZ2tHvteIdPlxLwiRb6dWE4C/P75GTcSh6WVJl5
        nwEEidVzd4PU9qkKjweaSY/qdg==
X-Google-Smtp-Source: APXvYqxUuLi8u3xAFJfZU+6XKRwyLqRF6/SeEB3k4EL3uemfhDVPFi1PaYsXAtwRciV4o1p3pnpfxA==
X-Received: by 2002:a62:d0:: with SMTP id 199mr45569170pfa.253.1560204106256;
        Mon, 10 Jun 2019 15:01:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s5sm403489pji.9.2019.06.10.15.01.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 15:01:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     groeck@chromium.org, Vadim Sukhomlinov <sukhomlinov@google.com>,
        apronin@chromium.org, mka@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Mon, 10 Jun 2019 15:01:18 -0700
Message-Id: <20190610220118.5530-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vadim Sukhomlinov <sukhomlinov@google.com>

TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
future TPM operations. TPM 1.2 behavior was different, future TPM
operations weren't disabled, causing rare issues. This patch ensures
that future TPM operations are disabled.

Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
[dianders: resolved merge conflicts with mainline]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/char/tpm/tpm-chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8804c9e916fd..f566fa8bf704 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -294,15 +294,15 @@ static int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		down_write(&chip->ops_sem);
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
-		chip->ops = NULL;
-		up_write(&chip->ops_sem);
 	}
+	chip->ops = NULL;
+	up_write(&chip->ops_sem);
 
 	return 0;
 }
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

