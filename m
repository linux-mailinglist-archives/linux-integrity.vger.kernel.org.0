Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A55209924
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 06:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgFYEib (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 00:38:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:56775 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgFYEib (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 00:38:31 -0400
IronPort-SDR: IQqcOYlNwHW+SNdfgY6No719yDpPM6k6HEHQXrXMM+IC0G+ewkzFPN0AD2/eN9zuz4I1+/C9qv
 ClQIOoSxnojQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124994916"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="124994916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 21:38:30 -0700
IronPort-SDR: rW/QrsxsaBFg9OVp1MNb5hUg5t6x3YkQiPCj0tHP5q2xY+PtkcjnpDLwF7TqLHp6cTEpjwCczq
 hjcK7Z1dubiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="265254035"
Received: from skurzyno-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.40.230])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 21:38:25 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm: tpm2-space: Resize session and context buffers dynamically
Date:   Thu, 25 Jun 2020 07:38:16 +0300
Message-Id: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Re-allocate context and session buffers when needed. Scale them in page
increments so that the reallocation is only seldomly required, and thus
causes minimal stress to the system. Add a static maximum limit of four
pages for buffer sizes.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
Tested only for compilation.
v2: TPM2_SPACE_DEFAULT_BUFFER_SIZE
 drivers/char/tpm/tpm2-space.c | 87 ++++++++++++++++++++++++-----------
 include/linux/tpm.h           |  6 ++-
 2 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..b8ece01d6afb 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -15,6 +15,9 @@
 #include <asm/unaligned.h>
 #include "tpm.h"
 
+#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
+#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
+
 enum tpm2_handle_types {
 	TPM2_HT_HMAC_SESSION	= 0x02000000,
 	TPM2_HT_POLICY_SESSION	= 0x03000000,
@@ -40,16 +43,21 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 
 int tpm2_init_space(struct tpm_space *space)
 {
-	space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	space->context_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
+				     GFP_KERNEL);
 	if (!space->context_buf)
 		return -ENOMEM;
 
-	space->session_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	space->session_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
+				     GFP_KERNEL);
 	if (space->session_buf == NULL) {
 		kfree(space->context_buf);
+		space->context_buf = NULL;
 		return -ENOMEM;
 	}
 
+	space->context_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
+	space->session_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
 	return 0;
 }
 
@@ -116,11 +124,13 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	return 0;
 }
 
-static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
-			     unsigned int buf_size, unsigned int *offset)
+static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 **buf,
+			     unsigned int *buf_size, unsigned int *offset)
 {
-	struct tpm_buf tbuf;
+	unsigned int new_buf_size;
 	unsigned int body_size;
+	struct tpm_buf tbuf;
+	void *new_buf;
 	int rc;
 
 	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
@@ -131,31 +141,48 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 
 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
 	if (rc < 0) {
-		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
-			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto err;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
-		tpm_buf_destroy(&tbuf);
-		return -ENOENT;
+		rc = -ENOENT;
+		goto out;
 	} else if (rc) {
-		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
-			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto err;
 	}
 
 	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
-	if ((*offset + body_size) > buf_size) {
-		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
-		tpm_buf_destroy(&tbuf);
-		return -ENOMEM;
+	/* We grow the buffer in page increments. */
+	new_buf_size = PFN_UP(*offset + body_size);
+
+	if (new_buf_size > TPM2_SPACE_MAX_BUFFER_SIZE) {
+		rc = -ENOMEM;
+		goto err;
 	}
 
-	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
+	if (new_buf_size > *buf_size) {
+		new_buf = krealloc(*buf, new_buf_size, GFP_KERNEL);
+		if (!new_buf) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		*buf = new_buf;
+		*buf_size = new_buf_size;
+	}
+
+	memcpy(*buf + *offset, &tbuf.data[TPM_HEADER_SIZE], body_size);
 	*offset += body_size;
+
+out:
 	tpm_buf_destroy(&tbuf);
-	return 0;
+	return rc;
+
+err:
+	dev_warn(&chip->dev, "%s: ret=%d\n", __func__, rc);
+
+	tpm_buf_destroy(&tbuf);
+	return rc;
 }
 
 void tpm2_flush_space(struct tpm_chip *chip)
@@ -311,8 +338,10 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 	       sizeof(space->context_tbl));
 	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
 	       sizeof(space->session_tbl));
-	memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
-	memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);
+	memcpy(chip->work_space.context_buf, space->context_buf,
+	       space->context_size);
+	memcpy(chip->work_space.session_buf, space->session_buf,
+	       space->session_size);
 
 	rc = tpm2_load_space(chip);
 	if (rc) {
@@ -492,7 +521,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			continue;
 
 		rc = tpm2_save_context(chip, space->context_tbl[i],
-				       space->context_buf, PAGE_SIZE,
+				       &space->context_buf,
+				       &space->context_size,
 				       &offset);
 		if (rc == -ENOENT) {
 			space->context_tbl[i] = 0;
@@ -509,7 +539,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			continue;
 
 		rc = tpm2_save_context(chip, space->session_tbl[i],
-				       space->session_buf, PAGE_SIZE,
+				       &space->session_buf,
+				       &space->session_size,
 				       &offset);
 
 		if (rc == -ENOENT) {
@@ -557,8 +588,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 	       sizeof(space->context_tbl));
 	memcpy(&space->session_tbl, &chip->work_space.session_tbl,
 	       sizeof(space->session_tbl));
-	memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
-	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
+	memcpy(space->context_buf, chip->work_space.context_buf,
+	       space->context_size);
+	memcpy(space->session_buf, chip->work_space.session_buf,
+	       space->session_size);
 
 	return 0;
 out:
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 03e9b184411b..9ea39e8f7162 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -92,10 +92,12 @@ enum tpm_duration {
 #define TPM_PPI_VERSION_LEN		3
 
 struct tpm_space {
+	u8  *context_buf;
+	u8  *session_buf;
+	u32 context_size;
+	u32 session_size;
 	u32 context_tbl[3];
-	u8 *context_buf;
 	u32 session_tbl[3];
-	u8 *session_buf;
 };
 
 struct tpm_bios_log {
-- 
2.25.1

