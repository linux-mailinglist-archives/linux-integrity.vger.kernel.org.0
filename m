Return-Path: <linux-integrity+bounces-6487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068EAE20A9
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B470F5A6539
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88D1E9915;
	Fri, 20 Jun 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6fzGPxR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22217BB21;
	Fri, 20 Jun 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439987; cv=none; b=Vb/JpgjIamebTjmdS/p93j4PgSTOTTYw65u3FRZBHn+gxn0y1VrbnjGCa5DhU/pZhOJOIeGQZRu8PPbIAmdTsgZMZB6vEZCrgROA/CVn2yn03DjRQ9TglQB+H3RR1SeEu++LJpEYzXs9QUP4Q41ab0KJKxUXB2jNNADI9qwivwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439987; c=relaxed/simple;
	bh=yTfyFomlAYC23JbMLP0F6GGfzLOVzSnfY0H8zplrHpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TckTo2cKgoBQXnVmmWom2Al5IqxCVy6V60XJIQyatiIqLO5wdak+ZvS75Cof8vGfQ5lSiYO34DIl5LP8uN41Q8nD7n4YS1DDTRiqmHzyut2IKJD0c5PtygBHJfrz3N8oWXYq7jbNrq4WphNruBkKA/uN/wq2gVA6+geBAopodoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6fzGPxR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d54214adso15738445e9.3;
        Fri, 20 Jun 2025 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750439984; x=1751044784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nqp5RyaLWU1LSai70owrzduSyRWQ7M8PeiJ+ff4U6jY=;
        b=O6fzGPxRVDVP8hp7MYS0bl5TuByK344YR4ZVcOKca7aCfTdj4u2+JXs19ZrTbLydg/
         lGmCLG8GE0/i6Wz4Oxd+lAmmgU+fct2YGax9JCTrONIzyAadbEZ5+zcdUbmKXu+W0IqY
         AhwrBMO6gnqskvQxtGrSnW5FN3AmySNXaEA3WGONBC3WI5KSVIg45DH6HHcORR3tfi/g
         ThEOOEQB1Ha17g8592Pj693cvBwEN5GFjLgi2XK/qrQGdo6cHAbE7hSG1P33/qAPXQJP
         NqpjVyowZ5bbSLa32E+x373m+e35VXDfGiaFH9gUDoHr7lGae0suvqGlVbRjhGEHFpyP
         /aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750439984; x=1751044784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqp5RyaLWU1LSai70owrzduSyRWQ7M8PeiJ+ff4U6jY=;
        b=TrGcoMorWESnX7LTZ9qjI1pmX8PfjqHArkwKX8g52KZyGlMrORLG+gHUq5qOQP6yt3
         iPAjCR/ygPp1zRnRYiNtkhaYMGsR3+upUENuN9Ru4nWCHbpSA0TiKFgx6symLoV6S4ZV
         3TRVsHyF7o/nnS01qH5aWO8kak8pxdRj6ERF4yc6s03qhAU/sG9D/D2/5fipJZgImXR1
         1c8SQSwTM6l66IuqBxDKFl6EysFghMFl77MqlrwC/3EfISZ6cPPOaoVSCqu9SyRLmDKb
         m9IOiDG+41NhQ99Ty1TtHTAlyWiq018+wIzmyef6psShZ/X+OD6tcerBsd07Ym0W3UmM
         J7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUl0rVkcMv5MorGu18/OELIf1Tj6Bt9JWpUJCbDa9d1XGxp7Ayq7R4HNdhaQF4flMrUR8TeDHxbEuTtMimh68w=@vger.kernel.org, AJvYcCXymmKpu469Za5CF4es1z0xWDigMpS7myPWHUgVFJFWt09JIdYOKbfa5p8ij5yFBkB+g7kQNUOv/WOvrxQl@vger.kernel.org
X-Gm-Message-State: AOJu0YzHa1QOIyx5rLvd5RF/tjS/BSIbG/PNs6Xucy/PgWvvgX7rqqRZ
	CKvksxwmA+k9HiICb1/ePreHyRlE5vrBEJSNKeAAhJzP9bTHG2W3Q+WsY7zCOTwg7Rw=
