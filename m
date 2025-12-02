Return-Path: <linux-integrity+bounces-7772-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C9C9D562
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 00:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE644E03AF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A22E22AA;
	Tue,  2 Dec 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JSPT+XB4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF95200C2;
	Tue,  2 Dec 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718153; cv=none; b=WXBPNlBIal+GhzgQE8lAiJ6/K973SrybKUJ73PomS7HSCmbNg8+M2k6i9/50WuIpzUAM1pVZ/p/n3OYajyrldqDwSjOBD3ht0lhi1cPRsnSeH/YHN2gtI260dnI/vPeCTo/Ux1G/zyB1K0HT/vYT0pL866hF8/xiXH/OmGokO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718153; c=relaxed/simple;
	bh=O1KV0oGv9tff2HSjRCgWh4qnHzLKiGz8SLZOrqTL4/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOjNb3NsaQwjOSrmAkwMjf6U/389aFNWcNha+wE7THdXcV+sxbAFEBCnRYoAL8mOHQDgS4jDk/AVpFC0haFn56zlqRyY+6QaoRiH7V4OPIoGEuYRHp++MlK0Dpt27oeBeKUSL82sUpo1JL23oilUEdswuV6VUTv0F/aGbFhNW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JSPT+XB4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.1.211])
	by linux.microsoft.com (Postfix) with ESMTPSA id D61742120E98;
	Tue,  2 Dec 2025 15:29:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D61742120E98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764718146;
	bh=B5GtCtaw11AiFNcqYmU5EYl7+oAn4QhtIpVGpnqomQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JSPT+XB4EXdWVFiS5RZxaGBPfwWFi1UkdjRDFhdddGzn21eFcfEdVhBdyIejimX8B
	 SUzcUbDFDFGpNpo9DwLxD0cWupigq5IT/uVqBTMc3kn9BG/8sZgqHNvsu4YI3yD60M
	 e07Akb/ibgr2GaRDFIWFDovvRJfn32xs0rxzM65M=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com
Subject: [PATCH 0/1] Trim N entries of IMA event logs
Date: Tue,  2 Dec 2025 15:28:55 -0800
Message-ID: <20251202232857.8211-1-chenste@linux.microsoft.com>
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

The time required for trimming is minimal, and IMA event logs are briefly
on hold during this process, preventing read or add operations. This short
interruption has no impact on the overall functionality of IMA.

steven chen (1):
  IMA event log trimming

 security/integrity/ima/ima.h       |  2 +
 security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c | 42 ++++++++++++++++
 3 files changed, 122 insertions(+)

-- 
2.43.0


