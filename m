Return-Path: <linux-integrity+bounces-8098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161DCC937C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D21823055E35
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0643451AA;
	Wed, 17 Dec 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZXp7KMFs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5157342527;
	Wed, 17 Dec 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765992343; cv=none; b=FkzSWGNxMVq/ACtCzD/ejraS4D3juE/4Xvzrdxl8GmyrqxOeDY165PxkbO0j9BGxPS8DkwtKRWAXxNskpz1fDDK0xF9yxH9+l2hw9B96pRCilui3ezAAThNnFqkt1Up0+niTB7kfPT3SqG6SQERjqWkz7RpJnuI2uyaMiihep40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765992343; c=relaxed/simple;
	bh=o+HNAoXe5dmj0ZXKdP/IxAcP+iQNOhjsPp/2eXaFA04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQoBEb6B5OZDnRmi5sSBBHJPrMpbvskFF1QCN2ec3oWMBoxmRXJIy2sliu7yHXXc7jJIE7lXkvWoW35ZfFLqSc7zNthMSfomMbIm2Ryf6TWQouQlsRfpUIgEjxkrTdebEbk46dbB+WYS4DQWW5Ql9D5Assra8IA3gWW5xSlKB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZXp7KMFs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHHK29c025635;
	Wed, 17 Dec 2025 17:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E9q9MwLx+QxB8gPZo
	WTVfIF6m08d+i7ReyBrKfC6Vc8=; b=ZXp7KMFsTfbr3Ezsi6iQDHDk1kTrHe/JL
	tX1+DmMHe/Y++nAdqmwWIDhDk4NnaLcS08Sz/+2JM27FK4marQioOjFK3lLv1Myk
	NUBZhRSbYHZHO05ggvxQL3wtOXrTmUfxTxlTwveFXcW4dtyTK/j89ufIoccirXxN
	Zd+W+QQVPJGM30pPomQg1eh+VzZHh99QWNmg8BB86TVPTaWkZUbF3ssPMbWjEw+j
	0mECjxbDgFFXX1J2t6gZA39o/rSm5aec1bO7J37DMfRQyjFVMA2COWXX50YxZ0LB
	1RCecZ4ojc1HNcYKakK8Nz4N5+/XfMm50FfdaiXlvskS6jQhG4LeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvea8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 17:25:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHHKZSI006748;
	Wed, 17 Dec 2025 17:25:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvea8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 17:25:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHExUCF014337;
	Wed, 17 Dec 2025 17:25:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpk3aea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 17:25:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHHPKTT27132252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 17:25:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 062E920043;
	Wed, 17 Dec 2025 17:25:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5AC20040;
	Wed, 17 Dec 2025 17:25:17 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.124.211.226])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 17:25:16 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ssrish@linux.ibm.com
Subject: [PATCH v2 3/6] pseries/plpks: expose PowerVM wrapping features via the sysfs
Date: Wed, 17 Dec 2025 22:55:02 +0530
Message-ID: <20251217172505.112398-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217172505.112398-1-ssrish@linux.ibm.com>
References: <20251217172505.112398-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX9tnRxkQteBI6
 Q5tqtyTkeO04SpvFWQjdHgLMFjwR8zMd129SpF1s6GFuTIS70B4NFLtUtiSx0KWrPH1JY97wHrf
 /E50ztVB8WLZhibwQGAofI8g3kRMbRNMaPU0Wgt+n+yiNYwm7+D1gdaDJzA+iYb5Pu3YwzKjKfE
 Ru1bW7BYOSVH5X0KXIt8Wc40yWMu8AYMVajPc+6tx3V6Cb46RUacUPHqD3O3B/vXJYBNL5GFBKx
 /0WEvv4L0U0N5tKUazS0Q1ntVXYFcReSjkchdEnXN6l/AImtYTynyNXEkteYFoU0cw3I3xqG0xd
 kLfR/KbkHL9+xnoDHy1MacNwas+r/K79i42xGr8pQ5roTMvy91R6L3OgM33HobxSATHumw9mLXW
 z+5N9ycAFxH1fo3WUksM7MEZqlbUIw==
X-Proofpoint-ORIG-GUID: 1kZIqMv__lyuypxDN-Xg_m7C5Xtx6ifC
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6942e785 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=z7cUUKlKUSfJ7xv5IYMA:9
X-Proofpoint-GUID: rx6XoglfU01VC7Xnu_RuNwHhcVe9AvI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Starting with Power11, PowerVM supports a new feature called "Key Wrapping"
that protects user secrets by wrapping them using a hypervisor generated
wrapping key. The status of this feature can be read by the
H_PKS_GET_CONFIG HCALL.

Expose the Power LPAR Platform KeyStore (PLPKS) wrapping features config
via the sysfs file /sys/firmware/plpks/config/wrapping_features.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 .../ABI/testing/sysfs-firmware-plpks          |  8 ++++++++
 arch/powerpc/include/asm/hvcall.h             |  4 +++-
 arch/powerpc/include/asm/plpks.h              |  3 +++
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  2 ++
 arch/powerpc/platforms/pseries/plpks.c        | 20 +++++++++++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-plpks b/Documentation/ABI/testing/sysfs-firmware-plpks
