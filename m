Return-Path: <linux-integrity+bounces-9480-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGDyGnbD/GnSTAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9480-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 18:53:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CF4EC7E9
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD0A630B3D92
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2547DF99;
	Thu,  7 May 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RATPRuJO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1574657DA;
	Thu,  7 May 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172451; cv=none; b=NY5LxDe3N3VCvOSBCHkQpR5F6y+KVoJUNUTWQKKjk3sDqxkZccaT1b6+9maMOJMnpCz2OVOuploS/Q0xbAWHL0O2bslfGZiUfrfb+3cPfT0DRjGcEjN9zczCUj4IjN52tTrSpXxUGbHiugnUci8CbXKQX4xS4/Epzpw4TDRdY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172451; c=relaxed/simple;
	bh=4PndgpJ2S9R3n3mKvoH1XhN0SDxuc8jiUDDhxf8Ph6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2IZGWUx9/ECXmJXKFgReb2gJvG7BC+F0Hqbdr7JgYexjrWrR52/uajn9udkHEh1/lXn86jvjDp2IrVWjyCiJfyuT/jk7I2IyY517V605rFZ50E1HTqAl/naPTJI00McG2bY6+RQYAulds2Wqih1/9lTDE9btQQREwlow0QYjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RATPRuJO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.64.200] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1D1C20B7165;
	Thu,  7 May 2026 09:47:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1D1C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778172446;
	bh=jt3dbhGdRRRtniH63ZDchc9RWsmE7a43+MifyDob+X4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RATPRuJO4MJ+2wJn+PcCTvyHsuYYEUKyBiSW0o6/U8Bf4lqr9vPKQJANTiyOyblZw
	 zk0PPCb+MLGqKiI9l6UxxvsQuvW8w4B2ProbAm5Ce4VOExLYqrawUpBNR9UypmBeo+
	 gjXPFeBR88KfLZfAsChGB4AyZeGqq02liDygqOBI=
Message-ID: <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
Date: Thu, 7 May 2026 09:47:27 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E92CF4EC7E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9480-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 4/29/2026 9:03 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduction
> ============
>
> The IMA measurements list is currently stored in the kernel memory.
> Memory occupation grows linearly with the number of entries, and can
> become a problem especially in environments with reduced resources.
>
> While there is an advantage in keeping the IMA measurements list in
> kernel memory, so that it is always available for reading from the
> securityfs interfaces, storing it elsewhere would make it possible to
> free precious memory for other kernel components.
>
> Storing the IMA measurements list outside the kernel does not introduce
> security issues, since its integrity is anyway protected by the TPM.
>
> Hence, the new IMA staging mechanism is introduced to allow user space
> to remove the desired portion of the measurements list from the kernel.
>
>
> Usage
> =====
>
> The IMA staging mechanism can be enabled from the kernel configuration
> with the CONFIG_IMA_STAGING option.
>
> If it is enabled, IMA duplicates the current measurements interfaces
> (both binary and ASCII), by adding the _staged file suffix. Both the
> original and the staging interfaces gain the write permission for the
> root user and group, but require the process to have CAP_SYS_ADMIN set.
>
> The staging mechanism supports two flavors.
>
> Staging with prompt
> ~~~~~~~~~~~~~~~~~~~
>
> The current measurements list is moved to a temporary staging area, and
> staged measurements are deleted upon confirmation.
>
> This staging process is achieved with the following steps.
>
>    1.  echo A > <original interface>: the user requests IMA to stage the
>        entire measurements list;
>    2.  cat <_staged interface>: the user reads the staged measurements;
>    3.  echo D > <_staged interface>: the user requests IMA to delete
>        staged measurements.
>
> Staging and deleting
> ~~~~~~~~~~~~~~~~~~~~
>
> N measurements are staged to a temporary staging area, and immediately
> deleted without further confirmation.
>
> This staging process is achieved with the following steps.
>
>    1.  cat <original interface>: the user reads the current measurements
>        list and determines what the value N for staging should be;
>    2.  echo N > <original interface>: the user requests IMA to delete N
>        measurements from the current measurements list.

This submission proposes two ways for log trimming:

*Favour 1:* Staging with prompt
*Favour 2:* stage and delete N

Functionally, both approaches address the same problem, but *Favour 2 
*is the
stronger design and should be preferred. There is no good reason to keep 
*Favour 1.*

 From a kernel implementation perspective, *Favour 2 *is more efficient 
because it
minimizes the time spent holding the list lock (can’t be shorter). It 
also substantially
reduces the amount of kernel-side logic, removing nearly half of the 
code required
by the alternative approach.

 From a user-space perspective, *Favour 2 *results in a much cleaner 
model. It avoids
the need to track and reconcile both old and staged lists in user space 
as well as
two lists (cur and staged) in the kernel space, which simplifies log 
trimming logic
and reduces maintenance overhead. In addition, it preserves the existing 
external
behavior by not exposing any staged list to user space.

Overall, *Favour 2 *provides the same functional result with lower 
kernel complexity,
shorter kernel list lock hold time, and a simpler user-space interface. 
For those
reasons, it is the preferable approach and *Favour 1* does not appear to 
offer sufficient
justification to keep both implementations.

