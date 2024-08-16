Return-Path: <linux-integrity+bounces-3336-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A01955138
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 21:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742521F23573
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881451C37BE;
	Fri, 16 Aug 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sH5VjGp2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD21C0DC5;
	Fri, 16 Aug 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835475; cv=none; b=nZkNEurnZVe3Uo8u99nBynam+2tZrWbEpGbVTHIwZ7hwpInAg3Rw7v+qxzkKXjsLGur+/oL/p0wsIfBlA3T7ticqDla50EbYW1UvqviuN1ws7IimxpNNOlX3mCTDvjwrO/BmX++z8OkAoW3s2vouuTT78ijaWK3XL8Az427PRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835475; c=relaxed/simple;
	bh=XMP5kYN/lNCxS08FM9q5A+YLKatBEUnyJVgLnMAWigI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ffao0JFz+qVvr8u6vI2y1mcWMhfnZrzDiuSAw4ww9hsHUN5rKCRP/d438ez7ZdTzyVb4NkObA5PYdHge3g7Q7M1dcuBh7XpYfEAT8Z1hfL0fSCzHA0DtrHWqU8DPBwz82m5TesWTWvCbXz7CcGyd+kk4jeJwLnCTX2P8IMTU5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sH5VjGp2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7078920B7165;
	Fri, 16 Aug 2024 12:11:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7078920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723835473;
	bh=DINdXw4rsRHscph2P2mh0jmv8tgdSIjxLG+8b1MLgBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sH5VjGp2yrjvCTHmfalgwmnYuUqubfq/VnipazfpCj58DUEY9PO9gEFZDibvnAIIL
	 RykxOtSBbRmQ2LY5/Q6gBtiUDG5Ini9yIjRJtKx3zWxpqcj8KmpvWVMcYlv9YI4P/B
	 UeSob/5uozqhsV8PZW3vnPLGLsAQFCxQZW0CSEa8=
Message-ID: <ac6e33b8-ec1f-494a-874f-9a16d3316fce@linux.microsoft.com>
Date: Fri, 16 Aug 2024 12:11:12 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and
 signature data to LSMs
To: Mikulas Patocka <mpatocka@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com>
 <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
 <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
 <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/2024 6:35 AM, Mikulas Patocka wrote:
> 
> 
> On Thu, 15 Aug 2024, Paul Moore wrote:
> 
>> On Thu, Aug 8, 2024 at 6:38 PM Fan Wu <wufan@linux.microsoft.com> wrote:
>>>
>>> Hi Mikulas,
>>>
>>> I hope you’re doing well. I wanted to thank you again for your thorough
>>> review for the last version. I’ve since made some minor updates for this
>>> version, including adding more comments and refactoring the way the hash
>>> algorithm name is obtained due to recent changes in dm-verity.
>>>
>>> Would you mind if we keep the Review-by tag on the latest version since
>>> the changes are minor? Your feedback is greatly valued, and I’d
>>> appreciate it if you could take a quick look when you have a moment.
>>
>> To add a bit more to this, this patchset now looks like it is in a
>> state where we would like to merge it into the LSM tree for the
>> upcoming merge window, but I would really like to make sure that the
>> device-mapper folks are okay with these changes; an
>> Acked-by/Reviewed-by on this patch would be appreciated, assuming you
>> are still okay with this patch.
>>
>> For those who may be missing the context, the full patchset can be
>> found on lore at the link below:
>>
>> https://lore.kernel.org/linux-security-module/1722665314-21156-1-git-send-email-wufan@linux.microsoft.com
> 
> Hi
> 
> I'm not an expert in Linux security subsystems. I skimmed through the
> dm-verity patch, didn't find anything wrong with it, so you can add
> 
> Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
>

Thank you for reviewing the patch and for your suggestion.

>>>>
>>>> +#ifdef CONFIG_SECURITY
>>>> +     u8 *root_digest_sig;    /* signature of the root digest */
>>>> +#endif /* CONFIG_SECURITY */
>>>>        unsigned int salt_size;
>>>>        sector_t data_start;    /* data offset in 512-byte sectors */
>>>>        sector_t hash_start;    /* hash start in blocks */
>>>> @@ -58,6 +61,9 @@ struct dm_verity {
>>>>        bool hash_failed:1;     /* set if hash of any block failed */
>>>>        bool use_bh_wq:1;       /* try to verify in BH wq before normal work-queue */
>>>>        unsigned int digest_size;       /* digest size for the current hash algorithm */
>>>> +#ifdef CONFIG_SECURITY
>>>> +     unsigned int sig_size;  /* root digest signature size */
>>>> +#endif /* CONFIG_SECURITY */
>>>>        unsigned int hash_reqsize; /* the size of temporary space for crypto */
>>>>        enum verity_mode mode;  /* mode for handling verification errors */
>>>>        unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
> 
> Just nit-picking: I would move "unsigned int sig_size" up, after "u8
> *root_digest_sig" entry.
> 
> Mikulas

Sure, I can make these two fields together.

-Fan

