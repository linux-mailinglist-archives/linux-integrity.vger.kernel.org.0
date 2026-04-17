Return-Path: <linux-integrity+bounces-9216-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILM/C8bx4WmKzgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9216-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 10:39:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A96418CA0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD52E307C622
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EF3AF66E;
	Fri, 17 Apr 2026 08:37:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5D3AF64D
	for <linux-integrity@vger.kernel.org>; Fri, 17 Apr 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415053; cv=none; b=RUvl4H/Zk+6m+7nqMuZHFIA+lYD1CcHmStafC8I/8OwpWo1mF8KnWNIaLzfI8vGkWP2ZlVUg717eNDBX1D3Sqg8plJLFpM5hezRwtCQnntyKH53BS/qj1z8ua52U/QE0OvE24cW8pZt7PqzPHHLgf2ulkEmFxBLtkFg7t7bBLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415053; c=relaxed/simple;
	bh=NcoDKD5VYEmBVEIiaM5bax7nm1SG0plSaU86+oT6uvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PblEHMqsbCV7BAPWXJMqpSkdpoyrDNTaDlMN2jqj8HCUhiJ7G2bkT2o98Kby/KVxMnKpG0pM/op+y4BHA3YkThoF2H+CH73rmqfRYfz+GE5ppcvbah/kb5915GGMDVXpCngLmEgQmKxDZEIk1JBUO5EEgSclOizydrDu8r2eLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fxp6w23KWzpTrN
	for <linux-integrity@vger.kernel.org>; Fri, 17 Apr 2026 16:33:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6062D4056C
	for <linux-integrity@vger.kernel.org>; Fri, 17 Apr 2026 16:37:27 +0800 (CST)
Received: from [10.221.98.196] (unknown [10.221.98.196])
	by APP1 (Coremail) with SMTP id LxC2BwDXM95A8eFpzudeAA--.34379S2;
	Fri, 17 Apr 2026 09:37:26 +0100 (CET)
Message-ID: <134c80cd-1a60-4a91-b088-b4f64e4ce841@huaweicloud.com>
Date: Fri, 17 Apr 2026 10:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ima: audit log emitted from ima_collect_measurement when SIGKILL
 interrupts reads from slow-read filesystems
To: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 Sahil Gupta <s.gupta@arista.com>, Pierre De Abreu <pierre@arista.com>,
 Julien Gomes <julien@arista.com>, Kunal Bharathi <kbharathi@arista.com>
References: <CAFn2k5C+AAp7MCCpsP+n8c_ghE-YkwQzy3d36jX9B1H3b+c9tg@mail.gmail.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAFn2k5C+AAp7MCCpsP+n8c_ghE-YkwQzy3d36jX9B1H3b+c9tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDXM95A8eFpzudeAA--.34379S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5GryDtF4rAF4fKryUJrb_yoW5XF17pr
	ZagFnIkr1kX3WIkwn7Gw4kuFW093s7Cay7Grn8ur18Z3Z8u3ZY9ryfKw1jqFy7Grnxtw13
	AF40g3srZ3WDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGnh2QYCbgACs5
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,arista.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9216-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: E8A96418CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 8:54 PM, Danny Hu wrote:
> When IMA appraisal/measurement is enabled for executables, an
> AUDIT_INTEGRITY_DATA (type=1800) audit message is emitted from
> ima_collect_measurement() if a process receives SIGKILL while reading
> a file from a slow-read filesystem.
> 
> Configuration:
> - IMA policy configured: measure func=BPRM_CHECK mask=MAY_EXEC
> - stacked overlayfs with git binary on squashfs (compressed, read-only
> filesystem on flash storage)
> - Kernel version 6.12.68
> 
> Steps to reproduce:
> $ echo 3 > /proc/sys/vm/drop_caches; timeout --signal=KILL 0.05s git
> Killed
> $ dmesg | tail -n 1
> audit: type=1800 audit(1775843687.948:10): pid=14049 uid=0
> auid=72198551 ses=2 op=collect_data cause=failed comm="timeout"
> name="git" dev="overlay" ino=11529215046068473654 res=0 errno=0
> 
> The drop_caches evicts both the page cache (forcing squashfs to
> re-read and decompress from flash on the next access) and the inode
> cache (forcing IMA to re-hash). The timeout command execs git and
> sends SIGKILL after 50ms.
> During that window, IMA is reading the file page by page in
> integrity_kernel_read. Since the page cache is cold, the squashfs read
> path must decompress blocks from flash storage. This IO operation
> causes the kernel to check for signals and return -EINTR. This
> propagates up through integrity_kernel_rea to ima_calc_file_hash and
> finally ima_collect_measurement, which logs the collect_data failure.
> 
> The log is more commonly observed during boot, when the page cache is
> cold and all binaries must be read from flash for the first time. Many
> services may start and stop concurrently, and any process that
> receives SIGKILL while IMA is reading the file from flash for the
> first time will produce this audit message.
> 
> I believe this log is spurious because the process is being killed;
> therefore, an interrupted file read is the expected outcome. The audit
> message in this case does not indicate any integrity violations as the
> file has not been tampered with. Lastly, the log's presence can
> mislead administrators or monitoring tools into believing a security
> event occurred when it was only an expected process kill.

Hi Danny

it still shows an unexpected condition occurred in IMA. I think it is 
worth keeping the audit message.

Thanks

Roberto

> Questions for the IMA maintainers:
> 1. Is this the intended behavior? Should ima_collect_measurement still
> emit the audit log when the failure is due to a fatal signal?
> 2. If not, could a potential fix be to skip the generation of the
> audit log in ima_collect_measurement (result == -EINTR &&
> fatal_signal_pending(current))?
> 
> Thanks,
> Danny


