Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA9C868F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJBKpi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 06:45:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:12114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbfJBKph (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 06:45:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 03:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="366670022"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.158])
  by orsmga005.jf.intel.com with ESMTP; 02 Oct 2019 03:45:31 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2,RESEND] tpm: Detach page allocation from tpm_buf
Date:   Wed,  2 Oct 2019 13:45:30 +0300
Message-Id: <20191002104530.7679-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As has been seen recently, binding the buffer allocation and tpm_buf
together is sometimes far from optimal. The buffer might come from the
caller namely when tpm_send() is used by another subsystem. In addition we
can stability in call sites w/o rollback (e.g. power events)>

Take allocation out of the tpm_buf framework and make it purely a wrapper
for the data buffer.

Link: https://patchwork.kernel.org/patch/11146585/
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-sysfs.c      |  19 ++-
 drivers/char/tpm/tpm.h            |  40 ++---
 drivers/char/tpm/tpm1-cmd.c       | 114 +++++++++----
 drivers/char/tpm/tpm2-cmd.c       | 265 +++++++++++++++++++-----------
 drivers/char/tpm/tpm2-space.c     |  64 +++++---
 drivers/char/tpm/tpm_vtpm_proxy.c |  24 +--
 6 files changed, 333 insertions(+), 193 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..eeb90c9225b9 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -32,21 +32,26 @@ struct tpm_readpubek_out {
 static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct tpm_buf tpm_buf;
-	struct tpm_readpubek_out *out;
-	int i;
-	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	struct tpm_readpubek_out *out;
+	struct page *data_page;
+	struct tpm_buf tpm_buf;
 	char anti_replay[20];
+	char *str = buf;
+	int i;
 
 	memset(&anti_replay, 0, sizeof(anti_replay));
 
 	if (tpm_try_get_ops(chip))
 		return 0;
 
-	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
 		goto out_ops;
 
+	tpm_buf_reset(&tpm_buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_READPUBEK);
+
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
 	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
@@ -83,7 +88,9 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	}
 
 out_buf:
-	tpm_buf_destroy(&tpm_buf);
+	kunmap(data_page);
+	__free_page(data_page);
+
 out_ops:
 	tpm_put_ops(chip);
 	return str - buf;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..45316e5d2d36 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -284,36 +284,30 @@ enum tpm_buf_flags {
 };
 
 struct tpm_buf {
-	struct page *data_page;
-	unsigned int flags;
 	u8 *data;
+	unsigned int size;
+	unsigned int flags;
 };
 
-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
+static inline void tpm_buf_reset(struct tpm_buf *buf, u8 *data,
+	unsigned int size, u16 tag, u32 ordinal)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
+	struct tpm_header *head = (struct tpm_header *)data;
 
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-}
-
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
-		return -ENOMEM;
+	/* sanity check */
+	if (size < TPM_HEADER_SIZE) {
+		WARN(1, "tpm_buf: overflow\n");
+		buf->flags |= TPM_BUF_OVERFLOW;
+		return;
+	}
 
+	buf->data = data;
+	buf->size = size;
 	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
