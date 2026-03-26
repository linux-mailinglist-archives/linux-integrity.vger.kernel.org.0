Return-Path: <linux-integrity+bounces-9104-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HaIAzJzxWmN+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9104-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:56:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DD33996E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A140308D3D2
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1236E46F;
	Thu, 26 Mar 2026 17:49:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DD2EBB9E;
	Thu, 26 Mar 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547358; cv=none; b=js6n3PPKWKiId7Sur8ejfQReaa+z5HzDTprQC0M7oYDaGMYKO23oC1BVVCuSVwPmpBtfV/Dsk03Esn6s4bJzWX5IbElmNELcQq2atu198eLJihEeJnLq6Ziy+X63Ys9VGCdp/QE1YrpRbWgLtihslChTlwKjeI9VpX4p00cCYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547358; c=relaxed/simple;
	bh=GVe9VZI4XjXsHiC6X8FNOyRI3MHUito5y2dGYWl8jTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7mwhyDCKKNdP8vTJ9bBjTkaJRv/jH/GDGg4rw16010l1BOwDYmqdsNuhtq7fETYv/j9WYnK/UHqda2OWq8I5L+uit5ASn/TsiBReidm48xwYAYahOBgMHDo/YSi1FEIRvJLwSQR8i8xieOTDYdLtd0hJ+8I2WfkUQ5ZadcWcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhW1611QJztKL9;
	Fri, 27 Mar 2026 01:27:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8E28A4056B;
	Fri, 27 Mar 2026 01:30:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3Yu84bcVppGUvAQ--.1881S2;
	Thu, 26 Mar 2026 18:30:42 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 00/13] ima: Introduce staging mechanism
Date: Thu, 26 Mar 2026 18:29:58 +0100
Message-ID: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3Yu84bcVppGUvAQ--.1881S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rCry5KrWfJryDtr4fKrg_yoWxJry8pa
	9ag34xCwn5Ja4Ikrn3Jw17CrsY9393Ka1UGrn3J34xtF15WFyvvr4Yk3yavFsxKr1Fqr1j
	y3ZIqrs8Can0yFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUVHqcUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4TtgAEs9
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9104-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 9E5DD33996E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduction
============

The IMA measurements list is currently stored in the kernel memory. Memory
occupation grows linearly with the number of entries, and can become a
problem especially in environments with reduced resources.

While there is an advantage in keeping the IMA measurements list in kernel
memory, so that it is always available for reading from the securityfs
interfaces, storing it elsewhere would make it possible to free precious
memory for other kernel components.

Storing the IMA measurements list outside the kernel does not introduce
security issues, since its integrity is anyway protected by the TPM.

Hence, the new IMA staging mechanism is introduced to allow user space
to remove the desired portion of the measurements list from the kernel.

The IMA staging mechanism can be enabled from the kernel configuration with
the CONFIG_IMA_STAGING option.

If it is enabled, IMA duplicates the current measurements interfaces (both
binary and ASCII), by adding the ``_staged`` file suffix. Unlike the
existing counterparts, the ``_staged`` interfaces have write permission for
the root user and group, and require the process to have CAP_SYS_ADMIN set.

The staging mechanism supports two flavors.

Staging with prompt:

 1. ``echo A > <_staged interface>``: the user requests IMA to stage the
    entire measurements list;
 2. ``cat <_staged interface>``: the user reads the staged measurements;
 3. ``echo D > <_staged interface>`` : the user request IMA to delete
    staged measurements.

Staging and deleting:

 1. ``cat <_non_staged interface>``: the user reads the current
    measurements list and determines what the value N for staging should
    be;
 2. ``echo N > <_staged interface>``: the user requests IMA to delete N
    measurements from the current measurements list.

Since with the staging mechanism measurements entries are removed from the
kernel, the user needs to save the staged ones in a storage and concatenate
them together, so that it can present them to remote attestation agents as
if staging was never done.


Patch set content
=================

Patches 1-8 are preparatory patches to quickly replace the hash table,
maintain separate counters for the different measurements list types,
mediate access to the measurements list interface, and simplify the staging
patches.

Patch 9 introduces the staging with prompt flavor. Patch 10 makes it
possible to flush the hash table when deleting all the staged measurements.
Patch 11 introduces the staging and deleting flavor. Patch 12 avoids staged
measurements entries to be stored twice if there is contention between the
measurements interfaces and kexec. Patch 13 adds the documentation of the
staging mechanism.


Changelog
=========

v3:
 - Add Kconfig option to enable the staging mechanism (suggested by Mimi)
 - Change the meaning of BINARY_STAGED to be just the staged measurements
 - Separate the two staging flavors in two different functions:
   ima_queue_staged_delete_all() for staging with prompt,
   ima_queue_staged_delete_partial() for staging and deleting
 - Delete N entries without staging first (suggested by Mimi)
 - Avoid duplicate staged entries if there is contention between the
   measurements list interfaces and kexec

v2:
 - New patch to move measurements and violation counters outside the
   ima_h_table structure
 - New patch to quickly replace the hash table
 - Forbid partial deletion when flushing hash table (suggested by Mimi)
 - Ignore ima_flush_htable if CONFIG_IMA_DISABLE_HTABLE is enabled
 - BINARY_SIZE_* renamed to BINARY_* for better clarity
 - Removed ima_measurements_staged_exist and testing list empty instead
 - ima_queue_stage_trim() and ima_queue_delete_staged_trimmed() renamed to
   ima_queue_stage() and ima_queue_delete_staged()
 - New delete interval [1, ULONG_MAX - 1]
 - Rename ima_measure_lock to ima_measure_mutex
 - Move seq_open() and seq_release() outside the ima_measure_mutex lock
 - Drop ima_measurements_staged_read() and use seq_read() instead
 - Optimize create_securityfs_measurement_lists() changes
 - New file name format with _staged suffix at the end of the file name
 - Use _rcu list variant in ima_dump_measurement_list()
 - Remove support for direct trimming and splice the remaining entries to
   the active list (suggested by Mimi)
 - Hot swap the hash table if flushing is requested

v1:
 - Support for direct trimming without staging
 - Support unstaging on kexec (requested by Gregory Lumen)

Roberto Sassu (13):
  ima: Remove ima_h_table structure
  ima: Replace static htable queue with dynamically allocated array
  ima: Introduce per binary measurements list type ima_num_entries
    counter
  ima: Introduce per binary measurements list type binary_runtime_size
    value
  ima: Introduce _ima_measurements_start() and _ima_measurements_next()
  ima: Mediate open/release method of the measurements list
  ima: Use snprintf() in create_securityfs_measurement_lists
  ima: Introduce ima_dump_measurement()
  ima: Add support for staging measurements with prompt
  ima: Add support for flushing the hash table when staging measurements
  ima: Support staging and deleting N measurements entries
  ima: Return error on deleting staged measurements after kexec
  doc: security: Add documentation of the IMA staging mechanism

 .../admin-guide/kernel-parameters.txt         |   4 +
 Documentation/security/IMA-staging.rst        | 159 +++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |   2 +
 security/integrity/ima/Kconfig                |  16 +
 security/integrity/ima/ima.h                  |  28 +-
 security/integrity/ima/ima_api.c              |   2 +-
 security/integrity/ima/ima_fs.c               | 302 +++++++++++++++--
 security/integrity/ima/ima_init.c             |   5 +
 security/integrity/ima/ima_kexec.c            |  47 ++-
 security/integrity/ima/ima_queue.c            | 310 ++++++++++++++++--
 11 files changed, 803 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/security/IMA-staging.rst

-- 
2.43.0


