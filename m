Return-Path: <linux-integrity+bounces-1199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92787854D02
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B94280FC0
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23745CDD2;
	Wed, 14 Feb 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MgSboqC0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482915C91F
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925116; cv=none; b=FdGEo8qK2X8AEoC87zwEA2J72UhV35BzoNl1ts/o1l/MBccRV9xUTP9DJkcQrx7MrA60UN+6kUjmBR8ZolhxgCRmo0ZhsP63BOcess39EJ4khsXe9GjhelI0n11lo8Fdtd+YZGRSBO3mBXtNVdJyT2EFVVJSGg7iER8coIEtzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925116; c=relaxed/simple;
	bh=LXV1i5V7bUzUQKq+OvgWm/ttViKgHRcxXbUfSUI4g44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9uqMH26beC0Ve7nU0I/M1L4ukIOI7Hk2xdYNocEP2TnCcldXVtm40IE1sgHXvxSX2ktmDo1StXmfYV4R1JWSTz/YELtiik0dOa8IXyUfByr5wDhxM10MK/9Adf1e50Cih/9bA7FrzcwyAxBoT+ZJvgHm+4T3Tdq4n5JRf90IKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MgSboqC0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 852A620B2000;
	Wed, 14 Feb 2024 07:38:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 852A620B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925114;
	bh=XVTfzBbBUMsyrdQi3Skonxs+2IjfCcOII0Uy0gvkOhs=;
	h=From:To:Cc:Subject:Date:From;
	b=MgSboqC0F+ncYxztW/2NUfQudXn1F37aIkHUfe6n0c1FMOhRHnsrlLdOCNDZB1K39
	 Ycn53o2R7cnDF63C9gBYtz+3v9sTY+lIefBev10sjpbcAI2mSibwfOwVZj/Ts2qpZ0
	 aCEdxVyKPGzcx+Nn8jVZVVCtQmL/tAsVAMDsYAtE=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v5 0/8] ima: kexec: measure events between kexec load and execute
Date: Wed, 14 Feb 2024 07:38:19 -0800
Message-Id: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current Kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'.  IMA log is then carried
over to the new Kernel after kexec 'execute'.

New events can be measured during/after the IMA log snapshot at kexec 
'load' and before the system boots to the new Kernel.  In this scenario,
the TPM PCRs are extended with these events, but they are not carried
over to the new Kernel after kexec soft reboot since the snapshot is
already taken.  This results in mismatch between TPM PCR quotes and the
actual IMA measurements list after kexec soft reboot, which in turn
results in remote attestation failure.

To solve this problem - 
 - allocate the necessary buffer at kexec 'load' time,
 - populate the buffer with the IMA measurements at kexec 'execute' time, 
 - and measure two new IMA events 'kexec_load' and 'kexec_execute' as
   critical data to help detect missing events after kexec soft reboot.

The solution details include:
 - refactoring the existing code to allocate a buffer to hold IMA
   measurements at kexec 'load', and dump the measurements at kexec
   'execute'

 - IMA functionality to suspend and resume measurements as needed during
   buffer copy at kexec 'execute',

 - kexec functionality for mapping the segments from the current Kernel
   to the subsequent one, 

 - necessary changes to the kexec_file_load syscall, enabling it to call
   the ima functions,

 - registering a reboot notifier which gets called during kexec 
   'execute',

 - introducing a new Kconfig option to configure the extra memory to be
   allocated for passing IMA log from the current Kernel to the next,
   
 - introducing two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially, from the
   current Kernel to the next,

 - excluding IMA segment while calculating and storing digest in function
   kexec_calculate_store_digests(), since IMA segment can be modified
   after the digest is computed during kexec 'load'.  This will ensure
   that the segment is not added to the 'purgatory_sha_regions', and thus
   not verified by verify_sha256_digest().

The changes proposed in this series ensure the integrity of the IMA
measurements is preserved across kexec soft reboots, thus significantly
improving the security of the Kernel post kexec soft reboots.

There were previous attempts to fix this issue [1], [2], [3].  But they
were not merged into the mainline Kernel.

We took inspiration from the past work [1] and [2] while working on this
patch series.

V4 of this series is available here[6] for reference.

References:
-----------

