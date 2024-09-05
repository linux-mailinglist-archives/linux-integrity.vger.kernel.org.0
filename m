Return-Path: <linux-integrity+bounces-3464-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5096DE19
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AB728220D
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C315A19DF5E;
	Thu,  5 Sep 2024 15:26:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA1629E4;
	Thu,  5 Sep 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550009; cv=none; b=Qu2e7ExhqM5AA6bN+XoKKN+64GXWknzGmIkoDKZITTIm6nwpEq1KOrdaI30WoFEIDw+05jGlA9+o5KLqgljEAnSvXSE52zzNOAO4eQWp31FAbvhQCqi/OtfRF3En0U0Qd9mzLtgO7hK2CxbBm7GBln51Rra/GR8uo02E5e1sJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550009; c=relaxed/simple;
	bh=pc9nIK6ksyPJvbtXtbJ/+Grb9aOAmdbsH11PSZN4IBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfO/QeNq/01Th5PE+GkzboZvxIhrM1q2i0x8Zh2Xok+rbOexbraZN3RO1yPqKv2qDetuUTLiHsy2Tvdj+GpcHSb0WRrnD+ncojJmQ10qERYpDrIEQSBE9hW8rM6vbzj58RDa7DzMrDOGcdBzmo3Mmjl1hDjuIk2tJXh+CiNeMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02lZ3H9Kz9v7Hq;
	Thu,  5 Sep 2024 23:07:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 868E2140114;
	Thu,  5 Sep 2024 23:26:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S7;
	Thu, 05 Sep 2024 16:26:43 +0100 (CET)
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
Subject: [RFC][PATCH v3 05/10] ima: Modify existing boot-time built-in policies with digest cache policies
Date: Thu,  5 Sep 2024 17:25:07 +0200
Message-Id: <20240905152512.3781098-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrur4rAF45uF4fuF1kuFg_yoW5uryfpa
	9FgrySkrs7Zr9rCw1fA3WIvF4rK3ykta1UGa1DK345AF45CF1jv3Wrtr43uFyUGr10qFWx
	JF4Ygw4YkF1qyaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLXwAAsf

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
index afaaf125a237..1df8ce411760 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2101,11 +2101,16 @@
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
2.34.1


