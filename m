Return-Path: <linux-integrity+bounces-3459-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF7996DE04
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D121C212E1
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D251714A3;
	Thu,  5 Sep 2024 15:26:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5ED7F7FC;
	Thu,  5 Sep 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549961; cv=none; b=S7RXCyBKErOIklcLgSkM1FmDkPf/GjX5iO8/1rdYzJPD64A0KDulvCT6L4hbearja0LgqlsFwPxlQktCjAZpltewBmgGBH/rwMk8cJ52fvogPEr06VAWSS3RlNGLvNvSGjJGBg+QzkinnNdra7UPK6HrQ+KUpw+qRgwRg1AOSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549961; c=relaxed/simple;
	bh=gDsN603Zjzy5qZmlhhu82heSLCVyMC0yN8pFnZ6FVWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rY/Y9hHxGCfg9KlkVJQQqYMI3Q5Bw4piV7YlFRayrq1pFxcLGAgSO2iKhL0eQrUX8YdhnTSQ1a4rdarPAdpolBPjFbzj5MROJ2h2SeRut/TBcpG3NETe90qLR7AmizRcD5MMzredPVlMhim46Sr/t5r17QOe0QvO3kCh4DrATQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02kd3qh2z9v7Hl;
	Thu,  5 Sep 2024 23:06:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 846E21405A0;
	Thu,  5 Sep 2024 23:25:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S2;
	Thu, 05 Sep 2024 16:25:45 +0100 (CET)
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
Subject: [RFC][PATCH v3 00/10] ima: Integrate with Integrity Digest Cache
Date: Thu,  5 Sep 2024 17:25:02 +0200
Message-Id: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr45JF1xZryDJryUWFy7trb_yoW3Jr17pa
	9Fg3W5tr1kZryxCr43Aa17CF4rKr9YqF47Wws8Jw1Fyan8ur1jvw1Syry5uFy5Kr4Fqa17
	tw42gr1UCw1qyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0x
	ZFpf9x07jSiihUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLPwACs9

From: Roberto Sassu <roberto.sassu@huawei.com>

One of the IMA shortcomings over the years has been the availability of
reference digest values for appraisal. Recently, the situation improved
and some Linux distributions are including file signatures, such as
Fedora 39.

The Integrity Digest Cache takes a different approach. Instead of requiring
Linux distributions to include file signatures in their packages, it parses
the digests from signed RPM package headers and exposes an API for
integrity providers to query a digest.

That enables Linux distributions to immediately gain the ability to do
integrity checks with the existing packages, lowering the burden for
software vendors.

In addition, integrating IMA with the Integrity Digest Cache has even more
benefits.

First, it allows generating a new-style masurement list including the RPM
package headers and the unknown files, which improves system performance
due to the lower usage of the TPM. The cost is the less accuracy of the
information reported, which might not suitable for everyone.

Second, performance improve for appraisal too. It has been found that
verifying the signatures of only the RPM package headers and doing a digest
lookup is much less computationally expensive than verifying individual
file signatures.

In the future, if RPM and other package formats include fsverity digests,
this would further improve the performance, due to verifying only the
portion of the file read.

For reference, a preliminary performance evaluation has been published
here:

https://lore.kernel.org/linux-integrity/20240905150543.3766895-15-roberto.sassu@huaweicloud.com/

Third, it makes a PCR predictable and suitable for TPM key sealing
policies.

Finally, it allows IMA to maintain a predictable PCR and to perform
appraisal from the very beginning of the boot, in the initial ram disk
(excluding auto-generated files).

Integration of IMA with the digest_cache LSM is straightforward.

Patch 1 lets IMA know when the digest_cache LSM is reading a digest list,
to populate a digest cache.

Patch 2 allows nested IMA verification of digest lists read by the
digest_cache LSM.

Patch 3 allows the usage of digest caches with the IMA policy.

Patch 4 introduces new boot-time built-in policies, to use digest caches
from the very beginning (it allows measurement/appraisal from the initial
ram disk).

Patch 5 modifies existing boot-time built-in policies if the digest_cache
LSM-specific policies have been selected at boot.

Patch 6 obtains a digest cache for a given file, stores it in the inode
integrity metadata, and notifies if the digest cache changed since last
file access.

Patches 7-8 store and load the integrity state of the digest list the
digest cache was populated from, to restrict the digest cache usage in case
an IMA action was not performed on the digest list.

Patches 9-10 enable the usage of digest caches respectively for measurement
and appraisal, at the condition that it is authorized with the IMA policy
and that the digest list itself was measured and appraised too.