X-Gm-Gg: ASbGncv7HhD7v+X50bSQsLUmWE0J/kbR74GJm12cA20tpty3ZROTtrvH4OVQEXEgGhg
	yV+2pX7Y130hewPgyhbC6DkBhDHbSz9KHa8n6JN9mdq2PjatVlI4RvODol48N/yRdMOyaaAExOR
	/cQYc3WGdVc0LFPUytqINWV3MLoidgWQxNkwFG9ivyqwZBbie1spfym9k7E1cpjaz9YpD5T0fBt
	NmxD+IxWSJW7jQozKd++4ShzmW9AgQmu/JoPlhxnj5ZDSZ1XrLj6xlyUEYejfS6mKL786EvEEfw
	mwZj5XgytbV6/837CTAA+FUvds3ZTF2ir3zgW3JsVStQzeKiFkhoovaUmYHpRtLDXdxMezSo1rF
	xynBqOTb+lrdkKAgvo1oUq9VL1F/dbrl1bNPKfriicS0dy52SzuP/Dg==
X-Google-Smtp-Source: AGHT+IG7nUurIlUkJSmJUrsRS663QPvCJsqVcHeV3pcLn+ixZg+fKc92NRxtysFHaINml1r46SFseQ==
X-Received: by 2002:a5d:584d:0:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3a6d1322b83mr2901841f8f.29.1750439984381;
        Fri, 20 Jun 2025 10:19:44 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:9139:5f50:46fd:9f3f? ([2a02:8012:e013:0:9139:5f50:46fd:9f3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18215sm2553836f8f.29.2025.06.20.10.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:19:43 -0700 (PDT)
Message-ID: <bda377bf-10f8-49d9-8e58-ec957a40e4d7@gmail.com>
Date: Fri, 20 Jun 2025 18:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Fix the timeout & use ktime
To: Jarkko Sakkinen <jarkko@kernel.org>, "Orlov, Ivan" <iorlov@amazon.co.uk>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
References: <20250611162508.85149-1-iorlov@amazon.com>
 <aEm2p-2p3W3Xw5OU@kernel.org>
Content-Language: en-US
From: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
In-Reply-To: <aEm2p-2p3W3Xw5OU@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2025 18:02, Jarkko Sakkinen wrote:
>> Instead, perform the check in the following way:
>>
>> 1. Read the current timestamp
>> 2. Read the completion status. If completed, return the result
>> 3. Sleep
>> 4. Check if the timestamp read at step 1 exceeds the timeout. Return
>>     an error if it does
>> 5. Goto 1
>>
>> Also, use ktime instead of jiffes as a more reliable and precise timing
>> source.
> 
> "also", i.e. a logically separate change which should be split up to
> a separate patch.
> 

Got it, will send this enhancement as a separate patch.

>> +		curr_time = ktime_get();
>>   		u8 status = tpm_chip_status(chip);
>>   		if ((status & chip->ops->req_complete_mask) ==
>>   		    chip->ops->req_complete_val)
>> @@ -140,7 +149,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>   
>>   		tpm_msleep(TPM_TIMEOUT_POLL);
>>   		rmb();
>> -	} while (time_before(jiffies, stop));
>> +	} while (ktime_before(curr_time, timeout));
> 
> 
> Wouldn't it be simpler fix to just check completion after dropping out
> of the loop?
> 

yes, this should also solve the problem without taking additional space 
on the stack with new vars. Will update in V2, thanks!

> And declare this before tpm_try_transmit():
> 
> static bool tpm_transmit_completed(struct tpm_chip *chip)
> {
> 	u8 status = tpm_chip_status(chip);
> 	
> 	return (status & chip->ops->req_complete_mask) == chip->ops->req_complete_val;
> }
> 

Cool, will do.

Thanks for the review and sorry for the late reply.

--
Kind regards,
Ivan Orlov


