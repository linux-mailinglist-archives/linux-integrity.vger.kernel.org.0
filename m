Return-Path: <linux-integrity+bounces-4849-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCEA388BE
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18903189B304
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F2225783;
	Mon, 17 Feb 2025 15:56:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C322578B;
	Mon, 17 Feb 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807783; cv=none; b=ZvWh/xhhqJnEQvGKV5CEoJhg8qNIvEhOyCilKVkEe988DQu0s67VzS3eP+F60qBroi4m6MYqPJxZxsu2WEWiYqtLBuV80A9zhV/CWpG0DkkSgs+RamaAotXRkUkcwMf1brm0JzOTDoV5+y+wm/KBjOU/iZFxB+J26YzmAQifDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807783; c=relaxed/simple;
	bh=OUyN/X118tGKL1J5sdWNiz6L3aV5usLo9mLYgnreIdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUg//tKHDqQ43QTuC0gilxNCJ2bNascIm/5LEv7BbCc6582mqGx5i65vA/eg6rGGKMwaxdCjSdJj1yPcCSP6mRQjaqoZ4rbgnoHPU7Fw/6jYa+xIgR/Ych/RofHqzVx1h8VGZTNT2P4zmPq829LMijSNKDtKWJyk80luk9hH4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85439152B;
	Mon, 17 Feb 2025 07:56:40 -0800 (PST)
Received: from [10.122.18.64] (unknown [10.122.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286EB3F5A1;
	Mon, 17 Feb 2025 07:56:21 -0800 (PST)
Message-ID: <aba6e089-2b70-465f-a0a0-01274da268f9@arm.com>
Date: Mon, 17 Feb 2025 09:56:20 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] tpm_crb: add support for the Arm FF-A start method
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-5-stuart.yoder@arm.com> <Z678u1yp2Wx_cIUR@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z678u1yp2Wx_cIUR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> @@ -119,7 +130,8 @@ static inline bool tpm_crb_has_idle(u32 start_method)
>>   {
>>   	if ((start_method == ACPI_TPM2_START_METHOD) ||
>>   	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>> -	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
>> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) ||
>> +	    (start_method == ACPI_TPM2_CRB_WITH_ARM_FFA))
> 
> Now that we have a chance, let's rip of the parentheses clutter.

Will do that throughout.

>>   		return false;
>>   	else
>>   		return true;
>> @@ -261,6 +273,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
>>   static int __crb_request_locality(struct device *dev,
>>   				  struct crb_priv *priv, int loc)
>>   {
>> +	int rc;
>>   	u32 value = CRB_LOC_STATE_LOC_ASSIGNED |
>>   		    CRB_LOC_STATE_TPM_REG_VALID_STS;
> 
> Declaration order + put to the same line.

Ack.

Thanks,
Stuart

