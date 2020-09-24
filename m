Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47829277487
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIXO6m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 10:58:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57270 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgIXO6l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OErXvv101502;
        Thu, 24 Sep 2020 14:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=EG2cDtHDj3afXnJV2kE6YpRWdf+r6HX61ECzGa4txCg=;
 b=IahnXl8HN8sriDPY4qBMrEjj0cpksyu87777AgCnlvd433L2GxdhBXGtxsMEOGY9XJS4
 ZEpHEMeTn9bto6biMUo0YVi6HXHhjxTatqGsxxDU6U9l51BJtRD5OZh/3C4l9VMoDecM
 s1keeIlhTS4GOZtB3M4ZBZ6h0Cj/Btyo5okriT/MoTsa7f9lH8yEXDghi0arnwaabujR
 HU79PSfaeOz//T2ikWpn3fLVGDTFq/n+98HenF/JDAozyeDFcguPdMjszMfvlorZzpkN
 cnajd4BEXtXUXQOvY2LKs6uVX7JJC4ZhdeLftfXLafbt4W6gNBIWEEjluMWCztoPb3Ha DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcpu5qcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 14:58:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEtUQZ159389;
        Thu, 24 Sep 2020 14:58:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33nux2vwnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OEwGIx016161;
        Thu, 24 Sep 2020 14:58:16 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:16 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 10/13] x86: Secure Launch adding event log securityfs
Date:   Thu, 24 Sep 2020 10:58:38 -0400
Message-Id: <1600959521-24158-11-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The late init functionality registers securityfs nodes to allow access
to TXT register fields on Intel along with the fetching of and writing
events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
---
 arch/x86/kernel/slaunch.c | 293 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 292 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index e040e32..7bdb89e 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -8,7 +8,7 @@
  *
  * Author(s):
  *     Daniel P. Smith <dpsmith@apertussolutions.com>
- *
+ *     Garnet T. Grimm <grimmg@ainfosec.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -493,3 +493,294 @@ void __init slaunch_setup(void)
 	    vendor[3] == INTEL_CPUID_MFGID_EDX)
 		slaunch_setup_intel();
 }
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
+					 datalen, data);
+	else
+		result = tpm12_log_event(sl_evtlog.addr, datalen, data);
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
+		const struct file_operations *ops)
+{
+	if (entry < 0 || entry > SL_TXT_DIR_ENTRY)
+		return -EINVAL;
+	fs_entries[entry] = securityfs_create_file(name, 0440,
+			fs_entries[parent], NULL, ops);
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
+	if (sl_flags & SL_FLAG_ARCH_TXT) {
+		fs_entries[SL_TXT_DIR_ENTRY] = securityfs_create_dir("txt",
+				fs_entries[SL_ROOT_DIR_ENTRY]);
+		if (IS_ERR(fs_entries[SL_TXT_DIR_ENTRY])) {
+			pr_err("Error creating securityfs txt directory\n");
+			ret = PTR_ERR(fs_entries[SL_TXT_DIR_ENTRY]);
+			goto err_dir;
+		}
+
+		for (i = 0; i < SL_TXT_ENTRY_COUNT; i++) {
+			ret = sl_create_file(SL_TXT_FILE_FIRST - i,
+					sl_files[i].parent, sl_files[i].name,
+					sl_files[i].fops);
+			if (ret)
+				goto err_dir;
+		}
+	}
+
+	if (sl_evtlog.addr > 0) {
+		ret = sl_create_file(0, SL_ROOT_DIR_ENTRY, sl_evtlog.name,
+				&sl_evtlog_ops);
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
+	if (sl_flags & SL_FLAG_ARCH_TXT) {
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
+static void slaunch_intel_evtlog(void)
+{
+	void __iomem *config;
+	struct txt_os_mle_data *params;
+	void *os_sinit_data;
+	u64 base, size;
+
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_err("Error failed to ioremap TXT reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&base, config + TXT_CR_HEAP_BASE, sizeof(u64));
+	memcpy_fromio(&size, config + TXT_CR_HEAP_SIZE, sizeof(u64));
+	iounmap(config);
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap) {
+		pr_err("Error failed to memremap TXT heap\n");
+		return;
+	}
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	sl_evtlog.size = params->evtlog_size;
+	sl_evtlog.addr = memremap(params->evtlog_addr, params->evtlog_size,
+				  MEMREMAP_WB);
+	if (!sl_evtlog.addr) {
+		pr_err("Error failed to memremap TPM event log\n");
+		return;
+	}
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tpm12_pcr_event),
+		    TPM20_EVTLOG_SIGNATURE, sizeof(TPM20_EVTLOG_SIGNATURE)))
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
+		pr_err("Error failed to find TPM20 event log element\n");
+}
+
+static int __init slaunch_late_init(void)
+{
+	/* Check to see if Secure Launch happened */
+	if (!(sl_flags & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)))
+		return 0;
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog();
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_late_init);
+
+__exitcall(slaunch_exit);
-- 
1.8.3.1

