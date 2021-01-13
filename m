Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E82F5775
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbhANCAS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbhAMXj4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 18:39:56 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9ABC0617B9;
        Wed, 13 Jan 2021 15:29:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB4421280521;
        Wed, 13 Jan 2021 15:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610580396;
        bh=4xviIYgeZKqnrWzKOv0DB61myXcKj8Y/IS1IklBMGEE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=okDL1YL5KmhOgQByAGRXxadf6esP+Uj1Z62wZQzQMWmdVE+SGrOt91JqXI8cAPP3i
         44cTPSj+bJjXzxpSnPagKNhowLN77NlTQ/2j459p96CyxbPRHhgvmZ6Q/NvKROjlmO
         SLf/niEvXqKzUuz6R4JG8ANqrvPdW2/808niUaF8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7GDKEgo6M0t2; Wed, 13 Jan 2021 15:26:36 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8279B12804FC;
        Wed, 13 Jan 2021 15:26:36 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR registers
Date:   Wed, 13 Jan 2021 15:26:33 -0800
Message-Id: <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Create sysfs per hash groups with 24 PCR files in them one group,
named pcr-<hash>, for each agile hash of the TPM.  The files are
plugged in to a PCR read function which is TPM version agnostic, so
this works also for TPM 1.2 but the hash is only sha1 in that case.

Note: the macros used to create the hashes emit spurious checkpatch
warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
they'll break.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

---

v2: fix TPM 1.2 legacy links failure
v3: fix warn on and add note to tpm_algorithms
v4: reword commit and add tested-by
v5: algorithm spelling fix WARN->dev_err
---
 drivers/char/tpm/tpm-sysfs.c | 179 +++++++++++++++++++++++++++++++++++
 include/linux/tpm.h          |   9 +-
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index e2ff0b273a0f..63f03cfb8e6a 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -337,11 +337,190 @@ static const struct attribute_group tpm2_dev_group = {
 	.attrs = tpm2_dev_attrs,
 };
 
+struct tpm_pcr_attr {
+	int alg_id;
+	int pcr;
+	struct device_attribute attr;
+};
+
+#define to_tpm_pcr_attr(a) container_of(a, struct tpm_pcr_attr, attr)
+
+static ssize_t pcr_value_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpm_pcr_attr *ha = to_tpm_pcr_attr(attr);
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	struct tpm_digest digest;
+	int i;
+	int digest_size = 0;
+	int rc;
+	char *str = buf;
+
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		if (ha->alg_id == chip->allocated_banks[i].alg_id)
+			digest_size = chip->allocated_banks[i].digest_size;
+	/* should never happen */
+	if (!digest_size)
+		return -EINVAL;
+
+	digest.alg_id = ha->alg_id;
+	rc = tpm_pcr_read(chip, ha->pcr, &digest);
+	if (rc)
+		return rc;
+	for (i = 0; i < digest_size; i++)
+		str += sprintf(str, "%02X", digest.digest[i]);
+	str += sprintf(str, "\n");
+
+	return str - buf;
+}
+
+/*
+ * The following set of defines represents all the magic to build
+ * the per hash attribute groups for displaying each bank of PCRs.
+ * The only slight problem with this approach is that every PCR is
+ * hard coded to be present, so you don't know if an PCR is missing
+ * until a cat of the file returns -EINVAL
+ *
+ * Also note you must ignore checkpatch warnings in this macro
+ * code. This is deep macro magic that checkpatch.pl doesn't
+ * understand.
+ */
+
+/* Note, this must match TPM2_PLATFORM_PCR which is fixed at 24. */
+#define _TPM_HELPER(_alg, _hash, F) \
+	F(_alg, _hash, 0)	    \
+	F(_alg, _hash, 1)	    \
+	F(_alg, _hash, 2)	    \
+	F(_alg, _hash, 3)	    \
+	F(_alg, _hash, 4)	    \
+	F(_alg, _hash, 5)	    \
+	F(_alg, _hash, 6)	    \
+	F(_alg, _hash, 7)	    \
+	F(_alg, _hash, 8)	    \
+	F(_alg, _hash, 9)	    \
+	F(_alg, _hash, 10)	    \
+	F(_alg, _hash, 11)	    \
+	F(_alg, _hash, 12)	    \
+	F(_alg, _hash, 13)	    \
+	F(_alg, _hash, 14)	    \
+	F(_alg, _hash, 15)	    \
+	F(_alg, _hash, 16)	    \
+	F(_alg, _hash, 17)	    \
+	F(_alg, _hash, 18)	    \
+	F(_alg, _hash, 19)	    \
+	F(_alg, _hash, 20)	    \
+	F(_alg, _hash, 21)	    \
+	F(_alg, _hash, 22)	    \
+	F(_alg, _hash, 23)
+
+/* ignore checkpatch warning about trailing ; in macro. */
+#define PCR_ATTR(_alg, _hash, _pcr)				   \
+	static struct tpm_pcr_attr dev_attr_pcr_##_hash##_##_pcr = {	\
+		.alg_id = _alg,					   \
+		.pcr = _pcr,					   \
+		.attr = {					   \
+			.attr = {				   \
+				.name = __stringify(_pcr),	   \
+				.mode = 0444			   \
+			},					   \
+			.show = pcr_value_show			   \
+		}						   \
+	};
+
+#define PCR_ATTRS(_alg, _hash)			\
+	_TPM_HELPER(_alg, _hash, PCR_ATTR)
+
+/* ignore checkpatch warning about trailing , in macro. */
+#define PCR_ATTR_VAL(_alg, _hash, _pcr)		\
+	&dev_attr_pcr_##_hash##_##_pcr.attr.attr,
+
+#define PCR_ATTR_GROUP_ARRAY(_alg, _hash)		       \
+	static struct attribute *pcr_group_attrs_##_hash[] = { \
+		_TPM_HELPER(_alg, _hash, PCR_ATTR_VAL)	       \
+		NULL					       \
+	}
+
+#define PCR_ATTR_GROUP(_alg, _hash)			    \
+	static struct attribute_group pcr_group_##_hash = { \
+		.name = "pcr-" __stringify(_hash),	    \
+		.attrs = pcr_group_attrs_##_hash	    \
+	}
+
+#define PCR_ATTR_BUILD(_alg, _hash)	   \
+	PCR_ATTRS(_alg, _hash)		   \
+	PCR_ATTR_GROUP_ARRAY(_alg, _hash); \
+	PCR_ATTR_GROUP(_alg, _hash)
+/*
+ * End of macro structure to build an attribute group containing 24
+ * PCR value files for each supported hash algorithm
+ */
+
+/*
+ * The next set of macros implements the cleverness for each hash to
+ * build a static attribute group called pcr_group_<hash> which can be
+ * added to chip->groups[].
+ *
+ * The first argument is the TPM algorithm id and the second is the
+ * hash used as both the suffix and the group name.  Note: the group
+ * name is a directory in the top level tpm class with the name
+ * pcr-<hash>, so it must not clash with any other names already
+ * in the sysfs directory.
+ */
+PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
+PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
+PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
+PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
+PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);
+
+
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
+	int i;
+
 	WARN_ON(chip->groups_cnt != 0);
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 	else
 		chip->groups[chip->groups_cnt++] = &tpm1_dev_group;
