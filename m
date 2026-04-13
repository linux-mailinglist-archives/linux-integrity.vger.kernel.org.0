Return-Path: <linux-integrity+bounces-9165-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFVwE2hH3GkCOwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9165-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 03:31:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A910B3E6A0F
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C60730094F3
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FFA1E260C;
	Mon, 13 Apr 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH9Nualt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0A1DE8AE;
	Mon, 13 Apr 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043876; cv=none; b=Yg/gW7x6jyf7dfnvYW4e9zs5eG/3Lg0mEMtqEHDKhXobmR+Btkz+byvDlMkku0p5dwtPT1ASTup6JS68H3ayh+dE4MokL09UqNgSadLrmTftWpYyVRew3wW4pqNDXR9N66zhZKivBqkaJhQoe+Hp9JjSOnYAf3znif7OtdPqrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043876; c=relaxed/simple;
	bh=dDKDOM59cCk/1shKzJFfyamyVDVcu+sdjTO3bNQaDb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYvFeaLPnrSOoTl6dlcSy53Fx5k2EoNpj/uIPgwyiRWGTG5cgGb40e+rFq2LfMJ5W3h35+hmWj9ythEhoVmFKwWxviXRQ5UuLX63rN7G6XsVJtaFCdPXHeKiZYGs0Yvy7K3q0QbhowR/Zr4E8FFHFZA5AWXLoPL/8ZoUrcm0HD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SH9Nualt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776043875; x=1807579875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dDKDOM59cCk/1shKzJFfyamyVDVcu+sdjTO3bNQaDb8=;
  b=SH9NualtCWf/h22TGC/usJjR5QaVmAm2JBdACr1+dDnO5oz6g5HhpWYg
   O9dDZQiOoPbezqluUuS7oYi1ngz8NBIdXr+q+Gq86+Kkw97XzmUjC5wZD
   ZikgbOMP+LxwN1OSdeKw5jIQvOl1Ag9wZA7J3r5U38Lf7MD/5If288myw
   HdxWuQ+vUJDH+PylebtIwKF2S6IgbOtzIjmsBQjZZi+aaeWZ+XavHX01P
   /klNokSTTNupt2LlTgnGHC3EQlD6JuOKIdd2Iaa2/UG3dOgCdHWqXQKu+
   wtfnuxkjd++CIjt6hsObOL5hsfJEMZCDqEpGVgs9lXASYiGeuSBnuUoE4
   Q==;
X-CSE-ConnectionGUID: E/n/6oIMSTiIpgoXLvu7Fw==
X-CSE-MsgGUID: 2lvp0byESheFP1Sxf7fykA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="79556109"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="79556109"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:31:14 -0700
X-CSE-ConnectionGUID: O8ks1XYJTGWYEwrCWXcQIA==
X-CSE-MsgGUID: hiD6Puk7QHy9dwUvsPATYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="225363459"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:31:14 -0700
Received: from [10.238.128.152] (unknown [10.238.128.152])
	by linux.intel.com (Postfix) with ESMTP id 7E1AC20B5708;
	Sun, 12 Apr 2026 18:31:11 -0700 (PDT)
Message-ID: <90a02329-5e95-4eb8-ac47-028690bf52b3@linux.intel.com>
Date: Mon, 13 Apr 2026 09:31:10 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tpm: restore timeout for key creation commands
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Serge Hallyn <serge@hallyn.com>,
 Lili Li <lili.li@intel.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>
 <2f9f7dcf-7cea-46f8-8887-ac2495e12863@molgen.mpg.de>
Content-Language: en-US
From: "Zhang, Baoli" <baoli.zhang@linux.intel.com>
In-Reply-To: <2f9f7dcf-7cea-46f8-8887-ac2495e12863@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9165-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,hallyn.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoli.zhang@linux.intel.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A910B3E6A0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/10/2026 2:49 PM, Paul Menzel wrote:
> Dear Baoli,
>
>
> Thank you for your patch. Some formalities:
>
> Am 10.04.26 um 03:49 schrieb Baoli.Zhang:
>> After the per-command duration map was introduced, TPM2 key creation
>> commands (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) were limited to
>> 30 seconds.
>>
>> On some platforms this is not sufficient and key creation can time out.
>> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
>> inadvertently reduced these command timeouts from 300 seconds to 30
>> seconds. Restore them to 300 seconds to avoid spurious failures.
>
> Please document such a platform.
Thanks for your comments, I will add the platform after the internal 
alignment.
>
>> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
>>
>> Signed-off-by: Baoli.Zhang <baoli.zhang@linux.intel.com>
>
> It’d be great if you remove the dot from your name:
>
>     git config --global user.name "Baoli Zhang"
>
Yes,  will remove it in v2.
>> Co-developed-by: lili.li <lili.li@intel.com>
>
> Same here. Maybe spell it Lili Li?
>
>     git commit --amend --author="BaoliZhang 
> <baoli.zhang@linux.intel.com>" -s
>
Yes, her name is Lili Li. Will also remove  dot from her name.
>> ---
>>   drivers/char/tpm/tpm2-cmd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 3a77be7ebf4aa..430022f695f24 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -71,9 +71,9 @@ static const struct {
>>       {TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
>>       {TPM2_CC_GET_CAPABILITY, 750},
>>       {TPM2_CC_NV_READ, 2000},
>> -    {TPM2_CC_CREATE_PRIMARY, 30000},
>> -    {TPM2_CC_CREATE, 30000},
>> -    {TPM2_CC_CREATE_LOADED, 30000},
>> +    {TPM2_CC_CREATE_PRIMARY, 300000},
>> +    {TPM2_CC_CREATE, 300000},
>> +    {TPM2_CC_CREATE_LOADED, 300000},
>>   };
>>     /**
>
>

