Return-Path: <linux-integrity+bounces-3700-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5EC9854EF
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891851F23A03
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0A148849;
	Wed, 25 Sep 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f23c+ti3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D9158D87;
	Wed, 25 Sep 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251391; cv=none; b=VQKel7j2Dv9xLvEe91ffN1ajNEo+UVlYU7vLKW8tn6p9IbANSgn3+skrvWBQlZgzxzOr72krdp0E/oDbkFE7cNfOyn6Oc6XdQU98STYp/azjwBvYC9DoVH8Vx8gXhzp5TNdqgWLn65h6j2Z6NirqQSFn8YScyuDg7lr7G1l/NZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251391; c=relaxed/simple;
	bh=+EZahcUF7Rql3wSvG7GZ/C586EekoorIercm2fv4YeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwwPSAeos64HnZRSz4znKNT+9VW1bKLTdxC90zltQ2DUXFTevOHitmHbEU/4niNvA4zpWii/UYfi0C+VM6ocQ7snzwbPlmHwfVE9fFZB6vjTZl/4a2fU1HNlDTVkljjGCsXHNj7Fa4fvXtcJoQ1tZAdf9znrdMT9ZJcS2sud0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f23c+ti3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so53437565e9.0;
        Wed, 25 Sep 2024 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727251388; x=1727856188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5IQaPS25TirzTFjDUvMy237jsFYdDj73HTyBN3YC55s=;
        b=f23c+ti3WnfvTYb7SQu+vyN66R2cBp8rl4iTm7NfV0HIuRqY0kAY7uon8pUWGPfStl
         v4HXiqpdYaYUE25RGBSwmS+67z2vqgxiIbqcrLpINeOidM1rS77Y9Zw6fg3DTEjPtZmF
         WQNDfAFg4GII6f+7eQnxchZ166GBCwLdpX5fEfUv3J1YgCli3sONdvqVY4skvya+ojDh
         Jg3v7jvchS96SjfGgxn0xjJzMUckUe6/507LBGRksbv3RCytes5ae9AxajQjbV3jLhVG
         /a/tn1WpOSAu7ibXq3Uag8wAnIYZxZ0bFS0OzNOFSH7sEOs0OJ9Gy+ApKive73PBvJ+n
         bd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251388; x=1727856188;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IQaPS25TirzTFjDUvMy237jsFYdDj73HTyBN3YC55s=;
        b=rCzMxM1I8EaGX1IEhrXaJ95CO5QZzlojf9cAZrudNHISLPhpk/0ygqQhwbmxiNe9GL
         5+6emky1/keKp6nbbZVSEWAbRMH82xX5+2ja4r9CA8Egq/LTvTosXaHV1K8Bj3uTlgMZ
         g5Y7EoQa2xPEVokaUC6GFsMA1amNd8ZFzpae3IqHXLlV/ZFYYPvNJEyxu9B+W/Gwg5iO
         yqzcDZ/A8MB8mYvjXX38tRZ5r6Z9Rzz3SA5vS2uVHuSyFoYYtNHKDHBuxu34nQ8iCqop
         L6U+e8aydqRtyVzKVmUq2hWbiYOCE87wATytm8/JGcwHOaJzV79rIyD/ndOcoqvA2VX3
         jCgA==
X-Forwarded-Encrypted: i=1; AJvYcCUx6LqVpqp2BhYanN+oMH8uK0EjEn/OZxR4ftK8Rqo7G1QMWR2FIKqRcDevcR9a1pa897zo2rseBdcpBmE+WPtW@vger.kernel.org, AJvYcCXW1FhgF0H1mJoJBhl8QIOgTje793b3IUJQN7zXua2Nh+Zma5dMJNEo6snSoft9dd1/TisSFs4BAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxdB/dT9VsFyR3F8yoCrjEMrZPxnpF1TIwHhYX8cBz8dCa0Frb
	wLlQ3wt8r9iZxjED/9wJkFyVUgChqz64KGOYmKemga6ksPb4+jhd
X-Google-Smtp-Source: AGHT+IEIdKjnFkaJ/wx+dZcalTm8g29PC3WzDiO34l29cvmjE5hM3zJJL6gEFiAKa9DPJqT8/vagkg==
X-Received: by 2002:a05:600c:3b17:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42e9610d332mr10762125e9.12.1727251387729;
        Wed, 25 Sep 2024 01:03:07 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f558sm3325024f8f.101.2024.09.25.01.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 01:03:07 -0700 (PDT)
