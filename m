Return-Path: <linux-integrity+bounces-4153-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C619D246E
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555642853B0
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA21C462D;
	Tue, 19 Nov 2024 11:02:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563B1C2335;
	Tue, 19 Nov 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014152; cv=none; b=fYjx7FJshzWlCEGPiMM8li+C/PGd17nhFlOgjRyabYZPVuzku92hHtgCNGWVjXLwmi65uBj+2oFB35fWM9tK4g5+WSP4ti9izImB9hVb9WE/fq7mIJZNohqmVDcMpTBB4PE4rIUh6mHwhcWyu0kaMLtV1RY4nG1Od6oNSe/PmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014152; c=relaxed/simple;
	bh=rls2C7PG/jZRCDjxmbSyiaDQJJ3Kvt8aX/lZdgUP+yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwuCu4Ix7UweTAEZZ+bV+4g4yJUog3mlV6uhheeTivok1C7yrVbP5PjMTHv1uvUO00tdw60jI6Jk5SgWgswZ+q4Sk9HM7eqjQ+D+A9bbKoAOATzxjOVkzSnfrNKrQxMM+d4Cb0n9EnCPFr2Pnj4CRjuh43aZFnT2Ndu8tqTCyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt1JG2sXhz9v7J3;
	Tue, 19 Nov 2024 18:41:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D3989140CA3;
	Tue, 19 Nov 2024 19:02:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S6;
	Tue, 19 Nov 2024 12:02:21 +0100 (CET)
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
Subject: [RFC][PATCH v4 4/9] ima: Modify existing boot-time built-in policies with digest cache policies
Date: Tue, 19 Nov 2024 12:00:58 +0100
Message-ID: <20241119110103.2780453-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrur4rAF45uF4fuF1kuFg_yoW5uF1rpa
	9FgrySkr97Zr9rCw1fA3WIvF4rK3ykta1UWa1DK345AF45CF1qv3W8tr43uFy7Gr10qF4x
	JFs0gw4jk3WqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QElQABsG

From: Roberto Sassu <roberto.sassu@huawei.com>

Setting the boot-time built-in policies 'digest_cache_measure' and
'digest_cache_appraise' is not sufficient to use the Integrity Digest Cache
to measure and appraise files, since their effect is only to measure and
appraise digest lists.

Modify existing measurement rules if the 'digest_cache_measure' built-in
policy is specified by adding to them:

digest_cache=data pcr=12

Other than enabling the usage of the Integrity Digest Cache for
measurement, the additional keywords also store measurements in the PCR 12,
to not confuse new style measurements with the original ones still stored
on PCR 10.

Modify existing appraisal rules if the 'digest_cache_appraise' built-in
policy is specified by adding to them:

digest_cache=data

The additional keyword enables the usage of Integrity Digest Cache for
appraisal.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++--
 security/integrity/ima/ima_policy.c             | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9b6f85b1376c..129d60f5a46b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2118,11 +2118,16 @@
 			critical data.
 
 			The "digest_cache_measure" policy measures digest lists
-			into PCR 12 (can be changed with kernel config).
+			into PCR 12 (can be changed with kernel config), enables
+			the digest cache to be used for the other selected
+			measure rules (if compatible), and measures the files
+			with digest not found in the digest list into PCR 12
+			(changeable).
 
 			The "digest_cache_appraise" policy appraises digest
 			lists with IMA signatures or module-style appended
-			signatures.
+			signatures, and enables the digest cache to be used for
+			the other selected appraise rules (if compatible).
 
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c2bf58010b89..c74ff36fcc1f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -930,6 +930,20 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
+		if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE) &&
+		    entries[i].action == MEASURE && ima_digest_cache_measure &&
+		    ima_digest_cache_func_allowed(entries[i].func)) {
+			entries[i].digest_cache_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+			entries[i].pcr = CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX;
+			entries[i].flags |= IMA_PCR;
+		}
+
+		if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE) &&
+		    entries[i].action == APPRAISE &&
+		    ima_digest_cache_appraise &&
+		    ima_digest_cache_func_allowed(entries[i].func))
+			entries[i].digest_cache_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+
 		if (policy_rule & IMA_DEFAULT_POLICY)
 			list_add_tail(&entries[i].list, &ima_default_rules);
 
-- 
2.47.0.118.gfd3785337b


