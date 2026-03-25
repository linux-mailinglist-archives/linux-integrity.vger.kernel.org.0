Return-Path: <linux-integrity+bounces-9088-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CjvJ4ZVxGljyAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9088-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 22:37:10 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13132C884
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 22:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7E33016EC1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3C396577;
	Wed, 25 Mar 2026 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OHL+2KLk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188F25A359;
	Wed, 25 Mar 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474444; cv=none; b=hJSuaiXqRkXj+/3JpQQ4n5ICpg0jpccGqfE+bnPArvyPc+3BYFa/yr3/wEIOKJEdEsQ6W77u5G3Y4vgvFosZRvgwii6G9j7AfpA8HYWGycMUZUCfnNEhMWt12kvHOZCpRYE6RZWCF9PzEHSuKXDQujilBxvDf49sd15u747PXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474444; c=relaxed/simple;
	bh=8erEa9yda/y/az9sBBVgPJj3jPvLJoEHhy5U6KJihaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4CsAMBAp0/RnMVOPhcyC8O0Cf1RaePIKdjy1vIScuzlcoC8l4oSBX0YvxwaN5lkR2ZCjwrHETNn2XLuHSgBqgek6u9CGNlgnFYBw5OAF/lF8T5VYb4PZ8bzs8lnCoa4sCgU0vM2tAdlXxVUMs4nYXF+2xSNEuS4zK2WzRPYpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OHL+2KLk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PEXj8K2773651;
	Wed, 25 Mar 2026 21:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pnWwTjrqpTpNmQNtLhoF9f3icdWKsd4i/HDtcPMIq
	Qo=; b=OHL+2KLkbS9b6KLdniZaQgHpt4RsKoi1h0Z5bHco2oKklQwJnRdieiqzD
	kAYrWSCw9yKAMqksBLHZQXTfkxhFerzYVtdPsXSAm1JMCjLuN0PZYKJ1cOvk3HCF
	fyXA6MBFv6fiHN0oYOJsgp+8TFHWQBfomBFnCzlclCoIuKpIjuKfN6AZ2aIFv+s+
	8Dj9gi8su7tkUuV73QGXFq1k1ulm6qKB2TeY/MV9S7OgHntrr/DJ44SaeyRBr3RK
	Lyy+KO6NqW/ONprCeFKXvU8i2rXw8l6sS6/li6ZEhIsCysYnS46zoTVPtlr/viex
	2m9tUYOmM4W6EpSWDksdtAUE75AVA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty2fua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:33:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKeHUE004375;
	Wed, 25 Mar 2026 21:33:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c28340-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:33:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PLXqjO57475400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:33:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9AE58059;
	Wed, 25 Mar 2026 21:33:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 034BB58061;
	Wed, 25 Mar 2026 21:33:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:33:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] evm: Enforce signatures version 3 with new EVM policy 'bit 3'
Date: Wed, 25 Mar 2026 17:33:49 -0400
Message-ID: <20260325213349.1061363-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c454c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=dtBzxhyFjFcZ9BccNZMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1NyBTYWx0ZWRfX+I42OWb+8gWt
 VE7tjoPJw0x6WI4oX3by7w+se+Im9RKeN2l7PnGiYAL0JFpa2oNqlPu1iRtAv51Q6PN0+8UWMpQ
 d9ng1h5mHxbKGfHrFvzhPj7K7e0vZ1SZNI6AN4vgnJzp3TbObUvMPB5G2Buk1W1pauRIo4Bp5uv
 fAmcQsCcAQ0WAIo4OWXXLCLxLDHSyz0BYmJz19n18BXoP9GBOCN4gkpIMRVxkEOVrc+pddYKi38
 SgtQw/4EL7waIODj4sR0j9/aeZ9P7/w1dDJ15QfNodrksLUCpb4Rt9Vngqy9b/twXFuKl6j1SNB
 SYuaXPh4ZxapabWfb3uWJ/kFqVgVJV+YhzaxGRL959TxiZbkUmsJdhxI+1wTLQuVXoXjEnjhk0Z
 SBXp1X1KO1wSAVUL0zwPkuk0TavFANxnh2Uw+zIAxdx8RdxS0jf+S0yvUgzqbdJgOaxsm+07Xsb
 zvldeVFk4vWK8mVqcpg==
X-Proofpoint-GUID: 33MzyhSLC_fOzn02VHAqT-SJwxA8pA25
X-Proofpoint-ORIG-GUID: 33MzyhSLC_fOzn02VHAqT-SJwxA8pA25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250157
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9088-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1D13132C884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable the configuration of EVM so that it requires that asymmetric
signatures it accepts are of version 3 (sigv3). To enable this, introduce
bit 3 (value 0x0008) that the user may write to EVM's securityfs policy
configuration file 'evm' for sigv3 enforcement.

Mention bit 3 in the documentation.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 Documentation/ABI/testing/evm     |  1 +
 security/integrity/evm/evm.h      |  3 ++-
 security/integrity/evm/evm_main.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 44750a933db4..db3007babb58 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -26,6 +26,7 @@ Description:
 		2	  Permit modification of EVM-protected metadata at
 			  runtime. Not supported if HMAC validation and
 			  creation is enabled (deprecated).
+		3	  Require asymmetric signatures to be version 3
 		31	  Disable further runtime modification of EVM policy
 		===	  ==================================================
 
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 51aba5a54275..694552aceaf8 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -20,11 +20,12 @@
 #define EVM_INIT_HMAC	0x0001
 #define EVM_INIT_X509	0x0002
 #define EVM_ALLOW_METADATA_WRITES	0x0004
+#define EVM_SIGV3_REQUIRED		0x0008
 #define EVM_SETUP_COMPLETE 0x80000000 /* userland has signaled key load */
 
 #define EVM_KEY_MASK (EVM_INIT_HMAC | EVM_INIT_X509)
 #define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP_COMPLETE | \
-		       EVM_ALLOW_METADATA_WRITES)
+		       EVM_ALLOW_METADATA_WRITES | EVM_SIGV3_REQUIRED)
 
 struct xattr_list {
 	struct list_head list;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b15d9d933b84..b59e3f121b8a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -136,6 +136,14 @@ static bool evm_hmac_disabled(void)
 	return true;
 }
 
+static bool evm_sigv3_required(void)
+{
+	if (evm_initialized & EVM_SIGV3_REQUIRED)
+		return true;
+
+	return false;
+}
+
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
@@ -258,6 +266,12 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		}
 
 		hdr = (struct signature_v2_hdr *)xattr_data;
+
+		if (evm_sigv3_required() && hdr->version != 3) {
+			evm_status = INTEGRITY_FAIL;
+			goto out;
+		}
+
 		digest.hdr.algo = hdr->hash_algo;
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
 				   xattr_value_len, xattr_data->type, &digest,

base-commit: e5797456e49041238b131c78e90e5d36a7fc0656
-- 
2.53.0


