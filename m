Return-Path: <linux-integrity+bounces-7540-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2DC133BC
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 08:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F3423E64
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 07:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF5221DAE;
	Tue, 28 Oct 2025 07:04:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418717BA6
	for <linux-integrity@vger.kernel.org>; Tue, 28 Oct 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635052; cv=none; b=K70xyA3OxYPdyCqyv0qyLv3BmbUvQBrjb2eE41NsAabK8kNGbqKw7sCeaC81jAA62zTqOiLQOv+XWjFF/joVD3KMS1V7R390kyEZZh1D/RqIlIgKTbWU8T1yB/1+JwGSLDZc3UhAixPYRaEvB0R6iT99MYmpmhLbQZJANaa7SsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635052; c=relaxed/simple;
	bh=gKJXGUDHhlGGKZfRNYSTnr+8Eb3KMdSmndKsqs4e0YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GPE8DKKKr0iBzi99nKege31uDc5WS6yH37UvCRHl8fI5ODRbyLiaTJ9WhlYsSGoS5ChEPWBHJ0sih3qr8/s4B5UPNqcvjgkKd3FO9eIp6gaXlJYnf3aOhM3wCsiGR8ZU4FgkCHb1Y5cIxMRqyQfZ4/WjuqY0tp0SskxPYdwkSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1vDdkG-0001Lk-BI; Tue, 28 Oct 2025 08:03:52 +0100
Message-ID: <3e1da766-7b1a-4b35-a1bd-45ff735c3cec@pengutronix.de>
Date: Tue, 28 Oct 2025 08:03:45 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
To: yebin <yebin@huaweicloud.com>, kernel@pengutronix.de,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 yebin10@huawei.com, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
References: <20251024061153.61470-1-yebin@huaweicloud.com>
 <68FB2470.4000206@huaweicloud.com>
 <85aca6f9-f279-4977-8888-416af127edac@pengutronix.de>
 <69002CFA.2040701@huaweicloud.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <69002CFA.2040701@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org

Hi,

On 10/28/25 3:39 AM, yebin wrote:
> 
> 
> On 2025/10/24 16:10, Ahmad Fatoum wrote:
>> Hello,
>>
>> On 10/24/25 9:02 AM, yebin wrote:
>>> Ignore this patch as 275a9a3f9b6a（“KEYS: trusted: Pass argument by
>>> pointer in dump_options”）already fix this issue.
>>
>> What tree are you looking at? I can't find this commit in my git and the
>> code you are purportedly patching never existed upstream.
>>
>> If you run into issues exclusive to a vendor fork, you need to submit
>> your patches to the vendor. The upstream mailing lists are for upstream.
>>
> This patch was submitted by Herbert Xu and is on linux-next.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> commit 275a9a3f9b6a2158bfb7826074b72d5bdfb2ac35
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Tue Oct 21 12:07:56 2025 +0800
> 
>     KEYS: trusted: Pass argument by pointer in dump_options
> 
>     Instead of passing pkey_info into dump_options by value, using a
>     pointer instead.
> 
>     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks for the clarification. The maintainers for trusted keys were
unfortunately not Cc'd on that submission, so it flew at least under my
radar. :/

Cheers,
Ahmad

> 
> 
>> Thanks,
>> Ahmad
>>
>>>
>>> On 2025/10/24 14:11, Ye Bin wrote:
>>>> From: Ye Bin <yebin10@huawei.com>
>>>>
>>>> There's issue as follows:
>>>> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
>>>> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of
>>>> passing struct with a flexible array member has changed in GCC 4.4
>>>>      37 | static inline void dump_options(struct caam_pkey_info
>>>> pkey_info)
>>>>         |                    ^~~~~~~~~~~~
>>>>
>>>> To solve the above problem, pass 'struct caam_pkey_info*' type
>>>> parameter
>>>> to the dump_options() function.
>>>>
>>>> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>> ---
>>>>    security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/
>>>> keys/trusted-keys/trusted_caam.c
>>>> index 090099d1b04d..dd7a69bcf6a3 100644
>>>> --- a/security/keys/trusted-keys/trusted_caam.c
>>>> +++ b/security/keys/trusted-keys/trusted_caam.c
>>>> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>>>>    };
>>>>
>>>>    #ifdef CAAM_DEBUG
>>>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>>>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>>>    {
>>>> -    pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
>>>> +    pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>>>>    }
>>>>    #else
>>>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>>>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>>>    {
>>>>    }
>>>>    #endif
>>>> @@ -108,7 +108,7 @@ static int trusted_caam_seal(struct
>>>> trusted_key_payload *p, char *datablob)
>>>>            ret = get_pkey_options(datablob, &info.pkey_info);
>>>>            if (ret < 0)
>>>>                return 0;
>>>> -        dump_options(info.pkey_info);
>>>> +        dump_options(&info.pkey_info);
>>>>        }
>>>>
>>>>        ret = caam_encap_blob(blobifier, &info);
>>>> @@ -140,7 +140,7 @@ static int trusted_caam_unseal(struct
>>>> trusted_key_payload *p, char *datablob)
>>>>            ret = get_pkey_options(datablob, &info.pkey_info);
>>>>            if (ret < 0)
>>>>                return 0;
>>>> -        dump_options(info.pkey_info);
>>>> +        dump_options(&info.pkey_info);
>>>>
>>>>            p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
>>>>            memcpy(p->key, &info.pkey_info, sizeof(struct
>>>> caam_pkey_info));
>>>>
>>>
>>>
>>
> 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


