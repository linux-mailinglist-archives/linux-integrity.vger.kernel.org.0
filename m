Return-Path: <linux-integrity+bounces-6086-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC7AA466F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E79E9C7CED
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C810221FAB;
	Wed, 30 Apr 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="afba0zdj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD220F07C;
	Wed, 30 Apr 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003868; cv=none; b=bpBNe/Jscwc2zphI58pC6FIrBBes6nPw6h0nCvmgs9Qng8XcrdyuNrIYGBfn89mnM8WDix+1CsbCQN7D89tiCSPRHTBXdaIBaY7bXKUWY4Z+ws6i1XuG8MtX87wFKroNIDSWsZFDGT0rAZguU296bnn9xby2BVKOwwh/hxgdsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003868; c=relaxed/simple;
	bh=40LW4iygyGi3IIVwrU2L+Xs1zVbklyueA4PTO923bmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQN1h2t2kqUIf6xpFpoMUXnDuf+4gIEo4tD1w8oDDU5PqRGXhqjXxB9yhyEAhVAkDjjOA5Ikt5PmXoPk1XmuObGJeAKPGRdS1x8iR21twI+MHlqV7knHvCxogSQKniBveFEKVfTg3pEfdZiM6450+rDcdGMyw5DKhwrlv7YPUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=afba0zdj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLhQX2026023;
	Wed, 30 Apr 2025 09:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Af7hM+o5bpWc9MvFA
	bHaQIhEEvdEeKQ66beJNFdxsHk=; b=afba0zdjdBrJLWkf/GGYyPXOCvYIaENvX
	vKXn+xSyzGI+T+Z+bMVyl3+WxaoeerZR+BySiiUtczX/4UJZR0LgwFvfxsSqEiaW
	FClb8watnoF/1B8DmLveVgp0ytGnJFWJxh64nhO36jMJkjZNg2ziNL/IaTs95x34
	EH0RZ6O+w7dfEljm5aIfX5H7j4/BAuKcoUL1JtQOt66YIj+VxOPaBNWGdC2k0Ejj
	WceIqSiP7kNwIF3keP5a22D5+fIcPhNc/3gyv5+2nw30fMA2xcMqD9yZjCr9Xqcm
	ayV9GuRPeqeSRet709myK3wYQH/XCZoL37rASHP45e6PNnOCuizvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwa1t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53U91E2I012583;
	Wed, 30 Apr 2025 09:04:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwa1t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53U8aFh5000678;
	Wed, 30 Apr 2025 09:04:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpf5m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53U946fO58327354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:04:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B55E20043;
	Wed, 30 Apr 2025 09:04:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE67620065;
	Wed, 30 Apr 2025 09:03:56 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.31.221])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 09:03:56 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc/secvar: Expose secvars relevant to the key management mode
Date: Wed, 30 Apr 2025 14:33:49 +0530
Message-ID: <20250430090350.30023-3-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: HD6ROCfALFyy9gATbSPO3Jd7KORgYwTo
X-Proofpoint-GUID: OU_ClCn2_gVoDQT8tHZjhYJer90zulYY
X-Authority-Analysis: v=2.4 cv=GOIIEvNK c=1 sm=1 tr=0 ts=6811e78b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=tLxTvSBFvjwC67ZwczkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MCBTYWx0ZWRfX1LKC90iBEGGX QJDEfPI3bgC7YFFRZ5SkBM48J446orIzFUrKL5q8HbFnQiVokXsHi0I4yf/Q2DeCTcJTS84JBCu 3H09acg3xZd7X/0AlkcEcwIPrIYk1nQkjMOnWd2M1uROY1m+4s4yAuzKfhY7rcR6c1Tpmh/hQwy
 rGVGrMH6Z0TE4JQb8svm9gIA6Dt7NbefamTJFqIL+737JHdmDIHQk2ywlxs6jEzIe7cxKDqR+dX dB1RpMVGDnmLufDaU7XM865pyxBeMnKb3WayfccEu3FFR3a35/JQnIxbN+j2/Z2aujOvfr+FV9M 8sld+8i0EfHn3lpDyQJtJfHO4HTGr6+cAUc6dlPMZAsvAfUW3/8C0hdAPxnfGDut590EtHVakIa
 x6PQBzkb8RRkNnCgzLRrmWJEyPRPKOcmYjr7S68tJ5rRjWUhSfF18WaUdWUzb2NRLtoMSkHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300060

