Return-Path: <linux-integrity+bounces-8390-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMMINt9cf2m0owIAu9opvQ
	(envelope-from <linux-integrity+bounces-8390-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 15:02:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EACC6158
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 15:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F45830479F3
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9A350D5A;
	Sun,  1 Feb 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DgTYn2aq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882333CEB9;
	Sun,  1 Feb 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769954417; cv=none; b=UOb55LgmIQaazwWhfOF1J7C/j9oP3j3p2oS1U02vfyYGD03RMhsZeGrbz0WoM5FvaO+294XpOCE9KSN36AbutxrN8aZBdQVb6d6Wb0vQ80Yb8yzPWrK1wWtWRARjP9CVCaxScJCkoK/qbuuRM0UzjyFPs0oQyqLiwnFBoFA8liY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769954417; c=relaxed/simple;
	bh=XCefpgXUxyNEKk/AXlmykIVBUmEW8jSfP/BPAzjGEUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDtzRBAmeQ1e203K0hZfTNT5FClufQi1Gp1gDWgr2jk0Xnhuat7xgTzX5RfKH0PIgjZeK6+ENYasvAXIx5OPDw96QVEN5GKC8HF6ENKql3scjJFcHZUv2voa1U2rSUU+35TDYN3jqKlEAPwnw6m8rUwLfkCDwzK/U1V+P7HkGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DgTYn2aq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611AvakW006015;
	Sun, 1 Feb 2026 14:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3AlJIuHueyJfodCUq
	PQr+cGMD8wjDvVNfPBSHGCosjo=; b=DgTYn2aqvWNFxtbgbqf/eul0lpRzK4kWi
	LomWABHSwpnLhQqk9QS0ntqJttnEUbn3LtCP86wSr4/AoOiStQ3B6NObiZ73S60s
	ANiD64cv+CUJSKyT8bR0NhcdbJr2ncaltt6hZeujFwVI8d0teIV5uX3I2J4WqUUT
	EzFzRHNeAKaBEPu+8GCcRphR98W4rSaiMY0b9XMaIVCxFFnEEr2AwPpJQlqAiqXv
	rhBB3S0l5+Xy0SpdXrwnv0b1yKXfEpXH10gJ3kdDpLOaWMnQ9Xmiy8OftF+YBMqu
	MYz1d4kkAmji8o7pPT1VR8xAoVrXaXyTHL6hNY1gxuvVXrr1zxsNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mkx5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 14:00:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 611E01oY021627;
	Sun, 1 Feb 2026 14:00:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mkx5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 14:00:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61170cbT029108;
	Sun, 1 Feb 2026 14:00:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2s1rd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 14:00:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 611DxuLV19530040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Feb 2026 13:59:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8306A20043;
	Sun,  1 Feb 2026 13:59:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728B120040;
	Sun,  1 Feb 2026 13:59:53 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.20.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Feb 2026 13:59:53 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ssrish@linux.ibm.com
Subject: [PATCH v6 6/6] docs: trusted-encryped: add PKWM as a new trust source
Date: Sun,  1 Feb 2026 19:29:30 +0530
Message-ID: <20260201135930.898721-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201135930.898721-1-ssrish@linux.ibm.com>
References: <20260201135930.898721-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Evg04QKxuVsarJqa7i2QNI9Y4fRtEMkb
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=697f5c61 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ULK339cd-4IVAxCgyX4A:9
X-Proofpoint-GUID: d_3W2q5XZ5y6p6-HFy-5oJprXxLmYsF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDEyMCBTYWx0ZWRfX0J06/X323CG0
 b+VW8LTBlJTEm4h6KBf1GeFq9oqzj13DG1zswjhuipqApsdx0hhWty+CMP5o8iTRXbGu0IKkzS1
 gNL+g9Q8bWvu1dCeUzT9pdyuH7uMjAnA/Hi+HiqaMd+bHZCNQA9wI7JFsgblbmmnoFdlGDzSG4J
 reNdhTRM5JYspysBMgcxc94JxLWfinSGdtcRD+A0Z8JYTY5aDM2tV0/LGuoXa4GIKx+2lnu6jkI
 Uryln5s32N0j3UZKs8scYDE+AgmhvedDmR18FNZmh3sOsHQlL0M1iwspHmG/MVY8AVrSQj5t7Y6
 dKDVuyhNeKI+B9ONhoj+JF8ItMlp2SR92DF056QSPFt/a7Gpc1OdX4ru/RORvq/L/hUCWVsTESe
 lyJaQPm9hJZBIPgalR6QX9YV49/9Q0deyXuofZ8SG5oSxBrA0b3fU0B1XlvTJPrUncbyITyBN+r
 R6RScvPIu6rPL91vMJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_05,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602010120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8390-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,HansenPartnership.com,kernel.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 79EACC6158
X-Rspamd-Action: no action

From: Nayna Jain <nayna@linux.ibm.com>

Update Documentation/security/keys/trusted-encrypted.rst and Documentation/
admin-guide/kernel-parameters.txt with PowerVM Key Wrapping Module (PKWM)
as a new trust source

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 .../security/keys/trusted-encrypted.rst       | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..aac15079b33d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7790,6 +7790,7 @@ Kernel parameters
 			- "tee"
 			- "caam"
 			- "dcp"
+			- "pkwm"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index eae6a36b1c9a..ddff7c7c2582 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -81,6 +81,14 @@ safe.
          and the UNIQUE key. Default is to use the UNIQUE key, but selecting
          the OTP key can be done via a module parameter (dcp_use_otp_key).
 
+     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
+
+         Rooted to a unique, per-LPAR key, which is derived from a system-wide,
+         randomly generated LPAR root key. Both the per-LPAR keys and the LPAR
+         root key are stored in hypervisor-owned secure memory at runtime,
+         and the LPAR root key is additionally persisted in secure locations
+         such as the processor SEEPROMs and encrypted NVRAM.
+
   *  Execution isolation
 
      (1) TPM
@@ -102,6 +110,14 @@ safe.
          environment. Only basic blob key encryption is executed there.
          The actual key sealing/unsealing is done on main processor/kernel space.
 
+     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
+
+         Fixed set of cryptographic operations done on on-chip hardware
+         cryptographic acceleration unit NX. Keys for wrapping and unwrapping
+         are managed by PowerVM Platform KeyStore, which stores keys in an
+         isolated in-memory copy in secure hypervisor memory, as well as in a
+         persistent copy in hypervisor-encrypted NVRAM.
+
   * Optional binding to platform integrity state
 
      (1) TPM
@@ -129,6 +145,11 @@ safe.
          Relies on Secure/Trusted boot process (called HAB by vendor) for
          platform integrity.
 
+     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
+
+         Relies on secure and trusted boot process of IBM Power systems for
+         platform integrity.
+
   *  Interfaces and APIs
 
      (1) TPM
@@ -149,6 +170,11 @@ safe.
          Vendor-specific API that is implemented as part of the DCP crypto driver in
          ``drivers/crypto/mxs-dcp.c``.
 
+     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
+
+         Platform Keystore has well documented interfaces in PAPR document.
+         Refer to ``Documentation/arch/powerpc/papr_hcalls.rst``
+
   *  Threat model
 
      The strength and appropriateness of a particular trust source for a given
@@ -191,6 +217,10 @@ selected trust source:
      a dedicated hardware RNG that is independent from DCP which can be enabled
      to back the kernel RNG.
 
+   * PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
+
+     The normal kernel random number generator is used to generate keys.
+
 Users may override this by specifying ``trusted.rng=kernel`` on the kernel
 command-line to override the used RNG with the kernel's random number pool.
 
@@ -321,6 +351,26 @@ Usage::
 specific to this DCP key-blob implementation.  The key length for new keys is
 always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
 
+Trusted Keys usage: PKWM
+------------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen [options]" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+    options:
+       wrap_flags=   ascii hex value of security policy requirement
+                       0x00: no secure boot requirement (default)
+                       0x01: require secure boot to be in either audit or
+                             enforced mode
+                       0x02: require secure boot to be in enforced mode
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
+specific to PKWM key-blob implementation.  The key length for new keys is
+always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
 Encrypted Keys usage
 --------------------
 
-- 
2.47.3


