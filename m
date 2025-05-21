Return-Path: <linux-integrity+bounces-6268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B946EABF23B
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 12:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B116A1BC0ED5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5F262803;
	Wed, 21 May 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kzjWMpCI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DA2620FA;
	Wed, 21 May 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825116; cv=none; b=hDxCUyVszXDRF2RowmNdht/2+lfwaAjmQQRNjfF6EZJnJmfkL0YcEnlsgV7//izeCWltP4lBuXAjW9l5Awh5vnvTTRuZyTuMwOJdLp15F1THEQkFepSUVq/UmRMUAgJjcetS8EXpG7nd06FPMGcaX5vAq1hoqBUOuaARyIWCuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825116; c=relaxed/simple;
	bh=Yj5FESqYIA7ScGcVcpjZcFcYpZM3cIeXjw2DKRH2ckg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0z++MgohzewgIgB77MSDH/vF7yckxk5W7l62IpyB0kcs9N4TtifFj/6MQDO+bIJvYWWsPRK9WIiCdakjqAUXXDuQWCDgTkT9G9EyZxPikh2ilh0BSVNOa4MmObsEAQ1NVTugUyzhjIO4flWWaoKu28WoeheW+V+GX735oO/WTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kzjWMpCI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8phhu014686;
	Wed, 21 May 2025 10:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+iv47Tf1NAy3MKg7J
	pMt0tSZMZNUHjGtMkJcRX2ZoxQ=; b=kzjWMpCI2yMJnJ2+8F9Q2uOymy+5O4LcM
	dogMhK1cYNMNfdv5VIHHlqxXnTu9vnyz0UrsMMZhsxKoQCsKgmH6rkHNL0pjWSIl
	PlrQmIkUh+l98LHMzwnkIrcSTj+jdOuy90cPR1rkfx2Hk/8qgEHWXSvYl0vhEzvn
	KPette/LmqGZffkdrpbjNq6Bt+EoQDJhVP2oxhcqYG9Cm3UWJkwJfO+goH066omT
	v6xzoeKcZyBxzUZrZukZ5f6VCpwjFCk76v3eBKxHHsIOFiMyXou/33BEgkZmY8dV
	vfV2te0E448moV+2OC2sat//+jtWxkhS6BuodTbCVN4Pkq6fh3IuA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph0j2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54LAsMH6025326;
	Wed, 21 May 2025 10:58:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph0j2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9gx4T010640;
	Wed, 21 May 2025 10:58:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwnmbt5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LAw7m130147158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 10:58:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 938C920043;
	Wed, 21 May 2025 10:58:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B88D20040;
	Wed, 21 May 2025 10:58:05 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.in.ibm.com (unknown [9.204.203.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 10:58:05 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/secvar: Expose secvars relevant to the key management mode
Date: Wed, 21 May 2025 16:27:58 +0530
Message-ID: <20250521105759.8408-3-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNSBTYWx0ZWRfXxj+Kr/SU8DGu 7cCuWAgvM3Wh88Nc9JjXMxjU5hz4F3VBsgjEKA2jQyrfRJFwRqsAsBJ/8SEzmCUi+DyVsOMoA6T ibhivpF6lol5UhjPIDQRNTpFGpb4aF7N8r/CtBHNg/ApAtu9oppIRpsJjKJi2dd8PcMjyeCzMcY
 7QgcG8Y/jrxIEUGcS+2GRCDF71UNHtj70XXyjMJRiNtsZiB/cwnsYZ6LWNfDsnyfvAVqLPfUb2W TFF2ig7rkfHWPPWi8VhoNaXD2B/IKiap+XXxOydwsyCfhAWB5MUQlExMiatXq937BYcrJj4BvWT 3v94iLAS5Kck5RtFHhX6q6rZz+PSEeOlY67NMn4n866ElpK0yIvF/LYnAcJr3mwJTjQgLvZjBhH
 0Vn1sWCmFmUl8SILKBoZryWG3jmVNy+HRIj+RImKLn20sZYXjVuFbgmgpR7DEt8kQrvxh5mI
X-Proofpoint-ORIG-GUID: Vww7UlYtzeEycHD7TKb6YTyr59h6E1Iq
X-Authority-Analysis: v=2.4 cv=L5kdQ/T8 c=1 sm=1 tr=0 ts=682db1c5 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=tLxTvSBFvjwC67ZwczkA:9
X-Proofpoint-GUID: GHnn0WbiKF2p2z2DrVtQ5F2IFlZ2RgHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210105

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
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-secvar        |  6 ++++
 arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index 45281888e520..948df3446a03 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -37,6 +37,12 @@ Description:	Each secure variable is represented as a directory named as
 		representation. The data and size can be determined by reading
 		their respective attribute files.
 
+		Only secvars relevant to the key management mode are exposed.
+		Only in the dynamic key mode can the user modify the secure boot
+		secvars db, dbx, grubdb, grubdbx, and sbat. PK, trustedcadb and
+		moduledb are the secvars common to both static and dynamic key
+		management modes.
+
 What:		/sys/firmware/secvar/vars/<variable_name>/size
 Date:		August 2019
 Contact:	Nayna Jain <nayna@linux.ibm.com>
diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
index 767e5e8c6990..f9e9cc40c9d0 100644
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
@@ -213,21 +220,34 @@ static int plpks_max_size(u64 *max_size)
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