Message-ID: <df791a04-feae-4708-865f-193360b35fad@gmail.com>
Date: Wed, 25 Sep 2024 10:03:06 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
To: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, luca.boccassi@gmail.com,
 dm-devel@lists.linux.dev, snitzer@kernel.org, serge@hallyn.com,
 wufan@linux.microsoft.com, David Howells <dhowells@redhat.com>,
 keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20240924215910.GA1585@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 11:59 PM, Eric Biggers wrote:
> On Wed, Sep 25, 2024 at 12:36:01AM +0300, Jarkko Sakkinen wrote:
>> On Tue Sep 24, 2024 at 9:27 PM EEST, Mikulas Patocka wrote:
>>>
>>>
>>> On Tue, 24 Sep 2024, Jarkko Sakkinen wrote:
>>>
>>>> On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
>>>>>
>>>>>
>>>>> On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
>>>>>
>>>>>> From: Luca Boccassi <bluca@debian.org>
>>>>>>
>>>>>> If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
>>>>>> the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
>>>>>> reasons, such as usage restrictions, we do not fallback. Do so.
>>>>>>
>>>>>> Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
>>>>>>
>>>>>> Suggested-by: Serge Hallyn <serge@hallyn.com>
>>>>>> Signed-off-by: Luca Boccassi <bluca@debian.org>
>>>>>
>>>>> Hi
>>>>>
>>>>> I'm not an expert in keyrings.
>>>>>
>>>>> I added keyring maintainers to the CC. Please review this patch and
>>>>> Ack/Nack it.
>>>>>
>>>>> Mikulas
>>>>>
>>>>>> ---
>>>>>>   drivers/md/dm-verity-verify-sig.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
>>>>>> index d351d7d39c60..a9e2c6c0a33c 100644
>>>>>> --- a/drivers/md/dm-verity-verify-sig.c
>>>>>> +++ b/drivers/md/dm-verity-verify-sig.c
>>>>>> @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>>>>>>   #endif
>>>>>>   				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
>>>>>>   #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
>>>>>> -	if (ret == -ENOKEY)
>>>>>> +	if (ret == -ENOKEY || ret == -EKEYREJECTED)
>>>>>>   		ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
>>>>>>   					sig_len,
>>>>>>   					VERIFY_USE_PLATFORM_KEYRING,
>>>>>> -- 
>>>>>> 2.39.5
>>>>>>
>>>>
>>>> I know nothing about dm-verity. What does it even do?
>>>>
>>>> BR, Jarkko
>>>
>>> dm-verity provides a read-only device with integrity checking. dm-verity
>>> stores hash for every block on the block device and checks the hash when
>>> reading the block. If the hash doesn't match, it can do one of these
>>> actions (depending on configuration):
>>> - return I/O error
>>> - try to correct the data using forward error correction
>>> - log the mismatch and do nothing
>>> - restart the machine
>>> - call panic()
>>>
>>> dm-verity is mostly used for the immutable system partition on Android
>>> phones. For more info, see
>>> Documentation/admin-guide/device-mapper/verity.rst
>>>
>>> The above patch changes the way that the signature of the root hash is
>>> verified. I have no clue whether the patch can or can't subvert system
>>> security, that's why I'd like to have some more reviews of the patch
>>> before accepting it.
>>
>> I guess someone who knows all this already should review it.
>>
>> Doesn't dm-verity have a maintainer?

(This reminds me of a nice comment from Neil about "little walled gardens" between MD & DM.
Apparently it applies to other subsystems as well. Sorry, I couldn't resist to mention it :-)

> This patch only affects dm-verity's in-kernel signature verification support,
> which has only been present since Linux v5.4 and is not used by Android or
> Chrome OS.  The whole feature seems weird to me, and it is prone to be misused;
> signatures are best verified by trusted userspace code instead (e.g. initramfs).
> But apparently there are people who use the dm-verity in-kernel signatures.  I
> think systemd has some support for it, as does the recently-upstreamed IPE LSM.
> I don't know what else.  The exact semantics of the "trusted" and "platform"
> keyrings are not entirely clear to me, but given that dm-verity already trusts
> keys from both keyrings this patch seems reasonable.  The people who actually
> use this feature are in the best position to make that call, though.

When we added support for this to veritysetup (--root-hash-signature), I think it was
a requirement from Microsoft.

Anyway, if you have a trusted key compiled-in the kernel in one keyring, I do not think
it would cause problems if stored in another.

But it scares me that we cannot easily test userspace for this in CI, as it requires compiling
own kernel with our own keys.

Do people use veritysetup (libcryptsetup) here, or does it run with its separate userspace tooling?

Milan


