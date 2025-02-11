Return-Path: <linux-integrity+bounces-4791-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B7A31972
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 00:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F318167023
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60A267AFC;
	Tue, 11 Feb 2025 23:21:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F385267AF5;
	Tue, 11 Feb 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316106; cv=none; b=FMWO2ftBjMuSIswieWqDSWZn2ZMy2FGKLbJHITruxCV2+qMITUUX/CHsq5y7ZO1UrjCz4/NXqF4aX+H8os11soEcONENX/3ljzY93/UkfGa6s99vZpRH9BDhY4h/5vwmpTf1oR9goqqtTqpMMW7e7EHcBO66g8LMZ8pmPhymqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316106; c=relaxed/simple;
	bh=sB2itsFohXunEWga5+rM3EMf9osNj1QTEbWJbv6fN8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOce9i6vcBdtH4c9x1hpBQ0dSg0ZkS2JIuB4sR3EkSaS/N0tVHvOQ8ybyUgAKq79ItwZAhL5lF3a6K6pMZEtE6OpK3SW5Pd8ECU4rHcsFHDT/1UtMeMd3mUb+jdu7mUNiHnPlb2wdQ55rXw1oAsypr7FF6ZvZ4Yq1DVEngojkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353431D15;
	Tue, 11 Feb 2025 15:22:05 -0800 (PST)
Received: from [10.118.111.35] (G9L3377F54.austin.arm.com [10.118.111.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9597D3F58B;
	Tue, 11 Feb 2025 15:21:43 -0800 (PST)
Message-ID: <e9d255f0-82d9-4c6d-b854-e3ba1ca0e8e2@arm.com>
Date: Tue, 11 Feb 2025 17:21:43 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tpm_crb: implement driver compliant to CRB over FF-A
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <20250210232227.97761-2-stuart.yoder@arm.com> <Z6u8Yb-NIs0_v2gm@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z6u8Yb-NIs0_v2gm@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/25 3:08 PM, Jarkko Sakkinen wrote:
> On Mon, Feb 10, 2025 at 05:22:24PM -0600, Stuart Yoder wrote:
>> The Arm specification TPM Service CRB over FF-A specification
>> defines the FF-A messages to interact with a CRB-based TPM
>> implemented as an FF-A secure partition.
>>
>> Spec URL:
>> https://developer.arm.com/documentation/den0138/latest/
>>
>> This driver is probed when a TPM Secure Partition is
>> discovered by the FF-A subsystem. It exposes APIs
>> used by the TPM CRB driver to send notifications to
>> the TPM.
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   drivers/char/tpm/Kconfig   |   9 ++
>>   drivers/char/tpm/Makefile  |   1 +
>>   drivers/char/tpm/ffa_crb.c | 310 +++++++++++++++++++++++++++++++++++++
>>   drivers/char/tpm/ffa_crb.h |  30 ++++
> 
> Let's use tpm_ prefix for these.

Ok, will do.

Thanks,
Stuart