Open points:
- Mimi prefers to extend flags in ima_iint_cache, rather than passing the
  parameter down to process_measurement() - will do in a next version
- Prefetching of digest lists should not be done if there is no
  measurement rule (not relevant for appraisal)


This patch set applies on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity

with commit fa8a4ce432e8 ("ima: fix buffer overrun in
ima_eventdigest_init_common").

and on top of the patch set at the URL:

https://lore.kernel.org/linux-integrity/20240905150543.3766895-1-roberto.sassu@huaweicloud.com/

Changelog

v2:
- Rename digest_cache LSM to Integrity Digest Cache (suggested by Paul
  Moore)
- Add digest_cache member to ima_iint_cache structure
- Nest mutex only in process_measurement()
- Check IMA_DIGEST_CACHE_APPRAISE_DATA earlier in
  ima_appraise_measurement()
- Introduce ima_digest_cache_get_check() to detect changes, instead of
  using the notifier mechanism (removed from the Integrity Digest Cache)
- Rename ima_digest_cache_store_allowed_usage() to
  ima_digest_cache_store_verified_usage()
- Rename ima_digest_cache_update_allowed_usage() to
  ima_digest_cache_load_verified_usage(), but do the AND outside the
  function
- Check allowed IMA hooks with ima_digest_cache_func_allowed() also at
  run-time (when a policy is evaluated)

v1:
- Change digest_cache= policy keyword value from 'content' to 'data'
  (suggested by Mimi)
- Move digest_cache LSM integration code to ima_digest_cache.c (suggested
  by Mimi)
- Don't store digest cache pointer in integrity metadata
- Rename 'digest_cache_mask' parameter of ima_get_action() and
  ima_match_policy() to 'digest_cache_usage'
- Rename 'digest_cache_mask' parameter of ima_store_measurement() and
  ima_appraise_measurement() to 'allowed_usage'
- Try digest cache method as first in ima_appraise_measurement() (suggested
  by Mimi)
- Introduce ima_digest_cache_change() to be called on digest cache reset
- Subscribe to digest cache events
- Add forgotten modification in ima_iint_lockdep_annotate() (reported by
  Mimi)
- Replace 'digest_cache_mask' member of the ima_rule_entry structure with
  'digest_cache_usage' (suggested by Mimi)
- Split patch introducing digest_cache LSM-specific boot-time built-in
  policies and modifying existing rules
- Add digest_cache LSM-specific boot-time built-in policies if the
  digest_cache LSM is enabled in the kernel configuration
- Rename IMA_DIGEST_CACHE_MEASURE_CONTENT and
  IMA_DIGEST_CACHE_APPRAISE_CONTENT to IMA_DIGEST_CACHE_MEASURE_DATA and
  IMA_DIGEST_CACHE_APPRAISE_DATA

Roberto Sassu (10):
  ima: Introduce hook DIGEST_LIST_CHECK
  ima: Nest iint mutex for DIGEST_LIST_CHECK hook
  ima: Add digest_cache policy keyword
  ima: Add digest_cache_measure/appraise boot-time built-in policies
  ima: Modify existing boot-time built-in policies with digest cache
    policies
  ima: Retrieve digest cache and check if changed
  ima: Store verified usage in digest cache based on integrity metadata
    flags
  ima: Load verified usage from digest cache found from query
  ima: Use digest caches for measurement
  ima: Use digest caches for appraisal

 Documentation/ABI/testing/ima_policy          |   6 +-
 .../admin-guide/kernel-parameters.txt         |  15 +-
 security/integrity/ima/Kconfig                |  10 ++
 security/integrity/ima/Makefile               |   1 +
 security/integrity/ima/ima.h                  |  21 ++-
 security/integrity/ima/ima_api.c              |  21 ++-
 security/integrity/ima/ima_appraise.c         |  33 +++--
 security/integrity/ima/ima_digest_cache.c     | 121 ++++++++++++++++
 security/integrity/ima/ima_digest_cache.h     |  38 +++++
 security/integrity/ima/ima_iint.c             |   4 +
 security/integrity/ima/ima_main.c             |  34 +++--
 security/integrity/ima/ima_policy.c           | 133 +++++++++++++++++-
 12 files changed, 409 insertions(+), 28 deletions(-)
 create mode 100644 security/integrity/ima/ima_digest_cache.c
 create mode 100644 security/integrity/ima/ima_digest_cache.h

-- 
2.34.1


