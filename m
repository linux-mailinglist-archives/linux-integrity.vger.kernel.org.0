Return-Path: <linux-integrity+bounces-8298-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IyGEwuoc2mtxwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8298-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 17:55:39 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0F78AFF
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 17:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 368303015847
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB442FE59A;
	Fri, 23 Jan 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M0xjmR3H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD12DF132;
	Fri, 23 Jan 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187333; cv=none; b=U2SAtpjk9tZ+eXKp1O+FQdE5N3bbkbL9DS4w/zddC6fa/gq3AbM+DRHzV+iN+5w1DKFe/lZbKzOq1wtjEV5vqKcXhA7FjXErlh+v82PYb12Av6kMkwkoKYn9thkw1UTLxdMcFnVvpNv63fRJXMmsDX/2PfZSZUSvGDCAHIgeDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187333; c=relaxed/simple;
	bh=YnBMsv46+T+o3e1v7jzif0QQl62RarWVBUWvPhrcjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bj2+qLIScAC0bj3DJU+EPEv/8hDGmOtWsVYQ1tHcnKyfOYHEtgQ1ytqOiitfTJ5GHDxilKVjM0TN6/GBibVbPvfOK2gbskII/tYFsceLbNTjZ3kQoFQByYAY31Aevrza8UyuzyWdvnYD0TdN5CmLQCr622jy9L6cdlLvo0ngtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M0xjmR3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NCaXMl019525;
	Fri, 23 Jan 2026 16:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mAVb05/RS/j/lQA6wXu+0VFr45JJKxNpoWd7gnEZ7
	L4=; b=M0xjmR3HAcs7STeEt4nn8J6lkyIzNjqvrEnr+lTl089opU39EsV3knjvt
	LiI+8Y5fhNYl/QxWKFbyX0YFFN8GHPMxxhfE92LzRsacbr8RxA+PxhTgDYNvTNwL
	ieSmZmZ0bcc4nQA0p+lgKAIc8bU2jPGxpctvKKomMSBlvoiaJvIk2hgZCElC/kjH
	gNvbdJeSYFpfHKDLgqGTamXnGDAxCzezG2y10z88I4m3ZPHlSIUhiF4byFNsRDKu
	aaAB2woosUQaP/sG4gAL3HcsOUJEFc7TpoQFV+jlQenChiDDbNniGnEu5Vda14Nq
	msPzfjHWuVjF4FOUwMDviA30ILotA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256h6vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 16:55:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NGX7AK023219;
	Fri, 23 Jan 2026 16:55:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256h6vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 16:55:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NF6LqE006393;
	Fri, 23 Jan 2026 16:55:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf21vpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 16:55:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NGt8pe46268924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 16:55:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B190620043;
	Fri, 23 Jan 2026 16:55:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCD620040;
	Fri, 23 Jan 2026 16:55:05 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.24.251])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 16:55:05 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        stefanb@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        ssrish@linux.ibm.com
Subject: [PATCH 0/2] move TPM-specific fields into trusted_tpm_options
Date: Fri, 23 Jan 2026 22:25:02 +0530
Message-ID: <20260123165504.461607-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEyNiBTYWx0ZWRfX/XL9OH1pVLeS
 8nhq/KSiicfO7Ttsey3Gun7ufUwLhPeV4mQEsW5mKBj5443mjamW9auT2OSmW/hpN5Me5CA/xe+
 2WDJhSMZ3uQOsAD3VvA3buMEt9zu/HEETKftIA3jdr+51YBO6FQ6SRKFZ4voS+srUbiNIuu8lIs
 WAHzSZZ5jfitRk+3V0F2xakndoHZjlbMWHG5WD/pouMJ7ibT6YqAMsSkKrXZU2MvRhEovePlC5n
 6fVvyuhhfLWZyZBODNTxW+mZ4oSZ1VIE0ohZL4d1bKRgYOmAPQBVWU0+RmQX12tGDC80HnfwTNS
 JjsWe3n0yyzw+zFyybgw2b4pTC73iYRezSmbAswT/mdA8IE7+dWRhTRnjsgAOVcp2igaQ5LhYh4
 HfDy0IC4dNdezDLoXn+/Bo04ftjX6owKEqkZyFIMs+arVqFaJo8yNx8wyfZkyKSCO0MqsJUq2Nz
 9Tdv4zTbcKj5NAg4q1Q==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=6973a7f3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3yCG5LwcDJjBEDrlHn8A:9
X-Proofpoint-GUID: Yhj4Wdvrij7FI0Zneiz8DfRfamwcZVT-
X-Proofpoint-ORIG-GUID: Mtbi3pHXcwUi8uys7erHXBPRPZKtfjLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8298-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,HansenPartnership.com,kernel.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDC0F78AFF
X-Rspamd-Action: no action

A recently posted patch series titled 'Extend "trusted" keys to support
a new trust source named the PowerVM Key Wrapping Module (PKWM)'
introduced a change in the handling of backend-specific fields in the
backend agnostic trusted_key_options structure. However, there are a
number of TPM-specific fields that are residing in trusted_key_options
and they have not been migrated yet.

This patch series intends to move all TPM-spcific fields out of
trusted_key_options into a newly defined trusted_tpm_options structure.
A pointer to the trusted_tpm_options struct is stored in
trusted_key_option's private.

Along with the migration of TPM-specific fields, this patch series includes
a preparatory bug-fix patch: passing the blob_handle to tpm_buf_append_name
during TPM2_Unseal instead of the keyhandle.

This patch series has been validated against both TPM 1.2 and TPM 2.0
trusted-key backends using a vTPM environment, on x86_64 and ppc64le.
Testing included key creation, loading, resealing (TPM 2.0), key revocation
, unlinking, invalidation, and reloading trusted keys from encrypted blobs.
I would welcome any additional testing from upstream to further strengthen
the validation.

This patch series is intended to be applied on top of the PKWM trusted-keys
series posted earlier [1], which introduces a pointer named private in the
trusted_key_options structure to handle backend-specific fields.

Srish Srinivasan (2):
  keys/trusted_keys: fix handle passed to tpm_buf_append_name during
    unseal
  keys/trusted_keys: move TPM-specific fields into trusted_tpm_options

[1]
lore.kernel.org/linuxppc-dev/20260115100504.488665-1-ssrish@linux.ibm.com/T

 include/keys/trusted-type.h               |  11 ---
 include/keys/trusted_tpm.h                |  14 +++
 security/keys/trusted-keys/trusted_tpm1.c | 103 ++++++++++++++--------
 security/keys/trusted-keys/trusted_tpm2.c |  66 +++++++++-----
 4 files changed, 123 insertions(+), 71 deletions(-)

-- 
2.43.0


