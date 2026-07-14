Return-Path: <linux-integrity+bounces-9938-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aX+NJsMBVmpNxwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9938-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:30:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60853752DCF
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:30:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=vZENe6dX;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9938-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9938-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8083033806
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED13043FD20;
	Tue, 14 Jul 2026 09:28:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35C3DA5A9;
	Tue, 14 Jul 2026 09:28:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021322; cv=none; b=bjos6odAXXi1Ypm6LX5l2w40Wy/K24ZcMNy/Vk/VjliWjF6dNJ0FV+lCcstKa6N8PbL0vNM9jAIPYzqmQvswjrmf6rLWFHLVFCPARbBjDWswdeFcXv2MmTJqZhXSP0G8RyxtQ+aYYfLOxduefKQswjJz4ZEV2Jh0xBsO5+vYr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021322; c=relaxed/simple;
	bh=gDb3Qs4mn/ESkiDws5e7mffbyctci816Fv9yJ1y74cM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qbJDaKhQh8ZZ5CmFJU1oGYgCdj+rwigBDZaJAwpRrBVeKC8yBdyhlHzDBwCe/Ck4Mqryyj4Dovznx8EG/xRKkFm8sRov21jlowfR1hGwZQ80wFXUwtgNmv9qCr2kHqc87J84CI4PciOHgMdIRjeKRMuKngbbwYuQNqOy/QpmG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vZENe6dX; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b4TVAimaH1L71yw0d948itY0oBJyD19kcO/d3tITGqY=;
	b=vZENe6dXFIzYBwhWEJXSQ0XHQx6cjaWHXipTXXDfcHiAnZIsXANSW+iolxdBnCbo4ZsiR7Tqg
	aEKLAf5H+no+9Cc/yGE/mdA35Mfngpy/hla3ikZnYX7MsgVXl8K8E87nvk7XDzG2YaicNWB2dwa
	WmRaak2RixM8U8ku5l5P+r8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gztzK6Ktcz1T4HL;
	Tue, 14 Jul 2026 17:19:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 240F0203B8;
	Tue, 14 Jul 2026 17:28:19 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 17:28:18 +0800
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 17:28:18 +0800
Subject: Re: [PATCH -next] ima: add cond_resched() in ima_calc_file_hash_tfm
 loop
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, <lujialin4@huawei.com>,
	<zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>
References: <20260713111022.2418849-1-cuigaosheng1@huawei.com>
 <8c757ecb48c7dd733eb10c3927e9db94cb056fb0.camel@huaweicloud.com>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <a4368b90-6efc-cf42-0d0d-1a97713b1ade@huawei.com>
Date: Tue, 14 Jul 2026 17:28:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8c757ecb48c7dd733eb10c3927e9db94cb056fb0.camel@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500013.china.huawei.com (7.202.195.103)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:mid,huawei.com:email,huawei.com:dkim];
	TAGGED_FROM(0.00)[bounces-9938-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:lujialin4@huawei.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cuigaosheng1@huawei.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huaweicloud.com,huawei.com,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuigaosheng1@huawei.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60853752DCF

On 2026/7/13 20:06, Roberto Sassu wrote:
> On Mon, 2026-07-13 at 11:10 +0000, Gaosheng Cui wrote:
>> When hashing large files, the while loop in ima_calc_file_hash_tfm
>> processes PAGE_SIZE chunks without any scheduling point, which can
>> cause soft lockup warnings:
>> watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
>> Call Trace:
>>    _sha256_update+0x12d/0x1a0
>>    ima_calc_file_hash_tfm+0xfb/0x150
>>    ima_calc_file_hash+0x6e/0x160
>>    ima_collect_measurement+0x202/0x340
>>    process_measurement+0x3a9/0xb30
>>    ima_file_check+0x56/0xa0
>>    do_open+0x11b/0x250
>>    path_openat+0x10b/0x1d0
>>    do_filp_open+0xa9/0x150
>>    do_sys_openat2+0x223/0x2a0
>>    __x64_sys_openat+0x54/0xa0
>>    do_syscall_64+0x59/0x110
>>    entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>
>> Add cond_resched() at the end of each loop iteration to voluntarily
>> yield the CPU when needed.
>>
>> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   security/integrity/ima/ima_crypto.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
>> index 0d72b48249ee..3b7d41a9fd18 100644
>> --- a/security/integrity/ima/ima_crypto.c
>> +++ b/security/integrity/ima/ima_crypto.c
>> @@ -233,6 +233,8 @@ static int ima_calc_file_hash_tfm(struct file *file,
>>   		rc = crypto_shash_update(shash, rbuf, rbuf_len);
>>   		if (rc)
>>   			break;
>> +
>> +		cond_resched();
> I would recommend not doing at every loop but every 4 MB at least:
>
> if (IS_ALIGNED(offset, SZ_4M))
>          cond_resched();
>
> Thanks
>
> Roberto

Thanks,

I've updated to patch v2，call cond_resched() every 4MB.

>>   	}
>>   	kfree(rbuf);
>>   out:
> .

