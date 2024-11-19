Return-Path: <linux-integrity+bounces-4157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1C9D2480
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D862B1F240B7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF791C6F47;
	Tue, 19 Nov 2024 11:03:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA691C4A36;
	Tue, 19 Nov 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014199; cv=none; b=gSnZCAJ37jk4+NDTat+pYENEo/4JtgcObBum86MMuuRZ5Y/zvdX4GHXgYJnlbkQ8tAt7F/vcNTUTUqOvRnyVOuv83EDUSZswJn2syYe2jB+t612Bz1vSNNPoam5NXpc5s3mZdCETROvF2QpXRfyWxdwU6FJT6q8KCWxLfobjEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014199; c=relaxed/simple;
	bh=Dtn3dFiwEnuNFVgKfjmK1osRUp4jcnUCWtkeo22Tyfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2Pn8wsy3nRbHefxu8YdE/EYJTMvMXw3lwsUZGjY1U5G0j7X5ap9uqwVWUBZ/AG6OMBK7XqYTqlO0Yr5s1LMXD0Yk1RrttuRCd1gY5x48+HyHQ7b1CPc0Lt/sOuoJtYe3os3GfXTeUpe5DAqacAI6GHbn7eT8PmGenYKlzfMaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt1K95dtvz9v7J6;
	Tue, 19 Nov 2024 18:42:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A4FC9140DF8;
	Tue, 19 Nov 2024 19:03:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S10;
	Tue, 19 Nov 2024 12:03:09 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v4 8/9] ima: Use digest caches for measurement
Date: Tue, 19 Nov 2024 12:01:02 +0100
Message-ID: <20241119110103.2780453-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
References: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S10
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy7KrWkXF1UJw4UZFW5ZFb_yoWxGw1xpa
	9IgF1UKr1kXFySkrn3A3W7Za1F93y8ta1UX398Ww1ay3ZxZr1q9w4Fkr1j9Fs8GrWvya4I
	yanFqw4UAw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
	U04rW7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEmAAAsK

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new measurement style using digest caches, which can be
performed exclusively on non-standard PCRs, to avoid ambiguity.

While a measurement on the standard PCR means that a file was accessed and
had the measured data, a measurement with the digest cache means only that
the calculated file digest was not found in any of the measured digest
lists (any digest list used for the search must be measured, otherwise IMA
wouldn't use it).

The new measurement style does not tell: whether or not the file was
actually accessed (since its measurement is skipped even if it was); in
which sequence files were accessed. So, one has to guess that the system
might have possibly accessed any of the files whose digest is in the
measured digest lists, in any order.

However, it has the following benefits: the IMA measurement list can be
much shorter, system performance can be much better due to less PCR extend
operations (see the performance evaluation in the Integrity Digest Cache
documentation); the PCR can be predictable as long as the set of measured
digest lists does not change (which obviously happens during software
updates).

The PCR can be predictable because the Integrity Digest Cache has a
prefetching mechanism that reads digest lists in a deterministic order,
until it finds the digest list containing the digest calculated by IMA from
an accessed file. If IMA measures digest lists, the PCR is extended in a
deterministic order too.

Predictable PCR means that a TPM key can be made dependent on specific PCR
values (or a OR of them, depending on the key policy). Accessing a file
with an unknown digest immediately makes that TPM key unusable, requiring a
reboot to use it again.

This mechanism can be used for the so called implicit remote attestation,
where the ability of a system to respond to challenges based on the private
part of the TPM key means that the system has the expected PCR values
(which would mean that the integrity of the system is ok). This is opposed
to the explicit remote attestation, where a system has to send all its
measurements, to prove to a remote party about its integrity.

Call the newly introduced function ima_digest_cache_load_verified_usage()
to retrieve the verified usage from the digest cache containing the
calculated digest of the file being accessed (if it is found), and AND it
with the policy usage.

If the AND result has the IMA_DIGEST_CACHE_MEASURE_DATA flag set, behave as
if the file was successfully added to the IMA measurement list (i.e. set
the IMA_MEASURED flag and the PCR flag from the value specified in the
matching policy rule), but actually don't do it.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  3 ++-
 security/integrity/ima/ima_api.c  | 15 ++++++++++++++-
 security/integrity/ima/ima_main.c |  7 +++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f3e6dcd9defd..61b019e7bace 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -389,7 +389,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   u64 allowed_usage);
 int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b44cf7d9fbcb..530c5bcc115e 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -351,7 +351,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   u64 allowed_usage)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -375,6 +376,18 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
+	/*
+	 * If digest cache usage was authorized with the IMA policy, the digest
+	 * list the digest cache was populated from was measured, and the file
+	 * digest was found in the digest cache, mark the file as successfully
+	 * measured.
+	 */
+	if (allowed_usage & IMA_DIGEST_CACHE_MEASURE_DATA) {
+		iint->flags |= IMA_MEASURED;
+		iint->measured_pcrs |= (0x1 << pcr);
+		return;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 607749d520b0..0d37cdc01622 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -225,7 +225,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
-	u64 policy_usage = 0ULL;
+	u64 policy_usage = 0ULL, verified_usage = 0ULL;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -385,10 +385,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	verified_usage = ima_digest_cache_load_verified_usage(file, iint);
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+				      template_desc,
+				      (policy_usage & verified_usage));
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.47.0.118.gfd3785337b


