Return-Path: <linux-integrity+bounces-510-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9AD8155D5
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 02:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6F2868D6
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE31110B;
	Sat, 16 Dec 2023 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b8v567WV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F410EE
	for <linux-integrity@vger.kernel.org>; Sat, 16 Dec 2023 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 864372048D68;
	Fri, 15 Dec 2023 17:07:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 864372048D68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688858;
	bh=tJPozi2Vgk/XBxXY2R8duwn30Nm5WOpGFbXweXLG8To=;
	h=From:To:Cc:Subject:Date:From;
	b=b8v567WVce40Ggd47bhDR1cmis1bo9sOPQGnACGlCrfdJ/e+jVTuS45KEoF/iXLiV
	 KvvHlFUgDoUeEZfDqmAaxx0vifTdLdg7s7Rm+DZAAs0yfusJNbsWaWOWvN6nKJfZ3D
	 kbOSCGKsKzlmc4BQCIypASjCQ+GFtFJ0kzivYLTQ=
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
Subject: [PATCH v3 0/7] ima: kexec: measure events between kexec load and execute
Date: Fri, 15 Dec 2023 17:07:22 -0800
Message-Id: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
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

New events can be measured after the IMA log snapshot at kexec 'load'
and before the system boots to the new Kernel.  In this scenario, the TPM
PCRs are extended with these events, but they are not carried over to the
new Kernel after kexec soft reboot since the snapshot is already taken.
This results in mismatch between TPM PCR quotes and the actual IMA 
measurements list after kexec soft reboot, which in turn results in
remote attestation failure.

To solve this problem allocate the necessary buffer at kexec 'load' time,
populate the buffer with the IMA measurements at kexec 'execute' time, and
measure two new IMA events 'kexec_load' and 'kexec_execute' as critical
data to help detect missing events after kexec soft reboot.


The solution details include:
 - refactoring the existing code to allocate a buffer to hold IMA
   measurements at kexec 'load', and dump the measurements at kexec
   'execute'

 - ima functionality to suspend and resume measurements as needed during
   buffer copy at kexec 'execute',

 - ima functionality for mapping the measurement list from the current
   Kernel to the subsequent one, 

 - necessary changes to the kexec_file_load syscall, enabling it to call
   the ima functions,

 - registering a reboot notifier which gets called during kexec 
   'execute',

 - introducing a new Kconfig option to configure the amount of memory
   to be allocated for passing IMA log from the current Kernel to the
   next,
   
 - introducing two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially, from the
   current Kernel to the next,

 - excluding ima segment while calculating and storing digest in function
   kexec_calculate_store_digests(), since ima segment can be modified
   after the digest is computed during kexec 'load',

The modifications proposed in this series ensure the integrity of the ima
measurements is preserved across kexec soft reboots, thus significantly
improving the security of the Kernel post kexec soft reboots.

There were previous attempts to fix this issue [1], [2], [3].  But they
were not merged into the mainline Kernel.

We took inspiration from the past work [1] and [2] while working on this
patch series.

V2 of this series is available here[4] for reference.

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

Tushar Sugandhi (7):
  ima: define and call ima_alloc_kexec_file_buf
  ima: kexec: move ima log copy from kexec load to execute
  ima: kexec: map IMA buffer source pages to image after kexec load
  kexec: update kexec_file_load syscall to alloc ima buffer after load
  ima: suspend measurements during buffer copy at kexec execute
  ima: configure memory to log events between kexec load and execute
  ima: measure kexec load and exec events as critical data

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |  16 +++
 kernel/kexec_core.c                |  59 +++++++-
 kernel/kexec_file.c                |  16 +++
 security/integrity/ima/Kconfig     |   9 ++
 security/integrity/ima/ima.h       |   2 +
 security/integrity/ima/ima_kexec.c | 207 ++++++++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |  32 +++++
 8 files changed, 304 insertions(+), 40 deletions(-)

-- 
2.25.1


