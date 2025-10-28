Return-Path: <linux-integrity+bounces-7537-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A1C12AEC
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CD875002A3
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40127145F;
	Tue, 28 Oct 2025 02:40:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758D271A6D;
	Tue, 28 Oct 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619209; cv=none; b=WtgTolpUO9GFi8gWMFVOSxE8SvCKgW8GP7jqSL14hiMlhGrCRwyvThnZ8QuLPjuESw2Z2qLk9/CVyr3gqZxippdxpEunhtW7CrVwufEM1p8QfokefU2o6vdlzFa57Rt7Qxlv38vzxusrzxge6/NWOFF5a67nRoBNm056Ja0Y/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619209; c=relaxed/simple;
	bh=Up3exb/hVI8G18iQaHfwEvY00r+Q3JlvAR1nJxnhQoM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tuy9mKsElGjD58RokD1L0XVoMvB8nwL5CGxl/4vBxir7ttnpKFFVtp1B9Bc+tF2uR7ilCugWKDCIJaBFqiAilEdBoxOxTY90/XN1VVoLMNuO69FvuRNgki0wHtClDlTjF3xZC2luT+4CL4l35nP78u3oKL9x+QxZTJXOA+VuPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cwZNC0gwlzYQtHg;
	Tue, 28 Oct 2025 10:39:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C99901A0930;
	Tue, 28 Oct 2025 10:39:57 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgCHK0T6LABpmqptBw--.52862S3;
	Tue, 28 Oct 2025 10:39:55 +0800 (CST)
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, kernel@pengutronix.de,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 yebin10@huawei.com
References: <20251024061153.61470-1-yebin@huaweicloud.com>
 <68FB2470.4000206@huaweicloud.com>
 <85aca6f9-f279-4977-8888-416af127edac@pengutronix.de>
From: yebin <yebin@huaweicloud.com>
Message-ID: <69002CFA.2040701@huaweicloud.com>
Date: Tue, 28 Oct 2025 10:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85aca6f9-f279-4977-8888-416af127edac@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHK0T6LABpmqptBw--.52862S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xAF4DWrW7GFWUur1Utrb_yoW5KF1Dpa
	1DCFyjqFW8tF9rC3yjgrn2kF1Skws0gFy7Ww4DtayjqFnxtry7ZFyUur45ur17ZFyIgryj
	vFyUZr1S9a4DCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/10/24 16:10, Ahmad Fatoum wrote:
> Hello,
>
> On 10/24/25 9:02 AM, yebin wrote:
>> Ignore this patch as 275a9a3f9b6a（“KEYS: trusted: Pass argument by
>> pointer in dump_options”）already fix this issue.
>
> What tree are you looking at? I can't find this commit in my git and the
> code you are purportedly patching never existed upstream.
>
> If you run into issues exclusive to a vendor fork, you need to submit
> your patches to the vendor. The upstream mailing lists are for upstream.
>
This patch was submitted by Herbert Xu and is on linux-next.

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
commit 275a9a3f9b6a2158bfb7826074b72d5bdfb2ac35
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Oct 21 12:07:56 2025 +0800

     KEYS: trusted: Pass argument by pointer in dump_options

     Instead of passing pkey_info into dump_options by value, using a
     pointer instead.

     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>


> Thanks,
> Ahmad
>
>>
>> On 2025/10/24 14:11, Ye Bin wrote:
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> There's issue as follows:
>>> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
>>> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of
>>> passing struct with a flexible array member has changed in GCC 4.4
>>>      37 | static inline void dump_options(struct caam_pkey_info pkey_info)
>>>         |                    ^~~~~~~~~~~~
>>>
>>> To solve the above problem, pass 'struct caam_pkey_info*' type parameter
>>> to the dump_options() function.
>>>
>>> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>    security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/
>>> keys/trusted-keys/trusted_caam.c
>>> index 090099d1b04d..dd7a69bcf6a3 100644
>>> --- a/security/keys/trusted-keys/trusted_caam.c
>>> +++ b/security/keys/trusted-keys/trusted_caam.c
>>> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>>>    };
>>>
>>>    #ifdef CAAM_DEBUG
>>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>>    {
>>> -    pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
>>> +    pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>>>    }
>>>    #else
>>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>>    {
>>>    }
>>>    #endif
>>> @@ -108,7 +108,7 @@ static int trusted_caam_seal(struct
>>> trusted_key_payload *p, char *datablob)
>>>            ret = get_pkey_options(datablob, &info.pkey_info);
>>>            if (ret < 0)
>>>                return 0;
>>> -        dump_options(info.pkey_info);
>>> +        dump_options(&info.pkey_info);
>>>        }
>>>
>>>        ret = caam_encap_blob(blobifier, &info);
>>> @@ -140,7 +140,7 @@ static int trusted_caam_unseal(struct
>>> trusted_key_payload *p, char *datablob)
>>>            ret = get_pkey_options(datablob, &info.pkey_info);
>>>            if (ret < 0)
>>>                return 0;
>>> -        dump_options(info.pkey_info);
>>> +        dump_options(&info.pkey_info);
>>>
>>>            p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
>>>            memcpy(p->key, &info.pkey_info, sizeof(struct caam_pkey_info));
>>>
>>
>>
>


