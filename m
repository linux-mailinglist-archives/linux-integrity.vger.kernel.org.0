Return-Path: <linux-integrity+bounces-5120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD382A50429
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEAA3A2FA9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C424EF60;
	Wed,  5 Mar 2025 16:09:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8318FC90;
	Wed,  5 Mar 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190962; cv=none; b=n077AEagBZDMSaw7pePJ6OyAkItq1BSSJA8PhtaKlY9CVfPpMp6IRFQtTQN7avLEMQcovGDSh3rTN3ZoqdZYTOpTOtOreUXgkSOg9aXRVHqK6p8p5waxezAMEltrcjO/G8DmHXbfmWn0ld8RIMvGOyGLgLd9AN1ckGRALZ0eiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190962; c=relaxed/simple;
	bh=QlRhJpb/e5hXiFz0CcYu2ha8VdnvKoFkYUAtASfFzTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwpXfjv4LndjiH+LB1suAEFlayUW2WIXoyPTxc3lXDV6SErX4XR/6yiVoiSQNFQFbJbpX+nIgiBPLueiV6kL3iRvm+0IUJDSVgM6x7mWYnXm92rVG4UivfYeq3O8x8H9X3Z/MJbpTp7EQevKmWmCKW0RWv/VXaGoNjKRSXUFMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93949FEC;
	Wed,  5 Mar 2025 08:09:32 -0800 (PST)
Received: from [10.122.49.92] (unknown [10.122.49.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F38FE3F5A1;
	Wed,  5 Mar 2025 08:09:18 -0800 (PST)
Message-ID: <d1270a11-6587-432e-9ea5-5fb3b4ca559a@arm.com>
Date: Wed, 5 Mar 2025 10:09:18 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, sudeep.holla@arm.com,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250217224946.113951-1-stuart.yoder@arm.com>
 <Z8SypwnbJR4g8Bho@kernel.org> <20250303165535.GT5011@ziepe.ca>
 <3b9141a372e9e787089a28beeb4bf11d5a144553.camel@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <3b9141a372e9e787089a28beeb4bf11d5a144553.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/4/25 10:02 AM, Jarkko Sakkinen wrote:
> On Mon, 2025-03-03 at 12:55 -0400, Jason Gunthorpe wrote:
>> On Sun, Mar 02, 2025 at 09:33:59PM +0200, Jarkko Sakkinen wrote:
>>> WARNING: line length of 102 exceeds 100 columns
>>> #764: FILE: drivers/char/tpm/tpm_crb.c:821:
>>> +                              FW_BUG "TPM2 ACPI table has wrong
>>> size %u for start method type %d\n",
>>
>> Just ignore that, it is an error in checkpatch. Strings are required
>> to
>> be long. I suspect FW_BUG confused it.
> 
> Yep, as its own issue I think you are right.
> 
> I also noticed couple of additional style issues not picked
> by checkpatch:
> 
> 	if (rc == -ENOENT) {  // FF-A driver is not available yet
> 		rc = -EPROBE_DEFER;
> 	}
> 
> I.e. extra curly braces and "//" comment.
> 
> Should be:
> 
> 	/* If driver is not available yet, request probe retry: */
> 	if (rc == -ENOENT)
> 		rc = -EPROBE_DEFER;
> 

I will respin and fix this.

Thanks,
Stuart

