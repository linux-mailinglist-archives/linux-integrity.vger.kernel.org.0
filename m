Return-Path: <linux-integrity+bounces-5829-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B2A85730
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2027B9A61BD
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0F1EFFB0;
	Fri, 11 Apr 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqgPZ0NN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FF28FFF4;
	Fri, 11 Apr 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362098; cv=none; b=BWvTkLca0rZBYDdPRYDV0DsCKrk8ecYoEkTFN2/fjHfQ6KSnkaX3ghQFU7ABAQEk2kgoK4OLzHn3+r8ooTTxgsC/BV9fg2lRqt6KvvCr2CpdQN+M6yfRpm7BnBlVJA0vtiAEeNYr9jRYO1C9MqPf5zo/EaALIjRFm3uqGj7aFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362098; c=relaxed/simple;
	bh=1/VnAU3eG+Zz256+Ii75bHu2m8jhHevqdI96JuhHr5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kszyLkMqQEZjyfgFlUQ406pkbx6bko1MENLFCpCwuIPOFWKwEwsSyWMSbtXtP5amQzrg61+3Oyn5VvKRL5aEGHsYk+4l4mvXchM26MPwdfrFkf0TLvsicldL4yH9FzF/dlXf3Wu6UiAGgsDnBG45yqlv5mXLaaCtK6RtKYUALyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqgPZ0NN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7394945d37eso1550382b3a.3;
        Fri, 11 Apr 2025 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744362097; x=1744966897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/E969e0oohjpwGaHlI/PM2cWB9lClbCyEMcGqnsKCdQ=;
        b=EqgPZ0NNlWJ5PgcjQvK4EcE/1Gs9s0atVukc1fvGmiG28nk11ktkXgIumvDanA+fcc
         wbLGD3Vii+1BmosGu71swR95baent+2UYgTTzlYAnqngXLAP9E8yPBCaNQd5P7vBJO7O
         4xTtXuAf9dWG7t9CqS5N20bOI7ypmhoR3y8z8kIWlP9QaDkKwN7FIqs5yBnNfiQ2E+iW
         YQfmsZ5Mte94Bz6zo+oJfddfjUNPxpChc8k2vuaSyLiY0hwsa5oEwd5KBJT0yf1OtWME
         xgdi/okp0ynjjmtOlRg/JSVFZd/LAl59uybUwmYfQdcpjcAnObRIXdGG/dhBBzrFXoXj
         L8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362097; x=1744966897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/E969e0oohjpwGaHlI/PM2cWB9lClbCyEMcGqnsKCdQ=;
        b=uQnLvw6QA19irIl6Tif1RK9XUlXMqUVFAM7EzDV0+qOUPKLq9a4XnIfzcAUnYe6iXJ
         bBU5St0MpJcCFPuqbDdbharQsFmHSpoQH0PBpgmvzaAuFJuWVnLXH+1FLISn/kStTOd9
         rgeYGZ0kbpvghv7NZ9wtrYNGs0EGRbUVYTSyltjE8TTbw9ScraRpk25nFOM1kqbh3jym
         9uZFuaPpalgGHtf+GWHi0MHPimeo6KtrzNe9P5O+qMTHKJQqs+rR8eErtHZ3Vlsvtzfn
         9xIdJBEnVVROQucWl92vNPAMHOi1gudufDYJPA2Q6Y0oT4DL20Vu/ksg5ouyKUDRo0Ih
         8t2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/sJFarsdfQffNjhqII7B5chCBqppkwel/SFaWCl+MYclfZtRRY3HWRxPzCACUB2Igt7E67zsQbtAczRGX@vger.kernel.org, AJvYcCVLvwnbuZ5JobamPoJqXvznEHXlfUjJyr6vbIoZz/S6cEGIfVe+26KovRNqXhtHBx4D9h0wyzFHvksVI7jQ/2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2FwQdx5zJmVOT0p2mB/b8IClSEzsrH7f2o8pOUs8w15ueUDI
	o4y8hZM8OtC8SxCruy574AemK3aAL692Km9/hgYRoP8ZRe2aPx2D
X-Gm-Gg: ASbGnctRtvRnP2qHVYG0WNRhFaO4zXkHo0YRm8LOLI382FJQLn+27qo0XUb9PEVD8Gt
	qE2Ls67sJYCWXMBLboDeXE452mM6RCove3/WM6ZXC+W7giBNDa4FlCzjvFUWp6UCQEs33ijWzQh
	EEGbzbezYxWTvQ5xwrpS2VEXed87q+hE/IUShZ9QEDuSacVe3ImWb7meu5lIP6jqvAy0EafLD9Q
	IWltobhWPv4dDJcK8qmw0/WSrtk7bnoKelDAxgsqr0aL4zLnRff5P91fjnpNuaRKb6grV5+Nmvv
	1GzgcKmn6gSwZHGxF8mCOgU8F66EOdfr1tJvmQfCfrwjNwB++w==
X-Google-Smtp-Source: AGHT+IGP9v5VhRLP++WAEFg1O+REZG6u4P6PL5wWR4HiyGsK0Yp7J7/PCPahcRoAnQB7uVOjSZsemA==
X-Received: by 2002:a05:6a21:9a01:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-201796652eemr4007563637.0.1744362096635;
        Fri, 11 Apr 2025 02:01:36 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23332d2sm966392b3a.159.2025.04.11.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 02:01:36 -0700 (PDT)
Message-ID: <3a1c03c6-19da-4300-a56e-daf8264be064@gmail.com>
Date: Fri, 11 Apr 2025 14:31:30 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] char: tpm: tpm-buf: Add sanity check fallback in read
 helpers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410103442.17746-1-purvayeshi550@gmail.com>
 <6w3lsskngim3x6lx7akwfly3hrrzxyi4pq4itwyye3rywlqum7@oiwkjmvtawl7>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <6w3lsskngim3x6lx7akwfly3hrrzxyi4pq4itwyye3rywlqum7@oiwkjmvtawl7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/25 12:50, Stefano Garzarella wrote:
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
>> V1 - https://lore.kernel.org/all/20250409205536.210202-1- 
>> purvayeshi550@gmail.com/
>> V2 - Update commit message to clarify patch adds a sanity check
> 
> LGTM!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thank you for the review.

> 
>>
>> drivers/char/tpm/tpm-buf.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>> index e49a19fea3bd..dc882fc9fa9e 100644
>> --- a/drivers/char/tpm/tpm-buf.c
>> +++ b/drivers/char/tpm/tpm-buf.c
>> @@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, 
>> off_t *offset, size_t count, void
>>  */
>> u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
>> {
>> -    u8 value;
>> +    u8 value = 0;
>>
>>     tpm_buf_read(buf, offset, sizeof(value), &value);
>>
>> @@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
>>  */
>> u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
>> {
>> -    u16 value;
>> +    u16 value = 0;
>>
>>     tpm_buf_read(buf, offset, sizeof(value), &value);
>>
>> @@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
>>  */
>> u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
>> {
>> -    u32 value;
>> +    u32 value = 0;
>>
>>     tpm_buf_read(buf, offset, sizeof(value), &value);
>>
>> -- 
>> 2.34.1
>>
>>
> 

Best Regards,
Purva


