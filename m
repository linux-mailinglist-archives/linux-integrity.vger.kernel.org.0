Return-Path: <linux-integrity+bounces-3361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA1957257
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A446BB23434
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54D18787E;
	Mon, 19 Aug 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fYyF7sjJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAB482EB;
	Mon, 19 Aug 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089623; cv=none; b=m2J2VG3SBl1t8bRL9i3ouqO3Cpj3loHFjQHIlynrmX8rFqMs0QWhTK2teXd8+B5H+t6sVgxx5jRDXmGtcGwljFSQKD4DuT9iUpVY41q1cgrosyjsC9o+JPdfi64m3RAGG4Z+kUly0CHIZSH5ZBwuITP2CqBGr//NJ2U0O6bDICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089623; c=relaxed/simple;
	bh=O/u/0h4UDWXzTlG+fyAEIwqdpcRuWTE+gYKDPyVqXGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVUVV/sFbvDv3GbOLaViNMz2spWguXn3Xbiyp6Cje6aYUfBHGiSTLqIz/HWqsdGgf/2QSWEEfqGTkjqpLxjO2eMCw0WYg6TKC0afz+PbsqFRj0FEVqAYmJ+2N4M1NROylJUwPeG3MmsgJ2iPRSI3OrcrkqfmOFc7Rt5M1fbgp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fYyF7sjJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id A692F20B7165;
	Mon, 19 Aug 2024 10:47:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A692F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724089621;
	bh=/Fg+0/px+hqNYUUfsmTiu8GgatTWcJCL0lwQFJVQ/tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fYyF7sjJlyEoM0JAIp8iI+WSf7amJf7ETBZwTv6JAFSIU+FKmhSsw4HNzrhAYxlT4
	 A5vyAPdyo2uFW5TfPI/HoeyeIVBWMk7SzosB2aa+PakJwYBTQzHf3wFXB4SYdLGd6N
	 AUz5EsqW9VbFKhs/h6K9lmyUTJIROMLqTNlh8tQw=
Message-ID: <8421b247-41d2-4bf5-ba80-f356a2b696fd@linux.microsoft.com>
Date: Mon, 19 Aug 2024 10:47:01 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and
 signature data to LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com>
 <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
 <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
 <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com>
 <ac6e33b8-ec1f-494a-874f-9a16d3316fce@linux.microsoft.com>
 <CAHC9VhSe0HkzX0gy5Oo+549wG9xqfeHmsveJqdR_xRcYtim+sA@mail.gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <CAHC9VhSe0HkzX0gy5Oo+549wG9xqfeHmsveJqdR_xRcYtim+sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/2024 10:22 AM, Paul Moore wrote:
> On Fri, Aug 16, 2024 at 3:11 PM Fan Wu <wufan@linux.microsoft.com> wrote:
>> On 8/16/2024 6:35 AM, Mikulas Patocka wrote:
> 
> ...
> 
>>>>>>
>>>>>> +#ifdef CONFIG_SECURITY
>>>>>> +     u8 *root_digest_sig;    /* signature of the root digest */
>>>>>> +#endif /* CONFIG_SECURITY */
>>>>>>         unsigned int salt_size;
>>>>>>         sector_t data_start;    /* data offset in 512-byte sectors */
>>>>>>         sector_t hash_start;    /* hash start in blocks */
>>>>>> @@ -58,6 +61,9 @@ struct dm_verity {
>>>>>>         bool hash_failed:1;     /* set if hash of any block failed */
>>>>>>         bool use_bh_wq:1;       /* try to verify in BH wq before normal work-queue */
>>>>>>         unsigned int digest_size;       /* digest size for the current hash algorithm */
>>>>>> +#ifdef CONFIG_SECURITY
>>>>>> +     unsigned int sig_size;  /* root digest signature size */
>>>>>> +#endif /* CONFIG_SECURITY */
>>>>>>         unsigned int hash_reqsize; /* the size of temporary space for crypto */
>>>>>>         enum verity_mode mode;  /* mode for handling verification errors */
>>>>>>         unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
>>>
>>> Just nit-picking: I would move "unsigned int sig_size" up, after "u8
>>> *root_digest_sig" entry.
>>>
>>> Mikulas
>>
>> Sure, I can make these two fields together.
> 
> Fan, do you want me to move the @sig_size field when merging or are
> you planning to submit another revision?  I'm happy to do it during
> the merge, but I don't want to bother if you are going to post another
> patchset.
> 

Thanks, Paul. It seems moving the field during the merge can expedite 
the process. Please go ahead with that. I appreciate your help with this!

-Fan

