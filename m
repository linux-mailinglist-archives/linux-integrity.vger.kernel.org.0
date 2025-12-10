Return-Path: <linux-integrity+bounces-7905-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44109CB451A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 00:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F353021FA2
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E228725D;
	Wed, 10 Dec 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jXS4/sQm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96F280335;
	Wed, 10 Dec 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410804; cv=none; b=H5B990xTnmn+brz4mZHEpPyi3x1VKMrnWBH4kD6c/43lFRieyISZSkaqva5NkKO0GaJsQdxfA/0WVtMGFHggK6ZJTVXmBPaZ/2rpNbdGKa9IRlXF7GHIEbEpTupnCOAE0lR6u2wJu3qMu7AHb5SMMYRScbqwrXXi5t1wvfhps+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410804; c=relaxed/simple;
	bh=iLf/3pqzRjM2vtmyV+qBQZ5P2ZcxfsLYZ37c66Wv7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EjyzG81cROOvmuGjiCUEZvvKWNOO2Ir5jXViKA2NxdDdohAAE/9gvpZPEqjvBEzBhXV1CSN5h+nrjAP0o4CM9QZKAjtHMsDdVFNwEq7WZr6/Deo9xwkVPotBEFjrp00TnscUc2slycYq5WKPJcVUSySLAp3U9etnJ2vfO1OnReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jXS4/sQm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (c-67-168-176-124.hsd1.wa.comcast.net [67.168.176.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46FC8211603E;
	Wed, 10 Dec 2025 15:53:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46FC8211603E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765410801;
	bh=PMrSM9sNdXVS3gVjnHz4WlV/DUtREqvT6AWyC31m77c=;
	h=From:To:Cc:Subject:Date:From;
	b=jXS4/sQm1ew3vN8t+D8XashX3HicdGHp0E/tyVJe3gnGkr4eaQEGdVnE3khe1FvVW
	 P20wHQoYyEWgeNhjqVd0tsIcWUtBN/H6GT8XhPFEtHLfA39rWOjJPCqyjuG+H6AsJU
	 7H8v9P4fFfwzsNID4HNvnWNNxWUthygkddinUoRk=
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
Subject: [PATCH v2 0/1] Trim N entries of IMA event logs
Date: Wed, 10 Dec 2025 15:53:11 -0800
Message-ID: <20251210235314.3341-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Integrity Measurement Architecture (IMA) maintains a measurement list
—a record of system events used for integrity verification. The IMA event
logs are the entries within this measurement list, each representing a
specific event or measurement that contributes to the system's integrity
assessment.

This update introduces the ability to trim, or remove, N entries from the
current measurement list. Trimming involves deleting N entries from the
list and clearing the corresponding entries from the hash table. This
action atomically truncates the measurement list, ensuring that no new
measurements can be added until the operation is complete. Importantly,
only one writer can initiate this trimming process at a time, maintaining
consistency and preventing race conditions.

A userspace interface, ima_trim_log, has been provided for this purpose.
By writing a number N to this interface, userspace can request the kernel
to trim N entries from the IMA event logs. When this interface is read,
it returns the number of entries trimmed during the last operation. This
value is not preserved across kexec soft reboots, as it is not considered
important information.

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
the digests of measurement entries are flushed from the hash table. (from
reference [2])

The ima_measure_users counter (protected by the ima_measure_lock mutex) has
been introduced to protect access to the measurement list part. The open
method of all the measurement interfaces has been extended to allow only
one writer at a time or, in alternative, multiple readers. The write
permission is used to delete the measurements, the read permission
to read them. Write requires also the CAP_SYS_ADMIN capability. (from
reference [2])

New IMA log trim event is added when trimming finish.

The time required for trimming is minimal, and IMA event logs are briefly
on hold during this process, preventing read or add operations. This short
interruption has no impact on the overall functionality of IMA.

V1 of this series is available here[1] for reference.

References:
-----------
[1] [PATCH 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251202232857.8211-1-chenste@linux.microsoft.com/T/#t

[2] [RFC][PATCH] ima: Add support for staging measurements for deletion
https://lore.kernel.org/linux-integrity/207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com/T/#t

Change Log v2:
 - Incorporated feedback from the Roberto on v1 series.
 - Adapted code from Roberto's RFC [Reference 2]
 - Add IMA log trim event log to record trim event
 - Updated patch descriptions as necessary.

steven chen (1):
  IMA event log trimming

 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/ima.h                  |   2 +
 security/integrity/ima/ima_fs.c               | 175 +++++++++++++++++-
 security/integrity/ima/ima_queue.c            |  64 +++++++
 4 files changed, 241 insertions(+), 4 deletions(-)

-- 
2.43.0


