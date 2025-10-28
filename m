Return-Path: <linux-integrity+bounces-7538-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFABC12AF5
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 03:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18ED74E9837
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49C270542;
	Tue, 28 Oct 2025 02:42:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15690F50F;
	Tue, 28 Oct 2025 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619323; cv=none; b=fXDezob7U+ZtRPFih4VOH0r+DX65Iq+QirJozCwoo4ZzsNtEQh8GtTQ7MMRzM94F8P3zXULWkbFvFruu7Mpjy8QVoLK+t8eZLyIexDRk3BJ6v59M+mW0McyhPJi34B+bdxsQt4kH4hv3exC52OJxmW+O7sba43LPTgFB2iD9dlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619323; c=relaxed/simple;
	bh=KcFH18GmIKZGGZoTubLhxbTNRmUD+KGx5g5hz3E+Gmk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vf6guzOSd3IUp6CvnGiGkFb/f7BA8QEZnFsAqkTzwOzWyyXchHpkOjeQwHh+o5IJIo1LP5bYz8/loh5+LZ+UfCpKKQCSK2uSotq2K2Qr4am00ORo6eO5XmJSPHSjlP6w1Vu2/DZaNvBYl1hmQ6DSV5deuR6ssl2Tud+6wODTuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cwZPL43CRzKHMMf;
	Tue, 28 Oct 2025 10:40:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 98EDE1A018D;
	Tue, 28 Oct 2025 10:41:50 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgBXrERsLQBp2dBtBw--.4806S3;
	Tue, 28 Oct 2025 10:41:48 +0800 (CST)
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20251024061153.61470-1-yebin@huaweicloud.com>
 <aP_QWHPHpGr-nUZD@kernel.org>
Cc: a.fatoum@pengutronix.de, kernel@pengutronix.de,
 James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
 dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <69002D6C.8050403@huaweicloud.com>
Date: Tue, 28 Oct 2025 10:41:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aP_QWHPHpGr-nUZD@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXrERsLQBp2dBtBw--.4806S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kCr4rCrWfGF4fAFyDGFg_yoW8uFWxpa
	15CFyj9FW8tF9Fg3yDGrZ7CF1ak398KFW7CwsxKa42gFnxJryUJFyj9F45ur13ZFyIgryj
	vay8Zr1Yg39F9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/10/28 4:04, Jarkko Sakkinen wrote:
> On Fri, Oct 24, 2025 at 02:11:53PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
>> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of passing struct with a flexible array member has changed in GCC 4.4
>>     37 | static inline void dump_options(struct caam_pkey_info pkey_info)
>>        |                    ^~~~~~~~~~~~
>>
>> To solve the above problem, pass 'struct caam_pkey_info*' type parameter
>> to the dump_options() function.
>>
>> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
>> index 090099d1b04d..dd7a69bcf6a3 100644
>> --- a/security/keys/trusted-keys/trusted_caam.c
>> +++ b/security/keys/trusted-keys/trusted_caam.c
>> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>>   };
>>
>>   #ifdef CAAM_DEBUG
>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>   {
>> -	pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
>> +	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>>   }
>>   #else
>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>   {
>>   }
>>   #endif
>
> Please fix the broken design while at it:
>
> 1. Remove the ad-hoc compilation flag (i.e., CAAM_DEBUG).
> 2. Substitute pr_info calls with pr_debug calls.
>
Alright, I'll fix the two points you mentioned.

> Then you can turn then on and off either dynamically, or alternatively
> from the kernel command-line [1].
>
> [1] https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>
> BR, Jarkko
>


