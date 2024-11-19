Return-Path: <linux-integrity+bounces-4149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA49D245B
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CF52843C2
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CFD1A9B24;
	Tue, 19 Nov 2024 11:01:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335F33998;
	Tue, 19 Nov 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014109; cv=none; b=tSY1GprNwwMcu8pBoBZ0H3glJ5lfJ8G6Da5yPVBp2MlpVVi02qusXbP9NlXFrlhPge5+eWXjnfkMVlWRhVC+a38H5ClftjsFrV2K18gVloQF9EQvuNm9Hw0lZkMHVOwsKvVy2GAIBwaOeFluQeTLsec7bKwiRrlVS4phqkdNGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014109; c=relaxed/simple;
	bh=ja+Xwh9hF7MphapjnEiIQL/SF6OfNNGbC/fXVpjJE7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWmwyEUNKpz7mCOaj/TAbjr5rWvL5qBAwHS+DSNeTdyo9fA//DxGodjPReAx+EYoowclhKtUs70N3wfUaj5DpOzTf62zlTM0jIEuCbgdn87EmSsoHoMIe7ydgt9pZ8shfgeGUl+Im0L7zsX/7/nG0fXGeqo0K8Mk2fdbyY3AFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt1HS22hkz9v7Q2;
	Tue, 19 Nov 2024 18:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0BC95140CA3;
	Tue, 19 Nov 2024 19:01:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S2;
	Tue, 19 Nov 2024 12:01:32 +0100 (CET)
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
Subject: [RFC][PATCH v4 0/9] ima: Integrate with Integrity Digest Cache
Date: Tue, 19 Nov 2024 12:00:54 +0100
Message-ID: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr45JF1xXr4kWF48Kw17ZFb_yoW3GryDpa
	9Fg3W5Kr4kuryxCr43Aa17ur4Fkr93tay7Wws8Jw1Fya15ur10v340kryUuFy5Kr40qa17
	trsFgw1UCw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf
	9x07jxUUUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEjAABsf

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
information reported, which might not be suitable for everyone.

Second, performance improves for appraisal too. It has been found that
verifying the signatures of only the RPM package headers and doing a digest
lookup is much less computationally expensive than verifying individual
file signatures.

In the future, if RPM and other package formats include fsverity digests,
this would further improve the performance, due to verifying only the
portion of the file read.

For reference, a preliminary performance evaluation has been published
here:

https://lore.kernel.org/linux-integrity/20241119104922.2772571-15-roberto.sassu@huaweicloud.com/

Third, it makes a PCR predictable and suitable for TPM key sealing
policies.

Finally, it allows IMA to maintain a predictable PCR and to perform
appraisal from the very beginning of the boot, in the initial ram disk
(excluding auto-generated files).

Integration of IMA with the Integrity Digest Cache is straightforward.

Patch 1 lets IMA know when the Integrity Digest Cache is reading a digest
list, to populate a digest cache.

Patch 2 allows the usage of digest caches with the IMA policy.

Patch 3 introduces new boot-time built-in policies, to use digest caches
from the very beginning (it allows measurement/appraisal from the initial
ram disk).

Patch 4 modifies existing boot-time built-in policies if the Integrity
Digest Cache-specific policies have been selected at boot.

Patch 5 obtains a digest cache for a given file, stores it in the inode
integrity metadata, and notifies if the digest cache changed since last
file access.

Patches 6-7 store and load the integrity state of the digest list the
digest cache was populated from, to restrict the digest cache usage in case
an IMA action was not performed on the digest list.

Patches 8-9 enable the usage of digest caches respectively for measurement
and appraisal, at the condition that it is authorized with the IMA policy
and that the digest list itself was measured and appraised too.

Open points:
- Mimi prefers to extend flags in ima_iint_cache, rather than passing the
  parameter down to process_measurement() - will do in a next version
- Prefetching of digest lists should not be done if there is no
  measurement rule (not relevant for appraisal)


This patch set applies on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity

with commit 08ae3e5f5fc8 ("integrity: Use static_assert() to check struct
sizes").

and on top of the patch set at the URL:

https://lore.kernel.org/linux-integrity/20241119104922.2772571-1-roberto.sassu@huaweicloud.com/

Changelog

v3:
- Pass file descriptor to digest_cache_get()
- Retry digest_cache_lookup() if an error pointer is returned
- Drop patch 2/10 and use new function digest_cache_opened_fd() as argument
  of mutex_lock_nested()

v2:
- Rename Integrity Digest Cache to Integrity Digest Cache (suggested by Paul
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
- Move Integrity Digest Cache integration code to ima_digest_cache.c (suggested
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
- Split patch introducing Integrity Digest Cache-specific boot-time built-in
  policies and modifying existing rules
- Add Integrity Digest Cache-specific boot-time built-in policies if the
  Integrity Digest Cache is enabled in the kernel configuration
- Rename IMA_DIGEST_CACHE_MEASURE_CONTENT and
  IMA_DIGEST_CACHE_APPRAISE_CONTENT to IMA_DIGEST_CACHE_MEASURE_DATA and
  IMA_DIGEST_CACHE_APPRAISE_DATA

Roberto Sassu (9):
  ima: Introduce hook DIGEST_LIST_CHECK
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
 security/integrity/ima/ima_digest_cache.c     | 126 +++++++++++++++++
 security/integrity/ima/ima_digest_cache.h     |  38 +++++
 security/integrity/ima/ima_iint.c             |   4 +
 security/integrity/ima/ima_main.c             |  33 +++--
 security/integrity/ima/ima_policy.c           | 133 +++++++++++++++++-
 12 files changed, 413 insertions(+), 28 deletions(-)
 create mode 100644 security/integrity/ima/ima_digest_cache.c
 create mode 100644 security/integrity/ima/ima_digest_cache.h

-- 
2.47.0.118.gfd3785337b


