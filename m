Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7462262B1
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGTPCB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:02:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47962 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgGTPCB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 074158EE266;
        Mon, 20 Jul 2020 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595257321;
        bh=Pc4Smw8NRQww0MPv+vURo3dba15pBdPe1luedmCls0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZUgSnivJCIrC6EK2FAHlEzYC1Y0uWwjo2SxWJU3fCCGGLXGGmm51CRqLqKvP0vTY
         eRlD3ZRAdstXGGoNqvUNiqydqI6hV86/x5W6LqAjrCzW2SvhVdpRMLdtZe3VL+o75n
         5zjV1QPMBpwoTIbFU7Fn6dKv2Wdcepx5Z8lSiz5o=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NvkGxmD3YoDA; Mon, 20 Jul 2020 08:02:00 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A75C8EE223;
        Mon, 20 Jul 2020 08:02:00 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 1/1] tpm: add sysfs exports for all banks of PCR registers
Date:   Mon, 20 Jul 2020 08:00:38 -0700
Message-Id: <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
References: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

use macro magic to create sysfs per hash groups with 24 PCR files in
them one for each possible agile hash of the TPM.  The files are
plugged in to a read function which is TPM version agnostic, so this
works also for TPM 1.2 although the hash is only sha1 in that case.
For every hash the TPM supports, a group named pcr-<hash> is created
and each of the PCR read files placed under it.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-sysfs.c | 178 +++++++++++++++++++++++++++++++++++
 include/linux/tpm.h          |   8 +-
 2 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d52bf4df0bca..d81ec5e437c1 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -348,9 +348,187 @@ static const struct attribute_group tpm2_dev_group = {
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
+			 * If this warning triggers, send a patch to
+			 * add both a PCR_ATTR_BUILD() macro above for
+			 * the missing algorithm as well as an
+			 * additional case in this switch statement.
+			 */
+			WARN(1, "TPM with unsupported bank algorthm 0x%04x",
+			     chip->allocated_banks[i].alg_id);
+			break;
+		}
+	}
+
+	/*
+	 * This will only trigger if someone has added an additional
+	 * hash to the tpm_algorithms enum without incrementing
+	 * TPM_MAX_HASHES
+	 */
+	WARN_ON(chip->groups_cnt >= TPM_MAX_HASHES);
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 	else
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 5026a06977e1..f73dc4f9fbf4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -42,6 +42,12 @@ enum tpm_algorithms {
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
@@ -145,7 +151,7 @@ struct tpm_chip {
 
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
 
-	const struct attribute_group *groups[3];
+	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-- 
2.26.2

