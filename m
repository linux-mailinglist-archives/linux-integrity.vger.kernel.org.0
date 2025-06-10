Return-Path: <linux-integrity+bounces-6402-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38DAD44A7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF63178F46
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6C283FD7;
	Tue, 10 Jun 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RFTFUzxS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCD283FC9;
	Tue, 10 Jun 2025 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590380; cv=none; b=NNICNG0SZFumLh/4rJOVcTEIXyPHAvKGtM4x5zCkF3L2gASRqJ3gmxrzlUa64XWkhvi09t+Rqb3InXspNlyo90K54L0Rc7VscAOlINMWgHlh2YHWgMrvg6RsgHpIcLgmfKJ9UTewl9LzenTC8wdJqRFI9vAq64fzj6yPCZ2BeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590380; c=relaxed/simple;
	bh=DZ8CM4S/wzyJFRF1yJfVXdaxaSJD+XG1lwmHyehtn0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdWWOYonkLFL/0APqNR2FepP+Mqtj4sktYYeb+vaKInPbY6c89CrOMcvw6hzV8IDCDNRMOm2ilGpmJ1/ooIuNEwzP/4UD1C35BOfitCxQ05dixQ3K2Sa5FBOsY2Q+IazghsytL4HlZmnQ0ep7sSvDurmWHuLN/c552a4OWCHXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RFTFUzxS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKd0hn001143;
	Tue, 10 Jun 2025 21:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ror2umoeh/9LFHu5s
	OpmgQ+S2h8VWYq2WrP0ryPKE4w=; b=RFTFUzxSa6kPd20FtGdBPaCb9K2WpYd6H
	DttT6ZlnKh4wScd4N2ZvzE36UC/YsPVO2mLvsyKb4l8/x8kqqW37xxdGuBPzDYLl
	PjVSQFxwtkJbxoeCfXbk99OsT08TiQbdiDURWCq6GjjNvlNKyztd10/zU4sVgKQ8
	2ttLBRkZaB25FTXLgZRQBQauS6Ejt7h3DfjuTE/lBzF1ZtImWKAeWR4bFsaapbBT
	tCqtO2vFjz29C3P1C7mRdatq0XJ2EAfNthgiJ6MTAIeWtL1EDuxh9Su6Gz4F11Bp
	ryWpMIX5PYt82JGcWl87a7OVNm2AoVsmLRlBRjhuH53Ie9WVUxSFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wynhar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55ALGsrF003360;
	Tue, 10 Jun 2025 21:19:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wynhak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK684V021836;
	Tue, 10 Jun 2025 21:19:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yvkg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ALJIao59703664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:19:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 861EB2004E;
	Tue, 10 Jun 2025 21:19:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E7E020043;
	Tue, 10 Jun 2025 21:19:15 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 21:19:15 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] powerpc/secvar: Expose secvars relevant to the key management mode
Date: Wed, 11 Jun 2025 02:49:06 +0530
Message-ID: <20250610211907.101384-3-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rV0kdsEIElMXerPPdLa6gv_mff9PxzjD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3NCBTYWx0ZWRfX050Zr9yBr/fI n5qBXuyXN8n6Mk1nggrlj4wzCrkfnVTE4hgXisqiERwzo5RUFTm9feh/kcZ9FrMTqcHlgdvZMQI HGblqaxZUhbfjY4myzvcOg1BYuQufpbyteICBh/lV/78YbbaSvihnxmErCyyTeAoRsmaFtcpzMb
 xc9f4Jt5EfZXa7NhC0xcyoc1j9JNiFmd5iQwczVn8DxgWGshNAZupgqERBhBVKjwLTygAVK0E8u z0walBzkDuDRMspmYN5mWRyY6Iui4mlQkPzVcwJryAGMP/GdfHlec31sz6lL//YxF1lcDqq5mP3 TetqP7RScAADzyc0t3sg9qD1V2UAN/duwS4qMnHCQP2P2mKsr3E25RsVkOZ75U6axymZx1N6/2S
 FENU7xZ1Xj3g5nr31cCciekY3uSv44H3v9Cba32omBrWQXtv7FEoMbdHFMefAhf6RqfvGjs8
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=6848a15c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=2qXihy3qlzCNzDExuI8A:9
X-Proofpoint-GUID: PIaYAC_5LnNIxIl-BvyJgG32MCmkBQEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100174

The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
secvars irrespective of the key management mode.

The PowerVM LPAR supports static and dynamic key management for secure
boot. The key management option can be updated in the management
console. The secvars PK, trustedcadb, and moduledb can be consumed both
in the static and dynamic key management modes for the loading of signed
third-party kernel modules. However, other secvars i.e. KEK, grubdb,
grubdbx, sbat, db and dbx, which are used to verify the grub and kernel
images, are consumed only in the dynamic key management mode.

Expose only PK, trustedcadb, and moduledb in the static key management
mode.

Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-secvar        |  7 +++++
 arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index f001a4f4bd2e..1016967a730f 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -38,6 +38,13 @@ Description:	Each secure variable is represented as a directory named as
 		representation. The data and size can be determined by reading
 		their respective attribute files.
 
+		Only secvars relevant to the key management mode are exposed.
+		Only in the dynamic key management mode should the user have
+		access (read and write) to the secure boot secvars db, dbx,
+		grubdb, grubdbx, and sbat. These secvars are not consumed in the
+		static key management mode. PK, trustedcadb and moduledb are the
+		secvars common to both static and dynamic key management modes.
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


