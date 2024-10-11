Return-Path: <linux-integrity+bounces-3784-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1099A721
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D6B284E1B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B2188CB1;
	Fri, 11 Oct 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i7ugDCY/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A2129E9C;
	Fri, 11 Oct 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659151; cv=none; b=aWYuaQsz/Cyt8GkvgR+nw18EFBOCY8g1cER2LlZyR+SgFy4pQuajuri3g0rHy5SXoMHdFcnuyCqLIoyu9M/65CkElMZhSa2KsIvyitN6qNEL3r/L9TtbQ497f6rbyf6LGMSrhujz3rgKTU+NkQlPtdTXoNFHulAKyH/NBb4dce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659151; c=relaxed/simple;
	bh=VE6P0QHlXoUSZ0wmR9juGSI8wFYkmHU+tHyy3N6cDNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNVa+6HA1VJSmBb1k//3r+CEbPvBlxZjws4XRd1am1EhgespbJyz2nU59IVMT+5akxrK25Gk7Vd0pVoPbLdY7nS/AaEjmGq0tpVbdvMRuiOBtn4Td+Dg9PkyaLL1+fSTFNzRcu9kJBmuI12NoLzxXl2aZhvKn2VifQzZvvEtMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i7ugDCY/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEwFt2031673;
	Fri, 11 Oct 2024 15:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=qOxhXgWL0DgoTYYCZfjO66lp0z
	KMKmhEMISDkO68gf8=; b=i7ugDCY/BJjUEFZwxzP0nvYYUvMK9X9rPDfr/0szv5
	Xu3vqS7yQXH1chKbyEYW9tFNeOYVTLcpXvtCVtoEmXezj3GmXPyFF/YpldYSbV47
	KAPM1Dvqs88tm306cAk8Eekk8pdx7CvOQw6Oij52dHaH8eP8WkWufLhMFeQ5Tp7D
	HkwlT4NqGa0Z2pLc3sYLkG9MUIVcU4opBaF+Do/m4DwRQMu6cmfegP1sMTO0D/CQ
	dWigDQqs3A52RdD2fNcqCmQLTlYi25UCQ5hHX2PUiQakYu/WRJjyrOACFcE+fDIy
	q2h5C0bxqh1ms9D/W6qSLk76S2YZvabJPHUtiQLCztiA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42760t03yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 15:05:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BE1Fsm030168;
	Fri, 11 Oct 2024 15:05:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsn6779-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 15:05:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49BF5bpv41025924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:05:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA7958059;
	Fri, 11 Oct 2024 15:05:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1641258055;
	Fri, 11 Oct 2024 15:05:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Oct 2024 15:05:36 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [PATCH] ima: Suspend PCR extends and log appends when rebooting
Date: Fri, 11 Oct 2024 11:05:22 -0400
Message-ID: <20241011150522.2697216-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: blaEVUvpSb-6NHgK1BdNTOGVk01qy-BA
X-Proofpoint-ORIG-GUID: blaEVUvpSb-6NHgK1BdNTOGVk01qy-BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110104

To avoid the following types of error messages from the TPM driver, suspend
PCR extends once the reboot notifier has been called. This avoids trying to
use the TPM after the TPM subsystem has been shut down.

[111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
[111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19

This error could be observed on a ppc64 machine running SuSE Linux.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_init.c  | 16 ++++++++++++++++
 security/integrity/ima/ima_queue.c | 27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..d3f46232b8b9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+void ima_measurements_suspend(void);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4e208239a40e..ac630d8d3049 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
 #include <generated/utsrelease.h>
 
 #include "ima.h"
@@ -115,6 +116,19 @@ void __init ima_load_x509(void)
 }
 #endif
 
+static int ima_reboot_notify(struct notifier_block *nb,
+                      unsigned long action,
+                      void *data)
+{
+	ima_measurements_suspend();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ima_reboot_notifier = {
+	.notifier_call = ima_reboot_notify,
+};
+
 int __init ima_init(void)
 {
 	int rc;
@@ -152,6 +166,8 @@ int __init ima_init(void)
 
 	ima_init_key_queue();
 
+	register_reboot_notifier(&ima_reboot_notifier);
+
 	ima_measure_critical_data("kernel_info", "kernel_version",
 				  UTS_RELEASE, strlen(UTS_RELEASE), false,
 				  NULL, 0);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..b8613b6c1a39 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -44,6 +44,12 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used internally by the kernel to suspend-resume ima measurements.
+ * Protected by ima_extend_list_mutex.
+ */
+static bool suspend_ima_measurements;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -148,6 +154,13 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 	return result;
 }
 
+void ima_measurements_suspend(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	suspend_ima_measurements = true;
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -176,6 +189,20 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
+	/*
+	 * suspend_ima_measurements will be set if the system is
+	 * undergoing kexec soft boot to a new kernel.
+	 * suspending measurements in this short window ensures the
+	 * consistency of the IMA measurement list during copying
+	 * of the kexec buffer.
+	 */
+	if (suspend_ima_measurements) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		result = -ENODEV;
+		goto out;
+	}
+
 	result = ima_add_digest_entry(entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
-- 
2.35.3


