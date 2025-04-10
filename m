Return-Path: <linux-integrity+bounces-5776-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA21A84A25
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D73B3A7A95
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433F1EF09C;
	Thu, 10 Apr 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABYrDWHR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1791E885A;
	Thu, 10 Apr 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302630; cv=none; b=Vxi4PLZCEg31sS7Lx7xdphNNV4ccEQJlmDSRAcLIrn5VwFozJbjoqb334VQr/BCNieScz5cGb5phtygwYAxreoS0YstfeAzgenY/51A1ymMZli24nvRhXdZPcjFh9/9gAKyk4jtCT2fTqhTxq4qENxL6/2ibWlQkDU4etz0OwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302630; c=relaxed/simple;
	bh=11ttv4ahbhHR9sZ2tih/SgMW1YoKlvi3OPar0EPAd+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfAkIHcybJfdWgNICDrQpf+2KBF8HN9n9fMJeh51MuGVmkkDq6cj+ZO7p0RgjoT99YZnINCBjvJWvQLAWVlVW6l0rCrAhtz1WH2t9pgvGoXFGn7dSOxc9mOJeRuBb/LDtqdUy2b8gmi+XGA4efda5rXR+wVuXRBs1qhevGTlhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABYrDWHR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227a8cdd241so12590445ad.3;
        Thu, 10 Apr 2025 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302629; x=1744907429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2l4qjV+BqecbmcsW1PXWYeppPA2F/JV6kYzErO5Ui1E=;
        b=ABYrDWHRbpB7YbWF+LSUtNdtcRWB9X/7r7AdQcjYymWYjbX+CZQRi0lsBYWz75Ss3i
         K46nxtDD4ry1Qcl/du5wyPLsRHLt6Y283nEqRtrywaaJw/VUNRjqJrcD+gnqNTH23dJe
         LFV+L7lVpxKyTJzsF48BeV2FRAdskzGgvIjCHR95SAKPHuXxPA45AAw/WN0BmOpOA2FC
         pqiQlgltm5JBq6GPoIg4zz/hKeCNWyRgUFuR06JJzUgqtgREMiDYCWh0485Yqj+IG+LA
         WcUyhfiXMT62C2roUoTs4/M1A4CYlrDZMDGl5MoA93kdf5RCVbjYjvfFJS2/Na43NI9C
         sWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302629; x=1744907429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l4qjV+BqecbmcsW1PXWYeppPA2F/JV6kYzErO5Ui1E=;
        b=dIeyp89WNGIK0vnz5IDfzGI0cimCJv17STdzRfeo+i3rKaFKH701Dhy3LaChVlqbvw
         sPBSpFIEa9X1NNAaWyW4qQhNj045fUfN5BzZWadn5K7/Zu+nnp6ZKDwK+El81/TMPjNT
         VHfmhG2NYAewNZlN3izY1SdUFLjXq9E6WrLriOs1GRqQm0bGummaZGl4i3h9JSWR1Zl7
         UkrvAmx6dibuYWiioBE2PxENb/zkWyGjSzb3BKD1x8UltCyK+M4TgYj1hQcIesPmcmum
         cv4nbVe2bhpSS/aRK7DgpKBLvT3nZh7IKzVFo5ElA2oePVqwEkNQhaC1ISI1T6iakjDS
         mUGg==
X-Forwarded-Encrypted: i=1; AJvYcCUtvz16XftTADT6aJjAt/uD9I8Kcik8gEk0aTJuwEes3QX+V0MBxiuyxg+a01pdlRJcZJccn88mjWyOAoAh@vger.kernel.org, AJvYcCVuJ3vgehOoQXL2xYj2zaighN5W6xd/7jyY8E/1AtYzciHefRFGgCqT/507K+1gK26/M3jy8U+M69wnhnIcV+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKhbNZbyl97qIpqn5CkZMPmabjV5zwEnwsAbA5urLy8eEh09g
	Zb9PrFy2j8ZiPXe2XPsU5s/5KpDrPUYNEoVhJy3yzjkN8/rrUPW3E4yd+QLs
