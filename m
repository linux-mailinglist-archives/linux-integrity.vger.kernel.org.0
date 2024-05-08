Return-Path: <linux-integrity+bounces-2353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F988C075A
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 00:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792011F239FB
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47D241E7;
	Wed,  8 May 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OQn9AT8g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A615E88;
	Wed,  8 May 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207416; cv=none; b=m0bppicqogg4h+dKioyasG/QR//kVUKXpKnMwzE9wmSRjUpXzN/v44Z5BstztCsVxr4/azASJj6q/AWo3uyQpBGZ1kVVCqw5VrTHuG+hEAZQJ54diDVJN+mUSDDCUys2Cx3RhFPPG6t+MMNfOdoGjeo5RgV4YKNSCvYwZDFh528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207416; c=relaxed/simple;
	bh=jfeLTHQ7V+tCqtymgqJlwOAfeOURmxDxjCflu8nkTEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ew+zAFcD1+A/SybQg/pNhhOuC6HZD5+itj0YmEVK9m7Ql8waBqOIGXLa7QbWN/DdXJ+AfM3iqAwamxKMl0+o/CV/TbjRL5ZnmpvGmikwf2vRfn3kJy8sA0ogQd50VjLsxMYtt9GOUju6vfDW7eb1gs6dluzwBwtvI4RR5LuZHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OQn9AT8g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id C10B42083CB3;
	Wed,  8 May 2024 15:30:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C10B42083CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715207414;
	bh=O39rDdpiO7kqlQ1I2DZU4uxK3DPuYhyDQeOss37ivQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OQn9AT8gEUZm1+BKeo83wexh4Z3f5It6vRhh7Pzqr+2y0WTUnuH/E7sqiAHVHeEL+
	 9XhkVv8JsB+7owD+m+wLhaQu1OV5XajkEcsn4jOkJzoZWmVZ0k69t5uJonoPcXpT9o
	 lDsC/EkVaH0XrDBb0zgwyEVgoCmSC44jslo29LI4=
Message-ID: <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
Date: Wed, 8 May 2024 15:30:14 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/21] dm: add finalize hook to target_type
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
 linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com>
 <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/2024 10:17 AM, Mikulas Patocka wrote:
> 
> 
> On Fri, 3 May 2024, Fan Wu wrote:
> 
>> This patch adds a target finalize hook.
>>
>> The hook is triggered just before activating an inactive table of a
>> mapped device. If it returns an error the __bind get cancelled.
>>
>> The dm-verity target will use this hook to attach the dm-verity's
>> roothash metadata to the block_device struct of the mapped device.
>>
>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> Hi
> 
> Why not use the preresume callback?
> 
> Is there some reason why do we need a new callback instead of using the
> existing one?
> 
> Mikulas
Thanks for the suggestion.

Mike suggested the new finalize() callback. I think the reason for not 
using the preresume() callback is that there are multiple points that 
can fail before activating an inactive table of a mapped device which 
can potentially lead to inconsistent state.

In our specific case, we are trying to associate dm-verity's roothash 
metadata with the block_device struct of the mapped device inside the 
callback.

If we use the preresume() callback for the work and an error occurs 
between the callback and the table activation, this leave the 
block_device struct in an inconsistent state.

This is because now the block device contains the roothash metadata of 
it's inactive table due to the preresume() callback, but the activation 
failed so the mapped device is still using the old table.

The new finalize() callback guarantees that the callback happens just 
before the table activation, thus avoiding the inconsistency.

-Fan

