Return-Path: <linux-integrity+bounces-6950-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF97B3CA4A
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5593BA1EA
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BA2749E0;
	Sat, 30 Aug 2025 10:41:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDA42050
	for <linux-integrity@vger.kernel.org>; Sat, 30 Aug 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550482; cv=none; b=J1uIM5SaLoNIobS6RVmXdW/JstDtagLWCXNmxe5UoB50jaFLXGUcvzt7umyz+zKbfM2UV89bpLIyj3EMe6Od38jSSJCcVFH8EtEVeoUU2HMNVXfZFz5DHTWQPlZs6Otkgg2zMoB6Ap6eoGMemCHgGNgDuZHSJKYGsJpM9cFvcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550482; c=relaxed/simple;
	bh=60sAM8FAcVj7GLqz42QKpiuGHJ82zcGYdFB03SD8eTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKveWgL08MiRZqq+J6pfMu0+peiqbpYCda+0U6cRQNOnru1V2rJtyHKYgkNVJ2k7OJtZOZHnyXG3iMMsg3ZDzLON5+ol9b+SY6XPzUobP3zFwuXt/Vr67X0YenkqM8PuHHm+utjm+fVyb81Y6GmdCHQ0vpFatnNozqc50+JK5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fb.dynamic.kabel-deutschland.de [95.90.247.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 79EE66004C2D0;
	Sat, 30 Aug 2025 12:41:04 +0200 (CEST)
Message-ID: <9a7d348e-fd97-41dc-913f-37ed289064cf@molgen.mpg.de>
Date: Sat, 30 Aug 2025 12:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
References: <20250827022102.17731-1-daleksan@redhat.com>
 <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>
 <aK7-rTTqg--lM9if@kernel.org>
 <CAG+gbFd-Y=VO0c7zU8a9DtpAEHGDjhpwk_nsiBg5FHA1qVy4yg@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAG+gbFd-Y=VO0c7zU8a9DtpAEHGDjhpwk_nsiBg5FHA1qVy4yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Denis,


Thank you for your answer, and sorry for my late reply.


Am 28.08.25 um 17:35 schrieb Denis Aleksandrov:
> On Wed, Aug 27, 2025 at 8:48 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>
>> On Wed, Aug 27, 2025 at 07:55:23AM +0200, Paul Menzel wrote:

[…]

>>> Am 27.08.25 um 04:21 schrieb Denis Aleksandrov:
>>>> Reads on tpm/tpm0/ppi/*operations can become very long on
>>>> misconfigured systems. Reading the TPM is a blocking operation,
>>>> thus a user could effectively trigger a DOS.
>>>>
>>>> Resolve this by caching the results and avoiding the blocking
>>>> operations after the first read.
>>>
>>> If you could elaborate, how to test this, and in possible error cases, how
>>> to debug this – for example, how to disable the cache–, that’d be great.
>>
>> +1
> 
> The issue is that this bug is not replicable on most systems, but the way that
> I've been able to test it is by running the following:
> $ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/tcg_operations
> and
> $ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/vs_operations
> On a system that I know is experiencing the DOS symptom.
> 
> For debugging, I've been using an unpatched kernel and running the same
> commands.

Could you please add this to the commit message?

>>>> Reported-by: Jan Stancek <jstancek@redhat.com>
>>>> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> 
> I'll make sure to add the Suggested-by tag in the future, and the v3.
> Sorry about that.
> 
>>>> ---
>>>>
>>>> Changes in v2:
>>>>    - Replaced file permission change with a caching mechanism as
>>>>      suggested by Jarkko.
>>>>
>>>>    drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
>>>>    1 file changed, 65 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
>>>> index d53fce1c9d6f..e0212893748e 100644
>>>> --- a/drivers/char/tpm/tpm_ppi.c
>>>> +++ b/drivers/char/tpm/tpm_ppi.c
>>>> @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
>>>>      GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
>>>>                0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
>>>> +static const char * const tpm_ppi_info[] = {
>>>> +   "Not implemented",
>>>> +   "BIOS only",
>>>> +   "Blocked for OS by BIOS",
>>>
>>> Is this x86 specific? If not maybe use *system firmware*?
> 
> This was the original implementation, but I can change the info message to
> be more general. I can add it to the v3.

Sorry, I missed, that you just moved that part. I saw, that you changed 
it. Should you send v4, maybe revert that change.

>>>> +   "User required",
>>>> +   "User not required",
>>>> +};
>>>> +
>>>> +/* A spinlock to protect access to the cache from concurrent reads */
>>>> +static DEFINE_SPINLOCK(tpm_ppi_lock);
>>>> +
>>>> +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
>>>> +
>>>> +static bool ppi_cache_populated;
>>>> +
>>>>    static bool tpm_ppi_req_has_parameter(u64 req)
>>>>    {
>>>>      return req == 23;
>>>> @@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>>>>      return status;
>>>>    }
>>>> -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>>>> -                              u32 end)
>>>> +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
>>>>    {
>>>>      int i;
>>>>      u32 ret;
>>>> @@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>>>>      union acpi_object *obj, tmp;
>>>>      union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
>>>> -   static char *info[] = {
>>>> -           "Not implemented",
>>>> -           "BIOS only",
>>>> -           "Blocked for OS by BIOS",
>>>> -           "User required",
>>>> -           "User not required",
>>>> -   };
>>>> -
>>>>      if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
>>>>                          1 << TPM_PPI_FN_GETOPR))
>>>>              return -EPERM;
>>>>      tmp.integer.type = ACPI_TYPE_INTEGER;
>>>> -   for (i = start; i <= end; i++) {
>>>> +   for (i = 0; i <= PPI_VS_REQ_END; i++) {
>>>>              tmp.integer.value = i;
>>>>              obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
>>>>                                 ACPI_TYPE_INTEGER, &argv,
>>>>                                 TPM_PPI_REVISION_ID_1);
>>>> -           if (!obj) {
>>>> +           if (!obj)
>>>>                      return -ENOMEM;
>>>> -           } else {
>>>> -                   ret = obj->integer.value;
>>>> -                   ACPI_FREE(obj);
>>>> -           }
>>>> -           if (ret > 0 && ret < ARRAY_SIZE(info))
>>>> -                   len += sysfs_emit_at(buf, len, "%d %d: %s\n",
>>>> -                                        i, ret, info[ret]);
>>>> +           ret = obj->integer.value;
>>>> +           ppi_operations_cache[i] = ret;
>>>> +           ACPI_FREE(obj);
>>>>      }
>>>>      return len;
>>>> @@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
>>>>                                         struct device_attribute *attr,
>>>>                                         char *buf)
>>>>    {
>>>> +   int i;
>>>> +   ssize_t len = 0;
>>>> +   u32 ret;
>>>>      struct tpm_chip *chip = to_tpm_chip(dev);
>>>> -   return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
>>>> -                              PPI_TPM_REQ_MAX);
>>>> +   spin_lock(&tpm_ppi_lock);
>>>> +   if (!ppi_cache_populated) {
>>>> +           len = cache_ppi_operations(chip->acpi_dev_handle, buf);
>>>> +
>>>> +           if (len < 0)
>>>> +                   return len;
>>>> +
>>>> +           ppi_cache_populated = true;
>>>> +   }
>>>> +
>>>> +   for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
>>>> +           ret = ppi_operations_cache[i];
>>>> +           if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> 
> To the point of minimally changing the original code, I also noticed that the
> "Not Implemented" status never gets reported due to the above conditional.
> Would it make sense to change "ret > 0" to "ret >= 0" for full reporting, in
> both tpm_show_tcg/vs_operations()?
> 
> Please let me know what your thoughts are about adding this to the v3.

