Return-Path: <linux-integrity+bounces-6084-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A2AA466D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540179C787D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7BA22171A;
	Wed, 30 Apr 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XLboUL3X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904BD22156A;
	Wed, 30 Apr 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003859; cv=none; b=p64Y+erB8Oj6IQcHaP67u8iI4zU4FCqoGY1aHNX7tJ6wG1JMnjbv9F5irYjU1WRhggFhVC9SaJHtCvGeMLKwGpykmoFYkLEbhpG3HK8Yqr7UN1CNt84PGLLa1VUwsE0YRzTALAbHgEp8eXV1glUa1z+tk36MkwTbe0xqcEt7hK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003859; c=relaxed/simple;
	bh=LCokjLwErfE/UZDdYEPosZ/G6TD8v1GAxOrZ5hp3UCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuG/sJw+oszhWJoE1oVjU5PDd2LF+Xj9SGCWOucL0I7yHGfAZhyaU66FZs+atBdgWWRt/WBt4zzzODVzqu3E4UgC25D/XmQ+mmLaVYRuJRmPsZLCLDKt44QpPkeCHRe+Vrfr7WKX+NRmB4EJriSzgGcoMIOzRb0GJ5BL9PlgCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XLboUL3X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TNkP8p027617;
	Wed, 30 Apr 2025 09:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Zumhz/f/NeuhysH9w
	nyORwBkCLTtfSiGRadpRGVjBfk=; b=XLboUL3X+nzBXTMaBGcZfaqjk3SZdWgZD
	UDLqy6F3ewOxq2kPhl3aOz2qdVgKu5kCnu3HufjwQUgcxg4nIG/huK9RoiK3EKw8
	2IfpIHFUQOmxS/63HJoyTgthaDApAdfdacuPfE1jwVFQewH0jFx0Hhlsr3duSSI6
	XNzSj3LAl5tvFXagIMjU6/HE2mcFUm1MwgyJcP+xCIqz4+aLEvJq+DdO2X6C4qbi
	r1zjOj8olqWynqlnnPZrFdGyXFZbyw7oGY8uLMyCB5Tcs/RdaLQBvcGRIoxYY/Iv
	C30hOfv7bGCJGWUbOq+o5jLUPl5RfsQzIONdhGAHyQMOC08u4i+NQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53U941h4020790;
	Wed, 30 Apr 2025 09:04:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53U71dUj016584;
	Wed, 30 Apr 2025 09:04:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70f8y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53U93udV20513234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:03:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC9D20065;
	Wed, 30 Apr 2025 09:03:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86FA20043;
	Wed, 30 Apr 2025 09:03:53 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.31.221])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 09:03:53 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/pseries: Correct secvar format representation for static key management
Date: Wed, 30 Apr 2025 14:33:48 +0530
Message-ID: <20250430090350.30023-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430090350.30023-1-ssrish@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MCBTYWx0ZWRfX+13vK5Gh/K/O n4H5UJgNIhNxU6Zfnfiy7DxWBznYrqX3dyDGDShB1Yj7yNdk/k6EB3YMb8kB2HxX+CvC7wWLiU6 UeczulnXHn4KjQRbvWfB6WWWfaxUYfHCxy+zv98owRN1d29/z/sCZzZdZeH8pg2a670DDEyhiYd
 stDJ9HA2U7Q8B84EivqmOGg1JRUsr7ZKIrWTTmN5hXBOkvizeSVACNM0WKIt87Ft0ViBPOyeKg8 c/E6Rh2LmQkZkY0xEG9WO3YpNe+KJM09GYOK03V2/J35SYiwWadUIiqvzKt1NmqjvW1VF5BAdd6 4kACtKBFViIldVDItglnR2Zh8inACBTVKfgm7QZIkc/plXyJ2dW7BTsj/Zvbjb+6hkaEOnUVqTx
 5DKS9nbn7GOaHtVet72YEffFVL7GJgW0xb3lQz/BlfLplaUR8BVubvTz05kRtTBFszO04+iJ
X-Authority-Analysis: v=2.4 cv=OqdPyz/t c=1 sm=1 tr=0 ts=6811e781 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=bBRBZpPUCD0QNnH9FkMA:9
X-Proofpoint-GUID: BAHk3Ggd2D9hfL-yeVeOSX-T_peAdEW8
X-Proofpoint-ORIG-GUID: dcBnhR0V-OfBfJo4CYr5TItUhOVk5CVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300060

On a PLPKS enabled PowerVM LPAR, the secvar format property for static
key management is misrepresented as "ibm,plpks-sb-unknown", creating
reason for confusion.

Static key management mode uses fixed, built-in keys. Dynamic key
management mode allows keys to be updated in production to handle
security updates without firmware rebuilds.

Define a function named plpks_get_sb_keymgmt_mode() to retrieve the
key management mode based on the existence of the SB_VERSION property
in the firmware.

Set the secvar format property to either "ibm,plpks-sb-v1" or
"ibm,plpks-sb-v0" based on the key management mode, and return the
length of the secvar format property.

Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks-secvar.c | 70 +++++++++++--------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
index 257fd1f8bc19..d57067a733ab 100644
--- a/arch/powerpc/platforms/pseries/plpks-secvar.c
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -152,39 +152,49 @@ static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
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
+ * SB_VERSION is defined as a "1 byte unsigned integer value". It is owned by
+ * the Partition Firmware and its presence indicates that the key management
+ * mode is dynamic. Only signed variables have null bytes in their names.
+ * SB_VERSION does not.
+ *
+ * Return 1 to indicate that the key management mode is dynamic. Otherwise
+ * return 0, indicating that the key management mode is static.
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
+		pr_info("Error %ld reading SB_VERSION from firmware\n", rc);
+		mode = 0;
 	}
+	return mode;
+}
 
-	ret = snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
-err:
-	return ret;
+// PLPKS dynamic secure boot doesn't give us a format string in the same way
+// OPAL does. Instead, report the format using the SB_VERSION variable in the
+// keystore. The string, made up by us, takes the form "ibm,plpks-sb-v<n>".Set
+// the secvar format property to either "ibm,plpks-sb-v1" or "ibm,plpks-sb-v0",
+// based on the key management mode, and return the length of the secvar format
+// property.
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


