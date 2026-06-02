Return-Path: <linux-integrity+bounces-9723-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGevHzq7HmrZJgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9723-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:15:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39C62D3B3
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13243301425D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6253644C2;
	Tue,  2 Jun 2026 11:15:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656721BBBE5;
	Tue,  2 Jun 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398903; cv=none; b=P1WHqEPXPdpILRrTqVGJmsMOX68i2PN5hQeu77b9kZwJQBx7a2qKJkWcpdieSaG34KSfhuEZIO2AGHewJLOOw53k/Qo6y03fzO72nMk5N8K7hjKYYtZa2kQT0vZf03Ie2vArOoP1n8yoL+lJNOtGpB2BqFTesTCcd79h624z6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398903; c=relaxed/simple;
	bh=EWyvEFImYPDjQCcQxXkQWdCSf98cv800ZT3YYV2AxQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G87erlX8fENjGbnP91DMB/OB893b3oMa1+1zLsP7mcxIQQwN36r7VjEIkLhSLlQSapaR21v4QJgk8ynM6xG/JgSwTMk1CLtn3SbL9f0G8mSdZ7E3lyMJzHdCtmyLxJ7YVMvD43QL0yjz/yfzOCMTyAZ6QzVKSJyGrZ3l+I7vowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gV7QW3hYZzxYPK;
	Tue,  2 Jun 2026 19:09:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D501C40565;
	Tue,  2 Jun 2026 19:14:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3o84fux5qKBozAA--.30704S2;
	Tue, 02 Jun 2026 12:14:50 +0100 (CET)
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
Subject: [PATCH v6 00/12] ima: Exporting and deleting IMA measurement records from kernel memory
Date: Tue,  2 Jun 2026 13:13:49 +0200
Message-ID: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3o84fux5qKBozAA--.30704S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1xWFWUCw1xCr4fWF1ftFb_yoWfWw1fpa
	9ag34xCwn5Ja4Syw1xJw1xCr4ru393Ka1DGrn7J34xJF15WFyvvr4YkrWakFsxKr1Syr1j
	y3W2qrs8ua1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGoeRsQEdQAAsO
X-Rspamd-Queue-Id: 9D39C62D3B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9723-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduction
============

The IMA measurements list is currently stored in the kernel memory.
Memory occupation grows linearly with the number of records, and can
become a problem especially in environments with reduced resources.

While there is an advantage in keeping the IMA measurements list in
kernel memory, so that it is always available for reading from the
securityfs interfaces, storing it elsewhere would make it possible to
free precious memory for other kernel usage.

The IMA measurements list needs to be retained and safely stored for new
attestation servers to validate it. Assuming the IMA measurements list
is properly saved, storing it outside the kernel does not introduce
security issues, since its integrity is anyway protected by the TPM.

Hence, the new IMA staging mechanism is introduced to export IMA
measurements to user space and delete them from kernel space.

Staging consists in atomically moving the current measurements list to a
temporary list, so that measurements can be deleted afterwards. The
staging operation locks the hot path (racing with addition of new
measurements) for a very short time, only for swapping the list
pointers. Deletion of the measurements instead is done locklessly, away
from the hot path.

There are two flavors of the staging mechanism. In the staging with
prompt, all current measurements are staged, read and deleted upon
confirmation. In the staging and deleting flavor, N measurements are
staged from the beginning of the current measurements list and
immediately deleted without confirmation.


Usage
=====

The IMA staging mechanism can be enabled from the kernel configuration
with the CONFIG_IMA_STAGING option. This option prevents inadvertently
removing the IMA measurement list on systems which do not properly save
it.

If the option is enabled, IMA duplicates the current securityfs
measurements interfaces (both binary and ASCII), by adding the _staged
file suffix. Both the original and the staging interfaces gain the write
permission for the root user and group, but require the process to have
CAP_SYS_ADMIN set.

The staging mechanism supports two flavors.

Staging with prompt
~~~~~~~~~~~~~~~~~~~

The current measurement list is moved to a temporary staging area,
allowing it to be saved to external storage, before being deleted upon
confirmation.

