Return-Path: <linux-integrity+bounces-6401-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC2AD44A6
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B363189CD7C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766428314E;
	Tue, 10 Jun 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="djjF8bE5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612C283CBF;
	Tue, 10 Jun 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590380; cv=none; b=REuUHh3MXxsS4QYhx5EUBofiKnRqmZaCpiE4Lhx4cycn+pmIzZcHUgBxZS/odyk7hSphOB/I+Fkhy3I1J14qFTRrQVK2ZB1SbHblIsx6FzcPhTKEQyUETKF3ugrN6k9OUq409glqJZgkXQcUAhnotd8v6ni02kiRqsQ0iPYTtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590380; c=relaxed/simple;
	bh=iM3m2zP+VBhWyWq7DNfWMJcMtnrc3pPdT5+05lOfW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP/8rx2FycP7UFcxWhvibjRMSr8hA/PE2NiI+3rtZNXviCrNTp3ureJRip2p9nNV0G96llu0WPYkwwbHUN6zGeSZGmtKuCtsUBzpo+OVgBr+sgJZWhILyF42A/soMpFOjJCQHr2flG/ONaDCRV54AGuItxjDiwPPmdMZOrquHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=djjF8bE5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIwPhi021397;
	Tue, 10 Jun 2025 21:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmzFqBJbcjrL+CWfY
	0ZbYCONlwyjWQK7JNaPcqkMwyw=; b=djjF8bE5tSj2zmPaDWxJi6R0CwJ7KKEjH
	ZFKia4SWuQcoE6nMv/8X7KIj/23DHA8Fwt/KDLVQKlpIunhnPuVZbDxP4avZbToP
	Thb/T35SmVfgWp1njS8R+4vN4/vFhPgCmW+evf2aHu41C3LbWOqqOePI6eN8XxWi
	nGWD5iS2R+08hfmaNvmgblzmj+bwWa9dhvDKaEZiIBzkMoFpPjjUr7k3g6uw2hfw
	VUDAVS2IRZXCkP2qVk3A58VR5AVfiWWoLtOYRHPC/UzN/u4ln8MnDFto6PBkOpF1
	6sPf8s4fEAbw2RRNAME3AfO3e1cJpe8UydBNRtrgsosmN4BGbnoBg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7grw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55ALJLpm024307;
	Tue, 10 Jun 2025 21:19:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7grw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AJiV7I022352;
	Tue, 10 Jun 2025 21:19:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yvkfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ALJFMt47710598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:19:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C28320043;
	Tue, 10 Jun 2025 21:19:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E478F2004E;
	Tue, 10 Jun 2025 21:19:11 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 21:19:11 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] powerpc/pseries: Correct secvar format representation for static key management
Date: Wed, 11 Jun 2025 02:49:05 +0530
Message-ID: <20250610211907.101384-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610211907.101384-1-ssrish@linux.ibm.com>
References: <20250610211907.101384-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wu7Yh1l6Ez2w4RlaZC1Zg3FNag7S-R38
X-Proofpoint-GUID: FWFqGftQl1wzBsRI1f94I_BCOU4hg9Mg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3NCBTYWx0ZWRfX8aT+UVGDWCqj ihMtY6NvmbsC1onDw5P/0FD0iclkt/+k20o5YSUZ0SJzTA5KVjCRSI64juAvxcaoZRdPE/uXmIO nONTawWFscp6kSFgUlEAgLFVqHp88UouTKUd6aGgCi+5bbi4CihHromCQLYN5P/4v06zQ3Q1tS4
 xmfpGmnebjws7R2u2uuryo1y474Bx4SXg/0Z/8LiWr+AUqxdoeP0/opJGgWG5Odhy2m9CmgLjrS a43pjrcULV3X0F6+X5ac/h18r3jFXyie9tA/liYRuCZGRGnzmyBq8k/+CfJ+QCCswAk+I32I0sL Efzopzb83l1swplP3SkfnrvwXpoqsrgLqW5EHhu8ONsQegSQVCXeDNi9eKFbahh5OC8ftwLaM/y
 tKN1lb2xADWFV1HkfDxsPiIeXfhS+3hOe5eUzvShU4JzvxsyIn48zfnJYK3Nby72wfbihrBV
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=6848a159 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=FNRAjOYsECM2cVzVVdoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100174

On a PLPKS enabled PowerVM LPAR, the secvar format property for static
key management is misrepresented as "ibm,plpks-sb-unknown", creating
reason for confusion.

Static key management mode uses fixed, built-in keys. Dynamic key
management mode allows keys to be updated in production to handle
security updates without firmware rebuilds.