-}
 
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
 }
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)
@@ -341,7 +335,7 @@ static inline void tpm_buf_append(struct tpm_buf *buf,
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
 
-	if ((len + new_len) > PAGE_SIZE) {
+	if ((len + new_len) > buf->size) {
 		WARN(1, "tpm_buf: overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 149e953ca369..2753699454ab 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -323,19 +323,25 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
  */
 static int tpm1_startup(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
-	if (rc < 0)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_STARTUP);
 
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -448,18 +454,24 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_PCR_EXTEND);
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
 	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -467,12 +479,16 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_GET_CAP);
 
 	if (subcap_id == TPM_CAP_VERSION_1_1 ||
 	    subcap_id == TPM_CAP_VERSION_1_2) {
@@ -491,7 +507,9 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, desc);
 	if (!rc)
 		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
@@ -514,19 +532,26 @@ struct tpm1_get_random_out {
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
-	struct tpm1_get_random_out *out;
 	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
+	struct tpm1_get_random_out *out;
+	struct page *data_page;
 	struct tpm_buf buf;
-	u32 total = 0;
 	int retries = 5;
+	void *data_ptr;
+	u32 total = 0;
 	u32 recd;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	data_ptr = kmap(data_page);
 
 	do {
+		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+			      TPM_ORD_GET_RANDOM);
+
 		tpm_buf_append_u32(&buf, num_bytes);
 
 		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
@@ -555,25 +580,29 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		dest += recd;
 		total += recd;
 		num_bytes -= recd;
-
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 	} while (retries-- && total < max);
 
 	rc = total ? (int)total : -EIO;
+
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
 #define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_PCRREAD);
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 
@@ -590,7 +619,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	memcpy(res_buf, &buf.data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
 
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -604,15 +634,21 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
  */
 static int tpm1_continue_selftest(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
+		      TPM_ORD_CONTINUE_SELFTEST);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -722,21 +758,28 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
+	struct page *data_page;
 	struct tpm_buf buf;
 	unsigned int try;
+	void *data_ptr;
 	int rc;
 
-
 	/* for buggy tpm, flush pcrs with extend to selected dummy */
 	if (tpm_suspend_pcr)
 		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
 				     "extending dummy pcr before suspend");
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	data_ptr = kmap(data_page);
+
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
+		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
+			      TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+
 		rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
 		/*
 		 * If the TPM indicates that it is too busy to respond to
@@ -750,9 +793,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		 */
 		if (rc != TPM_WARN_RETRY)
 			break;
-		tpm_msleep(TPM_TIMEOUT_RETRY);
 
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+		tpm_msleep(TPM_TIMEOUT_RETRY);
 	}
 
 	if (rc)
@@ -762,8 +804,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		dev_warn(&chip->dev, "TPM savestate took %dms\n",
 			 try * TPM_TIMEOUT_RETRY);
 
-	tpm_buf_destroy(&buf);
-
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ba9acae83bff..33aec240ce92 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -175,13 +175,14 @@ struct tpm2_pcr_read_out {
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr)
 {
-	int i;
-	int rc;
-	struct tpm_buf buf;
-	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
-	u16 digest_size;
+	struct tpm2_pcr_read_out *out;
 	u16 expected_digest_size = 0;
+	struct page *data_page;
+	struct tpm_buf buf;
+	u16 digest_size;
+	int rc;
+	int i;
 
 	if (pcr_idx >= TPM2_PLATFORM_PCR)
 		return -EINVAL;
@@ -197,9 +198,12 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		expected_digest_size = chip->allocated_banks[i].digest_size;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_PCR_READ);
 
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
@@ -225,8 +229,10 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		*digest_size_ptr = digest_size;
 
 	memcpy(digest->digest, out->digest, digest_size);
+
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -249,14 +255,18 @@ struct tpm2_null_auth_area {
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
-	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
+	struct page *data_page;
+	struct tpm_buf buf;
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
+		      TPM2_CC_PCR_EXTEND);
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 
@@ -278,8 +288,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
 
-	tpm_buf_destroy(&buf);
-
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -302,23 +312,29 @@ struct tpm2_get_random_out {
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
 	struct tpm2_get_random_out *out;
+	struct page *data_page;
+	u8 *dest_ptr = dest;
+	u32 num_bytes = max;
 	struct tpm_buf buf;
+	void *data_ptr;
+	int retries = 5;
+	int total = 0;
 	u32 recd;
-	u32 num_bytes = max;
 	int err;
-	int total = 0;
-	int retries = 5;
-	u8 *dest_ptr = dest;
 
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
-	if (err)
-		return err;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	data_ptr = kmap(data_page);
 
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
+			      TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+
 		tpm_buf_append_u16(&buf, num_bytes);
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
@@ -347,10 +363,13 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		num_bytes -= recd;
 	} while (retries-- && total < max);
 
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return total ? total : -EIO;
+
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return err;
 }
 
