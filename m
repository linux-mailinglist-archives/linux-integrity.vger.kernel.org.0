Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD63ACFE9
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFRQJf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:09:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55202 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232316AbhFRQJe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:34 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG28MZ010943;
        Fri, 18 Jun 2021 16:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WuPRvhKPPHvnrC9CCSyaDvvoPGhjtxqpJhLFlV4YKYQ=;
 b=ndj7LqZu8VxrvE5Dil3NXMPCPmzYr19QRnWVOEzC04o7tXNTpuU9V5uBg/w7/Eao1WBI
 XDIMfu32AB+kYJdQA7EDCGl7WepikNRfVKxumffR6R0TLMnwHpVM7HjTIUzjlYCaNkaK
 TZqOHHHfAMpZYZ7tkiiER+RFC/dUG+OR+dPv5Vt+ov7Tok+WbVWBELLzbuRN1n4ocA1h
 7LADKUQqiCgo3PrMrEBE2F2mToctPfMM1Nc6PALBsD1NGDblxH2kmHN9YUdrbq8EdCCf
 QN6s34a2IWhHnPmoqbG0cCBmkHS3+OGKWK3LwH8jprKJ9UZbxbNyQ2GavCJqCpXQKjMn 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp00ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1REx108894;
        Fri, 18 Jun 2021 16:06:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 396wawv2p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:56 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG5WDZ119680;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 396wawv2nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6rWN021853;
        Fri, 18 Jun 2021 16:06:53 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:53 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 10/12] x86: Secure Launch late initcall platform module
Date:   Fri, 18 Jun 2021 12:12:55 -0400
Message-Id: <1624032777-7013-11-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: 6Nq057nen0hWBDTvLeuiZBAvTWh5Kr1h
X-Proofpoint-GUID: 6Nq057nen0hWBDTvLeuiZBAvTWh5Kr1h
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The Secure Launch platform module is a late init module. During the
init call, the TPM event log is read and measurements taken in the
early boot stub code are located. These measurements are extended
into the TPM PCRs using the mainline TPM kernel driver.

