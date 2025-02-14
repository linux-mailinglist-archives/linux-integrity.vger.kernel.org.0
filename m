Return-Path: <linux-integrity+bounces-4825-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7240A352D6
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 01:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC3016A188
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F3275417;
	Fri, 14 Feb 2025 00:27:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B35228;
	Fri, 14 Feb 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492878; cv=none; b=FNclAOne/Ra8YvTiTPYMqccrl7K1Casy0/L/gFJ8dB7z4St8SaS/Qudy+gIW33h2/+RmUxUM54VY83208hKQTFW8gmVx5phf0/AXIgo3ec1dt3vP0i6ryVdxF0C035JyAoZWRq9GciWdYtFkMQ9nU3Xvq5YBV3s9NCMMPMv8MD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492878; c=relaxed/simple;
	bh=ZixwQJUuEXAoTI4MJdSnEFALiqrdtAKNVE63vO12Kh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWWrZ/kQPDx47823t78PAJT3CXF8x6uV9o1MZDelUMeLIoT1PX/R7Mc48zVACS4flBWCjtag/eUt6ETfRCvO590vi50Onn2VKtt5xQtRv0cSmJiH1AMYIjOcwbM0WHMNjJocXFmqQSiZtethyCXBjG/5YVk7aZMB0LYRAsPBlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3651682;
	Thu, 13 Feb 2025 16:28:16 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99E2B3F762;
	Thu, 13 Feb 2025 16:27:55 -0800 (PST)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] tpm_crb: implement driver compliant to CRB over FF-A
Date: Thu, 13 Feb 2025 18:27:41 -0600
Message-Id: <20250214002745.878890-2-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214002745.878890-1-stuart.yoder@arm.com>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm specification TPM Service CRB over FF-A specification
defines the FF-A messages to interact with a CRB-based TPM
implemented as an FF-A secure partition.

Spec URL:
https://developer.arm.com/documentation/den0138/latest/

This driver is probed when a TPM Secure Partition is
discovered by the FF-A subsystem. It exposes APIs
used by the TPM CRB driver to send notifications to
the TPM.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/Kconfig       |   9 +
 drivers/char/tpm/Makefile      |   1 +
 drivers/char/tpm/tpm_crb_ffa.c | 310 +++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_crb_ffa.h |  30 ++++
 4 files changed, 350 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e059..4c85b8c00b12 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -210,6 +210,15 @@ config TCG_CRB
 	  from within Linux.  To compile this driver as a module, choose
 	  M here; the module will be called tpm_crb.
 
+config TCG_ARM_CRB_FFA
+	tristate "TPM CRB over Arm FF-A Transport"
+	depends on ARM_FFA_TRANSPORT
+	default y if (TCG_CRB && ARM_FFA_TRANSPORT)
+	help
+	  If the Arm FF-A transport is used to access the TPM say Yes.
+	  To compile this driver as a module, choose M here; the module
+	  will be called tpm_crb_ffa.
+
 config TCG_VTPM_PROXY
 	tristate "VTPM Proxy Interface"
 	depends on TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9bb142c75243..2b004df8c04b 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -42,5 +42,6 @@ obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
 obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
 obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
+obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
new file mode 100644
index 000000000000..3bd9fd81ec21
--- /dev/null
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * This device driver implements the TPM CRB start method
+ * as defined in the TPM Service Command Response Buffer
+ * Interface Over FF-A (DEN0138).
+ */
+
+#define pr_fmt(fmt) "CRB_FFA: " fmt
+
+#include <linux/arm_ffa.h>
+#include "tpm_crb_ffa.h"
+
+/* TPM service function status codes */
+#define CRB_FFA_OK			0x05000001
+#define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
+#define CRB_FFA_NOFUNC			0x8e000001
+#define CRB_FFA_NOTSUP			0x8e000002
+#define CRB_FFA_INVARG			0x8e000005
+#define CRB_FFA_INV_CRB_CTRL_DATA	0x8e000006
+#define CRB_FFA_ALREADY			0x8e000009
+#define CRB_FFA_DENIED			0x8e00000a
+#define CRB_FFA_NOMEM			0x8e00000b
+
+#define CRB_FFA_VERSION_MAJOR	1
+#define CRB_FFA_VERSION_MINOR	0
+
+/* version encoding */
+#define CRB_FFA_MAJOR_VERSION_MASK  GENMASK(30, 16)
+#define CRB_FFA_MINOR_VERSION_MASK  GENMASK(15, 0)
+#define CRB_FFA_MAJOR_VERSION(x)    ((u16)(FIELD_GET(CRB_FFA_MAJOR_VERSION_MASK, (x))))
+#define CRB_FFA_MINOR_VERSION(x)    ((u16)(FIELD_GET(CRB_FFA_MINOR_VERSION_MASK, (x))))
+
+/*
+ * Normal world sends requests with FFA_MSG_SEND_DIRECT_REQ and
+ * responses are returned with FFA_MSG_SEND_DIRECT_RESP for normal
+ * messages.
+ *
+ * All requests with FFA_MSG_SEND_DIRECT_REQ and FFA_MSG_SEND_DIRECT_RESP
+ * are using the AArch32 SMC calling convention with register usage as
+ * defined in FF-A specification:
+ * w0:    Function ID (0x8400006F or 0x84000070)
+ * w1:    Source/Destination IDs
+ * w2:    Reserved (MBZ)
+ * w3-w7: Implementation defined, free to be used below
+ */
+
+/*
+ * Returns the version of the interface that is available
+ * Call register usage:
+ * w3:    Not used (MBZ)
+ * w4:    TPM service function ID, CRB_FFA_GET_INTERFACE_VERSION
+ * w5-w7: Reserved (MBZ)
+ *
+ * Return register usage:
+ * w3:    Not used (MBZ)
+ * w4:    TPM service function status
+ * w5:    TPM service interface version
+ *        Bits[31:16]: major version
+ *        Bits[15:0]: minor version
+ * w6-w7: Reserved (MBZ)
+ *
+ * Possible function status codes in register w4:
+ *     CRB_FFA_OK_RESULTS_RETURNED: The version of the interface has been
+ *                                  returned.
+ */
+#define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
+
+/*
+ * Return information on a given feature of the TPM service
+ * Call register usage:
+ * w3:    Not used (MBZ)
+ * w4:    TPM service function ID, CRB_FFA_START
+ * w5:    Start function qualifier
+ *            Bits[31:8] (MBZ)
+ *            Bits[7:0]
+ *              0: Notifies TPM that a command is ready to be processed
+ *              1: Notifies TPM that a locality request is ready to be processed
+ * w6:    TPM locality, one of 0..4
+ *            -If the start function qualifier is 0, identifies the locality
+ *             from where the command originated.
+ *            -If the start function qualifier is 1, identifies the locality
+ *             of the locality request
+ * w6-w7: Reserved (MBZ)
+ *
+ * Return register usage:
+ * w3:    Not used (MBZ)
+ * w4:    TPM service function status
+ * w5-w7: Reserved (MBZ)
+ *
+ * Possible function status codes in register w4:
+ *     CRB_FFA_OK: the TPM service has been notified successfully
+ *     CRB_FFA_INVARG: one or more arguments are not valid
+ *     CRB_FFA_INV_CRB_CTRL_DATA: CRB control data or locality control
+ *         data at the given TPM locality is not valid
+ *     CRB_FFA_DENIED: the TPM has previously disabled locality requests and
+ *         command processing at the given locality
+ */
+#define CRB_FFA_START 0x0f000201
+
+struct tpm_crb_ffa {
+	struct ffa_device *ffa_dev;
+	u16 major_version;
+	u16 minor_version;
+	struct mutex msg_data_lock;
+	struct ffa_send_direct_data direct_msg_data;
+};
+
+static struct tpm_crb_ffa *tpm_crb_ffa;
+
+static int tpm_crb_ffa_to_linux_errno(int errno)
+{
+	int rc;
+
+	switch (errno) {
+	case CRB_FFA_OK:
+		rc = 0;
+		break;
+	case CRB_FFA_OK_RESULTS_RETURNED:
+		rc = 0;
+		break;
+	case CRB_FFA_NOFUNC:
+		rc = -ENOENT;
+		break;
+	case CRB_FFA_NOTSUP:
+		rc = -EPERM;
+		break;
+	case CRB_FFA_INVARG:
+		rc = -EINVAL;
+		break;
+	case CRB_FFA_INV_CRB_CTRL_DATA:
+		rc = -ENOEXEC;
+		break;
+	case CRB_FFA_ALREADY:
+		rc = -EEXIST;
+		break;
+	case CRB_FFA_DENIED:
+		rc = -EACCES;
+		break;
+	case CRB_FFA_NOMEM:
+		rc = -ENOMEM;
+		break;
+	default:
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+int tpm_crb_ffa_init(void)
+{
+	if (tpm_crb_ffa == NULL)
+		return -ENOENT;
+
+	if (IS_ERR_VALUE(tpm_crb_ffa))
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
+
+static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
+		unsigned long a0, unsigned long a1, unsigned long a2)
+{
+	int ret;
+	const struct ffa_msg_ops *msg_ops;
+
+	if (tpm_crb_ffa == NULL)
+		return -ENOENT;
+
+	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
+
+	memset(&tpm_crb_ffa->direct_msg_data, 0x00,
+			sizeof(struct ffa_send_direct_data));
+
+	tpm_crb_ffa->direct_msg_data.data1 = func_id;
+	tpm_crb_ffa->direct_msg_data.data2 = a0;
+	tpm_crb_ffa->direct_msg_data.data3 = a1;
+	tpm_crb_ffa->direct_msg_data.data4 = a2;
+
+	ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
+			&tpm_crb_ffa->direct_msg_data);
+	if (!ret)
+		ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
+
+	return ret;
+}
+
+int tpm_crb_ffa_get_interface_version(uint16_t *major, uint16_t *minor)
+{
+	int rc;
+
+	if (tpm_crb_ffa == NULL)
+		return -ENOENT;
+
+	if (IS_ERR_VALUE(tpm_crb_ffa))
+		return -ENODEV;
+
+	if (major == NULL || minor == NULL)
+		return -EINVAL;
+
+	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
+
+	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
+	if (!rc) {
+		*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
+		*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_crb_ffa_get_interface_version);
+
+int tpm_crb_ffa_start(int request_type, int locality)
+{
+	if (tpm_crb_ffa == NULL)
+		return -ENOENT;
+
+	if (IS_ERR_VALUE(tpm_crb_ffa))
+		return -ENODEV;
+
+	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
+
+	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
+}
+EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
+
+static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
+{
+	int rc;
+	struct tpm_crb_ffa *p;
+
+	/* only one instance of a TPM partition is supported */
+	if (tpm_crb_ffa && !IS_ERR_VALUE(tpm_crb_ffa))
+		return -EEXIST;
+
+	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
+
+	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
+		pr_err("TPM partition doesn't support direct message receive.\n");
+		return -EINVAL;
+	}
+
+	p = kzalloc(sizeof(*tpm_crb_ffa), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	tpm_crb_ffa = p;
+
+	mutex_init(&tpm_crb_ffa->msg_data_lock);
+	tpm_crb_ffa->ffa_dev = ffa_dev;
+	ffa_dev_set_drvdata(ffa_dev, tpm_crb_ffa);
+
+	/* if TPM is aarch32 use 32-bit SMCs */
+	if (!ffa_partition_check_property(ffa_dev, FFA_PARTITION_AARCH64_EXEC))
+		ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
+
+	/* verify compatibility of TPM service version number */
+	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
+			&tpm_crb_ffa->minor_version);
+	if (rc) {
+		pr_err("failed to get crb interface version. rc:%d", rc);
+		goto out;
+	}
+
+	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
+		tpm_crb_ffa->minor_version);
+
+	if ((tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR) ||
+	    (tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
+		pr_err("Incompatible ABI version");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	kfree(tpm_crb_ffa);
+	tpm_crb_ffa = ERR_PTR(-ENODEV);
+	return -EINVAL;
+}
+
+static void tpm_crb_ffa_remove(struct ffa_device *ffa_dev)
+{
+	kfree(tpm_crb_ffa);
+	tpm_crb_ffa = NULL;
+}
+
+static const struct ffa_device_id tpm_crb_ffa_device_id[] = {
+	/* 17b862a4-1806-4faf-86b3-089a58353861 */
+	{ UUID_INIT(0x17b862a4, 0x1806, 0x4faf,
+		    0x86, 0xb3, 0x08, 0x9a, 0x58, 0x35, 0x38, 0x61) },
+	{}
+};
+
+static struct ffa_driver tpm_crb_ffa_driver = {
+	.name = "ffa-crb",
+	.probe = tpm_crb_ffa_probe,
+	.remove = tpm_crb_ffa_remove,
+	.id_table = tpm_crb_ffa_device_id,
+};
+
+module_ffa_driver(tpm_crb_ffa_driver);
+
+MODULE_AUTHOR("Arm");
+MODULE_DESCRIPTION("FFA CRB driver");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_crb_ffa.h b/drivers/char/tpm/tpm_crb_ffa.h
new file mode 100644
index 000000000000..da73c299c48c
--- /dev/null
+++ b/drivers/char/tpm/tpm_crb_ffa.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ *
+ * Authors:
+ * Stuart Yoder <stuart.yoder@arm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * This device driver implements the TPM CRB start method
+ * as defined in the TPM Service Command Response Buffer
+ * Interface Over FF-A (DEN0138).
+ */
+#ifndef _TPM_CRB_FFA_H
+#define _TPM_CRB_FFA_H
+
+#if IS_ENABLED(CONFIG_TCG_ARM_CRB_FFA)
+int tpm_crb_ffa_init(void);
+int tpm_crb_ffa_get_interface_version(uint16_t *major, uint16_t *minor);
+int tpm_crb_ffa_start(int request_type, int locality);
+#else
+static inline int tpm_crb_ffa_init(void) { return 0; }
+static inline int tpm_crb_ffa_get_interface_version(uint16_t *major, uint16_t *minor) { return 0; }
+static inline int tpm_crb_ffa_start(int request_type, int locality) { return 0; }
+#endif
+
+#define CRB_FFA_START_TYPE_COMMAND 0
+#define CRB_FFA_START_TYPE_LOCALITY_REQUEST 1
+
+#endif
-- 
2.34.1