X-Gm-Gg: ASbGncu8eyOpTXXWYOubJ8RCWF1QiIeT9Eia97No9+w6HS02EOu1LAerIv4XEWdTlHg
	r0mGOugXUE0ctTv2qW3JfGZADFojSqs6LCh8q4k6PNM2FIrBqEGWWiTt+6mMlpSQE8SWt2A2Q0p
	hQJUxwWVAFlqQUc8UMFfiQSFxGJ/KhfsOwZZAiDydZYNaeCGuEdDbf903M3ghibmiXJxd97yayR
	5qii2/n6xDv647MnHcKja+seJBSsHez5BdtkUvBrrLHHgbDYSrX7HS8+3HFlqOJvGUlapc3R52F
	piZ/uGXtdI2IYflva/Gn624cwqcsjwAaCOKOC8himeL+BgdJsfY4ob0mmqY7l6svId5mf62xSbV
	gBKXwsxIQyc1cV6/wIA==
X-Google-Smtp-Source: AGHT+IGQg4KGXXM1ngXxY0/v+O9laACetConth/iV0+PtJEgDWhgCOpVRNWmG8pzOjtT4T4raCS5ng==
X-Received: by 2002:a17:902:d504:b0:224:1074:63a0 with SMTP id d9443c01a7336-22b42c02570mr56828505ad.34.1744302628569;
        Thu, 10 Apr 2025 09:30:28 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:70f5:9c3d:61d0:62b9? ([2409:4080:204:a537:70f5:9c3d:61d0:62b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d46586sm3582805b3a.64.2025.04.10.09.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 09:30:28 -0700 (PDT)
Message-ID: <66ecd791-959b-4eee-bf08-7331baca27d4@gmail.com>
Date: Thu, 10 Apr 2025 22:00:23 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] char: tpm: tpm-buf: Add sanity check fallback in read
 helpers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410103442.17746-1-purvayeshi550@gmail.com>
 <Z_e7jK00SZWSsWOg@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z_e7jK00SZWSsWOg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/25 18:07, Jarkko Sakkinen wrote:
> On Thu, Apr 10, 2025 at 04:04:42PM +0530, Purva Yeshi wrote:
>> Fix Smatch-detected issue:
>>
>> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>> uninitialized symbol 'value'.
>> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>> uninitialized symbol 'value'.
>> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>> uninitialized symbol 'value'.
>>
>> Zero-initialize the return values in tpm_buf_read_u8(),
>> tpm_buf_read_u16(), and tpm_buf_read_u32() to guard against
>> uninitialized data in case of a boundary overflow.
>>
>> Add defensive initialization ensures the return values are
>> always defined, preventing undefined behavior if the unexpected
>> happens.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>> V1 - https://lore.kernel.org/all/20250409205536.210202-1-purvayeshi550@gmail.com/
>> V2 - Update commit message to clarify patch adds a sanity check
>>
>>   drivers/char/tpm/tpm-buf.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>> index e49a19fea3bd..dc882fc9fa9e 100644
>> --- a/drivers/char/tpm/tpm-buf.c
>> +++ b/drivers/char/tpm/tpm-buf.c
>> @@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
>>    */
>>   u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
>>   {
>> -	u8 value;
>> +	u8 value = 0;
>>   
>>   	tpm_buf_read(buf, offset, sizeof(value), &value);
>>   
>> @@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
>>    */
>>   u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
>>   {
>> -	u16 value;
>> +	u16 value = 0;
>>   
>>   	tpm_buf_read(buf, offset, sizeof(value), &value);
>>   
>> @@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
>>    */
>>   u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
>>   {
>> -	u32 value;
>> +	u32 value = 0;
>>   
>>   	tpm_buf_read(buf, offset, sizeof(value), &value);
>>   
>> -- 
>> 2.34.1
>>
>>
> 
> It's good and I think this change is appropriate overall!
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

Thank you for the review.

Best Regards,
Purva Yeshi

