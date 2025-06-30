Return-Path: <linux-integrity+bounces-6574-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F9AEDD6D
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE45C3B9E69
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CEC28B4EE;
	Mon, 30 Jun 2025 12:47:44 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61F28A3E0;
	Mon, 30 Jun 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287664; cv=none; b=e8h32XkXr0Pc0/hifF/Qp01yLYi9IhF5KVKNdzgSpGBtY2NCHuw5GyvEHUns2W6hfC+VvoVgrfuzess7k1whmK70iFQCGAFDNvzVMHIxg8Lhv7wxOpUC0Z5Ex9TsY8PGqtTFazVSXVxAQihg7tacd7E9O+aICt0ZU7rE8ojzh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287664; c=relaxed/simple;
	bh=ngCFuKMbAEbWcXu/NVfD5NO+et+4GZUuEmEASqwacz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igNTvACt8yAxv/RsC1nsFEX+bi0VSQZ9+HYUXSsGp86VgeRPu+C4lwUK21QvnSrNrxmtIvHU2j8YzwxgzPhyWfa8I8FXSM+B94ay4jfPohhA4vU6NkuPXYm03O1QRpzdbFeYfQ/aGvxQbE8aIpnitjz8mX0X7D40QflC6TziFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bW5Yp2KvMz16TJW;
	Mon, 30 Jun 2025 20:48:30 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 388B61A016C;
	Mon, 30 Jun 2025 20:47:34 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 20:47:33 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	Lu Jialin <lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH -next RFC 1/4] ima: rot: Introduce basic framework
Date: Mon, 30 Jun 2025 20:59:25 +0800
Message-ID: <20250630125928.765285-2-gongruiqi1@huawei.com>
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

Each type of RoT devices should have a corresponding entry in ima_rots,
a static array that represents entries' priority via their order. In
case that `ima_rot=` is absent, the first device (which means with
highest priority) that gets successfully initialized will be the RoT.
Otherwise, the framework will only try to initialize the one specified
by `ima_rot=`, and there will be no RoT if the initialization fails.

