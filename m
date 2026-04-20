Return-Path: <linux-integrity+bounces-9250-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM3JA+My5mlqtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9250-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 16:06:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CA42CA0B
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5107F31517A0
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830A3BED38;
	Mon, 20 Apr 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt+Bvu3Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322A3BED35;
	Mon, 20 Apr 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691564; cv=none; b=e1TG7lQdyn/YmkkkEjULKYFdtwkFPHahEyHKy4/w+I9UJNLXkmUfyjYT46ExhmVRGGrE2WPJfPgFnHlsaAMf1YinGSFzm+dS3ruRiUghJfBOFsKfzMqFwJegLG0rnstT4HJsqT1SysqRkvD7mKtiCr42a6/11cRwo4ggCqJQCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691564; c=relaxed/simple;
	bh=jjcoB13tRpPTnfLt/MgpFk0y0SStOhlkse4k3XMbPYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqDDS4OdALY9Qn+WCI8qLlRIjeW91G9CUSOYSnEWkagShBwVtX13ZW4TH3bNQXWp/1UzTTGsWZtAHnVHj6/y2eX1oUiIPxt+Ng6YggdFdc5pbuoF5gENLaELawiNkammdcpMPi1I4uBzrVLlSQOciR8g8ppDKfYUiup0xWfrNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt+Bvu3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F4EC19425;
	Mon, 20 Apr 2026 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691564;
	bh=jjcoB13tRpPTnfLt/MgpFk0y0SStOhlkse4k3XMbPYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt+Bvu3ZSn5EK+sFj9CLt0x8zw36Lsfq+3haxtZzpCNn/L+axJDMfg/oPO5bS7MOk
	 9zJeb7pegsgRjeYHcA8Ps6EldsRUlv9ROjVtRq6W0apA1NxmMyCz7TFNVwYVTSsExm
	 W7M1tT2TNKdVfQzSr7VypjfQlBk+ditwTPEuE5ZOlfDlnsHM7hHmM5NYVL60LjWOA+
	 1Q60BKtdOn84FuLc2NjWRYffuS7Pm5rrlDl1LuIpZ/pd32dlznXJXApcuFIuvF6h/t
	 REP3e7U6ig/Fp/fPgPlklT1nDevEpvp9u+YQe9qe2vPorumhXUWJYyyZ5/nxcAjgx4
	 7rcUxFbuWj+UQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] ima: Define and use a digest_size field in the ima_algo_desc structure
Date: Mon, 20 Apr 2026 09:18:16 -0400
Message-ID: <20260420132314.1023554-102-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,linux.ibm.com,kernel.org,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9250-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marc.info:url,lore:url]
X-Rspamd-Queue-Id: 818CA42CA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit a74d7197ebe5b1b8028911d47e78c119d9aaf193 ]

Add the digest_size field to the ima_algo_desc structure to determine the
digest size from the correct source.

If the hash algorithm is among allocated PCR banks, take the value from the
TPM bank info (equal to the value from the crypto subsystem if the TPM
algorithm is supported by it; otherwise, not exceding the size of the
digest buffer in the tpm_digest structure, used by IMA).

If the hash algorithm is SHA1, use the predefined value. Lastly, if the
hash algorithm is the default one but not among the PCR banks, take the
digest size from the crypto subsystem (the default hash algorithm is
checked when parsing the ima_hash= command line option).

Finally, use the new information to correctly show the template digest in
ima_measurements_show() and ima_ascii_measurements_show().

Link: https://github.com/linux-integrity/linux/issues/14
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have complete information. Let me provide the final analysis.

## Phase 1: Commit Message Forensics

### Step 1.1: Subject Line
**Record:** Subsystem: `ima:` (Integrity Measurement Architecture, a
security subsystem). Action verb: "Define and use" - sounds like
enhancement, but functionally equivalent to "fix digest size source".
One-line summary: Add a digest_size field to ima_algo_desc for accurate
template digest output.

### Step 1.2: Tags
**Record:**
- `Link: https://github.com/linux-integrity/linux/issues/14` (bug
  tracker for the linux-integrity subsystem)
- `Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>` (author)
- `Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>` (IMA maintainer -
  applied the patch)
- No `Fixes:`, no `Cc: stable`, no `Reported-by:` tag.