+
+	/* add one group for each bank hash */
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		switch (chip->allocated_banks[i].alg_id) {
+		case TPM_ALG_SHA1:
+			chip->groups[chip->groups_cnt++] = &pcr_group_sha1;
+			break;
+		case TPM_ALG_SHA256:
+			chip->groups[chip->groups_cnt++] = &pcr_group_sha256;
+			break;
+		case TPM_ALG_SHA384:
+			chip->groups[chip->groups_cnt++] = &pcr_group_sha384;
+			break;
+		case TPM_ALG_SHA512:
+			chip->groups[chip->groups_cnt++] = &pcr_group_sha512;
+			break;
+		case TPM_ALG_SM3_256:
+			chip->groups[chip->groups_cnt++] = &pcr_group_sm3;
+			break;
+		default:
+			/*
+			 * If triggers, send a patch to add both a
+			 * PCR_ATTR_BUILD() macro above for the
+			 * missing algorithm as well as an additional
+			 * case in this switch statement.
+			 */
+			dev_err(&chip->dev,
+				"TPM with unsupported bank algorithm 0x%04x",
+				chip->allocated_banks[i].alg_id);
+			break;
+		}
+	}
+
+	/*
+	 * This will only trigger if someone has added an additional
+	 * hash to the tpm_algorithms enum without incrementing
+	 * TPM_MAX_HASHES.
+	 */
+	WARN_ON(chip->groups_cnt > TPM_MAX_HASHES + 1);
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index df56d7fbe78f..c4ca52138e8b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -31,6 +31,7 @@ struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 
+/* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
 	TPM_ALG_SHA1		= 0x0004,
@@ -42,6 +43,12 @@ enum tpm_algorithms {
 	TPM_ALG_SM3_256		= 0x0012,
 };
 
+/*
+ * maximum number of hashing algorithms a TPM can have.  This is
+ * basically a count of every hash in tpm_algorithms above
+ */
+#define TPM_MAX_HASHES	5
+
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM_MAX_DIGEST_SIZE];
@@ -146,7 +153,7 @@ struct tpm_chip {
 
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
 
-	const struct attribute_group *groups[3];
+	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-- 
2.26.2

