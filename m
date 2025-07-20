Return-Path: <linux-integrity+bounces-6657-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E78B0B90B
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 01:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CC91895EF0
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Jul 2025 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC91EE019;
	Sun, 20 Jul 2025 23:06:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6FD1DE3BA;
	Sun, 20 Jul 2025 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052770; cv=none; b=Q0tIhniei+bK6PKDHot41mrcGjb//yBNLDOd2TZEuyaYCXuW7LhcUeNjg9p8ggUucnSyqYxUXz6qzENmS947syKPI36LGDzC5ZuDcuLAtwOgzcQnYP4j+X46TeYpAcnK9qgJFiN/OFNAbC2Wg5LkE64YA4Lh45zZxupUSlFmlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052770; c=relaxed/simple;
	bh=vHvoB3e4D6hWq9C0Ss1Oq+RJ+ypW8an1UjK/yS2GH7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWdrcarF1yCfvEBCSgd/x1pOx9h3NDqpAZWeMl1dgfjDCP5TP8V2Txm5AEgB3x8WS4Xi14+5sVf+qKNDxfLvvEKlMmp7BEp/NiJPp+/6IbJ5YdfNoPWIHh1eEXBhKxe1BU4iKsnERe9zFurkPExbhBEE9o1bzjp5iikGiw4Qfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D211595;
	Sun, 20 Jul 2025 16:05:55 -0700 (PDT)
Received: from [192.168.1.8] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA71C3F59E;
	Sun, 20 Jul 2025 16:06:00 -0700 (PDT)
Message-ID: <4113b3de-918c-4140-9f0d-d1699d2efc32@arm.com>
Date: Sun, 20 Jul 2025 18:05:59 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] tpm_crb_ffa: handle tpm busy return code
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708225151.2473657-1-prachotan.bathi@arm.com>
 <20250708225151.2473657-4-prachotan.bathi@arm.com>
 <aHukoB5Xz4wyx7Yw@kernel.org>
Content-Language: en-US
From: Prachotan Bathi <prachotan.bathi@arm.com>
In-Reply-To: <aHukoB5Xz4wyx7Yw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/25 8:58 AM, Jarkko Sakkinen wrote:

