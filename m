Return-Path: <linux-integrity+bounces-3468-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA996DE2B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458C81F276B2
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426B19E7E3;
	Thu,  5 Sep 2024 15:27:45 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302B1A01A1;
	Thu,  5 Sep 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550065; cv=none; b=V3K6OJHfNQcaNA5fTNyFtn3iEVovLZ8gpRRkUPjTAyGXCR29JYfKa7xQ8WaZ93W0IQi96nMqYPN5RnsU0t3tDZFbkiNOuINfukdJC2gfx2Yn/5sI9B0f9K9Mia2UfQexuAIeNz0Uezh3P2FLIWJypJYBgg0DjscLzpLcoeruDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550065; c=relaxed/simple;
	bh=lG600BlGw1TPl3SKRaW0nlF4d9BcII1RdiRFusiu/Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkoD6BLOwhF91/hRBsF+1HdyxnTbsRUSlkje9LYHgGMcb9x53FFMrlUYtGjNNUPzGuZBx52kkbRN2Lcf99uD9Hf7irW+Rk6Lm0Ug/FaiZ0/KdBJMxIJKtCc1hxk8h2zOyRCTTE7jRIiPartPF8v/nm5nwofgiGOKg+pwPHYumh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02mf5HWMz9v7Hl;
	Thu,  5 Sep 2024 23:08:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0D0E9140516;
	Thu,  5 Sep 2024 23:27:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S11;
	Thu, 05 Sep 2024 16:27:30 +0100 (CET)
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
Subject: [RFC][PATCH v3 09/10] ima: Use digest caches for measurement
Date: Thu,  5 Sep 2024 17:25:11 +0200
Message-Id: <20240905152512.3781098-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S11
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy7KrWkXF1UJw4UZFW5ZFb_yoWxGw17pa
	9IgF1UKr1kXFyIkrn3A3W7Za1F93yrta1UX398Ww1ay3ZxZr1q9w4rKr1j9Fs8Gryvya4I
	yanFqw4UAa1qyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUVdgAUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oLJwAAst

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
 security/integrity/ima/ima_main.c |  8 ++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b2ef37a11b65..c915339dd0d4 100644
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
index 97ece2abb0b9..3b34bfa5c891 100644
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
@@ -385,10 +385,14 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	verified_usage = ima_digest_cache_load_verified_usage(file_dentry(file),
+							      iint);
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
2.34.1


