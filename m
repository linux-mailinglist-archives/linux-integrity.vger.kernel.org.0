Return-Path: <linux-integrity+bounces-8169-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A525DCF66A2
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DEC53014590
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 02:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738D622129F;
	Tue,  6 Jan 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GbPTW9Wu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9F23183B;
	Tue,  6 Jan 2026 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665245; cv=none; b=CLCPdU2xyaD/U+NGOtEILbTzPyPNYGryPIWS4Wike2xKJ6Re00SRCv9STpyCqCSOicg7KmEE6nLqsY6Wc0A4f8FrnPXytKwSYJ034U8gfSVOCWbQyPSDjYa+ecQDsfUDPGExnN7hPJJtEgPS7Tpu8Z+UxKq6DFxC8/W01CtBM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665245; c=relaxed/simple;
	bh=otSLgEjPuWs/LT9Z40+2VWG9c/cJ1MTF9LinID6UibM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMoI49sN6m4rMefVjHfBhrdhqUmFUC5OcoxV8CKE6NVo7W7cjsppS32CPb3BZvhG4lC9FKUACfIZS0a2aVM2myF9l66kpBcNWabXoiVG2DCHiD3g5AZqA4jEUn1YROrnYKWeZE0h17n7rMPEU0FshFCvAN82hqHv8RRfdhNcqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GbPTW9Wu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [50.168.180.218])
	by linux.microsoft.com (Postfix) with ESMTPSA id 77121212539D;
	Mon,  5 Jan 2026 18:07:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77121212539D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767665242;
	bh=H08OoCkzX0Z4riXC6ajB/lJUPhjsty1aYHfK+Bxp6Kc=;
	h=From:To:Cc:Subject:Date:From;
	b=GbPTW9Wu3fJSQQ2bJSI1mOzl05ck/Nij065jVzaao5HPvI/PH64BO82H8ANs9gwIO
	 xIw4+8BfUCHyvW9PHMRZuyZ0LMcBS9Bkyq4yazewpUx0I88Btg8A1t3YV5AVT3jSKm
	 ymxoham8hH7mHSFU7o8VTScqa8134YyI56uZY0aU=
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
Subject: [PATCH v3 0/1] Trim N entries of IMA event logs
Date: Mon,  5 Jan 2026 18:07:09 -0800
Message-ID: <20260106020713.3994-1-chenste@linux.microsoft.com>
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
the digests of measurement entries are flushed from the hash table (from
reference [2]).

The ima_measure_users counter (protected by the ima_measure_lock mutex) has
been introduced to protect access to the measurement list part. The open
method of all the measurement interfaces has been extended to allow only
one writer at a time or, in alternative, multiple readers. The write
permission is used to stage/delete the measurements, the read permission
to read them. Write requires also the CAP_SYS_ADMIN capability (from
reference [2]).

New IMA log trim event is added when trimming finish. For kernel soft
reboot case, there is no need to transfer extra data from old kernel to
new kernel after trimming.

The time required for trimming is minimal, and IMA event logs are briefly
on hold during this process, preventing read or add operations. This short
interruption has no impact on the overall functionality of IMA.

A new critical data record "ima_log_trim" is added in this solution. This
record logs the trim event with number of entries deleted and time when
this happened. User space can get the total number of entries trimmed by
checking all "ima_log_trim" event in the measurement list.

The following are how user space to use the measurement list and
ima_log_trim interface
1. check any read/write measurement list/ima_log_trim operation, if any,
wait until released
2. when no app read/write measurement list/ima_log_trim operation, set
read/write flag
3. get the PCR quote first
4. read the measurement list file, close the file, send for verification
with other IMA information to verifier
5. wait for response from verifier, until get the good response from
verifier with number N that matched the PCR quote got in step 3
6. get the number N from the above message 
7. write the N to the ima_log_trim interface
8. save total N entries of the measurement list read in step 4 to userspace
9. release read/write flag

References:
-----------
[1] [PATCH 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251202232857.8211-1-chenste@linux.microsoft.com/T/#t

[2] [RFC][PATCH] ima: Add support for staging measurements for deletion
https://lore.kernel.org/linux-integrity/207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com/T/#t

[3] PATCH v2 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t

Change Log v3:
 - Incorporated feedback from Mimi on v2 series.
 - split patch into multiple patches
 - lock time performance improvement
 - Updated patch descriptions as necessary.

Change Log v2:
 - Incorporated feedback from the Roberto on v1 series.
 - Adapted code from Roberto's RFC [Reference 2]
 - Add IMA log trim event log to record trim event
 - Updated patch descriptions as necessary.

steven chen (3):
  ima: make ima event log trimming configurable
  ima: trim N IMA event log records
  ima: add new critical data record to measure log trimming

 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/Kconfig                |  12 ++
 security/integrity/ima/ima.h                  |   2 +
 security/integrity/ima/ima_fs.c               | 182 +++++++++++++++++-
 security/integrity/ima/ima_queue.c            |  85 ++++++++
 5 files changed, 281 insertions(+), 4 deletions(-)

-- 
2.43.0