### Step 1.3: Commit Body Analysis
**Record:** The message describes three cases for digest size:
1. TPM bank-allocated algos: take from TPM bank info (which may differ
   from crypto subsystem size)
2. SHA1: use predefined value
3. Default hash algo not among banks: use crypto subsystem's size

Author's framing is additive/improvement ("Add the ... field"), but the
Link points to GitHub issue #14 titled "Out of bound when creating per-
algo measurement list interfaces" - describing a KASAN out-of-bounds
read when TPM has unsupported algorithms (e.g., SHA3_256).

### Step 1.4: Hidden Bug Fix Detection
**Record:** This IS a hidden bug fix. The old code used
`hash_digest_size[algo]` where `algo` can be `HASH_ALGO__LAST` (for
unsupported TPM algos). Since `hash_digest_size` is declared
`[HASH_ALGO__LAST]`, that access is out-of-bounds. The new code uses the
TPM bank's `digest_size` (always valid) or a known constant.

## Phase 2: Diff Analysis

### Step 2.1: Inventory
**Record:** 3 files changed:
- `security/integrity/ima/ima.h` (+1)
- `security/integrity/ima/ima_crypto.c` (+6)
- `security/integrity/ima/ima_fs.c` (+6/-12)

Total: 13 insertions, 12 deletions. Scope: single-subsystem surgical
change.

### Step 2.2-2.3: Code Flow and Bug Mechanism
**Record:** Bug category: **Out-of-bounds read** (KASAN-detectable).

Before fix: `ima_putc(m, e->digests[algo_idx].digest,
hash_digest_size[algo])` where `algo = ima_algo_array[algo_idx].algo`.
If the TPM has an algorithm not supported by the kernel's crypto
subsystem (e.g., SHA3_256 which was not yet in `tpm2_hash_map`), `algo
== HASH_ALGO__LAST`, and `hash_digest_size[HASH_ALGO__LAST]` is an OOB
read of the `[HASH_ALGO__LAST]`-sized array.

After fix: `ima_putc(m, e->digests[algo_idx].digest,
ima_algo_array[algo_idx].digest_size)`. `digest_size` is populated from
`tpm_bank_info.digest_size` (which is filled via `tpm2_pcr_read` for
unknown algos, or `hash_digest_size[crypto_algo]` for known ones),
`SHA1_DIGEST_SIZE`, or `hash_digest_size[ima_hash_algo]` - all safe
indexes.

### Step 2.4: Fix Quality
**Record:** Fix is obviously correct, minimal, and well-contained. The
new `digest_size` field is populated once during init (`__init`), then
only read later. Regression risk is low - the change is semantically
equivalent to the old code when the TPM algo is supported, and correct
when it isn't.

## Phase 3: Git History

### Step 3.1-3.2: Blame and Fixes target
**Record:** The buggy line `ima_putc(m, e->digests[algo_idx].digest,
hash_digest_size[algo])` was introduced by commit `9fa8e76250082a`
("ima: add crypto agility support for template-hash algorithm", by
Enrico Bravi, merged in v6.10). This code is present in every stable
tree from v6.10 onwards (so 6.12.y and newer).

