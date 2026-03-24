Return-Path: <linux-integrity+bounces-9068-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HBXNfH2wmklngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9068-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:41:21 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262731C6E6
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2293029C04
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896235504D;
	Tue, 24 Mar 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OvkXQY5J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCA355F49
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384793; cv=none; b=Y4t2S4x7gS33WNj2s/uZX6r0/AfbdN88hVTrW8R36+987ZwPzhGNtLkOy0SxMYANwmiLIeA3lZQ/pHLYRm6/8ugRADSt9BTTSEYVD26tMVts4fcUfrslW/E6V1ADs5KRfZpenh3SHR/ls405Xuac/ezUsNpXogZsUp4k/t7OZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384793; c=relaxed/simple;
	bh=Wu93WYYa8G/MSnMp9w+g2NdxVJQrsB4qTeUMMLCbPbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb5NFynRc86f23evnAn2NuIxAafCWL82nyrBLBkeYd5aEzDIwLkbZ2WpaoKdTRRhIB/ueQTM4e2B442d4IIU3r+3LYXJio0Q6zn44hQ+3pNwg34raoLcPmmQ9VNTwp2kLiYxSgNbu0jcLpWglotkNNj53Ondq8iG2TR38NVKyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OvkXQY5J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OK608t1013982;
	Tue, 24 Mar 2026 20:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=udCpXNG3OSlXXkDmE
	ge2qRvBOxNYNpZiGlhpIJ7jmhg=; b=OvkXQY5Js4WaFjmsXtwlvb1O6qqx+u+8T
	0zFLWLilpbhwAIWyOmVkqUF3X49MWSsjCnqjF6QrlYiqPz3ivJoyqFPxZQ5fKUF1
	JIut0ihCtBp2ViCX/RvK6reUBhHaSTK3E5wpiGcSV6PRRHGH+s2qKT6fSIJIplFj
	KdV7Ypw+ehzJlgvx5pjBRkxv2VsHFd5JEiV8ym90N889630Q2s/tuhwq/k2yRIop
	oy0AaFyYWSLiQjj/hFwiipxf3UWfDdiOuqLIAKANPSyEQKgD0dru6rsr6RTcinGg
	eWDhyhzrP74wbFAt7KE9kugu8t1CM4Y+4AArv9T5Oayfa/W63g3UA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqdp6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OK2a8v012203;
	Tue, 24 Mar 2026 20:39:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk3k5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OKdhdW48628120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 20:39:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C9520043;
	Tue, 24 Mar 2026 20:39:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 394A520040;
	Tue, 24 Mar 2026 20:39:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.188.204])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 20:39:41 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/3] ima: add support to require IMA sigv3 signatures
Date: Tue, 24 Mar 2026 16:39:29 -0400
Message-ID: <20260324203929.2475782-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sewsr4YuHBzWyC7EzbSQ32YX6WmDv_mJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NyBTYWx0ZWRfXxtF5iSyo8UTS
 /L9XY/sWGSlp4DxbpTxAJ/clEXUnxL6texqEycZJPWbHUiGBB/vv4OM+Vs5MoqEwObCer5FRuHc
 cbK2IJ+qofeREodYQz07sVg5Mh4ph8mr7iFKWXgNOccRcQ1I5KTprTY4OkH95SmEz7swIFghuEP
 CsltxSpYP47oz7pagbQYH13PODBmRUtg50MzwSqtNEbZp9Pnh6CNRb4XshsWysqZKhnSRMFDU2c
 xR6ulXKP/cMb4FFEydTBZz0K1Ax11xw+q+9XsrmbdfseIzdkGzyk/XblBpP1aHrr99bMeuIQ08K
 BXQVEnH55S0QnJBUo6gRCHz4mtAQ3fTvCsTHOBkgP/LI6nT/jdlmvBnMsbxxo/Rtwn6GWN3dO1c
 hfUFcUR3rlnLzPmq/Y/gLjbveLydwD0IB8eAYeAb49mCcj84e1lXYSiZlKor1NrMh7OwrxeijNQ
 hBFQ00u70R/z/WgcEUg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2f694 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wZZ-SWNk9b6tDlcTpm0A:9
X-Proofpoint-GUID: sewsr4YuHBzWyC7EzbSQ32YX6WmDv_mJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240157
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9068-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5262731C6E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Defining a policy rule with the "appraise_type=imasig" option allows
either v2 or v3 signatures. Defining an IMA appraise rule with the
"appraise_type=sigv3" option requires a file sigv3 signature.

