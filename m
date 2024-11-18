Return-Path: <linux-integrity+bounces-4127-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9229D1457
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2024 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0598EB2A6BA
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479711A9B3D;
	Mon, 18 Nov 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="areC5p2a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0813D518;
	Mon, 18 Nov 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941890; cv=none; b=fA/SOFl6Ev9aiRe1zc71aoNF8OfkV3ZgM8g3H21IPO9U07sVzYIJD/aZJL4G+5qDNDrgPPrHQeUibvaRpnHDPmN5Hdk0VV7ZShnDCOJeO5tMwNpwDoK/+uUeaL9Ed2YpTDfGHLOYCNrqWsWN9VwqR2tZeHxMMxCaXbPL42wG2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941890; c=relaxed/simple;
	bh=cY/3EZ1/rIUKj6nA/2T++bb1HPfWnyEXEsAsEslo11o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiF6oJpgYuQZJg1B5dcbmdfF4WrnrvDnh9sRkIDBeRcZ6+K/PWh4NpAO+oU+eNoxTknoSucd7qmDhoYZv0gE2Tl3QE8c8Uxqj4SfBG4A2h8NdrwveTz57TtONxutXxqzBp4FoAp7+aAOheb9MDL69tWPsLtoKMW9eqbrHKTSlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=areC5p2a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIDTD6G003352;
	Mon, 18 Nov 2024 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c6t0TcuKxeY2VY9QNhhebI8mq3rfkrSo2oexHy4Yy
	lk=; b=areC5p2akx3l0wqMgznZPPDyzNkJKhSunaXWjJrRwiSJ2o/qQklyFxYKl
	FTkzARjqzsdmlHZC8mW5tmMxChmudPoJrsYu5txJugvKUoLJ7ve9lVTFfD9sabyB
	UrNQW4SfZsiXBWjHqefWSGy2qhmNVMVKztlERLQDiEH0KS4E+Y0E3U4D/I1dVSWE
	+jSAfcAEwvX6jd1Sr+S3IPffe2S0PvOSHHRaf4wOiihE9NFaysP7SHmglMPof4sM
	lev+N3aV9/fs1O+B2Cpy0gT9EYb9Rf1LrNyi9zqR2SijdUNDtllAC6MozCDYu98G
	dy3rSaxvgYk6Wn+XKjq8TZ0lKrZVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1gcd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 14:57:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIDbYQY000599;
	Mon, 18 Nov 2024 14:57:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77kmthy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 14:57:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AIEviWi43844128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 14:57:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2FD58051;
	Mon, 18 Nov 2024 14:57:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FB665805C;
	Mon, 18 Nov 2024 14:57:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 14:57:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        zohar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [PATCH v3] ima: Suspend PCR extends and log appends when rebooting
Date: Mon, 18 Nov 2024 09:57:31 -0500
Message-ID: <20241118145732.1258631-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MPRWE60AY8HBaGLZtXIpTHJOWOJQujsl
X-Proofpoint-ORIG-GUID: MPRWE60AY8HBaGLZtXIpTHJOWOJQujsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180124

From: Stefan Berger <stefanb@linux.ibm.com>

To avoid the following types of error messages due to a failure by the TPM
driver to use the TPM, suspend TPM PCR extensions and the appending of
entries to the IMA log once IMA's reboot notifier has been called. This
avoids trying to use the TPM after the TPM subsystem has been shut down.

[111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
[111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19

Synchronization with the ima_extend_list_mutex to set
ima_measurements_suspended ensures that the TPM subsystem is not shut down
when IMA holds the mutex while appending to the log and extending the PCR.
The alternative of reading the system_state variable would not provide this
guarantee.

This error could be observed on a ppc64 machine running SuSE Linux where
processes are still accessing files after devices have been shut down.

Suspending the IMA log and PCR extensions shortly before reboot does not
seem to open a significant measurement gap since neither TPM quoting would
work for attestation nor that new log entries could be written to anywhere
after devices have been shut down. However, there's a time window between
the invocation of the reboot notifier and the shutdown of devices. This
includes all subsequently invoked reboot notifiers as well as
kernel_restart_prepare() where __usermodehelper_disable() waits for all
running_helpers to exit. During this time window IMA could now miss log
entries even though attestation would still work. The reboot of the system
shortly after may make this small gap insignificant.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_init.c  |  2 ++
 security/integrity/ima/ima_queue.c | 44 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

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
index 532da87ce519..83d53824aa98 100644
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
@@ -168,6 +175,18 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	int result = 0, tpmresult = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
+
+	/*
+	 * Avoid appending to the measurement log when the TPM subsystem has
+	 * been shut down while preparing for system reboot.
+	 */
+	if (ima_measurements_suspended) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		result = -ENODEV;
+		goto out;
+	}
+
 	if (!violation && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
 		if (ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
@@ -211,6 +230,31 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
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


