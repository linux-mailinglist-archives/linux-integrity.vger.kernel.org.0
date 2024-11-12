Return-Path: <linux-integrity+bounces-4084-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D119C5DC5
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 17:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4F1F23447
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF720B1EB;
	Tue, 12 Nov 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YsnWFga/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F8207A27;
	Tue, 12 Nov 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430349; cv=none; b=i4O+FBAVxySzYybQz7A5gT7+8Q+XgTJ6Jj97QiVvLQHOGIjGrowHR3d9gGZuG+EyrE7WA0Z+wBHEJY/9QvnnYLMw+5XSYCgwBO/iS/GNMrmkB+aJoIeGyBDbbWUlaq/hb8GyPue0l6PoUmVju4Jnbpkne5YztN65oNdnU6vnkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430349; c=relaxed/simple;
	bh=iI5szIIcqmZrkEhRC5Ov52XwoqJuRtw9HckXkdyExoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGl8WARucrWjBWckfBhT0LN5mMYZ990iHdGDqGaOuHAAPHMGha4obWnni+1qhsq1kn+7JVmjt4BIL0dt33fABH90suhRZGuVtU1V+1QC6HllVYUkjZCvO908rhy79J1vpzhnL1Af0K87MztwYdZq2JylvegO/JT5Om7EcZ5sjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YsnWFga/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACF9wNV032510;
	Tue, 12 Nov 2024 16:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5kGHGQW/UIKfyiFBOgAB7MFfaJ7VUgcXK/YC6y9G0
	2k=; b=YsnWFga/XpiBK5kNJAAHPxl708odkqq+j+RFS/i1r/iJUevzNHsdKGAtC
	JLZVkBT8aY3/+Aojjn9qIHCEIlN4QVKoC8UvOSOvNIg7z/Los1YyrAEbDExgKkXc
	by74mVR9qzjmx1GqzERdp+q6dnfsAcLyffmJAwMYg//BAr9Jwc5XO50+y/HvesNr
	hFWBxBboLDX/M4QpkLl+A//H8Y7jhc7AZ/LqyINib61lcE39a6cfEEX/SL8iEfmU
	a/7QFp0mRB3hDofnCjsAPMqoOZTXMkblcXnqqHRhtBflxCXU81YWH9P9hP9Qk6al
	ElQVSEO/Kcy47hFeO+IaunRl+qLog==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9dv0dv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:52:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACGZ5Co008270;
	Tue, 12 Nov 2024 16:52:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeykfns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:52:16 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACGqEPU56295774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 16:52:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D620058055;
	Tue, 12 Nov 2024 16:52:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4E75804E;
	Tue, 12 Nov 2024 16:52:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 16:52:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        zohar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [PATCH v2] ima: Suspend PCR extends and log appends when rebooting
Date: Tue, 12 Nov 2024 11:52:06 -0500
Message-ID: <20241112165206.756351-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wQXyKy6mVxh0lCDZ9il-AdL2qV_-7djN
X-Proofpoint-ORIG-GUID: wQXyKy6mVxh0lCDZ9il-AdL2qV_-7djN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120133

To avoid the following types of error messages due to a failure by the TPM
driver to use the TPM, suspend TPM PCR extensions and the appending of
entries to the IMA log once IMA's reboot notifier has been called. This
avoids trying to use the TPM after the TPM subsystem has been shut down.

[111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
[111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19

This error could be observed on a ppc64 machine running SuSE Linux where
processes are still accessing files after devices have been shut down.

Suspending the IMA log and PCR extensions shortly before reboot does not
seem to open a significant measurement gap since neither TPM quoting would
work for attestation nor that new log entries could be written to anywhere
after devices have been shut down. However, there's a time window between
the invocation of the reboot notifier and the shutdown of devices in
kernel_restart_prepare() where __usermodehelper_disable() waits for all
running_helpers to exit. During this time window IMA could now miss log
entries even though attestation would still work. The reboot of the system
shortly after may make this small gap insignificant.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
 v2:
  - followed Mimi's suggestions

---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_init.c  |  2 ++
 security/integrity/ima/ima_queue.c | 43 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3c323ca213d4..3f1a82b7cd71 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -278,6 +278,7 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
+void __init ima_init_reboot_notifier(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4e208239a40e..a2f34f2d8ad7 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -152,6 +152,8 @@ int __init ima_init(void)
 
 	ima_init_key_queue();
 
+	ima_init_reboot_notifier();
+
 	ima_measure_critical_data("kernel_info", "kernel_version",
 				  UTS_RELEASE, strlen(UTS_RELEASE), false,
 				  NULL, 0);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..9b3c9587313f 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/rculist.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include "ima.h"
 
@@ -44,6 +45,12 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used internally by the kernel to suspend measurements.
+ * Protected by ima_extend_list_mutex.
+ */
+static bool ima_measurements_suspended;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -176,6 +183,17 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
+	/*
+	 * ima_measurements_suspended will be set before the TPM subsystem has
+	 * been shut down.
+	 */
+	if (ima_measurements_suspended) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		result = -ENODEV;
+		goto out;
+	}
+
 	result = ima_add_digest_entry(entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
@@ -211,6 +229,31 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	return result;
 }
 
+static void ima_measurements_suspend(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	ima_measurements_suspended = true;
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
+static int ima_reboot_notifier(struct notifier_block *nb,
+			       unsigned long action,
+			       void *data)
+{
+	ima_measurements_suspend();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ima_reboot_nb = {
+	.notifier_call = ima_reboot_notifier,
+};
+
+void __init ima_init_reboot_notifier(void)
+{
+	register_reboot_notifier(&ima_reboot_nb);
+}
+
 int __init ima_init_digests(void)
 {
 	u16 digest_size;
-- 
2.43.0


