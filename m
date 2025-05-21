Return-Path: <linux-integrity+bounces-6266-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438FABF236
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B286D8E1195
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE6261570;
	Wed, 21 May 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sbex4Tlj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF779CF;
	Wed, 21 May 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825112; cv=none; b=H/DXXOYN9Aic16mdO4T4nABPUgJgYC1c9te/LysQQNJ07HfEZEpBsSZ3D2qBkQEZ/XmpxVfd0BDyURuuDFPdq6NhcIEsrS4jYiach7gXC9K72g7GROF7FkRvyHqHu9xVq/Z0l71UZKqhkh3pVA0y9LQ577SYGWnvtRaa5CwwDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825112; c=relaxed/simple;
	bh=d/hH4YRKscfoJ3JNaunJOBbmXID5c/L62IMVrMbImKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSOM+ik3U+lWYZE2TRYePqd+neJixsiuNeJzK7t1nJrxyVgoW59eYb82jMyMnNw9dxtVQwEg8jimyjqRF7VdpFQ/FQnoO3t2kajbn9gfN4/Eg87WyCI8fDjNOnNX/BZw9v89KV1qyfMqON3ZCdBhF0Heure+OrshrIeg16JCnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sbex4Tlj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L5wd21024505;
	Wed, 21 May 2025 10:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h6nWBLUb3tJoieg6u
	MHTOlSkfwsqMXR5qlqotxgHTQo=; b=Sbex4TljDGiDecNEaRb6dxHGCYQP/g3dW
	TUqbFPuAETZC+UJjypi6sXe6NaBZXPB2Cogj/i17pPIZ1TAUnznprdyZmZRlp5+N
	GPghI11aeHQNBNeRN1EmbZkALiy0tCu+skJ/RtGmU3DK7aRZuYE/sz3c+F4SlZl5
	m1Kh8lp46WVMott4CO2qqPYYzqruUVuXV3ThEZDHjliPRXBqZ6FF8VuCajI4Ka1p
	hZ8n64x9XFasJdLs5XSBPbGkxCAU/luu510rcaSwH6Cc+WDeG4XO8ouCK8sdeF7b
	WdPnsH7silYNDbnnQ5Fh5nq7E9PFHDNvR/fKrDASaJeanM6NHwGtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaakwhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54LArS6U002824;
	Wed, 21 May 2025 10:58:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaakwhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9shZa024709;
	Wed, 21 May 2025 10:58:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkr3tgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LAw5Zs48038294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 10:58:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E59C620043;
	Wed, 21 May 2025 10:58:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0D020040;
	Wed, 21 May 2025 10:58:02 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.in.ibm.com (unknown [9.204.203.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 10:58:02 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] powerpc/pseries: Correct secvar format representation for static key management
Date: Wed, 21 May 2025 16:27:57 +0530
Message-ID: <20250521105759.8408-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521105759.8408-1-ssrish@linux.ibm.com>
References: <20250521105759.8408-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CMEqXQrD c=1 sm=1 tr=0 ts=682db1c2 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FNRAjOYsECM2cVzVVdoA:9
X-Proofpoint-ORIG-GUID: WoFquhr46etRrQkz54qW1eekvK2bJfxW
X-Proofpoint-GUID: -uMCd_DnlEBKD0buM0YB2fYneUvtDYy_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNSBTYWx0ZWRfXzA6lg5sQCEyM JtrDAbGZLs3St1/0fM8K5O+aTne39z0D110+hMTsN/FZD2UACBC/LI3Mdl6w3bpA5CgTTW3JaKU KEDKAdWpIPzROSFKLE5eb9110K7VTRiCDr3LSoXZ+fNo7jI9wOY7cFAChNZgAEVV9gUzgRZNVs7
 ykGNblYb5Ah+2gbl7IV1vjAmgM67byihsr0hVYqCuTpHgksBvtj4fifu/cuCJXHcm2QI7PxfTAD iAs0D8EKx2f98Me95G+qM4gmxntxzDsRRmdjfHqIKJQFj4x5eTermCbPvXdzJHje9gesEGf/RA9 9KujTHCeXmHaeC5ViriJ4tYrGicEMLSYiULhtb7yzM5gJCMDkFpGcSqjmCZNJO4OrMyxXx2HTdA
 R7kZZCDJHwGqMaTG/GjODLh1zbDV1yfhLFG9gC47yCAnzaCCHi4JcZAwE50c7YaDTAuHO/ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210105

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
---
 Documentation/ABI/testing/sysfs-secvar        |  9 ++-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 76 +++++++++++--------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index 857cf12b0904..45281888e520 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -22,9 +22,12 @@ Description:	A string indicating which backend is in use by the firmware.
 		and is expected to be "ibm,edk2-compat-v1".
 
 		On pseries/PLPKS, this is generated by the kernel based on the
-		version number in the SB_VERSION variable in the keystore, and
-		has the form "ibm,plpks-sb-v<version>", or
-		"ibm,plpks-sb-unknown" if there is no SB_VERSION variable.
+		version number in the SB_VERSION variable in the keystore. The
+		version numbering in the SB_VERSION variable starts from 1. The
+		format string takes the form "ibm,plpks-sb-v<version>" in the
+		case of dynamic key management mode. Otherwise, for any error in
+		reading SB_VERSION it takes the form "ibm,plpks-sb-v0",
+		indicating that the key management mode is static.
 
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


