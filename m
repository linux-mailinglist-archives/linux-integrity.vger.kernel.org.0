Return-Path: <linux-integrity+bounces-3242-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2757944924
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2024 12:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1556282838
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2024 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62587183CAF;
	Thu,  1 Aug 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="yt00bXCS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A417B40A
	for <linux-integrity@vger.kernel.org>; Thu,  1 Aug 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507180; cv=none; b=ODGGcsjIhjorKEJepG6SEeMUFqC63et+SUr5JkH64BOUzWNgeBbny9yIIEuoNoZgqIgC3rG4DtoE1I83/9U/VvVWn0I+UmQFL2iP4n6BWqNH+VrWXYjoaT/aEZ9G0NuyOG7FmJGbrxHE8dv8z3unsC54b28znLvqUbfmhHID7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507180; c=relaxed/simple;
	bh=fkVZYxNtPs0uUXqZ6PYwSSc9Tqcso2+yHEKllRu9bRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxP9knHBCxYFPTIF6gzoO4/wgmwxBs9xALhB0VTa2K2ftnpBkV4HmBpHs8UmPp1nv8lU7PA9dCIsv7O4ZGnWaUKMvKJyFiX7g0hAz2SSfBwK8Vs1UpQqez3PXCGua+dWq1ShqsKYC+MM6FEpfQs1VS8vVWEYdncGOFyg/8rCLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=yt00bXCS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e3129851so3237415e9.3
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2024 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1722507174; x=1723111974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2510jrh7iRZPI0nIWdOAj/PQxa24slJhwZ7o3CPdV00=;
        b=yt00bXCSwHpALR/vhwrcwdr8vFJgb0MzFquN8w/pcf4JGSLctXOu8C9kHT+rsQHsSK
         qpiIsctR6ktXNSo5HBae6VWp1Y/0DXmODkqHPuJJ5d0v7I6rqYz3VTtuvFtiJelQU0HS
         PDTLQHaO2Zc2agtmJ1mko8Z9MKMGJcBGRIh8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507174; x=1723111974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2510jrh7iRZPI0nIWdOAj/PQxa24slJhwZ7o3CPdV00=;
        b=k91yo71ZnPl036Zm7clOrXjczLG28IF2gpRQK8Y4+GIzD1QijjdgCXKa2cvaFVJAUt
         ky8X6bhJdCxHa7vcy2rd2GVnpeyoHtZSyI52e46VHRtCZUl5ckWiuqk6GgNNIH2La4UI
         O+nYYRviGE6/daGCK9y4mCyPRC/y4HKrWkV38fDrDVovDgeH0LNvc18ZkE25tWr+7CiI
         TgRbFv0BJuHqxabTRXysaSrd3BQHXnyKTQ0GN5OHeW9izRlbdDyNsPir3jU9006oMwhv
         TpnaES/C6nxMidQmaWhVnLzWa7F2ha/uaRYH2KNiJOl3a4Xw+A/6IH8n3KrQZjXlhnfH
         yiCg==
X-Gm-Message-State: AOJu0YzHVd0p7dT7dmOd1ZC7DUbW53jFiflUMchiIVe10yKjVl7MLZib
	rYhjCbxdDHsFWyzTfXXxuBsxg526FMrHs3nIHpvIotNNVh0P9V04IMWyj/hBefI=
X-Google-Smtp-Source: AGHT+IHPjUYLsyhF9u8Dt6qf1aK3A3kPB7cCDZ5QiPx0no3oWTUg09SzQtPmHYBEuKcD4NGHhyt1+A==
X-Received: by 2002:a5d:6052:0:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-36baaf842c0mr1438004f8f.60.1722507173930;
        Thu, 01 Aug 2024 03:12:53 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:949d:5800:e3ef:2d7a:4131:71f? (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm18948540f8f.26.2024.08.01.03.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 03:12:53 -0700 (PDT)
Message-ID: <785b9c89-a9a6-427d-8715-110cb638b645@smile.fr>
Date: Thu, 1 Aug 2024 12:12:53 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] integrity: wait for completion of i2c initialization using
 late_initcall_sync()
To: Mimi Zohar <zohar@linux.ibm.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
 eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
 roberto.sassu@huawei.com, Romain Naour <romain.naour@skf.com>
References: <20240701133814.641662-1-romain.naour@smile.fr>
 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
 <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
 <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
 <b551f01f52d5cefea3992f6c75baa0683ed57ac9.camel@linux.ibm.com>
Content-Language: fr, en-US
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <b551f01f52d5cefea3992f6c75baa0683ed57ac9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mimi,

Le 11/07/2024 à 16:06, Mimi Zohar a écrit :
> On Mon, 2024-07-01 at 22:37 -0400, Mimi Zohar wrote:
>> Hi Romain,
>>
>> Please limit the subject line to 70 - 75 characters.
>>
>>
>> On Mon, 2024-07-01 at 16:58 +0200, Romain Naour wrote:
>>>>> [1]
>>>>> https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
>>>>> [2]
>>>>> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
>>>>>
>>>>> Signed-off-by: Romain Naour <romain.naour@skf.com>
>>>>
>>>> Should this get a Fixes: tag and be also applied to the stable series?
>>>
>>> The current behavior can be reproduced on any released kernel (at least since
>>> 6.1). But I'm not sure if it should be backported to stable kernels since it
>>> delays the ima/evm initialization at runtime.
>>
>> With the IMA builtin measurement policy specified on the boot command line
>> ("ima_policy=tcb"), moving init_ima from the late_initcall() to
>> late_initcall_sync() affects the measurement list order.  It's unlikely, but
>> possible, that someone is sealing the TPM to PCR-10.  It's probably not a good
>> idea to backport the change.
>>
>> An alternative would be to continue using the late_initcall(), but retry on
>> failure, instead of going directly into TPM-bypass mode.

Indeed, it would be better if the IMA (and EVM) can use something like EPROBE_DEFER.

>>
>> As far as I can tell, everything is still being measured and verified, but more
>> testing is required.

Agree, I'm still evaluating the TPM stack when time allows.

> 
> Romain, Paul, another report of IMA going into TPM-bypass mode is here: 
> https://github.com/raspberrypi/linux/issues/6217.  Deferring IMA initialization
> to late_initcall_sync() did not resolve the problem for them.  Please take a
> look at the report.

I don't think that the "mdelay(200)" is really needed when late_initcall_sync()
is used. I guess the issue was the spi driver was not builtin, fixed by:

CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_MMIO=y

Best regards,
Romain


> 
> thanks,
> 
> Mimi
> 