@@ -361,20 +380,24 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
  */
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
-	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
-	if (rc) {
-		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
-			 handle);
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page) {
+		WARN(1, "tpm: out of memory");
 		return;
 	}
 
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_FLUSH_CONTEXT);
+
 	tpm_buf_append_u32(&buf, handle);
 
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 }
 
 /**
@@ -420,6 +443,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	struct page *data_page;
 	unsigned int blob_len;
 	struct tpm_buf buf;
 	u32 hash;
@@ -436,9 +460,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
+		      TPM2_CC_CREATE);
 
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
@@ -505,7 +532,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	payload->blob_len = blob_len;
 
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 
 	if (rc > 0) {
 		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
@@ -535,10 +563,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
+	struct page *data_page;
 	unsigned int blob_len;
+	struct tpm_buf buf;
 	int rc;
 
 	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
@@ -550,9 +579,12 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
+		      TPM2_CC_LOAD);
 
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
@@ -574,7 +606,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 
 	if (rc > 0)
 		rc = -EPERM;
@@ -599,14 +632,18 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	u16 data_len;
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
+		      TPM2_CC_UNSEAL);
 
 	tpm_buf_append_u32(&buf, blob_handle);
 	tpm2_buf_append_auth(&buf,
@@ -641,7 +678,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	}
 
 out:
-	tpm_buf_destroy(&buf);
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -693,12 +731,17 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			const char *desc)
 {
 	struct tpm2_get_cap_out *out;
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_GET_CAPABILITY);
+
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, property_id);
 	tpm_buf_append_u32(&buf, 1);
@@ -708,7 +751,9 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			&buf.data[TPM_HEADER_SIZE];
 		*value = be32_to_cpu(out->value);
 	}
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
@@ -725,15 +770,23 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
-	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
-	if (rc)
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page) {
+		WARN(1, "tpm: out of memory");
 		return;
+	}
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_SHUTDOWN);
+
 	tpm_buf_append_u16(&buf, shutdown_type);
 	tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 }
 
 /**
@@ -751,26 +804,36 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
+	void *data_ptr;
 	int full;
 	int rc;
 
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	data_ptr = kmap(data_page);
+
 	for (full = 0; full < 2; full++) {
-		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
-		if (rc)
-			return rc;
+		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+			      TPM2_CC_SELF_TEST);
 
 		tpm_buf_append_u8(&buf, full);
+
 		rc = tpm_transmit_cmd(chip, &buf, 0,
 				      "attempting the self test");
-		tpm_buf_destroy(&buf);
 
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
+
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
-			return rc;
+			break;
 	}
 
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
@@ -788,16 +851,22 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_header *out;
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_GET_CAPABILITY);
+
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(&buf, 1);
+
 	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
@@ -805,7 +874,9 @@ int tpm2_probe(struct tpm_chip *chip)
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
 	}
-	tpm_buf_destroy(&buf);
+
+	kunmap(data_page);
+	__free_page(data_page);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
@@ -843,21 +914,25 @@ struct tpm2_pcr_selection {
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
 	struct tpm2_pcr_selection pcr_selection;
-	struct tpm_buf buf;
-	void *marker;
-	void *end;
-	void *pcr_select_offset;
 	u32 sizeof_pcr_selection;
-	u32 nr_possible_banks;
+	void *pcr_select_offset;
 	u32 nr_alloc_banks = 0;
+	struct page *data_page;
+	u32 nr_possible_banks;
+	struct tpm_buf buf;
 	u16 hash_alg;
+	void *marker;
 	u32 rsp_len;
-	int rc;
 	int i = 0;
+	void *end;
+	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_GET_CAPABILITY);
 
 	tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
 	tpm_buf_append_u32(&buf, 0);
@@ -913,14 +988,16 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	}
 
 	chip->nr_allocated_banks = nr_alloc_banks;
-out:
-	tpm_buf_destroy(&buf);
 
+out:
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
 static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	u32 nr_commands;
 	__be32 *attrs;
@@ -930,35 +1007,32 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 
 	rc = tpm2_get_tpm_pt(chip, TPM_PT_TOTAL_COMMANDS, &nr_commands, NULL);
 	if (rc)
-		goto out;
+		return rc;
 
-	if (nr_commands > 0xFFFFF) {
-		rc = -EFAULT;
-		goto out;
-	}
+	if (nr_commands > 0xFFFFF)
+		return -EFAULT;
 
 	chip->cc_attrs_tbl = devm_kcalloc(&chip->dev, 4, nr_commands,
 					  GFP_KERNEL);
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		goto out;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_GET_CAPABILITY);
 
 	tpm_buf_append_u32(&buf, TPM2_CAP_COMMANDS);
 	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
 	tpm_buf_append_u32(&buf, nr_commands);
 
 	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, NULL);
-	if (rc) {
-		tpm_buf_destroy(&buf);
+	if (rc)
 		goto out;
-	}
 
 	if (nr_commands !=
-	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
-		tpm_buf_destroy(&buf);
+	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5]))
 		goto out;
-	}
 
 	chip->nr_commands = nr_commands;
 
@@ -974,11 +1048,13 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		}
 	}
 
-	tpm_buf_destroy(&buf);
-
 out:
+	kunmap(data_page);
+	__free_page(data_page);
+
 	if (rc > 0)
 		rc = -ENODEV;
+
 	return rc;
 }
 
@@ -995,19 +1071,24 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 
 static int tpm2_startup(struct tpm_chip *chip)
 {
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
-	if (rc < 0)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_STARTUP);
 
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
 
+	kunmap(data_page);
+	__free_page(data_page);
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..1d3e47392f23 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -68,14 +68,18 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 			     unsigned int *offset, u32 *handle)
 {
-	struct tpm_buf tbuf;
 	struct tpm2_context *ctx;
+	struct page *data_page;
 	unsigned int body_size;
+	struct tpm_buf tbuf;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
+
+	tpm_buf_reset(&tbuf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_CONTEXT_LOAD);
 
 	ctx = (struct tpm2_context *)&buf[*offset];
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
@@ -85,8 +89,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
 		   rc == TPM2_RC_REFERENCE_H0) {
 		/*
@@ -100,62 +104,70 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		 * flushed outside the space
 		 */
 		*handle = 0;
