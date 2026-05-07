Return-Path: <linux-integrity+bounces-9474-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEZjIO0k/GnxLwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9474-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 07:36:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8798C4E3231
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 07:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E14301A39C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 05:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654C2D662F;
	Thu,  7 May 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7gXWzzg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A926159E;
	Thu,  7 May 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132202; cv=none; b=icymsX9dJAaoKflGq+4NjHi9No++m3OCvG7H+mh63s8FjNTv4YncCYB45PXX0S3Bt3rsbXefMJ4iV8aS7xIZu3gXJWb9L4IjO5BkIWI2KI6AEfKHmSmXjV3EvMOUxg108a3A8kJW2WVU0NxvhQeKRVMwHaLN79lpPO0cogHZC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132202; c=relaxed/simple;
	bh=qKNCaCSjeLPWUXik5JvshBm3Wdf54DU0UMiT3F1ONUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNJQpWFw9FU1LcFfj6GXqyLmgnUE8KdQS2oA3rpyN2nyIOmhxEvUhzQKTj9TCGLRW/o9mshXvUveExOrax2Q/pHjq02r+SoLfTQdbugSCrZ0N8x2+ANRayFih9nDolCLIg+o7ysivAh5mDCl4F5bhwp/SvtxWagBkMwxE6zXfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7gXWzzg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778132200; x=1809668200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qKNCaCSjeLPWUXik5JvshBm3Wdf54DU0UMiT3F1ONUI=;
  b=D7gXWzzgK5WFahNgfkJp04nldsCklXmJ/yP/ga4LnaHFmpj1XvTBN0rb
   G/W6rDauEjlShsG9rYKuf4cqh3+B70Wnv6o8rVPUAT6g60Le5mOOJBgXJ
   OOuid3JJ+x3b3Gdfj/kewoOeL+6lB2VE0HVEPiGzUTdo60EFhtnYnRC2R
   +SY/l1PG8LSPN489tm8NSwqjJIhB8vxz3gqDxW5cN/xkAEBL4rIvu+xn+
   DExaVLlVK9qxbMs7lDO9+T6tkpICN8xmSYjNPzRQnWFeXMOCLsnZuqzPs
   PoBHx710V5XnlVMWA33LN3lBGvDkBeRK0/zv6fEyUPOeevkLbrH1VP7+F
   A==;
X-CSE-ConnectionGUID: Rc4PoKYfTJKPV0bjPqeQNw==
X-CSE-MsgGUID: ROl4u1oITCeiV6z9THLcyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79090104"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79090104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 22:36:39 -0700
X-CSE-ConnectionGUID: b7zWSra/Q8u+B8B8L49raw==
X-CSE-MsgGUID: rOdEC6uAQq+wtsXRG0Nupw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="235361017"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 22:36:40 -0700
Received: from [10.238.128.208] (unknown [10.238.128.208])
	by linux.intel.com (Postfix) with ESMTP id A245720B5713;
	Wed,  6 May 2026 22:36:37 -0700 (PDT)
Message-ID: <46109c55-c85d-4c32-9f09-f3205495afe0@linux.intel.com>
Date: Thu, 7 May 2026 13:36:36 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: restore timeout for key creation commands
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Serge Hallyn <serge@hallyn.com>, Lili Li <lili.li@intel.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260421005021.13765-1-baoli.zhang@linux.intel.com>
 <afi3hrjLm36qPc_T@kernel.org>
Content-Language: en-US
From: "Zhang, Baoli" <baoli.zhang@linux.intel.com>
In-Reply-To: <afi3hrjLm36qPc_T@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8798C4E3231
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,hallyn.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9474-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoli.zhang@linux.intel.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action


On 5/4/2026 11:13 PM, Jarkko Sakkinen wrote:
> On Tue, Apr 21, 2026 at 08:50:20AM +0800, Baoli Zhang wrote:
>> From: "Baoli Zhang" <baoli.zhang@linux.intel.com>
>>
>> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
>> inadvertently reduced the timeout for TPM2 key creation commands
>> (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
>> seconds.
>>
>> This causes intermittent timeout failures, with several failures observed
>> across hundreds of test runs on some Intel platforms using Infineon
>> SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
>> avoid spurious failures.
> Is this a production case?
>
> I'm not sure if there is anything to fix tbh. I mean it is
> pretty much the same as "maintaining compatibility to OTT driver"
> to addresses issues on undisclosed hardware.
>
> Please correct me if I'm wrong. Otherwise, I'd carry out internal patch
> to tweak this for pre-production hardware (presumably).
Hi Jarkko, this is indeed a production case. We discovered this issue 
during validation testing for the sustaining release.
>> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
>> Co-developed-by: Lili Li <lili.li@intel.com>
>> Signed-off-by: Lili Li <lili.li@intel.com>
>> Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
>> ---
>> Changes in v2:
>> - Add description of intermittent nature of the timeout issue.
>> - Fix Co-developed-by and Signed-off-by tag ordering.
>>
>> v1: https://patchwork.kernel.org/project/linux-integrity/patch/20260410014940.3557934-1-baoli.zhang@linux.intel.com/
>>
>>   drivers/char/tpm/tpm2-cmd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 3a77be7ebf4aa..430022f695f24 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -71,9 +71,9 @@ static const struct {
>>   	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
>>   	{TPM2_CC_GET_CAPABILITY, 750},
>>   	{TPM2_CC_NV_READ, 2000},
>> -	{TPM2_CC_CREATE_PRIMARY, 30000},
>> -	{TPM2_CC_CREATE, 30000},
>> -	{TPM2_CC_CREATE_LOADED, 30000},
>> +	{TPM2_CC_CREATE_PRIMARY, 300000},
>> +	{TPM2_CC_CREATE, 300000},
>> +	{TPM2_CC_CREATE_LOADED, 300000},
>>   };
>>   
>>   /**
>> -- 
>> 2.43.0
>>
> BR, Jarkko

