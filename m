Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4CA595D
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfIBO1y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 10:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbfIBO1w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 10:27:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F88C3084288;
        Mon,  2 Sep 2019 14:27:52 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-156.phx2.redhat.com [10.3.116.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B01560C05;
        Mon,  2 Sep 2019 14:27:49 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v4 2/3] tpm: provide a way to override the chip returned durations
Date:   Mon,  2 Sep 2019 07:27:34 -0700
Message-Id: <20190902142735.6280-3-jsnitsel@redhat.com>
In-Reply-To: <20190902142735.6280-1-jsnitsel@redhat.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 02 Sep 2019 14:27:52 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Patch adds method ->update_durations to override returned
durations in case TPM chip misbehaves for TPM 1.2 drivers.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm1-cmd.c | 15 +++++++++++++++
 include/linux/tpm.h         |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 149e953ca369..ca7158fa6e6c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -343,6 +343,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 {
 	cap_t cap;
 	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
+	unsigned long durations[3];
 	ssize_t rc;
 
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
@@ -427,6 +428,20 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
 	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
 
+	/*
+	 * Provide the ability for vendor overrides of duration values in case
+	 * of misreporting.
+	 */
+	if (chip->ops->update_durations)
+		chip->ops->update_durations(chip, durations);
+
+	if (chip->duration_adjusted) {
+		dev_info(&chip->dev, HW_ERR "Adjusting reported durations.");
+		chip->duration[TPM_SHORT] = durations[0];
+		chip->duration[TPM_MEDIUM] = durations[1];
+		chip->duration[TPM_LONG] = durations[2];
+	}
+
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
 	 * value wrong and apparently reports msecs rather than usecs. So we
 	 * fix up the resulting too-small TPM_SHORT value to make things work.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..bb1d1ac7081d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -67,6 +67,8 @@ struct tpm_class_ops {
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
+	void (*update_durations)(struct tpm_chip *chip,
+				 unsigned long *duration_cap);
 	int (*go_idle)(struct tpm_chip *chip);
 	int (*cmd_ready)(struct tpm_chip *chip);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-- 
2.21.0

