Return-Path: <linux-integrity+bounces-7412-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23EBCC119
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 312F24F5A79
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D82765C0;
	Fri, 10 Oct 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="juweejR8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15430277CB6
	for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083561; cv=none; b=tjpQm5yaKU67R5JPAeP5vrI2qZXhH37xY607VylDVBtedJK4SxVs+vUCtrf5jrCbMUn8pzLzYjKKBZZRXH1LqEEKBHf0XkoQydODIIZah8zRO5W8AOteyaevY/7FK6Gl+ynYJayNz4vqUsrG9dDdEnrAwsWsOApXcytVKQ9y9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083561; c=relaxed/simple;
	bh=I6EBiKNdRfM5DUO+YN0GtT/HPyGGFkQg/M6Csm4s9zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZnoXrupSNU7zP5EPOEAZt63KGupFJd/Pi54BK3UZepZNb4N+46jm5avJTVCP0y8Ijk7wZTPxhhOlRfvTiMPN6OJEiT2WAR1pgjCjJZSQgIpYJosGZk4FlJBpvjWNL8cQli8QsgzaRZd1lZFAMzIezYz4leEfUMRvNHR9Xvl3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=juweejR8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3459C240104
	for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 10:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760083555; bh=MDja4UA3eflsjZsjOVxolwjJMmD7nZMa5KVYgcDWShw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=juweejR8Jn5Gu8/ckTmE1SsacfITrT1IPAjWhM+nA0Z9mdP7GNSkwrIkoqzW+PVmY
	 lB7crvtDxfsYGePwvsFB0QafTcNMJOye+Ov8MuJXu8Kp7Hw1eaR+qEVTe2TtvcZzPv
	 xlMl0EVO0mJKilL6Ur4WvdEJa7CmLWCpRb3ZuX9ihwFGmc0Rxab/OfIGWblSMquNqs
	 V4MF6f8w8jE+drZE7TqtE0dW/Qgbz5tmC8OvjocsdfrRDy5VssW4venXY3cO9v0Krz
	 5f2WipGF2GV195zuFfSxD2yv3pRQYDw8HvXwXLwK1gxI94gM11OsRxZK6GUaUfjW8k
	 Oo2pq90BRouqQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cjfSf3SMZz6tw2;
	Fri, 10 Oct 2025 10:05:54 +0200 (CEST)
Message-ID: <dfc2e998-dc26-40be-8e17-e44f46b88f1a@posteo.de>
Date: Fri, 10 Oct 2025 08:05:54 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] tpm: infineon: add bounds check in tpm_inf_recv
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010074956.6862-1-shahriyar@posteo.de>
 <b1fbadb2-235e-4b08-afba-e397c6d076df@molgen.mpg.de>
Content-Language: en-US
From: Shahriyar <shahriyar@posteo.de>
In-Reply-To: <b1fbadb2-235e-4b08-afba-e397c6d076df@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 10:02 AM, Paul Menzel wrote:
> Dear Shahriyar,
> 
> 
> Thank you for the improved version.
> 
> Am 10.10.25 um 09:49 schrieb Shahriyar Jalayeri:
>> Add two buffer size validations to prevent buffer overflows in
>> tpm_inf_recv():
>>
>> 1. Validate that the provided buffer can hold at least the 4-byte header
>>     before attempting to read it.
>> 2. Validate that the buffer is large enough to hold the data size 
>> reported
>>     by the TPM before reading the payload.
>>
>> Without these checks, a malicious or malfunctioning TPM could cause 
>> buffer
>> overflows by reporting data sizes larger than the provided buffer, 
>> leading
>> to memory corruption.
>>
>> Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
>> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
>> ---
>> Changelog:
>> v5:
>>     - replaced space indentation with tabs before the header comment
>> v4:
>>     - removed the curly braces around one line statements
>> v3:
>>     - removed dev_err() logs
>>     - added missing "fixes" tag
>>     - described header structure
>>     - fixed commit message length
>>     - removed use of local variable as constant
>>     - fixed check to account for off-by-six bytes
>> v2:
>>     - added complete changes in the commit message
>>     - dev_err() logged expected sizes and stated operation is aborted
>>
>>   drivers/char/tpm/tpm_infineon.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/ 
>> tpm_infineon.c
>> index 7638b65b8..d76aae08b 100644
>> --- a/drivers/char/tpm/tpm_infineon.c
>> +++ b/drivers/char/tpm/tpm_infineon.c
>> @@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 
>> * buf, size_t count)
>>       number_of_wtx = 0;
>>   recv_begin:
>> +    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data 
>> size */
>> +    if (count < 4)
>> +        return -EIO;
>> +
>>       /* start receiving header */
>>       for (i = 0; i < 4; i++) {
>>           ret = wait(chip, STAT_RDA);
>> @@ -268,6 +272,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 
>> * buf, size_t count)
>>           /* size of the data received */
>>           size = ((buf[2] << 8) | buf[3]);
>> +        if (size + 6 > count)
>> +            return -EIO;
>> +
>>           for (i = 0; i < size; i++) {
>>               wait(chip, STAT_RDA);
>>               buf[i] = tpm_data_in(RDFIFO);
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

Thank you for your patience with newcomers.

-- 
BR.
/shj