Define a new appraise type: IMA_SIGV3_REQUIRED

Example: appraise func=BPRM_CHECK appraise_type=sigv3

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy  | 10 ++++++----
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_appraise.c |  7 +++++++
 security/integrity/ima/ima_policy.c   | 22 ++++++++++------------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index d4b3696a9efb..19258471b7b2 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -53,10 +53,7 @@ Description:
 			    where 'imasig' is the original or the signature
 				format v2.
 			    where 'modsig' is an appended signature,
-			    where 'sigv3' is the signature format v3. (Currently
-				limited to fsverity digest based signatures
-				stored in security.ima xattr. Requires
-				specifying "digest_type=verity" first.)
+			    where 'sigv3' is the signature format v3.
 
 			appraise_flag:= [check_blacklist] (deprecated)
 			Setting the check_blacklist flag is no longer necessary.
@@ -186,6 +183,11 @@ Description:
 			appraise func=BPRM_CHECK digest_type=verity \
 				appraise_type=sigv3
 
+		Example of a regular IMA file hash 'appraise' rule requiring
+		signature version 3 format stored in security.ima xattr.
+
+			appraise func=BPRM_CHECK appraise_type=sigv3
+
 		All of these policy rules could, for example, be constrained
 		either based on a filesystem's UUID (fsuuid) or based on LSM
 		labels.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0eea02ff04df..69e9bf0b82c6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -145,6 +145,7 @@ struct ima_kexec_hdr {
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
+#define IMA_SIGV3_REQUIRED	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_MODSIG_ALLOWED	0x20000000
 #define IMA_CHECK_BLACKLIST	0x40000000
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8f182d808b09..de963b9f3634 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -302,6 +302,13 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 			*status = INTEGRITY_FAIL;
 			break;
 		}
+
+		if ((iint->flags & IMA_SIGV3_REQUIRED) && sig->version != 3) {
+			*cause = "IMA-sigv3-required";
+			*status = INTEGRITY_FAIL;
+			break;
+		}
+
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
 					     (const char *)xattr_value,
 					     xattr_len,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index bf2d7ba4c14a..f7f940a76922 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1298,7 +1298,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
+				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED |
+				     IMA_SIGV3_REQUIRED))
 			return false;
 
 		break;
@@ -1833,9 +1834,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		case Opt_digest_type:
 			ima_log_string(ab, "digest_type", args[0].from);
-			if (entry->flags & IMA_DIGSIG_REQUIRED)
-				result = -EINVAL;
-			else if ((strcmp(args[0].from, "verity")) == 0)
+			if ((strcmp(args[0].from, "verity")) == 0)
 				entry->flags |= IMA_VERITY_REQUIRED;
 			else
 				result = -EINVAL;
@@ -1849,14 +1848,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 			} else if (strcmp(args[0].from, "sigv3") == 0) {
-				/* Only fsverity supports sigv3 for now */
-				if (entry->flags & IMA_VERITY_REQUIRED)
-					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
-				else
-					result = -EINVAL;
+				entry->flags |= IMA_SIGV3_REQUIRED |
+					IMA_DIGSIG_REQUIRED |
+					IMA_CHECK_BLACKLIST;
 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
 				 strcmp(args[0].from, "imasig|modsig") == 0) {
-				if (entry->flags & IMA_VERITY_REQUIRED)
+				if ((entry->flags & IMA_VERITY_REQUIRED) ||
+				    (entry->flags & IMA_SIGV3_REQUIRED))
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED |
@@ -1941,7 +1939,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 	/* d-ngv2 template field recommended for unsigned fs-verity digests */
 	if (!result && entry->action == MEASURE &&
-	    entry->flags & IMA_VERITY_REQUIRED) {
+	    (entry->flags & IMA_VERITY_REQUIRED)) {
 		template_desc = entry->template ? entry->template :
 						  ima_template_desc_current();
 		check_template_field(template_desc, "d-ngv2",
@@ -2309,7 +2307,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	if (entry->template)
 		seq_printf(m, "template=%s ", entry->template->name);
 	if (entry->flags & IMA_DIGSIG_REQUIRED) {
-		if (entry->flags & IMA_VERITY_REQUIRED)
+		if (entry->flags & IMA_SIGV3_REQUIRED)
 			seq_puts(m, "appraise_type=sigv3 ");
 		else if (entry->flags & IMA_MODSIG_ALLOWED)
 			seq_puts(m, "appraise_type=imasig|modsig ");
-- 
2.53.0