The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
secvars irrespective of the key management mode.

The PowerVM LPAR supports static and dynamic key management for secure
boot. The key management option can be updated in the management
console. Only in the dynamic key mode can the user modify the secure
boot secvars db, dbx, grubdb, grubdbx, and sbat, which are exposed via
the sysfs interface. But the sysfs interface exposes these secvars even
in the static key mode. This could lead to errors when reading them or
writing to them in the static key mode.

Expose only PK, trustedcadb, and moduledb in the static key mode to
enable loading of signed third-party kernel modules.

Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-secvar        |  9 ++++--
 arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index 857cf12b0904..2bdc7d9c0c10 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -22,9 +22,12 @@ Description:	A string indicating which backend is in use by the firmware.
 		and is expected to be "ibm,edk2-compat-v1".
 
 		On pseries/PLPKS, this is generated by the kernel based on the
-		version number in the SB_VERSION variable in the keystore, and
-		has the form "ibm,plpks-sb-v<version>", or
-		"ibm,plpks-sb-unknown" if there is no SB_VERSION variable.
+		existence of the SB_VERSION property in firmware. This string
+		takes the form "ibm,plpks-sb-v1" in the presence of SB_VERSION,
+		indicating the key management mode is dynamic. Otherwise it
+		takes the form "ibm,plpks-sb-v0" in the static key management
+		mode. Only secvars relevant to the key management mode are
+		exposed.
 
 What:		/sys/firmware/secvar/vars/<variable name>
 Date:		August 2019
diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
index d57067a733ab..cbcb2c356f2a 100644
--- a/arch/powerpc/platforms/pseries/plpks-secvar.c
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
 		return PLPKS_SIGNEDUPDATE;
 }
 
-static const char * const plpks_var_names[] = {
+static const char * const plpks_var_names_static[] = {
+	"PK",
+	"moduledb",
+	"trustedcadb",
+	NULL,
+};
+
+static const char * const plpks_var_names_dynamic[] = {
 	"PK",
 	"KEK",
 	"db",
@@ -207,21 +214,34 @@ static int plpks_max_size(u64 *max_size)
 	return 0;
 }
 
+static const struct secvar_operations plpks_secvar_ops_static = {
+	.get = plpks_get_variable,
+	.set = plpks_set_variable,
+	.format = plpks_secvar_format,
+	.max_size = plpks_max_size,
+	.config_attrs = config_attrs,
+	.var_names = plpks_var_names_static,
+};
 
-static const struct secvar_operations plpks_secvar_ops = {
+static const struct secvar_operations plpks_secvar_ops_dynamic = {
 	.get = plpks_get_variable,
 	.set = plpks_set_variable,
 	.format = plpks_secvar_format,
 	.max_size = plpks_max_size,
 	.config_attrs = config_attrs,
-	.var_names = plpks_var_names,
+	.var_names = plpks_var_names_dynamic,
 };
 
 static int plpks_secvar_init(void)
 {
+	u8 mode;
+
 	if (!plpks_is_available())
 		return -ENODEV;
 
-	return set_secvar_ops(&plpks_secvar_ops);
+	mode = plpks_get_sb_keymgmt_mode();
+	if (mode)
+		return set_secvar_ops(&plpks_secvar_ops_dynamic);
+	return set_secvar_ops(&plpks_secvar_ops_static);
 }
 machine_device_initcall(pseries, plpks_secvar_init);
-- 
2.47.1


