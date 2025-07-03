Return-Path: <linux-integrity+bounces-6601-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5184AF68F3
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 05:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0B27A23FF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 03:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276525BEE0;
	Thu,  3 Jul 2025 03:58:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860225A658;
	Thu,  3 Jul 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515139; cv=none; b=H5Y44vp3FkyNjBZ3L8/MSraNH1felPERcBNxcbj5cufmjKqigJkoQyXgTgNhp1mO3KrMNAqiqhsoMEot2OQixmhKKj+fG3BI1RW9JIFw3+1+D6V3uMYAOx6or94OpbKyL5loUCHI3Qj1jdHw3WQfLO3PIFQ1z/DY3Rls4VNIK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515139; c=relaxed/simple;
	bh=JNjd8X5+WjdNLfqrHNlQS3B+hnOBqWfWIcU07jicB4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJdJPG4dLdpNMa0It0RLCpk7KSaQpAOfl4RZjHLjjG8RgGu1ns/mjRb3vPzUJzhcIoIJKj4LGxyAQFugzW1vVB3KbjhsxEfyKhrecqlaGx9r5AgihSd85x4XP0iXK94H70ARL7M+eH9qcKK7KhS4ZIZbXdGDxhNlJ3gsLKSKzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84D71688;
	Wed,  2 Jul 2025 20:58:42 -0700 (PDT)
Received: from [10.122.56.71] (unknown [10.122.56.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6EA3F6A8;
	Wed,  2 Jul 2025 20:58:57 -0700 (PDT)
Message-ID: <151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
Date: Wed, 2 Jul 2025 22:58:56 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-3-prachotan.bathi@arm.com>
 <aGWvtzhs5ksKgaYo@kernel.org>
Content-Language: en-US
From: Prachotan Bathi <prachotan.bathi@arm.com>
In-Reply-To: <aGWvtzhs5ksKgaYo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 5:16 PM, Jarkko Sakkinen wrote:

> On Thu, Jun 26, 2025 at 01:45:20PM -0500, Prachotan Bathi wrote:
>> Add a memzero macro to simplify and standardize zeroing
>> FF-A data args, replacing direct uses of memset for
>> improved readability and maintainability.
>>
>> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb_ffa.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>> index 089d1e54bb46..397cc3b0a478 100644
>> --- a/drivers/char/tpm/tpm_crb_ffa.c
>> +++ b/drivers/char/tpm/tpm_crb_ffa.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/arm_ffa.h>
>>   #include "tpm_crb_ffa.h"
>>   
>> +#define memzero(s, n) memset((s), 0, (n))
>> +
>>   /* TPM service function status codes */
>>   #define CRB_FFA_OK			0x05000001
>>   #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
>> @@ -192,7 +194,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>>   
>>   	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
>> -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
>> +		memzero(&tpm_crb_ffa->direct_msg_data2,
>>   		       sizeof(struct ffa_send_direct_data2));
>>   
>>   		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
>> @@ -205,7 +207,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   		if (!ret)
>>   			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
>>   	} else {
>> -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
>> +		memzero(&tpm_crb_ffa->direct_msg_data,
>>   		       sizeof(struct ffa_send_direct_data));
>>   
>>   		tpm_crb_ffa->direct_msg_data.data1 = func_id;
>> -- 
>> 2.43.0
>>
> It adds a ross-reference to the source code, meaning that you have to
> jump back and forth in the source code just to see that there is a
> function that wraps up a single memset() call.
>
> How does that map to "readability"?
>
> BR, Jarkko

Hi Jarkko

I've implemented this change post your feedback on v4 of the initial patch
series, maybe this should've been a question at that point, but what was the
reasoning for recommending that I use memzero instead? I'll use the same
reasoning to rephrase the commit message.

Best
Prachotan.
Sorry for the spam, Thunderbird keeps defaulting to html emails.


On 7/2/25 5:16 PM, Jarkko Sakkinen wrote:
> On Thu, Jun 26, 2025 at 01:45:20PM -0500, Prachotan Bathi wrote:
>> Add a memzero macro to simplify and standardize zeroing
>> FF-A data args, replacing direct uses of memset for
>> improved readability and maintainability.
>>
>> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb_ffa.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>> index 089d1e54bb46..397cc3b0a478 100644
>> --- a/drivers/char/tpm/tpm_crb_ffa.c
>> +++ b/drivers/char/tpm/tpm_crb_ffa.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/arm_ffa.h>
>>   #include "tpm_crb_ffa.h"
>>   
>> +#define memzero(s, n) memset((s), 0, (n))
>> +
>>   /* TPM service function status codes */
>>   #define CRB_FFA_OK			0x05000001
>>   #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
>> @@ -192,7 +194,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>>   
>>   	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
>> -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
>> +		memzero(&tpm_crb_ffa->direct_msg_data2,
>>   		       sizeof(struct ffa_send_direct_data2));
>>   
>>   		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
>> @@ -205,7 +207,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   		if (!ret)
>>   			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
>>   	} else {
>> -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
>> +		memzero(&tpm_crb_ffa->direct_msg_data,
>>   		       sizeof(struct ffa_send_direct_data));
>>   
>>   		tpm_crb_ffa->direct_msg_data.data1 = func_id;
>> -- 
>> 2.43.0
>>
> It adds a ross-reference to the source code, meaning that you have to
> jump back and forth in the source code just to see that there is a
> function that wraps up a single memset() call.
>
> How does that map to "readability"?
>
> BR, Jarkko