### Step 3.3: Related Commits
**Record:** Companion commit `d7bd8cf0b348d` ("ima_fs: Correctly create
securityfs files for unsupported hash algos") was applied 12 days after
this one, sharing the same `Link:` to issue #14. That commit has an
explicit `Fixes: 9fa8e7625008` tag and includes a KASAN dump showing
`create_securityfs_measurement_lists+0x396/0x440` OOB in
`hash_algo_name`. The two commits address two sides of the same bug:
`a74d7197ebe5b` fixes OOB in `hash_digest_size[algo]` (runtime, at file
read), `d7bd8cf0b348d` fixes OOB in `hash_algo_name[algo]` (boot, at
file creation).

### Step 3.4: Author Context
**Record:** Roberto Sassu is a long-term IMA contributor. Mimi Zohar is
the IMA subsystem maintainer who merged the patch.

### Step 3.5: Dependencies
**Record:** The fix depends on `tpm_bank_info.digest_size` being
available, which has existed since commit `879b589210a9a` (2019). No new
dependencies. Applies to any stable tree containing `9fa8e76250082a`
(v6.10+).

## Phase 4: Mailing List Research

### Step 4.1-4.4: Patch Discussion
**Record:**
- `b4 dig -c a74d7197ebe5b` found single v1 submission at `https://lore.
  kernel.org/all/20260225125301.87996-1-roberto.sassu@huaweicloud.com/`
- Discussion thread contains 3 messages from Mimi Zohar (maintainer) and
  Roberto Sassu. Mimi requested title rename and asked for a note about
  the design change (from crypto subsystem's digest size to TPM's).
- No explicit stable nomination, no mention of KASAN in discussion
  thread itself.
- GitHub issue #14 (referenced via Link: tag) explicitly documents the
  OOB bug this is fixing: "If a TPM algorithm is not supported the PCR
  bank info is initialized with HASH_ALGO__LAST, which passed to
  hash_algo_name[] causes an out of bound."
- No v2, applied as single revision.

### Step 4.5: Stable Discussion
**Record:** No prior stable mailing list discussion found for this
specific commit.

## Phase 5: Code Semantic Analysis

### Step 5.1-5.4: Call Paths
**Record:** `ima_measurements_show()` is called when a userspace process
reads `/sys/kernel/security/ima/binary_runtime_measurements*`.
`ima_ascii_measurements_show()` similarly for ASCII files. These files
are readable by root. The path is reachable from userspace via a simple
`read()` syscall against the securityfs files. `ima_init_crypto()` is
called once at boot via initcall.

### Step 5.5: Similar Patterns
**Record:** The sister commit `d7bd8cf0b348d` addresses the same pattern
(`hash_algo_name[algo]` with `algo == HASH_ALGO__LAST`) in the file-
creation path.

## Phase 6: Stable Tree Cross-Reference

### Step 6.1-6.3: Applicability
**Record:**
- Buggy code exists in 6.12.y (verified via `git blame stable-
  push/linux-6.12.y` showing line 184 originated from 9fa8e76250082a).
  Also in 6.15, 6.17, 6.18, 6.19, 7.0.
- 6.1.y and 6.6.y don't have the crypto agility code
  (`hash_digest_size[algo]` usage) - the fix is NOT applicable/needed
  there. 6.6.y uses `TPM_DIGEST_SIZE`.
- Backport difficulty to 6.12.y: minor rework needed (ima_algo_array
  allocation uses `kcalloc` instead of `kzalloc_objs` in newer tree, but
  that's not affected by this patch - the field addition and assignments
  apply straightforwardly).
- Neither this commit nor `d7bd8cf0b348d` is yet in 6.12.y (verified via
  `git log stable-push/linux-6.12.y`).

## Phase 7: Subsystem Context

### Step 7.1-7.2
**Record:** Subsystem: IMA (security/integrity/ima/). Criticality:
IMPORTANT - used for measured boot/attestation on enterprise/embedded
systems. Activity: active subsystem with regular fixes. The code is only
reachable when CONFIG_IMA is enabled AND a TPM is present, further
narrowing impact to TPM-equipped systems.

## Phase 8: Impact and Risk

### Step 8.1: Affected Users
**Record:** Users with IMA enabled + TPM 2.0 chip that exposes an
algorithm not in the kernel's `tpm2_hash_map`. The KASAN dump in
d7bd8cf0b348d shows this was hit on real hardware (SHA3_256-capable
TPM).

### Step 8.2: Trigger
**Record:** The secondary OOB fixed by THIS commit
(hash_digest_size[HASH_ALGO__LAST]) triggers when:
1. A TPM exposes an unsupported algorithm (e.g., SHA3_256)
2. A user (root) reads the unsupported-algo measurements file
Root privilege required - not a remote attack vector, but reproducible
with specific hardware. The primary OOB (in create_securityfs) hits
every boot with such TPMs, which is what the KASAN report showed.

### Step 8.3: Failure Mode
**Record:** Out-of-bounds read from kernel memory. Under KASAN: reported
as BUG. Without KASAN: may return garbage digest size, which could cause
excessive data to be read from `e->digests[algo_idx].digest` (a fixed-
size `[TPM2_MAX_DIGEST_SIZE]` buffer) or leak a few bytes past the
`hash_digest_size` array. Severity: **MEDIUM-HIGH** (OOB read is KASAN-
reportable security-relevant behavior, not a guaranteed crash without
KASAN but can leak info or cause incorrect behavior).

### Step 8.4: Risk vs Benefit
**Record:**
- **Benefit: MEDIUM** - Fixes one half of a KASAN-reportable OOB read
  with real-hardware reproducer.
- **Risk: LOW** - 13-line structural change, all within the IMA init
  path + two show functions, no change of external behavior for
  supported TPM algos.
- **Ratio: Favorable for backport** - but only valuable when paired with
  d7bd8cf0b348d (the boot-time crash fix).

## Phase 9: Final Synthesis

### Step 9.1-9.4: Evidence Summary

**For backport:**
- Small, contained (13/12 lines, 3 files)
- Fixes real OOB read (hash_digest_size[HASH_ALGO__LAST])
- Obviously correct - reviewed by IMA maintainer (Mimi Zohar)
- Low regression risk
- Reachable from userspace (root reads securityfs file)
- Bug has real-hardware reproducer (SHA3_256 TPMs)
- Companion commit d7bd8cf0b348d has `Fixes:` tag and will be auto-
  selected; backporting only d7bd8cf0b348d leaves a latent OOB in the
  read path

**Against backport:**
- No explicit `Fixes:` tag, no `Cc: stable`
- Framed as enhancement, not bug fix
- Alone doesn't fix the primary crash (boot-time OOB in
  `create_securityfs_measurement_lists`) - that's d7bd8cf0b348d
