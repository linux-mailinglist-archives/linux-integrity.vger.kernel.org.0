Return-Path: <linux-integrity+bounces-9374-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO+sI8Fj8mmBqgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9374-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:02:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08C499F3E
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 219083013C4B
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA633290C4;
	Wed, 29 Apr 2026 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XN8bSfMy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDC2F7462;
	Wed, 29 Apr 2026 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492916; cv=none; b=V4G/hsOX2uimfWi8YWrzGggHoE5lF+zqgeE73U908luwCKf2WCvkPW2DsW4DPu+0fXAw/sMTZSMSQL/ylKFyQiiORbu2nETx+Y38LuAPMqix2xO66I1tY7iy4FgXtgnzhjp2VKhjKgrNhRXn+nX+Cd37w8H9OpF6Iqabh76JsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492916; c=relaxed/simple;
	bh=fJSg5n+VTofLF+R3vGeT0B6uJwenTXr9SrOBn2KG+f8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=u8Xap3xTeVjvKIRru02bLB/QbhufSWkjfNjqxtB915GVmfHzag1WxbE6GvdN+XbBrMB7SQqmmoXVfXzttwpMom+UAb7fznyBh/ry22q+1uGNM7qpCNtNmx3G2uAU40cvi4EknmPOHBlzCmeW2UT/eVd9TfOhrHyAVhfWLjMedY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XN8bSfMy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFUqIl1317126;
	Wed, 29 Apr 2026 20:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R2x2PQ
	rvORUdwNxHDcUtETRc8rS0gty21jpHed4L61s=; b=XN8bSfMyWP8gMr/AlEGpjg
	I9o25iCplYG0leQKr/pZYRG7PLhl95Ed2+CYsJhH4qP+Lo4NYjDh/HzB9RUOTqL+
	aPy3pnBcvVFfaCWE/ZIWOvitKBZ7cJmClG6R6SDSOAwG/NoIkemEPUsSAGJcuprL
	JMlC3+ku0+VNHW4R3wqWMuI3lcENDx+3vIpxgmBTxPs4Kg0sZZN0Jr6tIKQo5Ue5
	+0iKoIDgbNiIWR2wpr8MR39Y1Nap0sXOI5oXtK13NQiai4YmH/AMs7plpOWZY9xy
	v9R+8j/nJvKvvhjIoJcpuGZCsaHDEe/Az/VoJDq5080NvHc5KXwwK83I9Dml+m0A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1ju408-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 20:01:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TJrroh010290;
	Wed, 29 Apr 2026 20:01:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gfsjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 20:01:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TK1EAE30343876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 20:01:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D87958052;
	Wed, 29 Apr 2026 20:01:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D9FA58065;
	Wed, 29 Apr 2026 20:01:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.118.181])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 20:01:12 +0000 (GMT)
Message-ID: <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
Subject: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
In-Reply-To: <cover.1777036497.git.noodles@meta.com>
References: <cover.1777036497.git.noodles@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 16:01:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5OCBTYWx0ZWRfX7FCsE6eIcPV0
 dRO44UnF0wfI9Fsdy2pzNYSqckElbnehPhzYgU59deAy09/NqVV5peRfk/XnbOaVW4WNoW3yIeh
 5F+xYDm7ICIWl6PiWsn9iHAP1ul1MYT7KzCitUYIxkTTG19zx6c8QY6KuVi8oxcM9zdCQPY8ObM
 r9CMcB2a2GKNRKXO/IeLvVr2M4oKebO8S43cNheX553J3+3F+CUMfY8bMCnlJ8d9j7Ai4xxA0g0
 h+c8R0ktb+8HGBQfxSF+PRXxXejvuC6BsLbJf+Fu3oHQivQmbviOYnZP/e+oyKNzqrGn1CZmGWK
 WiLsM3Uq/RkPd0CFQziWQZ1FSxfcMvfGF0u+zsxxDD7Ya5RQYxWa8fK48enDGobj4cMyO3GfQqZ
 XEvi6l4hn5CYxmeDkErHfoJjX6+ewPe+gLpxlN/DGP1CJcwZrDob9FSjNkZbySgRy4so59IQp57
 iZ9BLkgkza1SODVqvrQ==
X-Proofpoint-GUID: G4mI1EHlNTHJ2Sv4EmdWBE_u_oyWeRVx
X-Proofpoint-ORIG-GUID: 6taI1q2EF8KzjwX9tVp-Ex5_1ZWFnHn4
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2638c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=fWDe5KWseGDh5RaNRN8A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290198
X-Rspamd-Queue-Id: 9B08C499F3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9374-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]

With this "[RFC PATCH v3 0/4] Fix IMA + TPM initialisation ordering
issue" patch set, how many records would be missing if IMA
initialization is deferred to late_initcall_sync [1]?

[1]https://lore.kernel.org/linux-integrity/cover.1777036497.git.noodles@met=
a.com/
---
Jonathan, Yeoreum, others -

By going into TPM-bypass mode, we can see how many measurements are actuall=
y
missing when deferring IMA initialization to late_initcall_sync. As this is
system/TPM dependent, I'd appreciate your checking. Please use the boot com=
mand
line option "ima_policy=3Dtcb|critical_data".

thanks, Mimi

 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_init.c |  6 ++++++
 security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 01aae19ed365..9a1117112fb2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -286,6 +286,7 @@ extern bool ima_canonical_fmt;
=20
 /* Internal IMA function definitions */
 int ima_init_core(bool late);
+int ima_init_debug(bool late);
 int ima_fs_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation=
,
 			   const char *op, struct inode *inode,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima=
_init.c
index 5f335834a9bb..edd063b99685 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -122,6 +122,12 @@ void __init ima_load_x509(void)
 }
 #endif
=20
+int __init ima_init_debug(bool late)
+{
+	ima_add_boot_aggregate(late); /* just add an additional record */
+	return 0;
+}
+
 int __init ima_init_core(bool late)
 {
 	int rc;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index 42099bfe7e43..23e669be54fc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1254,6 +1254,7 @@ static int ima_kernel_module_request(char *kmod_name)
=20
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
=20
+#define TESTING 1
 static int __init init_ima(bool late)
 {
 	int error;
@@ -1264,6 +1265,23 @@ static int __init init_ima(bool late)
 		return 0;
 	}
=20
+#ifdef TESTING
+	/*
+	 * Initialize early, even if it means going into TPM-bypass mode,
+	 * but add an additional boot_aggregrate message for the
+	 * late_initcall_sync.
+	 *
+	 * If measurement list records exist between the boot_aggregate
+	 * and the boot_aggregate_late records, these records would be
+	 * missing when IMA initializion is deferred to late_initcall_sync.
+	 */
+	if (ima_tpm_chip) {
+		ima_init_debug(late); /* Add an additional record */
+		return 0;
+	}
+
+	ima_tpm_chip =3D tpm_default_chip();
+#elif
 	/*
 	 * If we found the TPM during our first attempt, or we know there's no
 	 * TPM, nothing further to do
@@ -1276,6 +1294,7 @@ static int __init init_ima(bool late)
 		pr_debug("TPM not available, will try later\n");
 		return -EPROBE_DEFER;
 	}
+#endif
=20
 	if (!ima_tpm_chip)
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
--=20
2.53.0