Steven
>
> Management of Staged Measurements
> =================================
>
> Since with the staging mechanism measurement entries are removed from
> the kernel, the user needs to save the staged ones in a storage and
> concatenate them together, so that it can present them to remote
> attestation agents as if staging was never done.
>
>
> Patch set content
> =================
>
> Patches 1-8 are preparatory patches to quickly replace the hash table,
> maintain separate counters for the different measurements list types,
> mediate access to the measurements list interface, and simplify the staging
> patches.
>
> Patch 9 introduces the staging with prompt flavor. Patch 10 makes it
> possible to flush the hash table when deleting all the staged measurements.
> Patch 11 introduces the staging and deleting flavor. Patch 12 avoids
> measurements entries to be stored twice if there is contention between the
> measurements interfaces and kexec. Patch 13 adds the documentation of the
> staging mechanism.
>
>
> Changelog
> =========
>
> v4:
>   - Add write permission to the original measurement interface, and move
>     the A and N staging commands to that interface
>   - Explain better the two staging flavors and highlight that the staging
>     and delete only stages measurements internally
>   - Rename ima_queue_staged_delete_partial() to ima_queue_delete_partial()
>   - Replace ima_staged_measurements_prepended with per measurements list
>     flag to avoid copying staged and active list measurements twice
>   - Optimize the staging and deleting flavor by locklessly determining the
>     cut position in the active list, and immediately deleting entries
>     without explicit staging and splicing (suggested by Steven Chen)
>
> v3:
>   - Add Kconfig option to enable the staging mechanism (suggested by Mimi)
>   - Change the meaning of BINARY_STAGED to be just the staged measurements
>   - Separate the two staging flavors in two different functions:
>     ima_queue_staged_delete_all() for staging with prompt,
>     ima_queue_staged_delete_partial() for staging and deleting
>   - Delete N entries without staging first (suggested by Mimi)
>   - Avoid duplicate staged entries if there is contention between the
>     measurements list interfaces and kexec
>
> v2:
>   - New patch to move measurements and violation counters outside the
>     ima_h_table structure
>   - New patch to quickly replace the hash table
>   - Forbid partial deletion when flushing hash table (suggested by Mimi)
>   - Ignore ima_flush_htable if CONFIG_IMA_DISABLE_HTABLE is enabled
>   - BINARY_SIZE_* renamed to BINARY_* for better clarity
>   - Removed ima_measurements_staged_exist and testing list empty instead
>   - ima_queue_stage_trim() and ima_queue_delete_staged_trimmed() renamed to
>     ima_queue_stage() and ima_queue_delete_staged()
>   - New delete interval [1, ULONG_MAX - 1]
>   - Rename ima_measure_lock to ima_measure_mutex
>   - Move seq_open() and seq_release() outside the ima_measure_mutex lock
>   - Drop ima_measurements_staged_read() and use seq_read() instead
>   - Optimize create_securityfs_measurement_lists() changes
>   - New file name format with _staged suffix at the end of the file name
>   - Use _rcu list variant in ima_dump_measurement_list()
>   - Remove support for direct trimming and splice the remaining entries to
>     the active list (suggested by Mimi)
>   - Hot swap the hash table if flushing is requested
>
> v1:
>   - Support for direct trimming without staging
>   - Support unstaging on kexec (requested by Gregory Lumen)
>
> Roberto Sassu (13):
>    ima: Remove ima_h_table structure
>    ima: Replace static htable queue with dynamically allocated array
>    ima: Introduce per binary measurements list type ima_num_entries
>      counter
>    ima: Introduce per binary measurements list type binary_runtime_size
>      value
>    ima: Introduce _ima_measurements_start() and _ima_measurements_next()
>    ima: Mediate open/release method of the measurements list
>    ima: Use snprintf() in create_securityfs_measurement_lists
>    ima: Introduce ima_dump_measurement()
>    ima: Add support for staging measurements with prompt
>    ima: Add support for flushing the hash table when staging measurements
>    ima: Support staging and deleting N measurements entries
>    ima: Return error on deleting measurements already copied during kexec
>    doc: security: Add documentation of the IMA staging mechanism
>
>   .../admin-guide/kernel-parameters.txt         |   4 +
>   Documentation/security/IMA-staging.rst        | 163 +++++++++
>   Documentation/security/index.rst              |   1 +
>   MAINTAINERS                                   |   2 +
>   security/integrity/ima/Kconfig                |  16 +
>   security/integrity/ima/ima.h                  |  32 +-
>   security/integrity/ima/ima_api.c              |   2 +-
>   security/integrity/ima/ima_fs.c               | 315 ++++++++++++++++--
>   security/integrity/ima/ima_init.c             |   5 +
>   security/integrity/ima/ima_kexec.c            |  53 ++-
>   security/integrity/ima/ima_queue.c            | 283 ++++++++++++++--
>   11 files changed, 803 insertions(+), 73 deletions(-)
>   create mode 100644 Documentation/security/IMA-staging.rst
>