- Design change (TPM's size vs crypto's size) noted by maintainer in
  review

**Exception Category:** Not a device ID/quirk/DT/build/doc. Standard bug
fix evaluation.

**Stable Rules Check:**
1. Obviously correct: YES (reviewed, simple struct field addition + safe
   sources)
2. Fixes real bug: YES (OOB read)
3. Important issue: MEDIUM (KASAN-reportable OOB with real hardware)
4. Small and contained: YES (13/12 lines)
5. No new features/APIs: YES (internal struct field, not user-visible)
6. Applies to stable: YES (6.12.y+ with minor/no conflicts)

## Verification

- [Phase 1] Parsed tags: no Fixes:, no Cc: stable, has `Link:
  github.com/linux-integrity/linux/issues/14`
- [Phase 1] Hidden bug fix confirmed: commit uses additive language but
  eliminates OOB read
- [Phase 2] Diff analysis: `git show a74d7197ebe5b` confirmed +13/-12
  across 3 files; key change is replacing `hash_digest_size[algo]` with
  `ima_algo_array[algo_idx].digest_size`
- [Phase 3] `git blame stable-push/linux-6.12.y
  security/integrity/ima/ima_fs.c`: buggy line 184 was introduced by
  9fa8e76250082a (v6.10)
- [Phase 3] `git show 9fa8e76250082`: confirmed merged in v6.10
  (2024-04-12)
- [Phase 3] Found companion commit d7bd8cf0b348d sharing the same GitHub
  issue link
- [Phase 3] Verified `include/linux/tpm.h` defines
  `tpm_bank_info.digest_size` (dependency satisfied in all target stable
  trees since 2019 via commit 879b589210a9a)
- [Phase 4] `b4 dig -c a74d7197ebe5b`: found single v1 submission
- [Phase 4] `b4 dig -c a74d7197ebe5b -a`: only v1, no earlier revisions
- [Phase 4] `b4 dig -c a74d7197ebe5b -w`: maintainer Mimi Zohar was a
  recipient
- [Phase 4] Read `/tmp/thread.mbx`: confirmed maintainer review, no
  stable nomination, no KASAN mention in thread
- [Phase 4] WebFetch github issue #14: confirmed OOB bug rationale
- [Phase 4] WebFetch marc.info original patch: confirmed patch content
  matches commit
- [Phase 5] Verified `ima_measurements_show` is reachable via read() on
  `/sys/kernel/security/ima/*_runtime_measurements*`
- [Phase 6] `git show stable-push/linux-6.12.y:.../ima_fs.c`: confirmed
  buggy line present at 184
