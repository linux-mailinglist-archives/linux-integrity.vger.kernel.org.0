Return-Path: <linux-integrity+bounces-9079-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKmFNTUKw2lKnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9079-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F9F31D170
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F76B3013027
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CA19343E;
	Tue, 24 Mar 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Thb+H7mO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC93AC0DE
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389811; cv=none; b=Ih6Mm+HRthSeLT8P3TmYTNmxueKpilFJv1cG4PKFye8OeCQ1KbYrBFR+pIQvfFEZJIZXGIX6qjb04DuU+q1zyHicLwKsd2TU0jrTp4gRYKBZmmH+pEIriUhLoaG4RoWKJ96EuzYqe96YllrrgPWVZzetOiKI+eJ2A7UtFXh07wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389811; c=relaxed/simple;
	bh=vnlDOEh9sepeBzBlQxYirAnee240rnID4GlqRmBJjvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkzO9AOJh37W6apIxNtfucDk4aYoBEZVQ3JOaPsfa6hhwZYhUsodbvYHmpwOjqLpdoLqO30FH8fp8C3yawbzmJYV5PLgLEFxP6I4/Dr6y2rceI6bucqn/UROFwBEbM+6rtu42bKze35odbQ/RCknfI3bkc7z2YOChcc/Vc0m5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Thb+H7mO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OFSKuG3792418;
	Tue, 24 Mar 2026 22:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b2njq2pdZMWo7/wJW
	OhvX7NZN+GfB5XOucqApYyzJXM=; b=Thb+H7mOTjybFwMRQDFxl7jAUBprTg7y3
	P57kAHkiR2/lc7JkiuhxA4e96yaFaX6rDNTFVmm35QK+VF96WghC+sM7mauU7OgJ
	pjg2faug1dJXvxp+QG0qZknfYUGwq7SyEGEKHZJYrzq0BG6FH0CGc5nZ7cIybZvu
	iCLS6VTwCLp9samjwqX/uXGYYY0agvQXoOboE9uCYSexaYbCVdSG01ojNhbSkyB2
	vgG/m6EAb69dJ6NPkoDFZX4zUVj9mUwcoZnRFPYIsDNs0Z6jzBhm1c0NrZ9juNxb
	foUf1w8jGCycOwlpsPb7RqiEY9lM7LY3C27T+L/oNKf0wuWMa4R5A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqdxjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKo3tZ004407;
	Tue, 24 Mar 2026 22:03:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c23sxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3JHr31457858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25FB658056;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2AE58052;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 4/8] Support v3 IMA and EVM file signatures with --v3 option.
Date: Tue, 24 Mar 2026 18:03:10 -0400
Message-ID: <20260324220314.743709-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324220314.743709-1-stefanb@linux.ibm.com>
References: <20260324220314.743709-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ltsT6zhdvVVMI3XNFtCFXvBz9ZDJamv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX5oBi7agqd9wq
 Ga47lnjgebWUA4mJ3D1HqltggFtMRKO5dP0iiy+XKTTkCXOV5p/I8MM6Bqjn2McIxicRodfnACU
 SM7vVgBxyjylAnOgT+HWtYmPZw47ixMEbLDPGm6R/290lQxP4DC2IMAcBMDn5c3lPOS0Po5x+ED
 j5K5XjEljsszYx26io/Q0mabtjmhgF915WcQbzifwH2EGZ6v96hlrLmTSISywK2idqd71FEFiUI
 EGjFSE6npb2mq09voMe9enrVEHZpRdqw+xKBZBmjWGlTSiB46Ky+YwYjQ8NtIXEFgg15InkBFj1
 TkCjrQEtSkyJCNZETHxnlc8T3CpbO/knM892PuGYd7ZT+HvtG2GQ7B3bhiqyM8GbUe8HGWct9cU
 CMJIMJ5CnmSGTKyUC32QSUqzVlL++OWBRbUCQ4k4Jvo1+FWiCA+YloVE2EXh99FJVfEhU/Jleej
 p2RVfF0UN7xDc7ogW3Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c30a28 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KIJi67mhznwvO7aXmeMA:9
X-Proofpoint-GUID: ltsT6zhdvVVMI3XNFtCFXvBz9ZDJamv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9079-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 99F9F31D170
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable both IMA and EVM file signatures with a new --v3 option that sets
the previously introduced global variable that states which signature
version to use.

Similarly, introduce a --v2 option for users to (already) choose old V2
type of signatures.

Update the README with the dump of the evmctl help screen and mention
v3 signature format that is expected for Linux 7.1.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README       |  6 ++++--
 src/evmctl.c | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 815b555..34dfddf 100644
--- a/README
+++ b/README
@@ -84,6 +84,8 @@ OPTIONS
       --provider p   preload OpenSSL provider (such as: pkcs11)
       --ignore-violations ignore ToMToU measurement violations
       --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)
+      --v2           create V2 signatures; this is the default
+      --v3           create V3 signatures; this requires Linux 7.1 or later
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
@@ -139,7 +141,7 @@ evmctl '--smack' options enables that.
 Key and signature formats
 -------------------------
 
-Linux integrity subsystem supports two type of signature and respectively two
+Linux integrity subsystem supports three types of signature and respectively two
 key formats.
 
 First key format (v1) is pure RSA key encoded in PEM a format and uses own signature
@@ -149,7 +151,7 @@ for signing and importing the key.
 Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
 in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
 
-For v2 signatures x509 certificate (containing the public key) could be appended to the
+For v2 and v3 signatures x509 certificate (containing the public key) could be appended to the
 private key (they both are in PEM format) to automatically extract keyid from its Subject
 Key Identifier (SKID).
 
diff --git a/src/evmctl.c b/src/evmctl.c
index aab5af9..2843ff8 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -3017,6 +3017,8 @@ static void usage(void)
 #ifdef DEBUG
 		"      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)\n"
 #endif
+		"      --v2           create V2 signatures; this is the default\n"
+		"      --v3           create V3 signatures; this requires Linux 7.1 or later\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n"
@@ -3092,6 +3094,8 @@ static struct option opts[] = {
 #if CONFIG_IMA_EVM_PROVIDER
 	{"provider", 1, 0, 149},
 #endif
+	{"v2", 0, 0, 150},
+	{"v3", 0, 0, 151},
 	{}
 
 };
@@ -3370,6 +3374,12 @@ int main(int argc, char *argv[])
 			access_info.type = IMAEVM_OSSL_ACCESS_TYPE_PROVIDER;
 			break;
 #endif
+		case 150: /* --v2 */
+			g_signature_version = SIGNATURE_V2;
+			break;
+		case 151: /* --v3 */
+			g_signature_version = SIGNATURE_V3;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.53.0