The platform module also registers the securityfs nodes to allow
access to TXT register fields on Intel along with the fetching of
and writing events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/slmodule.c | 495 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 496 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 574e643..1187077 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 00000000..807f9ca
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and
+ * finalization support.
+ *
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ * Copyright (c) 2021 Assured Information Security, Inc.
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ *
+ * Author(s):
+ *     Daniel P. Smith <dpsmith@apertussolutions.com>
+ *     Garnet T. Grimm <grimmg@ainfosec.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <crypto/sha2.h>
+#include <linux/slaunch.h>
+
+#define SL_FS_ENTRIES		10
+/* root directory node must be last */
+#define SL_ROOT_DIR_ENTRY	(SL_FS_ENTRIES - 1)
+#define SL_TXT_DIR_ENTRY	(SL_FS_ENTRIES - 2)
+#define SL_TXT_FILE_FIRST	(SL_TXT_DIR_ENTRY - 1)
+#define SL_TXT_ENTRY_COUNT	7
+
+#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
+static ssize_t txt_pub_read_u##size(unsigned int offset,		\
+		loff_t *read_offset,					\
+		size_t read_len,					\
+		char __user *buf)					\
+{									\
+	void __iomem *txt;						\
+	char msg_buffer[msg_size];					\
+	u##size reg_value = 0;						\
+	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
+			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
+	if (IS_ERR(txt))						\
+		return PTR_ERR(txt);					\
+	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
+	iounmap(txt);							\
+	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
+	return simple_read_from_buffer(buf, read_len, read_offset,	\
+			&msg_buffer, msg_size);				\
+}
+
+DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
+DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
+DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
+
+#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
+static ssize_t txt_##reg_name##_read(struct file *flip,			\
+		char __user *buf, size_t read_len, loff_t *read_offset)	\
+{									\
+	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
+			read_len, buf);					\
+}									\
+static const struct file_operations reg_name##_ops = {			\
+	.read = txt_##reg_name##_read,					\
+}
+
+DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
+DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
+DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
+DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
+DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
+DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
+DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = {"eventlog", 0, 0};
+static void *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
+static DEFINE_MUTEX(sl_evt_log_mutex);
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	ssize_t size;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	mutex_lock(&sl_evt_log_mutex);
+	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
+				       sl_evtlog.size);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	return size;
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+				size_t datalen, loff_t *ppos)
+{
+	char *data;
+	ssize_t result;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_log_mutex);
+	if (evtlog20)
+		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
+					 sl_evtlog.size, datalen, data);
+	else
+		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
+					 datalen, data);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek	= default_llseek,
+};
+
+static struct dentry *fs_entries[SL_FS_ENTRIES];
+
+struct sfs_file {
+	int parent;
+	const char *name;
+	const struct file_operations *fops;
+};
+
+static const struct sfs_file sl_files[] = {
+	{ SL_TXT_DIR_ENTRY, "sts", &sts_ops },
+	{ SL_TXT_DIR_ENTRY, "ests", &ests_ops },
+	{ SL_TXT_DIR_ENTRY, "errorcode", &errorcode_ops },
+	{ SL_TXT_DIR_ENTRY, "didvid", &didvid_ops },
+	{ SL_TXT_DIR_ENTRY, "ver_emif", &ver_emif_ops },
+	{ SL_TXT_DIR_ENTRY, "scratchpad", &scratchpad_ops },
+	{ SL_TXT_DIR_ENTRY, "e2sts", &e2sts_ops }
+};
+
+static int sl_create_file(int entry, int parent, const char *name,
+			  const struct file_operations *ops)
+{
+	if (entry < 0 || entry > SL_TXT_DIR_ENTRY)
+		return -EINVAL;
+	fs_entries[entry] =
+		 securityfs_create_file(name, 0440,
+					fs_entries[parent], NULL, ops);
+	if (IS_ERR(fs_entries[entry])) {
+		pr_err("Error creating securityfs %s file\n", name);
+		return PTR_ERR(fs_entries[entry]);
+	}
+	return 0;
+}
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i = 0;
+
+	fs_entries[SL_ROOT_DIR_ENTRY] = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(fs_entries[SL_ROOT_DIR_ENTRY])) {
+		pr_err("Error creating securityfs slaunch root directory\n");
+		ret = PTR_ERR(fs_entries[SL_ROOT_DIR_ENTRY]);
+		goto err;
+	}
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		fs_entries[SL_TXT_DIR_ENTRY] =
+			securityfs_create_dir("txt",
+					      fs_entries[SL_ROOT_DIR_ENTRY]);
+		if (IS_ERR(fs_entries[SL_TXT_DIR_ENTRY])) {
+			pr_err("Error creating securityfs txt directory\n");
+			ret = PTR_ERR(fs_entries[SL_TXT_DIR_ENTRY]);
+			goto err_dir;
+		}
+
+		for (i = 0; i < SL_TXT_ENTRY_COUNT; i++) {
+			ret = sl_create_file(SL_TXT_FILE_FIRST - i,
+					     sl_files[i].parent, sl_files[i].name,
+					     sl_files[i].fops);
+			if (ret)
+				goto err_dir;
+		}
+	}
+
+	if (sl_evtlog.addr > 0) {
+		ret = sl_create_file(0, SL_ROOT_DIR_ENTRY, sl_evtlog.name,
+				     &sl_evtlog_ops);
+		if (ret)
+			goto err_dir;
+	}
+
+	return 0;
+
+err_dir:
+	for (i = 0; i <= SL_ROOT_DIR_ENTRY; i++)
+		securityfs_remove(fs_entries[i]);
+err:
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	for (i = 0; i < SL_FS_ENTRIES; i++)
+		securityfs_remove(fs_entries[i]);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		if (sl_evtlog.addr) {
+			memunmap(sl_evtlog.addr);
+			sl_evtlog.addr = NULL;
+		}
+		sl_evtlog.size = 0;
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+}
+
+static void slaunch_intel_evtlog(void __iomem *txt)
+{
+	struct txt_os_mle_data *params;
+	void *os_sinit_data;
+	u64 base, size;
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TXT heap\n",
+			SL_ERROR_HEAP_MAP);
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	sl_evtlog.size = params->evtlog_size;
+	sl_evtlog.addr = memremap(params->evtlog_addr, params->evtlog_size,
+				  MEMREMAP_WB);
+	if (!sl_evtlog.addr)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TPM event log\n",
+			SL_ERROR_EVENTLOG_MAP);
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
+		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog20)
+		slaunch_txt_reset(txt,
+			"Error failed to find TPM20 event log element\n",
+			SL_ERROR_TPM_INVALID_LOG20);
+}
+
+static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
+				       struct tcg_pcr_event2_head *event)
+{
+	struct tpm_digest *digests;
+	u16 *alg_id_field = (u16 *)((u8 *)event +
+				    sizeof(struct tcg_pcr_event2_head));
+	u8 *dptr;
+	int ret;
+	u32 i, j;
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		slaunch_txt_reset(txt,
+			"Failed to allocate array of digests\n",
+			SL_ERROR_GENERIC);
+
+	for (i = 0; i < tpm->nr_allocated_banks; i++)
+		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
+
+
+	/* Early SL code ensured there was a max count of 2 digests */
+	for (i = 0; i < event->count; i++) {
+		dptr = (u8 *)alg_id_field + sizeof(u16);
+
+		for (j = 0; j < tpm->nr_allocated_banks; j++) {
+			if (digests[j].alg_id != *alg_id_field)
+				continue;
+
+			switch (digests[j].alg_id) {
+			case TPM_ALG_SHA256:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA256_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA256_DIGEST_SIZE + sizeof(u16));
+				break;
+			case TPM_ALG_SHA1:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA1_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA1_DIGEST_SIZE + sizeof(u16));
+				break;
+			default:
+				;
+			}
+		}
+	}
+
+	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
+	if (ret) {
+		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
+		slaunch_txt_reset(txt,
+			"Failed to extend TPM20 PCR\n",
+			SL_ERROR_TPM_EXTEND);
+	}
+
+	kfree(digests);
+}
+
+static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tcg_pcr_event *event_header =
+		(struct tcg_pcr_event *)(sl_evtlog.addr +
+					 evtlog20->first_record_offset);
+	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
+	struct tcg_pcr_event2_head *event =
+		(struct tcg_pcr_event2_head *)((u8 *)event_header +
+					       sizeof(struct tcg_pcr_event) +
+					       event_header->event_size);
+	int start = 0, end = 0, size;
+
+	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
+		size = __calc_tpm2_event_size(event, event_header, false);
+		if (!size)
+			slaunch_txt_reset(txt,
+				"TPM20 invalid event in event log\n",
+				SL_ERROR_TPM_INVALID_EVENT);
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start)
+			slaunch_tpm20_extend_event(tpm, txt, event);
+
+next:
+		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM20 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tpm12_event_log_header *event_header =
+		(struct tpm12_event_log_header *)sl_evtlog.addr;
+	struct tcg_pcr_event *event =
+		(struct tcg_pcr_event *)((u8 *)event_header +
+				sizeof(struct tpm12_event_log_header));
+	struct tpm_digest digest;
+	int start = 0, end = 0, size, ret;
+
+	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
+		size = sizeof(struct tcg_pcr_event) + event->event_size;
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start) {
+			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
+			digest.alg_id = TPM_ALG_SHA1;
+			memcpy(&digest.digest[0], &event->digest[0],
+			       SHA1_DIGEST_SIZE);
+
+			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
+			if (ret) {
+				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
+				slaunch_txt_reset(txt,
+					"Failed to extend TPM12 PCR\n",
+					SL_ERROR_TPM_EXTEND);
+			}
+		}
+
+next:
+		event = (struct tcg_pcr_event *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM12 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_pcr_extend(void __iomem *txt)
+{
+	struct tpm_chip *tpm;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		slaunch_txt_reset(txt,
+			"Could not get default TPM chip\n",
+			SL_ERROR_TPM_INIT);
+	if (evtlog20)
+		slaunch_tpm20_extend(tpm, txt);
+	else
+		slaunch_tpm12_extend(tpm, txt);
+}
+
+static int __init slaunch_module_init(void)
+{
+	void __iomem *txt;
+
+	/* Check to see if Secure Launch happened */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
+		return 0;
+
+	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+		      PAGE_SIZE);
+	if (!txt)
+		panic("Error ioremap of TXT priv registers\n");
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog(txt);
+
+	slaunch_pcr_extend(txt);
+
+	iounmap(txt);
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_module_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_module_init);
+
+__exitcall(slaunch_module_exit);
-- 
1.8.3.1

