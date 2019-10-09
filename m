Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A409D1AE5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2019 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfJIV2v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Oct 2019 17:28:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:4920 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbfJIV2t (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Oct 2019 17:28:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 14:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="187747042"
Received: from thomaske-mobl.ger.corp.intel.com (HELO localhost) ([10.252.3.55])
  by orsmga008.jf.intel.com with ESMTP; 09 Oct 2019 14:28:44 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/3] tpm: migrate pubek_show to struct tpm_buf
Date:   Thu, 10 Oct 2019 00:28:29 +0300
Message-Id: <20191009212831.29081-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
References: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

commit da379f3c1db0c9a1fd27b11d24c9894b5edc7c75 upstream

Migrated pubek_show to struct tpm_buf and cleaned up its implementation.
Previously the output parameter structure was declared but left
completely unused. Now it is used to refer different fields of the
output. We can move it to tpm-sysfs.c as it does not have any use
outside of that file.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-sysfs.c | 87 ++++++++++++++++++++----------------
 drivers/char/tpm/tpm.h       | 13 ------
 2 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 86f38d239476..83a77a445538 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -20,44 +20,48 @@
 #include <linux/device.h>
 #include "tpm.h"
 
-#define READ_PUBEK_RESULT_SIZE 314
+struct tpm_readpubek_out {
+	u8 algorithm[4];
+	u8 encscheme[2];
+	u8 sigscheme[2];
+	__be32 paramsize;
+	u8 parameters[12];
+	__be32 keysize;
+	u8 modulus[256];
+	u8 checksum[20];
+} __packed;
+
 #define READ_PUBEK_RESULT_MIN_BODY_SIZE (28 + 256)
 #define TPM_ORD_READPUBEK 124
-static const struct tpm_input_header tpm_readpubek_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(30),
-	.ordinal = cpu_to_be32(TPM_ORD_READPUBEK)
-};
+
 static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	u8 *data;
-	struct tpm_cmd_t tpm_cmd;
-	ssize_t err;
-	int i, rc;
+	struct tpm_buf tpm_buf;
+	struct tpm_readpubek_out *out;
+	ssize_t rc;
+	int i;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	char anti_replay[20];
 
-	memset(&tpm_cmd, 0, sizeof(tpm_cmd));
-
-	tpm_cmd.header.in = tpm_readpubek_header;
-	err = tpm_transmit_cmd(chip, NULL, &tpm_cmd, READ_PUBEK_RESULT_SIZE,
-			       READ_PUBEK_RESULT_MIN_BODY_SIZE, 0,
-			       "attempting to read the PUBEK");
-	if (err)
-		goto out;
-
-	/*
-	   ignore header 10 bytes
-	   algorithm 32 bits (1 == RSA )
-	   encscheme 16 bits
-	   sigscheme 16 bits
-	   parameters (RSA 12->bytes: keybit, #primes, expbit)
-	   keylenbytes 32 bits
-	   256 byte modulus
-	   ignore checksum 20 bytes
-	 */
-	data = tpm_cmd.params.readpubek_out_buffer;
+	memset(&anti_replay, 0, sizeof(anti_replay));
+
+	rc = tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK);
+	if (rc)
+		return rc;
+
+	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
+
+	rc = tpm_transmit_cmd(chip, NULL, tpm_buf.data, PAGE_SIZE,
+			      READ_PUBEK_RESULT_MIN_BODY_SIZE, 0,
+			      "attempting to read the PUBEK");
+	if (rc) {
+		tpm_buf_destroy(&tpm_buf);
+		return 0;
+	}
+
+	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
 	str +=
 	    sprintf(str,
 		    "Algorithm: %02X %02X %02X %02X\n"
@@ -68,21 +72,26 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 		    "%02X %02X %02X %02X\n"
 		    "Modulus length: %d\n"
 		    "Modulus:\n",
-		    data[0], data[1], data[2], data[3],
-		    data[4], data[5],
-		    data[6], data[7],
-		    data[12], data[13], data[14], data[15],
-		    data[16], data[17], data[18], data[19],
-		    data[20], data[21], data[22], data[23],
-		    be32_to_cpu(*((__be32 *) (data + 24))));
+		    out->algorithm[0], out->algorithm[1], out->algorithm[2],
+		    out->algorithm[3],
+		    out->encscheme[0], out->encscheme[1],
+		    out->sigscheme[0], out->sigscheme[1],
+		    out->parameters[0], out->parameters[1],
+		    out->parameters[2], out->parameters[3],
+		    out->parameters[4], out->parameters[5],
+		    out->parameters[6], out->parameters[7],
+		    out->parameters[8], out->parameters[9],
+		    out->parameters[10], out->parameters[11],
+		    be32_to_cpu(out->keysize));
 
 	for (i = 0; i < 256; i++) {
-		str += sprintf(str, "%02X ", data[i + 28]);
+		str += sprintf(str, "%02X ", out->modulus[i]);
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-out:
+
 	rc = str - buf;
+	tpm_buf_destroy(&tpm_buf);
 	return rc;
 }
 static DEVICE_ATTR_RO(pubek);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4bb9b4aa9b49..d53d12f3df6d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -351,17 +351,6 @@ enum tpm_sub_capabilities {
 	TPM_CAP_PROP_TIS_DURATION = 0x120,
 };
 
-struct	tpm_readpubek_params_out {
-	u8	algorithm[4];
-	u8	encscheme[2];
-	u8	sigscheme[2];
-	__be32	paramsize;
-	u8	parameters[12]; /*assuming RSA*/
-	__be32	keysize;
-	u8	modulus[256];
-	u8	checksum[20];
-} __packed;
-
 typedef union {
 	struct	tpm_input_header in;
 	struct	tpm_output_header out;
@@ -391,8 +380,6 @@ struct tpm_getrandom_in {
 } __packed;
 
 typedef union {
-	struct	tpm_readpubek_params_out readpubek_out;
-	u8	readpubek_out_buffer[sizeof(struct tpm_readpubek_params_out)];
 	struct	tpm_pcrread_in	pcrread_in;
 	struct	tpm_pcrread_out	pcrread_out;
 	struct	tpm_getrandom_in getrandom_in;
-- 
2.20.1

