Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B89F788
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH1Aqa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 20:46:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfH1Aq1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 20:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A76C85360;
        Wed, 28 Aug 2019 00:46:27 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-118-116.phx2.redhat.com [10.3.118.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D34B860923;
        Wed, 28 Aug 2019 00:46:26 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>
Subject: [PATCH 2/2 v2] tpm_tis: override durations for STM tpm with firmware 1.2.8.28
Date:   Tue, 27 Aug 2019 17:46:21 -0700
Message-Id: <20190828004621.29050-3-jsnitsel@redhat.com>
In-Reply-To: <20190828004621.29050-1-jsnitsel@redhat.com>
References: <20190828004621.29050-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 28 Aug 2019 00:46:27 +0000 (UTC)
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
---
v2: Make suggested changes from Jarkko
    - change struct field name to durations from durs
    - formatting cleanups
    - turn into void function like update_timeouts and
      use chip->duration_adjusted to track whether adjustment occurred.

 drivers/char/tpm/tpm_tis_core.c | 91 +++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c3181ea9f271..81b65ec2a41b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -506,6 +506,96 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return rc;
 }
 
+struct tis_vendor_durations_override {
+	u32 did_vid;
+	struct tpm_version_t tpm_version;
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
+	for (i = 0; i != ARRAY_SIZE(vendor_dur_overrides); i++) {
+		if (vendor_dur_overrides[i].did_vid != did_vid)
+			continue;
+
+		/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
+		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+				 "attempting to determine the 1.2 version",
+				 sizeof(cap.tpm_version_1_2));
+		if (!rc) {
+			if ((cap.tpm_version_1_2.Major ==
+			     vendor_dur_overrides[i].tpm_version.Major) &&
+			    (cap.tpm_version_1_2.Minor ==
+			     vendor_dur_overrides[i].tpm_version.Minor) &&
+			    (cap.tpm_version_1_2.revMajor ==
+			     vendor_dur_overrides[i].tpm_version.revMajor) &&
+			    (cap.tpm_version_1_2.revMinor ==
+			     vendor_dur_overrides[i].tpm_version.revMinor)) {
+
+				memcpy(duration_cap,
+				       vendor_dur_overrides[i].durations,
+				       sizeof(vendor_dur_overrides[i].durations));
+
+				chip->duration_adjusted = true;
+				goto out;
+			}
+		} else {
+			rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+					 "attempting to determine the 1.1 version",
+					 sizeof(cap.tpm_version));
+
+			if (rc)
+				goto out;
+
+			if ((cap.tpm_version.Major ==
+			     vendor_dur_overrides[i].tpm_version.Major) &&
+			    (cap.tpm_version.Minor ==
+			     vendor_dur_overrides[i].tpm_version.Minor) &&
+			    (cap.tpm_version.revMajor ==
+			     vendor_dur_overrides[i].tpm_version.revMajor) &&
+			    (cap.tpm_version.revMinor ==
+			     vendor_dur_overrides[i].tpm_version.revMinor)) {
+
+				memcpy(duration_cap,
+				       vendor_dur_overrides[i].durations,
+				       sizeof(vendor_dur_overrides[i].durations));
+
+				chip->duration_adjusted = true;
+				goto out;
+			}
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
@@ -842,6 +932,7 @@ static const struct tpm_class_ops tpm_tis = {
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
 	.update_timeouts = tpm_tis_update_timeouts,
+	.update_durations = tpm_tis_update_durations,
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-- 
2.21.0