[1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/

[2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
https://lkml.org/lkml/2016/8/16/577

[3] [PATCH 1/6] kexec_file: Add buffer hand-over support
https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/

[4] [PATCH v2 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20231005182602.634615-1-tusharsu@linux.microsoft.com/

[5] [PATCH v3 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20231216010729.2904751-1-tusharsu@linux.microsoft.com/

[6] [PATCH v4 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20240122183804.3293904-1-tusharsu@linux.microsoft.com/

Change Log v5:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v4 of this series[6].
 - Rebased the patch series to mainline 6.8.0-rc1.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.
 - Divided the patch #4 in the v4 of the series[6] into two separate
   patches. One (patch #4) to setup the infrastructure/stub functions
   to prepare the IMA log copy from Kexec 'load' to 'execute', and 
   another one (patch #5) to actually copy the log.
 - Updated the config description for IMA_KEXEC_EXTRA_MEMORY_KB
   to remove unnecessary references related to backwards compatibility.
 - Fixed a typo in log message/removed an extra line etc.
 - Updated patch descriptions as per the feedback.

Change Log v4:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v3 of this series[5].
 - Rearranged patches so that they remain bisect-safe i.e. the
   system can go through kexec soft reboot, and IMA log is carried
   over after each patch.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying kexec soft reboot works, and IMA log gets
   carried over.
 - Suspend-resume measurements is now a separate patch (patch #5)
   and all the relevant code is part of the same patch.
 - Excluding IMA segment from segment digest verification is now a
   separate patch. (patch #3).
 - Registering reboot notifier and functions related to move ima 
   log copy from kexec load to execute are now part of the same
   patch (patch #4) to protect bisect-safeness of the series.
 - Updated the title of patch #6 as per the feedback.
 - The default value of kexec extra memory for IMA measurements
   is set to half the PAGESIZE to maintain backwards compatibility.
 - Added number of IMA measurement records as part of 'kexec_load' 
   and 'kexec_execute' IMA critical data events.
 - Updated patch descriptions as necessary.

Change Log v3:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v2 of this series[4].
 - Renamed functions and removed extraneous checks and code comments.
 - Updated patch descriptions and titles as necessary.
 - Updated kexec_calculate_store_digests() in patch 2/7 to exclude ima
   segment from calculating and storing digest.
 - Updated patch 3/7 to use kmalloc_array instead of kmalloc and freed
   memory early to avoid potential memory leak.
 - Updated patch 6/7 to change Kconfig option IMA_KEXEC_EXTRA_PAGES to
   IMA_KEXEC_EXTRA_MEMORY_KB to allocate the memory in kb rather than
   in number of pages.
 - Optimized patch 7/7 not to free and alloc memory if the buffer size
   hasn't changed during multiple kexec 'load' operations.
 - Fixed a bug in patch 7/7 to measure multiple 'kexec_load' events even
   if buffer size hasn't changed.
 - Verified the patches are bisect-safe by compiling and booting into
   each patch individually.


Change Log v2:
 - Incorporated feedback from the community on v1 series.
 - Refactored the existing ima_dump_measurement_list to move buffer
   allocation functionality to ima_alloc_kexec_buf() function.
 - Introduced a new Kconfig option to configure the memory.
 - Updated the logic to copy the IMA log only in case of kexec soft 
   reboot, and not on kexec crash.
 - Updated the logic to copy as many IMA events as possible in case of
   memory constraint, rather than just bailing out.
 - Introduced two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially from the
   current Kernel to the next.
 - Refactored patches to ensure no warnings during individual patch
   compilation.
 - Used virt_to_page instead of phys_to_page.
 - Updated patch descriptions as necessary.



Tushar Sugandhi (8):
  ima: define and call ima_alloc_kexec_file_buf
  kexec: define functions to map and unmap segments
  ima: kexec: skip IMA segment validation after kexec soft reboot
  ima: kexec: define functions to copy IMA log at soft boot
  ima: kexec: move IMA log copy from kexec load to execute
  ima: suspend measurements during buffer copy at kexec execute
  ima: make the kexec extra memory configurable
  ima: measure kexec load and exec events as critical data

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |  16 ++
 kernel/kexec_core.c                |  59 +++++++-
 kernel/kexec_file.c                |  16 ++
 security/integrity/ima/Kconfig     |   9 ++
 security/integrity/ima/ima.h       |   2 +
 security/integrity/ima/ima_kexec.c | 225 ++++++++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |  32 ++++
 8 files changed, 322 insertions(+), 40 deletions(-)

-- 
2.25.1


