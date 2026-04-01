Return-Path: <linux-integrity+bounces-9114-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEwyDORazWkRcQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9114-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14937ED39
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56AD3064F2A
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2026 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309447DD78;
	Wed,  1 Apr 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YSIvzG8s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836447DD66;
	Wed,  1 Apr 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064929; cv=none; b=QGYPJP5HTdoQOeFDAfFELSHFJ6WGPcsEEpSu3ic2d4q9Mh9DnMyVMdTRJIh/vdNnCQ1BbFBUyrC3cpaV8FFLsR5Vc4naNoOjeBvfPwXJjd4MXN7sClKJDT205zSt96ZU7jyU+50Y0L1HDXKsP2J53rQ8qUrmPksDlF3lRcbk/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064929; c=relaxed/simple;
	bh=eaE0d++8x8d1/1c8Q3kSHHs6PRk9dsU4dLXa7wTKxks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKm05vl7sZdQxMUetwuPvU8f6dKbYIJWMTa4NwVzInW+vURyUJrg4x8dGO+Hbn9ylwoLmy+kgzqYiJBYWtJn1rCGbvV8yoBv9Utx1n+jTrA+v/ZIjQfJT6KHhXweja3ffI0jVR+wiTmHx+P+u/oVfXCEZf6UPT04fMnADrqUPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YSIvzG8s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.174.223])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9DC520B710C;
	Wed,  1 Apr 2026 10:35:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9DC520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775064926;
	bh=2IJwL8/O3PkPKN6JWP55pOr/Z6dhg01IhjDRHmeVyjY=;
	h=From:To:Cc:Subject:Date:From;
	b=YSIvzG8sMEi5F1O1o5etXJqI/9DUQ09Q5SD+LjQezKXaLTjhKoiNcYuPdla0iNFU0
	 f/4sUmRxRD8W0OjlR1Ff3IvmYorIcylWOTnzNKSmkTDdu/hYWhZtGbomo5o9JJiE2C
	 ul+NNVx/7bp1YMKu861dftP2TC/07UuNjT/jerpQ=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 0/3] Trim N entries of IMA event logs
Date: Wed,  1 Apr 2026 10:29:52 -0700
Message-ID: <20260401172956.4581-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9114-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC14937ED39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Integrity Measurement Architecture (IMA) maintains a measurement list
—a record of system events used for integrity verification. The IMA event
logs are the entries within this measurement list, each representing a
specific event or measurement that contributes to the system's integrity
assessment.

This update introduces the ability to trim, or remove, N entries from the
current measurement list. Trimming involves deleting N entries from the
list. This action atomically truncates the measurement list, ensuring that
no new measurements can be added until the operation is complete.
Importantly, only one writer can initiate this trimming process at a time,
maintaining consistency and preventing race conditions.

A userspace interface, ima_trim_log, has been provided for this purpose.
When this interface is read, it returns the total number T of entries
trimmed since system boot up. This value T need to be preserved across
kexec soft reboots. By writing two number T:N to this interface, userspace
can request the kernel to trim N entries from the IMA event logs.

To maintain a complete record, userspace is responsible for concatenating
and storing the logs before initiating trimming. Userspace can then send
the collected data to remote verifiers for validation. After receiving
confirmation from the remote verifiers, userspace may instruct the kernel
to proceed with trimming the IMA event logs accordingly.

The primary benefit of this solution is the ability to free valuable
kernel memory by delegating the task of reconstructing the full
measurement list from log chunks to userspace. Trust is not required in
userspace for the integrity of the measurement list, as its integrity is
cryptographically protected by the Trusted Platform Module (TPM).

Multiple readers are allowed to access the ima_trim_log interface
concurrently, while only one writer can trigger log trimming at any time.
During trimming, readers do not see the list and cannot access it while
deletion is in progress, ensuring atomicity.

Introduce the new kernel option ima_flush_htable to decide whether or not
the digests of measurement entries are flushed from the hash table (from
reference [2]).

The ima_measure_users counter (protected by the ima_measure_lock mutex) has
been introduced to protect access to the measurement list part. The open
method of all the measurement interfaces has been extended to allow only
one writer at a time or, in alternative, multiple readers. The write
permission is used to stage/delete the measurements, the read permission
to read them. Write requires also the CAP_SYS_ADMIN capability (from
reference [2]). This ima_measure_users needs to be preserved across kexec
soft reboots

The total trimmed number T and the ima_measure_users both need to be
preserved across kexec soft reboot and new patch will be added for this
purpose in next version.

New IMA log trim event is added when trimming finish.

The time required for trimming is minimal, and IMA event logs are briefly
on hold during this process, preventing read or add operations. This short
interruption has no impact on the overall functionality of IMA.

A new critical data record "ima_log_trim" is added in this solution. This
record logs the trim event with number of entries deleted total T since
system start and time when this happened. User space can get the total
number T of entries trimmed by checking "ima_log_trim" event in the
measurement list.

The following are how user space to use the measurement list and
ima_log_trim interface
1. get the total numer trimmed T through "ima_log_trim" interface
2. get the PCR quote
3. read the measurement list file, close the file, send for verification
4. wait for response from verifier, until get the good response from
verifier with number N that matched the PCR quote got in step 2
5. get the number N from the above message
6. write the T:N to the ima_log_trim interface when no conflict

when kernel get log trim request T:N
 Get the T, compare with the total trimmed number
 if equal, then do trim N and change T to T+N
 else return error

Using above way to trim the log, the time for user space to hold the list
will be trimming T:N operation itself at the step 6. User space agent
race condition is solved too in this way.

References:
-----------
[1] [PATCH 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251202232857.8211-1-chenste@linux.microsoft.com/T/#t

[2] [RFC][PATCH] ima: Add support for staging measurements for deletion
https://lore.kernel.org/linux-integrity/207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com/T/#t

[3] [PATCH v2 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t

[4] [PATCH v3 0/3] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20260106020713.3994-1-chenste@linux.microsoft.com/T/#t

[5] [PATCH v4 0/3] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20260205235849.7086-1-chenste@linux.microsoft.com/T/#t

Change Log v5:
 - lock time performance improvement
 - Keep hash table unchanged because log already use the hash value
 - Updated patch descriptions as necessary.

Change Log v4:
 - Incorporated feedback from Roberto on v3 series.
 - Update "ima_log_trim" interface definition
   When read this interface, return total number of records trimmed T
   need to write T:N to this interface to trim N records
 - Update user space use case on how to trim IMA event logs
 - Updated patch descriptions as necessary.

Change Log v3:
 - Incorporated feedback from Mimi on v2 series.
 - split patch into multiple patches
 - lock time performance improvement
 - Updated patch descriptions as necessary.

Change Log v2:
 - Incorporated feedback from the Roberto on v1 series.
 - Adapted code from Roberto's RFC [Reference 2]
 - Add IMA log trim event log to record trim event
 - Updated patch descriptions as necessary

steven chen (3):
  ima: make ima event log trimming configurable
  ima: trim N IMA event log records
  ima: add new critical data record to measure log trim

 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/Kconfig                |  12 +
 security/integrity/ima/ima.h                  |   4 +-
 security/integrity/ima/ima_fs.c               | 218 +++++++++++++++++-
 security/integrity/ima/ima_kexec.c            |   2 +-
 security/integrity/ima/ima_queue.c            |  96 ++++++++
 6 files changed, 328 insertions(+), 8 deletions(-)

-- 
2.43.0