This staging process is achieved with the following steps.

  1.  echo A > <_staged interface>: the user requests IMA to stage the
      entire measurements list;
  2.  cat <_staged interface>: the user reads the staged measurements;
  3.  echo D > <_staged interface>: the user requests IMA to delete
      staged measurements.

Staging and deleting
~~~~~~~~~~~~~~~~~~~~

N measurements are staged to a temporary staging area, and immediately
deleted without further confirmation.

This staging process is achieved with the following steps.

  1.  cat <original interface>: the user reads the current measurements
      list and determines what the value N for staging should be;
  2.  echo N > <original interface>: the user requests IMA to delete N
      measurements from the current measurements list.


Management of Staged Measurements
=================================

Since with the staging mechanism measurement records are removed from
the kernel, the staged measurements need to be saved in a storage and
concatenated together, so that they can be presented to remote
attestation agents as if staging was never done. This task can be
accomplished by a system service.


Patch set content
=================

Patches 1-8 are preparatory patches to quickly replace the hash table,
maintain separate counters for the different measurements list types,
mediate access to the measurements list interface, and simplify the staging
patches.

Patch 9 introduces the staging with prompt flavor. Patch 10 makes it
possible to flush the hash table when deleting all the staged measurements.
Patch 11 introduces the staging and deleting flavor. Patch 12 adds the
documentation of the staging mechanism.


Changelog
=========

v5:
 - Add motivation for the ima_flush_htable= kernel option (suggested by
   Mimi)
 - New documentation title and fixes (suggested by Mimi)
 - Allow stage all command on the _staged interface instead of the original
 - Set CONFIG_IMA_STAGING default to n (suggested by Mimi)
 - Rename ima_num_entries to ima_num_records (suggested by Mimi)
 - Comment for ima_num_records and ima_num_violations (suggested by Mimi)
 - Add overflow check in ima_measure_lock()
 - Allow a writer to open for write or read/write the other staging
   interfaces
 - Ignore ppos in _ima_measurements_write()
 - Implement lockless kexec measurement lists dump by denying
   staging/delete after measurement suspend (collapse patch 12 into 9 and
   11)
 - Refuse delete based on measurement suspend instead of using
   ima_copied_flags (suggested by Mimi)
 - Add staging/deleting functions documentation

v4:
 - Add write permission to the original measurement interface, and move
   the A and N staging commands to that interface
 - Explain better the two staging flavors and highlight that the staging
   and delete only stages measurements internally
 - Rename ima_queue_staged_delete_partial() to ima_queue_delete_partial()
 - Replace ima_staged_measurements_prepended with per measurements list
   flag to avoid copying staged and active list measurements twice
 - Optimize the staging and deleting flavor by locklessly determining the
   cut position in the active list, and immediately deleting entries
   without explicit staging and splicing (suggested by Steven Chen)

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

Roberto Sassu (12):
  ima: Remove ima_h_table structure
  ima: Replace static htable queue with dynamically allocated array
  ima: Introduce per binary measurements list type ima_num_records
    counter
  ima: Introduce per binary measurements list type binary_runtime_size
    value
  ima: Introduce _ima_measurements_start() and _ima_measurements_next()
  ima: Mediate open/release method of the measurements list
  ima: Use snprintf() in create_securityfs_measurement_lists
  ima: Introduce ima_dump_measurement()
  ima: Add support for staging measurements with prompt
  ima: Add support for flushing the hash table when staging measurements
  ima: Support staging and deleting N measurements records
  doc: security: Add documentation of exporting and deleting IMA
    measurements

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/security/IMA-export-delete.rst  | 190 ++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |   2 +
 security/integrity/ima/Kconfig                |  15 +
 security/integrity/ima/ima.h                  |  29 +-
 security/integrity/ima/ima_api.c              |   2 +-
 security/integrity/ima/ima_fs.c               | 346 ++++++++++++++++--
 security/integrity/ima/ima_init.c             |   5 +
 security/integrity/ima/ima_kexec.c            |  42 ++-
 security/integrity/ima/ima_queue.c            | 329 +++++++++++++++--
 11 files changed, 894 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/security/IMA-export-delete.rst

-- 
2.43.0


