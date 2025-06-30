Return-Path: <linux-integrity+bounces-6571-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B5AEDD64
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162CF3AFAB2
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520C286D48;
	Mon, 30 Jun 2025 12:47:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3826F463;
	Mon, 30 Jun 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287660; cv=none; b=ml+Wen7MGUKX/9wlDdEXywWwVpEiZyYyGdje9VIiIC7WMllrvkcHU/QNeS+FzN2Qrx8c3zESlK8UqzK5b9+MuVj+90XH9NJ6SdTrVODdI1Y4CapVfs4Og5W9OZ67TQJ+bZDM27a0NTQRxNTW1wcsbWbFccLSpr4E4blJ+XwbNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287660; c=relaxed/simple;
	bh=2j7p5gpf+8wtNYLLVp46XrGSopcKtlZ1X8i8OTr8ApA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc4Y65PRYvWrQ0qpRv8xANzygPApa00xbGxUMm+90waz5YU9a6R4hN9w6q2XB2xVC+97J1ifLqibvLJODXfIhGghWoFzuCiJBkD3+HtWeOwnXgRS4/Ov8XDPJnr4dPmDXiw5aHyZV40PvIO9WCXoXt4UY5TBnFFWVF0EqBhS7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bW5Rj6qMjzCsMV;
	Mon, 30 Jun 2025 20:43:13 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BB175180237;
	Mon, 30 Jun 2025 20:47:35 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 20:47:35 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	Lu Jialin <lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH -next RFC 4/4] ima: rot: Involve per-RoT default PCR index
Date: Mon, 30 Jun 2025 20:59:28 +0800
Message-ID: <20250630125928.765285-5-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630125928.765285-1-gongruiqi1@huawei.com>
References: <20250630125928.765285-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100016.china.huawei.com (7.202.181.57)

As both the extend operation and the measurement list require a PCR
index, the concept of PCR needs to be somehow applied to RoTs besides
TPM as well, and each type of RoT device should have its own PCR index,
no matter it's actually used or not.

The original CONFIG_IMA_MEASURE_PCR_IDX in fact has two roles:

  1. It specifies the default index of TPM's PCR that IMA will use.
  2. It provides a dummy PCR index (as a placeholder in the measurement
     list) when TPM (now generalized to RoT) is unavailable.

Now rename this config to emphasize its first role, and create another
macro, IMA_DEFAULT_PCR_IDX, to take up the second role.

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/integrity/ima/Kconfig    | 12 ++++++++----
 security/integrity/ima/ima.h      |  3 +++
 security/integrity/ima/ima_api.c  |  2 +-
 security/integrity/ima/ima_init.c |  2 +-
 security/integrity/ima/ima_main.c |  4 ++--
 security/integrity/ima/ima_rot.c  |  2 +-
 6 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 976e75f9b9ba..5e3b4ddea9ab 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -44,14 +44,18 @@ config IMA_KEXEC
 	   Depending on the IMA policy, the measurement list can grow to
 	   be very large.
 
-config IMA_MEASURE_PCR_IDX
+config IMA_ROT_TPM_PCR_IDX
 	int
 	range 8 14
 	default 10
 	help
-	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
-	  that IMA uses to maintain the integrity aggregate of the
-	  measurement list.  If unsure, use the default 10.
+	  IMA_ROT_TPM_PCR_IDX determines the index of PCR that IMA, when
+	  choosing TPM as the Root of Trust (RoT), would use to maintain
+	  the integrity aggregate of the measurement list. Its value is
+	  also used as a dummy PCR index IMA would use in the absence of
+	  RoT.
+
+	  If unsure, use the default 10.
 
 config IMA_LSM_RULES
 	bool
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 31e3f76cdda6..f64fde127006 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -42,6 +42,9 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 #define IMA_TEMPLATE_IMA_NAME "ima"
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
+#define IMA_DEFAULT_PCR_IDX CONFIG_IMA_ROT_TPM_PCR_IDX
+#define IMA_MEASURE_PCR_IDX (ima_rot_inst ? ima_rot_inst->default_pcr : IMA_DEFAULT_PCR_IDX)
+
 #define NR_BANKS(rot) ((rot != NULL) ? rot->nr_allocated_banks : 0)
 
 /* current content of the policy */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 65cf5b2400f2..94201216225d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -152,7 +152,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		goto err_out;
 	}
 	result = ima_store_template(entry, violation, inode,
-				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
+				    filename, IMA_MEASURE_PCR_IDX);
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 096eaa7a7666..a63a5d8355df 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -87,7 +87,7 @@ static int __init ima_add_boot_aggregate(void)
 
 	result = ima_store_template(entry, violation, NULL,
 				    boot_aggregate_name,
-				    CONFIG_IMA_MEASURE_PCR_IDX);
+				    IMA_MEASURE_PCR_IDX);
 	if (result < 0) {
 		ima_free_template_entry(entry);
 		audit_cause = "store_entry";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..ed13966dc562 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -245,7 +245,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
 	int rc = 0, action, must_appraise = 0;
-	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int pcr = IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	struct modsig *modsig = NULL;
 	int xattr_len = 0;
@@ -1060,7 +1060,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	}
 
 	if (!pcr)
-		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+		pcr = IMA_MEASURE_PCR_IDX;
 
 	iint.ima_hash = hash_hdr;
 	iint.ima_hash->algo = ima_hash_algo;
diff --git a/security/integrity/ima/ima_rot.c b/security/integrity/ima/ima_rot.c
index 0083d9c4e64e..ed32a48bef8d 100644
--- a/security/integrity/ima/ima_rot.c
+++ b/security/integrity/ima/ima_rot.c
@@ -38,7 +38,7 @@ static struct ima_rot ima_rots[] = {
 #ifdef CONFIG_TCG_TPM
 	{
 		.name = "tpm",
-		.default_pcr = CONFIG_IMA_MEASURE_PCR_IDX,
+		.default_pcr = CONFIG_IMA_ROT_TPM_PCR_IDX,
 		.init = ima_tpm_init,
 		.extend = ima_tpm_extend,
 		.calc_boot_aggregate = ima_tpm_calc_boot_aggregate,
-- 
2.25.1


