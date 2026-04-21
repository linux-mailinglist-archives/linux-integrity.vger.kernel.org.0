Return-Path: <linux-integrity+bounces-9271-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKtYAL/G52mCAgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9271-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 20:49:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5243ECD4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE18A3008451
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37213612ED;
	Tue, 21 Apr 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2RdsnJ2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6C2D3A86;
	Tue, 21 Apr 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797367; cv=none; b=OXbaeRiccWBPaI/QOq7NX8FaXTqvGEMuxUWPyex/xC2BWlhAfDr+b+H9pvOTIkWDDcxEIASVo/nIF6Yz8xadfI31FkUdogNhAKptlJenZokqaCNKbm+MbF/jwCK6IfCNpqX7YDowFu3+VXie0aNKS04c3IXXMmS/rZuu7VWdXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797367; c=relaxed/simple;
	bh=wDJes4bca8u8IHr9T386Iw3vj1ffLpKD3Cl0p7EnG88=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YevYuw8bYhU7/h1rxM787yerDvZBNAFyQ69k8r2WwLoGM0sEF0LruZFOuJm9mjToxZpkSR/SqAsAalwB1GiSqYNtK/0M9xJyzduikhEa5/HMLJ1ihcLALdiKNRdH4LiJpvI7tnXkzNoMuxrtYf9vKxDiGy1rGYidbCWyqu2AICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2RdsnJ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIlklU970298;
	Tue, 21 Apr 2026 18:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8Wqq/b
	scmb5poF+9W9BhAXH2imxamrzQDM7ZlLTxhzc=; b=U2RdsnJ2HqT0Qt9iY/Zx3E
	4+vp9dV6qlsLkpsw1VmLWSYGh7/dI6ExJ2iGiBQzEB0sdDWdpDMewjfYB0xTulg2
	e2iabEQwsCXAWDyMfuPGstQI8wirZtF5y1pMx4DTt7yxArwywGglnyqjUvnufBV+
	Zt/FCDMl7GhpsUpsmK8qf6j4ZkWjcf0AKKcvNVyI/Q7pj+4Z2U4Siglp9kDJ50HY
	tJmnADdTsr3chYGTUOc/pTTgOvbgeNlGSBX2VnFqTC1mFvUTAwgdmiQUeJpJjloo
	ejUFz/VO/Qyvlewb/RjJVCsvzBqo5Vuuu11mdSDoztjYIRPTjfitWrREaRy/C3Dg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3g048-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 18:49:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LIZN2J008855;
	Tue, 21 Apr 2026 18:49:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k1xp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 18:49:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LIn8ph32572040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 18:49:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8121D58043;
	Tue, 21 Apr 2026 18:49:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD2358059;
	Tue, 21 Apr 2026 18:49:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 18:49:07 +0000 (GMT)
