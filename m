Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3EA595C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 16:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfIBO1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 10:27:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbfIBO1w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 10:27:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8794930001EB;
        Mon,  2 Sep 2019 14:27:52 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-156.phx2.redhat.com [10.3.116.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C61760C18;
        Mon,  2 Sep 2019 14:27:52 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v4 3/3] tpm_tis: override durations for STM tpm with firmware 1.2.8.28
Date:   Mon,  2 Sep 2019 07:27:35 -0700
Message-Id: <20190902142735.6280-4-jsnitsel@redhat.com>
In-Reply-To: <20190902142735.6280-1-jsnitsel@redhat.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 02 Sep 2019 14:27:52 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There was revealed a bug in the STM TPM chipset used in Dell R415s.
Bug is observed so far only on chipset firmware 1.2.8.28
(1.2 TPM, device-id 0x0, rev-id 78). After some number of
operations chipset hangs and stays in inconsistent state:

tpm_tis 00:09: Operation Timed out
tpm_tis 00:09: tpm_transmit: tpm_send: error -5

Durations returned by the chip are the same like on other
firmware revisions but apparently with specifically 1.2.8.28 fw
durations should be reset to 2 minutes to enable tpm chip work
properly. No working way of updating firmware was found.

This patch adds implementation of ->update_durations method
that matches only STM devices with specific firmware version.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_tis_core.c | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c3181ea9f271..27c6ca031e23 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -506,6 +506,84 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return rc;
 }
 
+struct tis_vendor_durations_override {
+	u32 did_vid;
+	struct tpm1_version version;
+	unsigned long durations[3];
+};
+
+static const struct  tis_vendor_durations_override vendor_dur_overrides[] = {
+	/* STMicroelectronics 0x104a */
+	{ 0x0000104a,
+	  { 1, 2, 8, 28 },
+	  { (2 * 60 * HZ), (2 * 60 * HZ), (2 * 60 * HZ) } },
+};
+
+static void tpm_tis_update_durations(struct tpm_chip *chip,
+				     unsigned long *duration_cap)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	struct tpm1_version *version;
+	u32 did_vid;
+	int i, rc;
+	cap_t cap;
+
+	chip->duration_adjusted = false;
+
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
+	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
+	if (rc < 0) {
+		dev_warn(&chip->dev, "%s: failed to read did_vid. %d\n",
+			 __func__, rc);
+		goto out;
+	}
+
+	/* Try to get a TPM version 1.2 or 1.1 TPM_CAP_VERSION_INFO */
+	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+			 "attempting to determine the 1.2 version",
+			 sizeof(cap.version2));
+	if (!rc) {
+		version = &cap.version2.version;
+	} else {
+		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+				 "attempting to determine the 1.1 version",
+				 sizeof(cap.version1));
+
+		if (rc)
+			goto out;
+
+		version = &cap.version1;
+	}
+
+	for (i = 0; i != ARRAY_SIZE(vendor_dur_overrides); i++) {
+		if (vendor_dur_overrides[i].did_vid != did_vid)
+			continue;
+
+		if ((version->major ==
+		     vendor_dur_overrides[i].version.major) &&
+		    (version->minor ==
+		     vendor_dur_overrides[i].version.minor) &&
+		    (version->rev_major ==
+		     vendor_dur_overrides[i].version.rev_major) &&
+		    (version->rev_minor ==
+		     vendor_dur_overrides[i].version.rev_minor)) {
+
+			memcpy(duration_cap,
+			       vendor_dur_overrides[i].durations,
+			       sizeof(vendor_dur_overrides[i].durations));
+
+			chip->duration_adjusted = true;
+			goto out;
+		}
+	}
+
+out:
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+}
+
 struct tis_vendor_timeout_override {
 	u32 did_vid;
 	unsigned long timeout_us[4];
@@ -842,6 +920,7 @@ static const struct tpm_class_ops tpm_tis = {
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
 	.update_timeouts = tpm_tis_update_timeouts,
+	.update_durations = tpm_tis_update_durations,
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-- 
2.21.0