> On Tue, Jul 08, 2025 at 05:51:51PM -0500, Prachotan Bathi wrote:
>> Platforms supporting direct message request v2 [1] can support secure
>> partitions that support multiple services. For CRB over FF-A interface,
>> if the firmware TPM or TPM service [1] shares its Secure Partition (SP)
>> with another service, message requests may fail with a -EBUSY error.
>>
>> To handle this, replace the single check and call with a retry loop
>> that attempts the TPM message send operation until it succeeds or a
>> configurable timeout is reached. Implement a _try_send_receive function
>> to do a single send/receive and modify the existing send_receive to
>> add this retry loop.
>> The retry mechanism introduces a module parameter (`busy_timeout_ms`,
>> default: 2000ms) to control how long to keep retrying on -EBUSY
>> responses. Between retries, the code waits briefly (50-100 microseconds)
>> to avoid busy-waiting and handling TPM BUSY conditions more gracefully.
>>
>> The parameter can be modified at run-time as such:
>> echo 3000 | tee /sys/module/tpm_crb_ffa/parameters/busy_timeout_ms
>> This changes the timeout from the default 2000ms to 3000ms.
>>
>> [1] TPM Service Command Response Buffer Interface Over FF-A
>> https://developer.arm.com/documentation/den0138/latest/
>>
>> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  8 ++++
>>   drivers/char/tpm/tpm_crb_ffa.c                | 45 ++++++++++++++++---
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 07e22ba5bfe3..343377538fe9 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -7214,6 +7214,14 @@
>>   			causing a major performance hit, and the space where
>>   			machines are deployed is by other means guarded.
>>   
>> +	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
>> +			Maximum time in milliseconds to retry sending a message
>> +			to the TPM service before giving up. This parameter controls
>> +			how long the system will continue retrying when the TPM
>> +			service is busy.
>> +			Format: <unsigned int>
>> +			Default: 2000 (2 seconds)
>> +
>>   	tpm_suspend_pcr=[HW,TPM]
>>   			Format: integer pcr id
>>   			Specify that at suspend time, the tpm driver
>> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>> index 7faed6f3bf66..06599c07b746 100644
>> --- a/drivers/char/tpm/tpm_crb_ffa.c
>> +++ b/drivers/char/tpm/tpm_crb_ffa.c
>> @@ -10,8 +10,16 @@
>>   #define pr_fmt(fmt) "CRB_FFA: " fmt
>>   
>>   #include <linux/arm_ffa.h>
>> +#include <linux/delay.h>
>> +#include <linux/moduleparam.h>
>>   #include "tpm_crb_ffa.h"
>>   
>> +static unsigned int busy_timeout_ms = 2000;
>> +
>> +module_param(busy_timeout_ms, uint, 0644);
>> +MODULE_PARM_DESC(busy_timeout_ms,
>> +		 "Maximum time in ms to retry before giving up on busy");
>> +
>>   /* TPM service function status codes */
>>   #define CRB_FFA_OK			0x05000001
>>   #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
>> @@ -178,17 +186,13 @@ int tpm_crb_ffa_init(void)
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>>   
>> -static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>> -				      unsigned long a0,
>> -				      unsigned long a1,
>> -				      unsigned long a2)
>> +static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
>> +					  unsigned long a0, unsigned long a1,
>> +					  unsigned long a2)
>>   {
>>   	const struct ffa_msg_ops *msg_ops;
>>   	int ret;
>>   
>> -	if (!tpm_crb_ffa)
>> -		return -ENOENT;
>> -
>>   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>>   
>>   	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
>> @@ -214,6 +218,33 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>>   	}
>>   
>> +	return ret;
>> +}
>> +
>> +static int __tpm_crb_ffa_send_receive(unsigned long func_id, unsigned long a0,
>> +				      unsigned long a1, unsigned long a2)
>> +{
>> +	ktime_t start, stop;
>> +	int ret;
>> +
>> +	if (!tpm_crb_ffa)
>> +		return -ENOENT;
>> +
>> +	start = ktime_get();
>> +	stop = ktime_add(start, ms_to_ktime(busy_timeout_ms));
>> +
>> +	for (;;) {
>> +		ret = __tpm_crb_ffa_try_send_receive(func_id, a0, a1, a2);
>> +		if (ret != -EBUSY)
>> +			break;
>> +
>> +		usleep_range(50, 100);
>> +		if (ktime_after(ktime_get(), stop)) {
>> +			dev_warn(&tpm_crb_ffa->ffa_dev->dev,
>> +				 "Busy retry timed out\n");
>> +			break;
>> +		}
>> +	}
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.43.0
>>
> I think these patches look totally fine now. If you don't mind I'll add
> suggested-by to 2/3?
>
> Anyhow, I can pick these to my tree. Just coming from holiday but
> they'll end up the 6.17 PR.
>
> BR, Jarkko

Yes, of course, thanks for catching these and suggesting the needed changes.

Best

Prachotan.

On 7/19/25 8:58 AM, Jarkko Sakkinen wrote:
> On Tue, Jul 08, 2025 at 05:51:51PM -0500, Prachotan Bathi wrote:
>> Platforms supporting direct message request v2 [1] can support secure
>> partitions that support multiple services. For CRB over FF-A interface,
>> if the firmware TPM or TPM service [1] shares its Secure Partition (SP)
>> with another service, message requests may fail with a -EBUSY error.
>>
>> To handle this, replace the single check and call with a retry loop
>> that attempts the TPM message send operation until it succeeds or a
>> configurable timeout is reached. Implement a _try_send_receive function
>> to do a single send/receive and modify the existing send_receive to
>> add this retry loop.
>> The retry mechanism introduces a module parameter (`busy_timeout_ms`,
>> default: 2000ms) to control how long to keep retrying on -EBUSY
>> responses. Between retries, the code waits briefly (50-100 microseconds)
>> to avoid busy-waiting and handling TPM BUSY conditions more gracefully.
>>
>> The parameter can be modified at run-time as such:
>> echo 3000 | tee /sys/module/tpm_crb_ffa/parameters/busy_timeout_ms
>> This changes the timeout from the default 2000ms to 3000ms.
>>
>> [1] TPM Service Command Response Buffer Interface Over FF-A
>> https://developer.arm.com/documentation/den0138/latest/
>>
>> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  8 ++++
>>   drivers/char/tpm/tpm_crb_ffa.c                | 45 ++++++++++++++++---
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 07e22ba5bfe3..343377538fe9 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -7214,6 +7214,14 @@
>>   			causing a major performance hit, and the space where
>>   			machines are deployed is by other means guarded.
>>   
>> +	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
>> +			Maximum time in milliseconds to retry sending a message
>> +			to the TPM service before giving up. This parameter controls
>> +			how long the system will continue retrying when the TPM
>> +			service is busy.
>> +			Format: <unsigned int>
>> +			Default: 2000 (2 seconds)
>> +
>>   	tpm_suspend_pcr=[HW,TPM]
>>   			Format: integer pcr id
>>   			Specify that at suspend time, the tpm driver
>> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>> index 7faed6f3bf66..06599c07b746 100644
>> --- a/drivers/char/tpm/tpm_crb_ffa.c
>> +++ b/drivers/char/tpm/tpm_crb_ffa.c
>> @@ -10,8 +10,16 @@
>>   #define pr_fmt(fmt) "CRB_FFA: " fmt
>>   
>>   #include <linux/arm_ffa.h>
>> +#include <linux/delay.h>
>> +#include <linux/moduleparam.h>
>>   #include "tpm_crb_ffa.h"
>>   
>> +static unsigned int busy_timeout_ms = 2000;
>> +
>> +module_param(busy_timeout_ms, uint, 0644);
>> +MODULE_PARM_DESC(busy_timeout_ms,
>> +		 "Maximum time in ms to retry before giving up on busy");
>> +
>>   /* TPM service function status codes */
>>   #define CRB_FFA_OK			0x05000001
>>   #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
>> @@ -178,17 +186,13 @@ int tpm_crb_ffa_init(void)
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>>   
>> -static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>> -				      unsigned long a0,
>> -				      unsigned long a1,
>> -				      unsigned long a2)
>> +static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
>> +					  unsigned long a0, unsigned long a1,
>> +					  unsigned long a2)
>>   {
>>   	const struct ffa_msg_ops *msg_ops;
>>   	int ret;
>>   
>> -	if (!tpm_crb_ffa)
>> -		return -ENOENT;
>> -
>>   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>>   
>>   	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
>> @@ -214,6 +218,33 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>>   			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>>   	}
>>   
>> +	return ret;
>> +}
>> +
>> +static int __tpm_crb_ffa_send_receive(unsigned long func_id, unsigned long a0,
>> +				      unsigned long a1, unsigned long a2)
>> +{
>> +	ktime_t start, stop;
>> +	int ret;
>> +
>> +	if (!tpm_crb_ffa)
>> +		return -ENOENT;
>> +
>> +	start = ktime_get();
>> +	stop = ktime_add(start, ms_to_ktime(busy_timeout_ms));
>> +
>> +	for (;;) {
>> +		ret = __tpm_crb_ffa_try_send_receive(func_id, a0, a1, a2);
>> +		if (ret != -EBUSY)
>> +			break;
>> +
>> +		usleep_range(50, 100);
>> +		if (ktime_after(ktime_get(), stop)) {
>> +			dev_warn(&tpm_crb_ffa->ffa_dev->dev,
>> +				 "Busy retry timed out\n");
>> +			break;
>> +		}
>> +	}
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.43.0
>>
> I think these patches look totally fine now. If you don't mind I'll add
> suggested-by to 2/3?
>
> Anyhow, I can pick these to my tree. Just coming from holiday but
> they'll end up the 6.17 PR.
>
> BR, Jarkko