Without having looked at the history, I guess it would make sense in a 
separate patch.

>>>> +                   len += sysfs_emit_at(buf, len, "%d %d: %s\n",
>>>> +                                                   i, ret, tpm_ppi_info[ret]);
>>>> +   }
>>>> +   spin_unlock(&tpm_ppi_lock);
>>>> +
>>>> +   return len;
>>>>    }
>>>>    static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
>>>>                                        struct device_attribute *attr,
>>>>                                        char *buf)
>>>>    {
>>>> +   int i;
>>>> +   ssize_t len = 0;
>>>> +   u32 ret;
>>>>      struct tpm_chip *chip = to_tpm_chip(dev);
>>>> -   return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
>>>> -                              PPI_VS_REQ_END);
>>>> +   spin_lock(&tpm_ppi_lock);
>>>> +   if (!ppi_cache_populated) {
>>>> +           len = cache_ppi_operations(chip->acpi_dev_handle, buf);
>>>> +
>>>> +           if (len < 0)
>>>> +                   return len;
>>>> +
>>>> +           ppi_cache_populated = true;
>>>> +   }
>>>> +
>>>> +   for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
>>>> +           ret = ppi_operations_cache[i];
>>>> +           if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
>>>> +                   len += sysfs_emit_at(buf, len, "%d %d: %s\n",
>>>> +                                                   i, ret, tpm_ppi_info[ret]);
>>>> +   }
>>>> +   spin_unlock(&tpm_ppi_lock);
>>>> +
>>>> +   return len;
>>>>    }
>>>>    static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
>>>
>>> The diff looks good. Feel free to carry:
>>>
>>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Could you look at the next patch as a sanity check for the issues that
>> you addressed? I highly appreciate your great comments on details like
>> the ones you put out, thank you.

> Thank you all for your detailed reviews and suggestions. Once the final review
> is made, I'll make sure to make the proper corrections before sending in the v3.

Thank you for v3.


Kind regards,

Paul

