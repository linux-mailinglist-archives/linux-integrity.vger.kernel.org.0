Return-Path: <linux-integrity+bounces-4820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BBA35128
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A1B3AB320
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481A266B49;
	Thu, 13 Feb 2025 22:24:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2619DF61;
	Thu, 13 Feb 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485442; cv=none; b=FiV1NskmIyU6fkkZXvIyiv3CJ3Sx0H3pQOrarL/ZhwCzx5k/SIEzb9YUMdQpMa00evzJiNGhVpcR//n1YtKm8hsgw6FYzwVQCn3OV4BaESFjubQl7L9bVlveUxC4V3GTz0GO8DUoQ/Uo5r0dJZQcBI745e35LnI+B8glAJjFXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485442; c=relaxed/simple;
	bh=KXojiP8qEiRRD5LjEU3mXAYf5UsCLT7fe7EySo/mM8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHkV09qyQYQSqyFrVJLw1+Wc3a0enDLuKQgGYq/9jnCRZ5fH4NO2vawKWRUPoHKy74+OGumi3flRQVWHBYRFQ5k9u2ZkzsbUIkZEqUCRqIiO0YnrGZJ3JqKyFMe467ZquqPvPyOeaSSMpNglZE6USMd+O3cWzdmB3kM4VS3OLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE44113E;
	Thu, 13 Feb 2025 14:24:20 -0800 (PST)
Received: from [10.122.17.146] (unknown [10.122.17.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A776F3F5A1;
	Thu, 13 Feb 2025 14:23:59 -0800 (PST)
Message-ID: <291d5cbe-428c-4361-ba14-f1d3a01d1ce6@arm.com>
Date: Thu, 13 Feb 2025 16:23:58 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] tpm_crb: refactor check for idle support into TPM
 into inline function
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-3-stuart.yoder@arm.com> <Z65umt3_lzAgXbJX@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z65umt3_lzAgXbJX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/13/25 4:13 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 12, 2025 at 04:05:45PM -0600, Stuart Yoder wrote:
>> Refactor the two checks for whether the TPM supports idle into a single
>> inline function.
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index ea085b14ab7c..87d69e990249 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>>   	u64 reply_addr;
>>   };
>>   
>> +static inline bool does_tpm_support_idle(u32 start_method)
>> +{
>> +	if ((start_method == ACPI_TPM2_START_METHOD) ||
>> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
>> +		return false;
>> +	else
>> +		return true;
>> +}
>> +
> 
> I think we could also prefix tpm_crb stuff with tpm_crb_* for the sake
> of easier grepping etc.
> 
> So I'd propose this to be called as: tpm_crb_has_idle()

Ack.

Stuart