Message-ID: <cb09097358b1f5d993eae2a340a956d12bb0ca91.camel@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.18] ima: Define and use a digest_size
 field in the ima_algo_desc structure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
        stable@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260420132314.1023554-102-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
	 <20260420132314.1023554-102-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 14:49:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: AfdEZ8OYEdL5mMWn6zLlUAoVwbsNm-Bs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE4NyBTYWx0ZWRfX+pkS4iUrNQZ7
 +lYsMuiIic/ED9S5sNOLyfBua49FgKgifXomrRLItX6zTf3wRS0jqAFB56GAbWCOsZsxi+XCkIU
 EdOOyeBkVUUtNUCRrvtRxZQR4Qp0qVPHJzOVq1IE1z5Y4eZ4F8ksa3+9NeO9uHMqNv3ceJWxh/C
 I5xKETjooUnCvHVWJDMHKv04lbiq2cZpdAeQSWKc61hvgZuhB/yCOyh9PSIEqN8ekSooKomoeYK
 BOWKim0kJNrGXK0vu+e25f4r1brwNE8GlU6l2K/iTqF2A3Gv1JgWC1HbecvMk88mztx+F05+CKj
 /Vjt4YjOG75Pz/0Qe6T48CToLnQzbZpJ/1jQoV83w7YPQi97Scd1bzX8Ftbsxa0OJg+ilxY45AZ
 u+zoDnm4hRSdQ/nyHBR7OsFnB6TBJg==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e7c6a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=gu6fZOg2AAAA:8 a=Vp9frXyZb8n4gNz9-bgA:9 a=QEXdDO2ut3YA:10
 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: lH4AO2nOnBmQl6KqS2U42MhxskyuQYmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210187
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-9271-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marc.info:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E3D5243ECD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-20 at 09:18 -0400, Sasha Levin wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> [ Upstream commit a74d7197ebe5b1b8028911d47e78c119d9aaf193 ]
>=20
> Add the digest_size field to the ima_algo_desc structure to determine the
> digest size from the correct source.
>=20
> If the hash algorithm is among allocated PCR banks, take the value from t=
he
> TPM bank info (equal to the value from the crypto subsystem if the TPM
> algorithm is supported by it; otherwise, not exceding the size of the
> digest buffer in the tpm_digest structure, used by IMA).
>=20
> If the hash algorithm is SHA1, use the predefined value. Lastly, if the
> hash algorithm is the default one but not among the PCR banks, take the
> digest size from the crypto subsystem (the default hash algorithm is
> checked when parsing the ima_hash=3D command line option).
>=20
> Finally, use the new information to correctly show the template digest in
> ima_measurements_show() and ima_ascii_measurements_show().
>=20
> Link: https://github.com/linux-integrity/linux/issues/14
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>=20
> LLM Generated explanations, may be completely bogus:
>=20
> Now I have complete information. Let me provide the final analysis.
>=20
> ## Phase 1: Commit Message Forensics
>=20
> ### Step 1.1: Subject Line
> **Record:** Subsystem: `ima:` (Integrity Measurement Architecture, a
> security subsystem). Action verb: "Define and use" - sounds like
> enhancement, but functionally equivalent to "fix digest size source".
> One-line summary: Add a digest_size field to ima_algo_desc for accurate
> template digest output.
>=20
> ### Step 1.2: Tags
> **Record:**
> - `Link: https://github.com/linux-integrity/linux/issues/14` (bug
>   tracker for the linux-integrity subsystem)
> - `Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>` (author)
> - `Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>` (IMA maintainer -
>   applied the patch)
> - No `Fixes:`, no `Cc: stable`, no `Reported-by:` tag.
>=20
> ### Step 1.3: Commit Body Analysis
> **Record:** The message describes three cases for digest size:
> 1. TPM bank-allocated algos: take from TPM bank info (which may differ
>    from crypto subsystem size)
> 2. SHA1: use predefined value
> 3. Default hash algo not among banks: use crypto subsystem's size
>=20
> Author's framing is additive/improvement ("Add the ... field"), but the
> Link points to GitHub issue #14 titled "Out of bound when creating per-
> algo measurement list interfaces" - describing a KASAN out-of-bounds
> read when TPM has unsupported algorithms (e.g., SHA3_256).
>=20
> ### Step 1.4: Hidden Bug Fix Detection
> **Record:** This IS a hidden bug fix. The old code used
> `hash_digest_size[algo]` where `algo` can be `HASH_ALGO__LAST` (for
> unsupported TPM algos). Since `hash_digest_size` is declared
> `[HASH_ALGO__LAST]`, that access is out-of-bounds. The new code uses the
> TPM bank's `digest_size` (always valid) or a known constant.
>=20
> ## Phase 2: Diff Analysis
>=20
> ### Step 2.1: Inventory
> **Record:** 3 files changed:
> - `security/integrity/ima/ima.h` (+1)
> - `security/integrity/ima/ima_crypto.c` (+6)
> - `security/integrity/ima/ima_fs.c` (+6/-12)
>=20
> Total: 13 insertions, 12 deletions. Scope: single-subsystem surgical
> change.
>=20
> ### Step 2.2-2.3: Code Flow and Bug Mechanism
> **Record:** Bug category: **Out-of-bounds read** (KASAN-detectable).
>=20
> Before fix: `ima_putc(m, e->digests[algo_idx].digest,
> hash_digest_size[algo])` where `algo =3D ima_algo_array[algo_idx].algo`.
> If the TPM has an algorithm not supported by the kernel's crypto
> subsystem (e.g., SHA3_256 which was not yet in `tpm2_hash_map`), `algo
> =3D=3D HASH_ALGO__LAST`, and `hash_digest_size[HASH_ALGO__LAST]` is an OO=
B
> read of the `[HASH_ALGO__LAST]`-sized array.
>=20
> After fix: `ima_putc(m, e->digests[algo_idx].digest,
> ima_algo_array[algo_idx].digest_size)`. `digest_size` is populated from
> `tpm_bank_info.digest_size` (which is filled via `tpm2_pcr_read` for
> unknown algos, or `hash_digest_size[crypto_algo]` for known ones),
> `SHA1_DIGEST_SIZE`, or `hash_digest_size[ima_hash_algo]` - all safe
> indexes.
>=20
> ### Step 2.4: Fix Quality
> **Record:** Fix is obviously correct, minimal, and well-contained. The
> new `digest_size` field is populated once during init (`__init`), then
> only read later. Regression risk is low - the change is semantically
> equivalent to the old code when the TPM algo is supported, and correct
> when it isn't.
>=20
> ## Phase 3: Git History
>=20
> ### Step 3.1-3.2: Blame and Fixes target
> **Record:** The buggy line `ima_putc(m, e->digests[algo_idx].digest,
> hash_digest_size[algo])` was introduced by commit `9fa8e76250082a`
> ("ima: add crypto agility support for template-hash algorithm", by
> Enrico Bravi, merged in v6.10). This code is present in every stable
> tree from v6.10 onwards (so 6.12.y and newer).
>=20
> ### Step 3.3: Related Commits
> **Record:** Companion commit `d7bd8cf0b348d` ("ima_fs: Correctly create
> securityfs files for unsupported hash algos") was applied 12 days after
> this one, sharing the same `Link:` to issue #14. That commit has an
> explicit `Fixes: 9fa8e7625008` tag and includes a KASAN dump showing
> `create_securityfs_measurement_lists+0x396/0x440` OOB in
> `hash_algo_name`. The two commits address two sides of the same bug:
> `a74d7197ebe5b` fixes OOB in `hash_digest_size[algo]` (runtime, at file
> read), `d7bd8cf0b348d` fixes OOB in `hash_algo_name[algo]` (boot, at
> file creation).
>=20
> ### Step 3.4: Author Context
> **Record:** Roberto Sassu is a long-term IMA contributor. Mimi Zohar is
> the IMA subsystem maintainer who merged the patch.
>=20
> ### Step 3.5: Dependencies
> **Record:** The fix depends on `tpm_bank_info.digest_size` being
> available, which has existed since commit `879b589210a9a` (2019). No new
> dependencies. Applies to any stable tree containing `9fa8e76250082a`
> (v6.10+).
>=20
> ## Phase 4: Mailing List Research
>=20
> ### Step 4.1-4.4: Patch Discussion
> **Record:**
> - `b4 dig -c a74d7197ebe5b` found single v1 submission at `https://lore.
>   kernel.org/all/20260225125301.87996-1-roberto.sassu@huaweicloud.com/`
> - Discussion thread contains 3 messages from Mimi Zohar (maintainer) and
>   Roberto Sassu. Mimi requested title rename and asked for a note about
>   the design change (from crypto subsystem's digest size to TPM's).
> - No explicit stable nomination, no mention of KASAN in discussion
>   thread itself.
> - GitHub issue #14 (referenced via Link: tag) explicitly documents the
>   OOB bug this is fixing: "If a TPM algorithm is not supported the PCR
>   bank info is initialized with HASH_ALGO__LAST, which passed to
>   hash_algo_name[] causes an out of bound."
> - No v2, applied as single revision.
>=20
> ### Step 4.5: Stable Discussion
> **Record:** No prior stable mailing list discussion found for this
> specific commit.
>=20
> ## Phase 5: Code Semantic Analysis
>=20
> ### Step 5.1-5.4: Call Paths
> **Record:** `ima_measurements_show()` is called when a userspace process
> reads `/sys/kernel/security/ima/binary_runtime_measurements*`.
> `ima_ascii_measurements_show()` similarly for ASCII files. These files
> are readable by root. The path is reachable from userspace via a simple
> `read()` syscall against the securityfs files. `ima_init_crypto()` is
> called once at boot via initcall.
>=20
> ### Step 5.5: Similar Patterns
> **Record:** The sister commit `d7bd8cf0b348d` addresses the same pattern
> (`hash_algo_name[algo]` with `algo =3D=3D HASH_ALGO__LAST`) in the file-
> creation path.
>=20
> ## Phase 6: Stable Tree Cross-Reference
>=20
> ### Step 6.1-6.3: Applicability
> **Record:**
> - Buggy code exists in 6.12.y (verified via `git blame stable-
>   push/linux-6.12.y` showing line 184 originated from 9fa8e76250082a).
>   Also in 6.15, 6.17, 6.18, 6.19, 7.0.
> - 6.1.y and 6.6.y don't have the crypto agility code
>   (`hash_digest_size[algo]` usage) - the fix is NOT applicable/needed
>   there. 6.6.y uses `TPM_DIGEST_SIZE`.
> - Backport difficulty to 6.12.y: minor rework needed (ima_algo_array
>   allocation uses `kcalloc` instead of `kzalloc_objs` in newer tree, but
>   that's not affected by this patch - the field addition and assignments
>   apply straightforwardly).
> - Neither this commit nor `d7bd8cf0b348d` is yet in 6.12.y (verified via
>   `git log stable-push/linux-6.12.y`).
>=20
> ## Phase 7: Subsystem Context
>=20
> ### Step 7.1-7.2
> **Record:** Subsystem: IMA (security/integrity/ima/). Criticality:
> IMPORTANT - used for measured boot/attestation on enterprise/embedded
> systems. Activity: active subsystem with regular fixes. The code is only
> reachable when CONFIG_IMA is enabled AND a TPM is present, further
> narrowing impact to TPM-equipped systems.
>=20
> ## Phase 8: Impact and Risk
>=20
> ### Step 8.1: Affected Users
> **Record:** Users with IMA enabled + TPM 2.0 chip that exposes an
> algorithm not in the kernel's `tpm2_hash_map`. The KASAN dump in
> d7bd8cf0b348d shows this was hit on real hardware (SHA3_256-capable
> TPM).
>=20
> ### Step 8.2: Trigger
> **Record:** The secondary OOB fixed by THIS commit
> (hash_digest_size[HASH_ALGO__LAST]) triggers when:
> 1. A TPM exposes an unsupported algorithm (e.g., SHA3_256)
> 2. A user (root) reads the unsupported-algo measurements file
> Root privilege required - not a remote attack vector, but reproducible
> with specific hardware. The primary OOB (in create_securityfs) hits
> every boot with such TPMs, which is what the KASAN report showed.
>=20
> ### Step 8.3: Failure Mode
> **Record:** Out-of-bounds read from kernel memory. Under KASAN: reported
> as BUG. Without KASAN: may return garbage digest size, which could cause
> excessive data to be read from `e->digests[algo_idx].digest` (a fixed-
> size `[TPM2_MAX_DIGEST_SIZE]` buffer) or leak a few bytes past the
> `hash_digest_size` array. Severity: **MEDIUM-HIGH** (OOB read is KASAN-
> reportable security-relevant behavior, not a guaranteed crash without
> KASAN but can leak info or cause incorrect behavior).
>=20
> ### Step 8.4: Risk vs Benefit
> **Record:**
> - **Benefit: MEDIUM** - Fixes one half of a KASAN-reportable OOB read
>   with real-hardware reproducer.
> - **Risk: LOW** - 13-line structural change, all within the IMA init
>   path + two show functions, no change of external behavior for
>   supported TPM algos.
> - **Ratio: Favorable for backport** - but only valuable when paired with
>   d7bd8cf0b348d (the boot-time crash fix).
>=20
> ## Phase 9: Final Synthesis
>=20
> ### Step 9.1-9.4: Evidence Summary
>=20
> **For backport:**
> - Small, contained (13/12 lines, 3 files)
> - Fixes real OOB read (hash_digest_size[HASH_ALGO__LAST])
> - Obviously correct - reviewed by IMA maintainer (Mimi Zohar)
> - Low regression risk
> - Reachable from userspace (root reads securityfs file)
> - Bug has real-hardware reproducer (SHA3_256 TPMs)
> - Companion commit d7bd8cf0b348d has `Fixes:` tag and will be auto-
>   selected; backporting only d7bd8cf0b348d leaves a latent OOB in the
>   read path
>=20
> **Against backport:**
> - No explicit `Fixes:` tag, no `Cc: stable`
> - Framed as enhancement, not bug fix
> - Alone doesn't fix the primary crash (boot-time OOB in
>   `create_securityfs_measurement_lists`) - that's d7bd8cf0b348d
> - Design change (TPM's size vs crypto's size) noted by maintainer in
>   review
>=20
> **Exception Category:** Not a device ID/quirk/DT/build/doc. Standard bug
> fix evaluation.
>=20
> **Stable Rules Check:**
> 1. Obviously correct: YES (reviewed, simple struct field addition + safe
>    sources)
> 2. Fixes real bug: YES (OOB read)
> 3. Important issue: MEDIUM (KASAN-reportable OOB with real hardware)
> 4. Small and contained: YES (13/12 lines)
> 5. No new features/APIs: YES (internal struct field, not user-visible)
> 6. Applies to stable: YES (6.12.y+ with minor/no conflicts)
>=20
> ## Verification
>=20
> - [Phase 1] Parsed tags: no Fixes:, no Cc: stable, has `Link:
>   github.com/linux-integrity/linux/issues/14`
> - [Phase 1] Hidden bug fix confirmed: commit uses additive language but
>   eliminates OOB read
> - [Phase 2] Diff analysis: `git show a74d7197ebe5b` confirmed +13/-12
>   across 3 files; key change is replacing `hash_digest_size[algo]` with
>   `ima_algo_array[algo_idx].digest_size`
> - [Phase 3] `git blame stable-push/linux-6.12.y
>   security/integrity/ima/ima_fs.c`: buggy line 184 was introduced by
>   9fa8e76250082a (v6.10)
> - [Phase 3] `git show 9fa8e76250082`: confirmed merged in v6.10
>   (2024-04-12)
> - [Phase 3] Found companion commit d7bd8cf0b348d sharing the same GitHub
>   issue link
> - [Phase 3] Verified `include/linux/tpm.h` defines
>   `tpm_bank_info.digest_size` (dependency satisfied in all target stable
>   trees since 2019 via commit 879b589210a9a)
> - [Phase 4] `b4 dig -c a74d7197ebe5b`: found single v1 submission
> - [Phase 4] `b4 dig -c a74d7197ebe5b -a`: only v1, no earlier revisions
> - [Phase 4] `b4 dig -c a74d7197ebe5b -w`: maintainer Mimi Zohar was a
>   recipient
> - [Phase 4] Read `/tmp/thread.mbx`: confirmed maintainer review, no
>   stable nomination, no KASAN mention in thread
> - [Phase 4] WebFetch github issue #14: confirmed OOB bug rationale
> - [Phase 4] WebFetch marc.info original patch: confirmed patch content
>   matches commit
> - [Phase 5] Verified `ima_measurements_show` is reachable via read() on
>   `/sys/kernel/security/ima/*_runtime_measurements*`
> - [Phase 6] `git show stable-push/linux-6.12.y:.../ima_fs.c`: confirmed
>   buggy line present at 184
> - [Phase 6] `git show stable-push/linux-6.6.y:.../ima_fs.c`: uses
>   `TPM_DIGEST_SIZE`, no crypto agility, bug doesn't exist there
> - [Phase 6] `git show stable-push/linux-6.1.y`: ima_fs.c does not have
>   the buggy code
> - [Phase 6] `git log stable-push/linux-6.12.y`: neither this commit nor
>   d7bd8cf0b348d is yet in 6.12.y
> - [Phase 8] Failure mode: OOB read of
>   `hash_digest_size[HASH_ALGO__LAST]` - triggered by reading per-algo
>   measurement file on TPM with unsupported algo
> - UNVERIFIED: Whether d7bd8cf0b348d has been auto-selected by Fixes:-tag
>   tooling; whether user-visible symptoms (without KASAN) would be
>   observable in the field.
>=20
> ## Conclusion
>=20
> This commit is a small, surgical fix for a real out-of-bounds read bug
> that affects stable trees from v6.12 onwards. While the commit message
> frames it as an "add a field" improvement rather than a bug fix, the
> code change explicitly eliminates an OOB read in the user-reachable path
> `ima_measurements_show()` / `ima_ascii_measurements_show()` when a TPM
> exposes an algorithm not supported by the kernel crypto subsystem. The
> companion commit `d7bd8cf0b348d` addresses the parallel boot-time OOB
> (in `create_securityfs_measurement_lists`) and has a `Fixes:` tag, so it
> will likely be auto-selected. If d7bd8cf0b348d reaches stable (as it
> should), this commit is needed to plug the remaining runtime OOB on the
> same hardware.
>=20
> **YES**

Thanks, Sasha!

The AI's conclusion is correct.  This patch is needed when backporting comm=
it
d7bd8cf0b348 ("ima_fs: Correctly create securityfs files for unsupported ha=
sh
algos") is correct.

Mimi

