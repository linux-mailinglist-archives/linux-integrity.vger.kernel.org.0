Return-Path: <linux-integrity+bounces-8347-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H7mNKgBeWmOuQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8347-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 19:19:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039298EF2
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FF33009896
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595BC32573C;
	Tue, 27 Jan 2026 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="n60CF9tj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06621326945;
	Tue, 27 Jan 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537959; cv=none; b=DippjMXi7DkvOXJ/UyIriy8oyJJ+PXg5qYlpWKw8fGU7XSA4erRrG3jo1v/b9jwPPYaNhu5PNj747Q9ykEU1AwEAPJBaJNvJuSJdTMYL8efhW37IPrbrNNq7xVzdo9kON5Asm8TwM8laTHjcQxeeZ2A09Dwx/yuehEDq3FQ3DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537959; c=relaxed/simple;
	bh=5fMX1/ECBchGbinJQi24tMZwPt1WSzLt+BWU/KED+Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc/bW/PwYD6T4Q5S2zafE5e3plsgfey4vXS/uNeA9akP/ufrKUaqtFJVlAj9z72hoyt7DBe8/z3a4rheqNVy1Jx6E5wP1SjM5wz89gDf638+TwPHS8o0GbowCPoU0efuWOiBR41ch0NtFjLDK+/fSYWA78LkgxZBriV6ai3maP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=n60CF9tj; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uBLL9ZvNDL3CUghcZr3iwEXw7lwEbEStImsqSjcHyaM=; b=n60CF9tjkghfYkSrC3rl+UgPZK
	wrjAN0pBIvz1AERGoop7kG8rabivnF5D1q7EkUZqE6z0DSOF7xyYbwRUT9cBnN1t62nWeWw8ZKpJu
	6sKYy24JooX/6t9+tcw00kFEn3jyhxRpyGjDA5g3gx0sF1p4ksbBg6r4gm5GrXB5C+Z2KXBorNLuE
	tk9pHbadQG+gPRSpcAbbV/eaaC36wtCvGovPkeJdEhF3VYm0ulG9Xt/ySukkM/N2jDmoNq1qkZXk8
	TdO7kg3B5Qw7quhEV6NDkRTLDjaybIvK8lA0eTKmvVAV/R4RsLQzciGJPCfLd6OLZDcQjh2a4pABf
	peVMlRBw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vknLf-009rMz-0b;
	Tue, 27 Jan 2026 17:59:31 +0000
Date: Tue, 27 Jan 2026 17:59:31 +0000
From: Jonathan McDowell <noodles@earth.li>
To: dima@arista.com
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Silvia Sisinni <silvia.sisinni@polito.it>,
	Enrico Bravi <enrico.bravi@polito.it>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v3] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
Message-ID: <aXj9AwtTKVes5C38@earth.li>
References: <20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8347-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[earth.li:-];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6039298EF2
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:21:13PM +0000, Dmitry Safonov via B4 Relay wrote:
>From: Dmitry Safonov <dima@arista.com>
>
>ima_init_crypto() skips initializing ima_algo_array[i] if the algorithm
>from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
>It seems avoid adding the unsupported algorithm to ima_algo_array will
>break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).
>
>On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
>
>> ==================================================================
>> BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists+0x396/0x440
>> Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
>>
>> CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x61/0x90
>>  print_report+0xc4/0x580
>>  ? kasan_addr_to_slab+0x26/0x80
>>  ? create_securityfs_measurement_lists+0x396/0x440
>>  kasan_report+0xc2/0x100
>>  ? create_securityfs_measurement_lists+0x396/0x440
>>  create_securityfs_measurement_lists+0x396/0x440
>>  ima_fs_init+0xa3/0x300
>>  ima_init+0x7d/0xd0
>>  init_ima+0x28/0x100
>>  do_one_initcall+0xa6/0x3e0
>>  kernel_init_freeable+0x455/0x740
>>  kernel_init+0x24/0x1d0
>>  ret_from_fork+0x38/0x80
>>  ret_from_fork_asm+0x11/0x20
>>  </TASK>
>>
>> The buggy address belongs to the variable:
>>  hash_algo_name+0xb8/0x420
>>
>> The buggy address belongs to the physical page:
>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107ce18
>> flags: 0x8000000000002000(reserved|zone=2)
>> raw: 8000000000002000 ffffea0041f38608 ffffea0041f38608 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
>>  ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> >ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
>>                                         ^
>>  ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
>>  ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
>> ==================================================================
>
>Seems like the TPM chip supports sha3_256, which isn't yet in
>tpm_algorithms:
>> tpm tpm0: TPM with unsupported bank algorithm 0x0027
>
>Grepping HASH_ALGO__LAST in security/integrity/ima/ shows that is
>the check other logic relies on, so add files under TPM_ALG_<ID>
>and print 0 as their hash_digest_size.

Can I suggest, for better consistency, it's tpm_alg_<id> (i.e. lower 
case, like the rest of the path)?

>This is how it looks on the test machine I have:
>> # ls -1 /sys/kernel/security/ima/
>> ascii_runtime_measurements
>> ascii_runtime_measurements_TPM_ALG_27
>> ascii_runtime_measurements_sha1
>> ascii_runtime_measurements_sha256
>> binary_runtime_measurements
>> binary_runtime_measurements_TPM_ALG_27
>> binary_runtime_measurements_sha1
>> binary_runtime_measurements_sha256
>> policy
>> runtime_measurements_count
>> violations

J.

-- 
"Why 'maybe' for everything?" "I'm using fluffy logic."