All necessary hooks and variables of the RoT entry should be set at
least when .init() is finished.

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/integrity/ima/Makefile   |  2 +-
 security/integrity/ima/ima.h      |  2 +
 security/integrity/ima/ima_init.c |  1 +
 security/integrity/ima/ima_rot.c  | 98 +++++++++++++++++++++++++++++++
 security/integrity/ima/ima_rot.h  | 42 +++++++++++++
 5 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_rot.c
 create mode 100644 security/integrity/ima/ima_rot.h

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..b3c8436d941c 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_IMA) += ima.o ima_iint.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_rot.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..d3375427dc24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -23,6 +23,7 @@
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
+#include "ima_rot.h"
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
@@ -64,6 +65,7 @@ extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern struct ima_rot *ima_rot_inst;
 extern const char boot_aggregate_name[];
 
 /* IMA event related data */
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..15c51e1b369c 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,7 @@
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+struct ima_rot *ima_rot_inst;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
diff --git a/security/integrity/ima/ima_rot.c b/security/integrity/ima/ima_rot.c
new file mode 100644
index 000000000000..7a1ae056ea5d
--- /dev/null
+++ b/security/integrity/ima/ima_rot.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Huawei Technologies Co., Ltd.
+ *
+ * Authors:
+ * GONG Ruiqi <gongruiqi1@huawei.com>
+ *
+ * File: ima_rot.c
+ *	IMA rot layer
+ */
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/gfp_types.h>
+
+#include "ima.h"
+
+/*
+ * Meaning of preferred_rot_name's value:
+ *
+ * - NULL: User doesn't specify one.
+ * - NAME_UNKNOWN: User specifies an unknown RoT name.
+ * - (Valid RoT name): User specifies a valid name.
+ *
+ * Which corresponds to cases of `ima_rot=`.
+ */
+static const char *preferred_rot_name;
+#define NAME_UNKNOWN "UNKNOWN"
+
+/*
+ * The list containing all possible RoT devices.
+ *
+ * The order of RoTs inside the list implies priority.
+ * IOW, RoT device that owns higher priority should be placed at the front.
+ */
+static struct ima_rot ima_rots[] = {
+};
+
+/**
+ * ima_rot_name() - Process RoT device name that user provides.
+ * @str: Name of RoT device.
+ *
+ * The back-end handler of `ima_rot=` kernel cmdline, by which users can specify
+ * the Root of Trust (RoT) device for IMA. How system will react to each case of
+ * this cmdline's value is explained as follows:
+ *
+ * - Absent: Choose an RoT device based on priority, try to initialize it and
+ *   give up if it fails.
+ *
+ * - Invalid/Unknown RoT name: Give up RoT initialization. IMA will run without
+ *   an RoT device.
+ *
+ * - Valid RoT name: Try to initialize this RoT device and give up if it fails.
+ *
+ * Return: Always return 1.
+ */
+static int __init ima_rot_name(char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ima_rots); i++) {
+		if (!strcmp(str, ima_rots[i].name)) {
+			preferred_rot_name = str;
+			break;
+		}
+	}
+
+	if (!preferred_rot_name) {
+		pr_info("%s is NOT implemented as an IMA RoT\n", str);
+		preferred_rot_name = NAME_UNKNOWN;
+	}
+
+	return 1;
+}
+__setup("ima_rot=", ima_rot_name);
+
+/*
+ * Pick the most prioritized RoT that can be initialized successfully.
+ */
+struct ima_rot * __init ima_rot_init(void)
+{
+	int rc, i;
+
+	for (i = 0; i < ARRAY_SIZE(ima_rots); i++) {
+		if (preferred_rot_name && strcmp(preferred_rot_name, ima_rots[i].name))
+			continue;
+
+		pr_info("IMA RoT initializing %s\n", ima_rots[i].name);
+		rc = ima_rots[i].init(&ima_rots[i]);
+		if (!rc) {
+			pr_info("%s initialized and taken as IMA RoT\n", ima_rots[i].name);
+			return &ima_rots[i];
+		}
+		pr_debug("%s failed to self-initialize (%d)\n", ima_rots[i].name, rc);
+	}
+
+	return NULL;
+}
diff --git a/security/integrity/ima/ima_rot.h b/security/integrity/ima/ima_rot.h
new file mode 100644
index 000000000000..f88f8162d6c8
--- /dev/null
+++ b/security/integrity/ima/ima_rot.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Huawei Technologies Co., Ltd.
+ *
+ * Authors:
+ * GONG Ruiqi <gongruiqi1@huawei.com>
+ *
+ * File: ima_rot.h
+ *	IMA rot layer
+ */
+
+#ifndef __LINUX_IMA_ROT_H
+#define __LINUX_IMA_ROT_H
+
+#include <linux/tpm.h>
+
+/**
+ * struct ima_rot - Root of Trust (RoT) device instance.
+ * @name: Name of the device.
+ * @default_pcr: Index of default (virtual) PCR.
+ * @nr_allocated_banks: Number of (virtual) TPM banks.
+ * @allocated_banks: Info of (virtual) TPM bank.
+ * @init: Initializes this device to be an IMA RoT.
+ * @extend: Performs a hash extend operation to the device's (virtual) PCR.
+ * @calc_boot_aggregate: Generate the initial value of IMA measurement list
+ *                       (i.e. boot aggregate).
+ *
+ * Attributes and methods necessary for a device working as an RoT for IMA.
+ */
+struct ima_rot {
+	const char *name;
+	int default_pcr;
+	int nr_allocated_banks;
+	struct tpm_bank_info *allocated_banks;
+
+	int (*init)(struct ima_rot *rot);
+	int (*extend)(struct tpm_digest *digests_arg, const void *args);
+	int (*calc_boot_aggregate)(struct ima_digest_data *hash);
+};
+
+struct ima_rot *ima_rot_init(void);
+#endif /* __LINUX_IMA_ROT_H */
-- 
2.25.1


