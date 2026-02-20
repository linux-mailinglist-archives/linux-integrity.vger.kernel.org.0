Return-Path: <linux-integrity+bounces-8530-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEkzF0OpmGmvKgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8530-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:34:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FC16A165
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88245300EAA5
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E3366542;
	Fri, 20 Feb 2026 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fqGqLbPv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4834575F;
	Fri, 20 Feb 2026 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612479; cv=none; b=t1ZW5RDqDvnKrJNq/sQgZj9kNzmBhyLXsbDfpSJiuJCHhVTTbdTw9EU98oT9mSUFPtL32+N8q/XEacZK4OQGkhc2nY4voXFaSSeaw1cn7f/fqivpstCtoFHvWn0wmxZXuuRZ9Zx8iPeuzr7QHKjtDl1d1jV+BOW6DHpUwSbCg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612479; c=relaxed/simple;
	bh=JahsDDBTzLrjHMi8VQdDrRysEKrqkdg6maPvxtOdLwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvu+sXW7EqRLJ4T9Ws9agZEO0wm4G6AZBJIjQT5NVrTNT+CsKDPvx35AZhtXs+Xoon9ab3xLHZjL7S6sWtS14VAE7VxhTy09D+aYLX+aN4CLCwKCqOSoKGlKrkEBbYjbhuzsu8XxtiAIht71k6nM9EUFjC3RwzumNiJy+ZGlzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fqGqLbPv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KFfO0r1600964;
	Fri, 20 Feb 2026 18:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RGqJ2VqAAo2X5ReEUCba4JsEHz0o9t/0iU4iJ2NTb
	Qg=; b=fqGqLbPvNnldGfPINkZ1eF0AN7Y2rKzWt5/XljueRyWZviwtk0PIjLTiE
	7rCpowN8HyLfl5OTpX7JvpnLMlrhuOGVdKkHs2JIddTrQ34gNbi700l5A1vRrJRe
	kfbZLmBtfA80uvxp/qcxe4RiPE2lniryLKhgpzIqWDmYzsu+WlzlZ9LIQZblfvKE
	8AcLp7xx42juFNcgrbjidlSYFs3pjingmzrBSJqX/aiZF1ADNQBF/+NLJSIjNGkZ
	0aZTFzzYDNvE7QFeaOLGZ33b2GmiQiVTp+Lrr3Xju6lt+UtGnnMzh7hyn4M2f8s5
	k6qgyXYpK8N95eww0I8KYOvajyZug==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcrck64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:34:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KF0P6p015715;
	Fri, 20 Feb 2026 18:34:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hhc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:34:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KIYTZl40239438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 18:34:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5886202FB;
	Fri, 20 Feb 2026 18:34:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC35202F9;
	Fri, 20 Feb 2026 18:34:27 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 18:34:27 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        ssrish@linux.ibm.com
Subject: [PATCH v2 0/2] move TPM-specific fields into trusted_tpm_options
Date: Sat, 21 Feb 2026 00:04:24 +0530
Message-ID: <20260220183426.80446-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vX5fIhY2s66yMQ80m34NoQ258_ISunHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MyBTYWx0ZWRfX2v62y3M8wGK2
 aw5bGFZ0rbSEADbouW5drDS1tDlj1NzydoOYLIAmYv2XnhwqeoQ40UjGHWhE9QtDa39geSAUtaI
 I4k/V9nA5singngT1MS7eTSzacir0JpdOkCCKP5Wt3Sa+VNqNz3lklSeMB2S48bLmnkwbG8AzTJ
 FjlwrNpHGnykSn67P/tJwJ/uQAh8B70NYvfJx1BWi5+QtadDhykv+2NuTkuJ/JyhrKcVHMoytcI
 81VjuWinMvjsgSBFVCJn0t3XH30rJLbX5++b3bV9YRhFF54dAhsZAyYf12woRalTOEfqsO4lBmR
 tZfU2d6KTa+WUxRyi0I8di77TsPeWgH1S9v9wq+zyKi5alhzuSgw71rRhM38mMXw7WA+R2QrL5g
 9DP5+h+ayKN/lxNVcbJa0r8RA/ZjhTajYePy6tLdNo9NUtxi1WEoa1LqTZ/lfTEg7shKLldBMCi
 O3Al7dq9dL84eUDtZ7g==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=6998a93b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=jNe4AHez7ImSQk6licYA:9
X-Proofpoint-ORIG-GUID: vX5fIhY2s66yMQ80m34NoQ258_ISunHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8530-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B92FC16A165
X-Rspamd-Action: no action

The backend-agnostic trusted_key_options structure carries TPM-specific
fields. With the recent addition of a backend-private pointer, these fields
can be moved out of the generic options structure.

This patch series intends to reloacte all TPM-spcific fields into a newly
defined trusted_tpm_options structure. A pointer to the trusted_tpm_options
struct is stored in trusted_key_option's private.

Along with the migration of TPM-specific fields, this patch series includes
a preparatory clean-up patch: replacing pr_info() with pr_debug() and using
KERN_DEBUG for print_hex_dump() for logging debug information.

Testing covered both TPM 1.2 and TPM 2.0 backends (virtual environment),
including trusted key creation, revocation, unlinking, invalidation, and
loading keys from encrypted blobs. I would welcome any additional testing
from upstream to further strengthen the validation.

Changelog:

v2:
 * Exclude the bug-fix patch as it has already been applied to 6.19-rc7
 * Rename instances of trusted_tpm_options from tpm_opts to private
 * Use pr_debug and KERN_DEBUG for logging debug messages (preparatory
   clean up patch)
 * Address comments from Jarkko

Srish Srinivasan (2):
  keys/trusted_keys: clean up debug message logging in the tpm backend
  keys/trusted_keys: move TPM-specific fields into trusted_tpm_options

 include/keys/trusted-type.h               |  11 --
 include/keys/trusted_tpm.h                |  14 +++
 security/keys/trusted-keys/trusted_tpm1.c | 129 ++++++++++++----------
 security/keys/trusted-keys/trusted_tpm2.c |  51 +++++----
 4 files changed, 111 insertions(+), 94 deletions(-)

-- 
2.43.0