Define a function named plpks_get_sb_keymgmt_mode() to retrieve the
key management mode based on the existence of the SB_VERSION property
in the firmware.

Set the secvar format property to either "ibm,plpks-sb-v<version>" or
"ibm,plpks-sb-v0" based on the key management mode, and return the
length of the secvar format property.

Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-secvar        | 10 ++-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 76 +++++++++++--------
 2 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index 857cf12b0904..f001a4f4bd2e 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -22,9 +22,13 @@ Description:	A string indicating which backend is in use by the firmware.
 		and is expected to be "ibm,edk2-compat-v1".
 
 		On pseries/PLPKS, this is generated by the kernel based on the
-		version number in the SB_VERSION variable in the keystore, and
-		has the form "ibm,plpks-sb-v<version>", or
-		"ibm,plpks-sb-unknown" if there is no SB_VERSION variable.
+		version number in the SB_VERSION variable in the keystore. The
+		version numbering in the SB_VERSION variable starts from 1. The
+		format string takes the form "ibm,plpks-sb-v<version>" in the
+		case of dynamic key management mode. If the SB_VERSION variable
+		does not exist (or there is an error while reading it), it takes
+		the form "ibm,plpks-sb-v0", indicating that the key management
+		mode is static.
 
 What:		/sys/firmware/secvar/vars/<variable name>
 Date:		August 2019
diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
index 257fd1f8bc19..767e5e8c6990 100644
--- a/arch/powerpc/platforms/pseries/plpks-secvar.c
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -152,39 +152,55 @@ static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
 	return rc;
 }
 
-// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
-// Instead, report the format using the SB_VERSION variable in the keystore.
-// The string is made up by us, and takes the form "ibm,plpks-sb-v<n>" (or "ibm,plpks-sb-unknown"
-// if the SB_VERSION variable doesn't exist). Hypervisor defines the SB_VERSION variable as a
-// "1 byte unsigned integer value".
-static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
+/*
+ * Return the key management mode.
+ *
+ * SB_VERSION is defined as a "1 byte unsigned integer value", taking values
+ * starting from 1. It is owned by the Partition Firmware and its presence
+ * indicates that the key management mode is dynamic. Any failure in
+ * reading SB_VERSION defaults the key management mode to static. The error
+ * codes -ENOENT or -EPERM are expected in static key management mode. An
+ * unexpected error code will have to be investigated. Only signed variables
+ * have null bytes in their names, SB_VERSION does not.
+ *
+ * Return 0 to indicate that the key management mode is static. Otherwise
+ * return the SB_VERSION value to indicate that the key management mode is
+ * dynamic.
+ */
+static u8 plpks_get_sb_keymgmt_mode(void)
 {
-	struct plpks_var var = {0};
-	ssize_t ret;
-	u8 version;
-
-	var.component = NULL;
-	// Only the signed variables have null bytes in their names, this one doesn't
-	var.name = "SB_VERSION";
-	var.namelen = strlen(var.name);
-	var.datalen = 1;
-	var.data = &version;
-
-	// Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
-	ret = plpks_read_fw_var(&var);
-	if (ret) {
-		if (ret == -ENOENT) {
-			ret = snprintf(buf, bufsize, "ibm,plpks-sb-unknown");
-		} else {
-			pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
-			ret = -EIO;
-		}
-		goto err;
+	u8 mode;
+	ssize_t rc;
+	struct plpks_var var = {
+		.component = NULL,
+		.name = "SB_VERSION",
+		.namelen = 10,
+		.datalen = 1,
+		.data = &mode,
+	};
+
+	rc = plpks_read_fw_var(&var);
+	if (rc) {
+		if (rc != -ENOENT && rc != -EPERM)
+			pr_info("Error %ld reading SB_VERSION from firmware\n", rc);
+		mode = 0;
 	}
+	return mode;
+}
 
-	ret = snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
-err:
-	return ret;
+/*
+ * PLPKS dynamic secure boot doesn't give us a format string in the same way
+ * OPAL does. Instead, report the format using the SB_VERSION variable in the
+ * keystore. The string, made up by us, takes the form of either
+ * "ibm,plpks-sb-v<n>" or "ibm,plpks-sb-v0", based on the key management mode,
+ * and return the length of the secvar format property.
+ */
+static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
+{
+	u8 mode;
+
+	mode = plpks_get_sb_keymgmt_mode();
+	return snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", mode);
 }
 
 static int plpks_max_size(u64 *max_size)
-- 
2.47.1


