Return-Path: <linux-integrity+bounces-6095-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F28AA5056
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E90B9E40BD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780152609E9;
	Wed, 30 Apr 2025 15:33:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747832609D0;
	Wed, 30 Apr 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027218; cv=none; b=FzrBFS48IILH+uGoJPs4obRnCOXy2ozcci241bMsJ7aJn1DOJXS3+m0WQCrufEkyqGNbppKnt4s696Wp6599aHOxG9K5MkqcMJEwhHZh6VZGWwDXKLLblpeferYVnv6e2nDTMCY9LRqXX19boMpJ9KUoPG7NSe7m6dJNgdPu2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027218; c=relaxed/simple;
	bh=Car0jrOm+0zbL2E7KRDTptURzHM1P0fYXPJMqsd8tqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ce7D9A59dd/8U3Fw7MA7dtAR5/RV+d97dWBBpU4ES1VUolYdZvP8pyI2xXDhGv8PNyXnaWlwZhHWRqFN4IUpUx/6C+54BFKw02QdIwUy8IU+pVHsPNB8PZwtvM3B+i3NBPqoA07IS0tVlvOXBiPwllS+CbjVZhyD6hhj6GoKCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58CE41063;
	Wed, 30 Apr 2025 08:33:28 -0700 (PDT)
Received: from [10.122.23.72] (unknown [10.122.23.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1153F5A1;
	Wed, 30 Apr 2025 08:33:35 -0700 (PDT)
Message-ID: <6c6c0cb8-3403-48d2-9ca8-31e5ad4ff0e8@arm.com>
Date: Wed, 30 Apr 2025 10:33:34 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tpm_crb: ffa_tpm: fix cut/paste error in comment
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, linux-kernel@vger.kernel.org
References: <20250429221519.1022170-1-stuart.yoder@arm.com>
 <aBJCeoapwgdaPONq@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <aBJCeoapwgdaPONq@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/25 10:32 AM, Jarkko Sakkinen wrote:
> On Tue, Apr 29, 2025 at 05:15:17PM -0500, Stuart Yoder wrote:
>> Fix the comment for the 'start' function, which was a cut/paste
>> mistake for a different function.
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb_ffa.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>> index 3169a87a56b60..65b01a46d4b88 100644
>> --- a/drivers/char/tpm/tpm_crb_ffa.c
>> +++ b/drivers/char/tpm/tpm_crb_ffa.c
>> @@ -68,7 +68,8 @@
>>   #define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
>>   
>>   /*
>> - * Return information on a given feature of the TPM service
>> + * Notifies the TPM service that a TPM command or TPM locality request is
>> + * ready to be processed, and allows the TPM service to process it.
>>    * Call register usage:
>>    * w3:    Not used (MBZ)
>>    * w4:    TPM service function ID, CRB_FFA_START
>> -- 
>> 2.34.1
>>
> 
> Can you squash the comment updates into single patch instead and
> enumerate the changes? Does not really serve any purpose because
> comments do not "run".

Sure, will do.

Thanks,
Stuart


