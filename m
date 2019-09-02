Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3287A595A
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfIBO1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 10:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbfIBO1t (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 10:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ECE3308427C;
        Mon,  2 Sep 2019 14:27:49 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-156.phx2.redhat.com [10.3.116.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC7E160C5D;
        Mon,  2 Sep 2019 14:27:48 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v4 1/3] tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
Date:   Mon,  2 Sep 2019 07:27:33 -0700
Message-Id: <20190902142735.6280-2-jsnitsel@redhat.com>
In-Reply-To: <20190902142735.6280-1-jsnitsel@redhat.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 02 Sep 2019 14:27:49 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Replace existing TPM 1.x version structs with new structs that consolidate
the common parts into a single struct so that code duplication is no longer
needed in caps_show().

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Klimov <aklimov@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm-sysfs.c | 45 ++++++++++++++++++------------------
 drivers/char/tpm/tpm.h       | 23 ++++++++----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d9caedda075b..eb05d5df4759 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -217,6 +217,7 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	struct tpm1_version *version;
 	ssize_t rc = 0;
 	char *str = buf;
 	cap_t cap;
@@ -232,31 +233,31 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 	str += sprintf(str, "Manufacturer: 0x%x\n",
 		       be32_to_cpu(cap.manufacturer_id));
 
-	/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
-	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+	/* TPM 1.2 */
+	if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
 			 "attempting to determine the 1.2 version",
-			 sizeof(cap.tpm_version_1_2));
-	if (!rc) {
-		str += sprintf(str,
-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
-			       cap.tpm_version_1_2.Major,
-			       cap.tpm_version_1_2.Minor,
-			       cap.tpm_version_1_2.revMajor,
-			       cap.tpm_version_1_2.revMinor);
-	} else {
-		/* Otherwise just use TPM_STRUCT_VER */
-		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
-				"attempting to determine the 1.1 version",
-				sizeof(cap.tpm_version)))
-			goto out_ops;
-		str += sprintf(str,
-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
-			       cap.tpm_version.Major,
-			       cap.tpm_version.Minor,
-			       cap.tpm_version.revMajor,
-			       cap.tpm_version.revMinor);
+			 sizeof(cap.version2))) {
+		version = &cap.version2.version;
+		goto out_print;
 	}
+
+	/* TPM 1.1 */
+	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+			"attempting to determine the 1.1 version",
+			sizeof(cap.version1))) {
+		goto out_ops;
+	}
+
+	version = &cap.version1;
+
+out_print:
+	str += sprintf(str,
+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
+		       version->major, version->minor,
+		       version->rev_major, version->rev_minor);
+
 	rc = str - buf;
+
 out_ops:
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..a4f74dd02a35 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -186,19 +186,16 @@ struct	stclear_flags_t {
 	u8	bGlobalLock;
 } __packed;
 
-struct	tpm_version_t {
-	u8	Major;
-	u8	Minor;
-	u8	revMajor;
-	u8	revMinor;
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
 } __packed;
 
-struct	tpm_version_1_2_t {
-	__be16	tag;
-	u8	Major;
-	u8	Minor;
-	u8	revMajor;
-	u8	revMinor;
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
 } __packed;
 
 struct	timeout_t {
@@ -243,8 +240,8 @@ typedef union {
 	struct	stclear_flags_t	stclear_flags;
 	__u8	owned;
 	__be32	num_pcrs;
-	struct	tpm_version_t	tpm_version;
-	struct	tpm_version_1_2_t tpm_version_1_2;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
 	__be32	manufacturer_id;
 	struct timeout_t  timeout;
 	struct duration_t duration;
-- 
2.21.0