-		tpm_buf_destroy(&tbuf);
-		return -ENOENT;
+		rc = -ENOENT;
+		goto out;
 	} else if (rc > 0) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out;
 	}
 
 	*handle = be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
 	*offset += body_size;
 
-	tpm_buf_destroy(&tbuf);
-	return 0;
+out:
+	kunmap(data_page);
+	__free_page(data_page);
+	return rc;
 }
 
 static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 			     unsigned int buf_size, unsigned int *offset)
 {
-	struct tpm_buf tbuf;
 	unsigned int body_size;
+	struct page *data_page;
+	struct tpm_buf tbuf;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
-	if (rc)
-		return rc;
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
 
+	tpm_buf_reset(&tbuf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_CONTEXT_SAVE);
 	tpm_buf_append_u32(&tbuf, handle);
 
 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
-		tpm_buf_destroy(&tbuf);
-		return -ENOENT;
+		rc = -ENOENT;
+		goto out;
 	} else if (rc) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out;
 	}
 
 	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
 	if ((*offset + body_size) > buf_size) {
 		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
-		tpm_buf_destroy(&tbuf);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
 	*offset += body_size;
-	tpm_buf_destroy(&tbuf);
-	return 0;
+
+out:
+	kunmap(data_page);
+	__free_page(data_page);
+	return rc;
 }
 
 void tpm2_flush_space(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 2f6e087ec496..e6e89be0e149 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -394,19 +394,23 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 
 static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
+	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+	const struct tpm_header *header;
+	struct page *data_page;
 	struct tpm_buf buf;
 	int rc;
-	const struct tpm_header *header;
-	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+
+	data_page = alloc_page(GFP_HIGHUSER);
+	if (!data_page)
+		return -ENOMEM;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS,
-				  TPM2_CC_SET_LOCALITY);
+		tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE,
+			      TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
 	else
-		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
-				  TPM_ORD_SET_LOCALITY);
-	if (rc)
-		return rc;
+		tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE,
+			      TPM_TAG_RQU_COMMAND, TPM_ORD_SET_LOCALITY);
+
 	tpm_buf_append_u8(&buf, locality);
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
@@ -426,8 +430,8 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 		locality = -1;
 
 out:
-	tpm_buf_destroy(&buf);
-
+	kunmap(data_page);
+	__free_page(data_page);
 	return locality;
 }
 
-- 
2.20.1

