Return-Path: <linux-integrity+bounces-9523-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM/fAsCmAmoZvQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9523-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 06:04:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B565351976B
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 06:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDD8130060A9
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE883275AE4;
	Tue, 12 May 2026 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhJMgMsd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC4383304;
	Tue, 12 May 2026 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558648; cv=none; b=KKeAotPFcaHWXpVrXETzPLPnM892sQ5Dc8YEJF33CFICJKh9gTcV/NSxxZ6us6rRiGSa4Lrk+tAGiWHcAm2yaNM2SxT1tzoLMZffGPGHilgdi61vFO+Dt+OeCqPqKY1Jb2wffSYL+H+rQ7KVp7cMXBsjCoSeDfiTaxcLqgjMJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558648; c=relaxed/simple;
	bh=VRCjjgaqo8G4LEnN9W6SVbZ/UZLyZM5t3yjKthELRSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnbbUjXXvWEa5DM+kvYkVyv7QYSLTdUKh+zs2FgrsEeqRQObIUYy8YpXRLYYZ4h1bItx8HHxU2dVX2fIR8dW5yZGuaQa9V1MI6WJZss3L+IVcsNlQECXYlNbixT3yKr1SlwSek2mC9Tsh96xZUJ+ZWdK3VCStk4kK4NFkdUxl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhJMgMsd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778558647; x=1810094647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VRCjjgaqo8G4LEnN9W6SVbZ/UZLyZM5t3yjKthELRSM=;
  b=HhJMgMsd6sdp+0SLCjZONL7Jt0Yp5zH5yK7Vc6oYyvIPJGU/xKysxGSB
   zU9kzJvakWt/Gd2TOEoryrAKLmJnJdK2Vm2mYUsOMtv80/jZefjuZuIT0
   70CB2dlVfBexHSSW8DwRMIX8WvAC2IKr4ucArAzwiEV4CAimerQxpduJo
   ckZ8PJsWlf+spstgRNbWjFETxVgKwBhvJqKfRMDc615bBCtwqvgk5V3WY
   iRdSvpadpZPknKKUt2RuP9IrAR3ndlP7NwbAJ0VIz+2IXv0Ypq2N/hD47
   68u/r8wPiCJf+FPdg8Vq2uWWZ3fOwaJSxbMb+eIsqtCJdzkm3aNcvAf7j
   Q==;
X-CSE-ConnectionGUID: rQUTuHjTT+SJB4z8nzCBfg==
X-CSE-MsgGUID: jwFYvjWuQnqShCuyGIeEpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83074764"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83074764"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:04:07 -0700
X-CSE-ConnectionGUID: UvBcKWwbTwmWvfwPv4Oxqw==
X-CSE-MsgGUID: 90iEtlvtRpaH6gScY5xp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231246196"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:04:06 -0700
Received: from [10.238.128.186] (unknown [10.238.128.186])
	by linux.intel.com (Postfix) with ESMTP id DE7FD20B5713;
	Mon, 11 May 2026 21:04:03 -0700 (PDT)
Message-ID: <ab62f209-72f3-4e36-aa5b-2ddb0314539a@linux.intel.com>
Date: Tue, 12 May 2026 12:04:02 +0800
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
 <46109c55-c85d-4c32-9f09-f3205495afe0@linux.intel.com>
 <af-F9iMpvQFpVBwH@kernel.org>
Content-Language: en-US
From: "Zhang, Baoli" <baoli.zhang@linux.intel.com>
In-Reply-To: <af-F9iMpvQFpVBwH@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B565351976B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,hallyn.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9523-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoli.zhang@linux.intel.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action


On 5/10/2026 3:07 AM, Jarkko Sakkinen wrote:
> On Thu, May 07, 2026 at 01:36:36PM +0800, Zhang, Baoli wrote:
>> On 5/4/2026 11:13 PM, Jarkko Sakkinen wrote:
>>> On Tue, Apr 21, 2026 at 08:50:20AM +0800, Baoli Zhang wrote:
>>>> From: "Baoli Zhang" <baoli.zhang@linux.intel.com>
>>>>
>>>> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
>>>> inadvertently reduced the timeout for TPM2 key creation commands
>>>> (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
>>>> seconds.
>>>>
>>>> This causes intermittent timeout failures, with several failures observed
>>>> across hundreds of test runs on some Intel platforms using Infineon
>>>> SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
>>>> avoid spurious failures.
>>> Is this a production case?
>>>
>>> I'm not sure if there is anything to fix tbh. I mean it is
>>> pretty much the same as "maintaining compatibility to OTT driver"
>>> to addresses issues on undisclosed hardware.
>>>
>>> Please correct me if I'm wrong. Otherwise, I'd carry out internal patch
>>> to tweak this for pre-production hardware (presumably).
>> Hi Jarkko, this is indeed a production case. We discovered this issue during
>> validation testing for the sustaining release.
> OK, it can be considered as a backwards compatibility issue then I
> guess.
>
> I applied the patch, thank you.
>
> BR, Jarkko

Thanks Jarkko and you all for your kindly review and help.

BR/Baoli

>