index af0353f34115..cba061e4eee2 100644
--- a/Documentation/ABI/testing/sysfs-firmware-plpks
+++ b/Documentation/ABI/testing/sysfs-firmware-plpks
@@ -48,3 +48,11 @@ Description:	Bitmask of flags indicating which algorithms the hypervisor
 		supports for signed update of objects, represented as a 16 byte
 		hexadecimal ASCII string. Consult the hypervisor documentation
 		for what these flags mean.
+
+What:		/sys/firmware/plpks/config/wrapping_features
+Date:		November 2025
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	Bitmask of the wrapping features indicating the wrapping
+		algorithms that are supported for the H_PKS_WRAP_OBJECT requests
+		, represented as a 8 byte hexadecimal ASCII string. Consult the
+		hypervisor documentation for what these flags mean.
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9aef16149d92..dff90a7d7f70 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -360,7 +360,9 @@
 #define H_GUEST_RUN_VCPU	0x480
 #define H_GUEST_COPY_MEMORY	0x484
 #define H_GUEST_DELETE		0x488
-#define MAX_HCALL_OPCODE	H_GUEST_DELETE
+#define H_PKS_WRAP_OBJECT	0x490
+#define H_PKS_UNWRAP_OBJECT	0x494
+#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 8829a13bfda0..8f034588fdf7 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -23,6 +23,7 @@
 #define PLPKS_IMMUTABLE		PPC_BIT32(5) // Once written, object cannot be removed
 #define PLPKS_TRANSIENT		PPC_BIT32(6) // Object does not persist through reboot
 #define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
+#define PLPKS_WRAPPINGKEY	PPC_BIT32(8) // Object contains a wrapping key
 #define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
 
 // Signature algorithm flags from signed_update_algorithms
@@ -103,6 +104,8 @@ u32 plpks_get_maxlargeobjectsize(void);
 
 u64 plpks_get_signedupdatealgorithms(void);
 
+u64 plpks_get_wrappingfeatures(void);
+
 u16 plpks_get_passwordlen(void);
 
 void plpks_early_init_devtree(void);
diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/platforms/pseries/plpks-sysfs.c
index 01d526185783..c2ebcbb41ae3 100644
--- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
+++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
@@ -30,6 +30,7 @@ PLPKS_CONFIG_ATTR(used_space, "%u\n", plpks_get_usedspace);
 PLPKS_CONFIG_ATTR(supported_policies, "%08x\n", plpks_get_supportedpolicies);
 PLPKS_CONFIG_ATTR(signed_update_algorithms, "%016llx\n",
 		  plpks_get_signedupdatealgorithms);
+PLPKS_CONFIG_ATTR(wrapping_features, "%016llx\n", plpks_get_wrappingfeatures);
 
 static const struct attribute *config_attrs[] = {
 	&attr_version.attr,
@@ -38,6 +39,7 @@ static const struct attribute *config_attrs[] = {
 	&attr_used_space.attr,
 	&attr_supported_policies.attr,
 	&attr_signed_update_algorithms.attr,
+	&attr_wrapping_features.attr,
 	NULL,
 };
 
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 03722fabf9c3..4a08f51537c8 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -38,6 +38,7 @@ static u32 usedspace;
 static u32 supportedpolicies;
 static u32 maxlargeobjectsize;
 static u64 signedupdatealgorithms;
+static u64 wrappingfeatures;
 
 struct plpks_auth {
 	u8 version;
@@ -248,6 +249,7 @@ static int _plpks_get_config(void)
 		__be32 supportedpolicies;
 		__be32 maxlargeobjectsize;
 		__be64 signedupdatealgorithms;
+		__be64 wrappingfeatures;
 		u8 rsvd1[476];
 	} __packed * config;
 	size_t size;
@@ -280,6 +282,7 @@ static int _plpks_get_config(void)
 	supportedpolicies = be32_to_cpu(config->supportedpolicies);
 	maxlargeobjectsize = be32_to_cpu(config->maxlargeobjectsize);
 	signedupdatealgorithms = be64_to_cpu(config->signedupdatealgorithms);
+	wrappingfeatures = be64_to_cpu(config->wrappingfeatures);
 
 	// Validate that the numbers we get back match the requirements of the spec
 	if (maxpwsize < 32) {
@@ -472,6 +475,23 @@ u64 plpks_get_signedupdatealgorithms(void)
 	return signedupdatealgorithms;
 }
 
+/**
+ * plpks_get_wrappingfeatures() - Returns a bitmask of the wrapping features
+ * supported by the hypervisor.
+ *
+ * Successful execution of the H_PKS_GET_CONFIG HCALL during initialization
+ * reads a bitmask of the wrapping features supported by the hypervisor into the
+ * file local static wrappingfeatures variable. This is valid only when the
+ * PLPKS config structure version >= 3.
+ *
+ * Return:
+ *	bitmask of the wrapping features supported by the hypervisor
+ */
+u64 plpks_get_wrappingfeatures(void)
+{
+	return wrappingfeatures;
+}
+
 /**
  * plpks_get_passwordlen() - Get the length of the PLPKS password in bytes.
  *
-- 
2.47.3