- [Phase 6] `git show stable-push/linux-6.6.y:.../ima_fs.c`: uses
  `TPM_DIGEST_SIZE`, no crypto agility, bug doesn't exist there
- [Phase 6] `git show stable-push/linux-6.1.y`: ima_fs.c does not have
  the buggy code
- [Phase 6] `git log stable-push/linux-6.12.y`: neither this commit nor
  d7bd8cf0b348d is yet in 6.12.y
- [Phase 8] Failure mode: OOB read of
  `hash_digest_size[HASH_ALGO__LAST]` - triggered by reading per-algo
  measurement file on TPM with unsupported algo
- UNVERIFIED: Whether d7bd8cf0b348d has been auto-selected by Fixes:-tag
  tooling; whether user-visible symptoms (without KASAN) would be
  observable in the field.

## Conclusion

This commit is a small, surgical fix for a real out-of-bounds read bug
that affects stable trees from v6.12 onwards. While the commit message
frames it as an "add a field" improvement rather than a bug fix, the
code change explicitly eliminates an OOB read in the user-reachable path
`ima_measurements_show()` / `ima_ascii_measurements_show()` when a TPM
exposes an algorithm not supported by the kernel crypto subsystem. The
companion commit `d7bd8cf0b348d` addresses the parallel boot-time OOB
(in `create_securityfs_measurement_lists`) and has a `Fixes:` tag, so it
will likely be auto-selected. If d7bd8cf0b348d reaches stable (as it
should), this commit is needed to plug the remaining runtime OOB on the
same hardware.

**YES**

 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c |  6 ++++++
 security/integrity/ima/ima_fs.c     | 18 ++++++------------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 89ebe98ffc5e5..c38a9eb945b68 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,6 +53,7 @@ extern atomic_t ima_setxattr_allowed_hash_algorithms;
 struct ima_algo_desc {
 	struct crypto_shash *tfm;
 	enum hash_algo algo;
+	unsigned int digest_size;
 };
 
 /* set during initialization */
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index aff61643415de..10022b0db4d58 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -109,6 +109,7 @@ static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 
 int __init ima_init_crypto(void)
 {
+	unsigned int digest_size;
 	enum hash_algo algo;
 	long rc;
 	int i;
@@ -147,7 +148,9 @@ int __init ima_init_crypto(void)
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
 		ima_algo_array[i].algo = algo;
+		ima_algo_array[i].digest_size = digest_size;
 
 		/* unknown TPM algorithm */
 		if (algo == HASH_ALGO__LAST)
@@ -183,12 +186,15 @@ int __init ima_init_crypto(void)
 		}
 
 		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
+		ima_algo_array[ima_sha1_idx].digest_size = SHA1_DIGEST_SIZE;
 	}
 
 	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
 	    ima_hash_algo_idx != ima_sha1_idx) {
+		digest_size = hash_digest_size[ima_hash_algo];
 		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
 		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
+		ima_algo_array[ima_hash_algo_idx].digest_size = digest_size;
 	}
 
 	return 0;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff02..23d3a14b8ce36 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -132,16 +132,12 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	char *template_name;
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	enum hash_algo algo;
 	int i, algo_idx;
 
 	algo_idx = ima_sha1_idx;
-	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL) {
+	if (m->file != NULL)
 		algo_idx = (unsigned long)file_inode(m->file)->i_private;
-		algo = ima_algo_array[algo_idx].algo;
-	}
 
 	/* get entry */
 	e = qe->entry;
@@ -160,7 +156,8 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	ima_putc(m, e->digests[algo_idx].digest,
+		 ima_algo_array[algo_idx].digest_size);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -229,16 +226,12 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	enum hash_algo algo;
 	int i, algo_idx;
 
 	algo_idx = ima_sha1_idx;
-	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL) {
+	if (m->file != NULL)
 		algo_idx = (unsigned long)file_inode(m->file)->i_private;
-		algo = ima_algo_array[algo_idx].algo;
-	}
 
 	/* get entry */
 	e = qe->entry;
@@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	seq_printf(m, "%2d ", e->pcr);
 
 	/* 2nd: template hash */
-	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	ima_print_digest(m, e->digests[algo_idx].digest,
+			 ima_algo_array[algo_idx].digest_size);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
-- 
2.53.0


