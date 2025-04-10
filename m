Return-Path: <linux-integrity+bounces-5758-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7AA83F4E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 11:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D291B3BC9F8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B84267F64;
	Thu, 10 Apr 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6nSgXlR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA62673B7;
	Thu, 10 Apr 2025 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278283; cv=none; b=dLUJdYh7b9gEr+vs+Gvgc8Cq1gjZ/cKqovDPU5rwy0SZgBzd9z8FZoErsRzSJKkDX2SSlbbDfCZSgkaChLhsSyIxMubthwgFR6AJ1KEk8kfqVt3dHdxffNJpb/TZfG0avrPJfEqr7aUkTlXqGVAcBougH+vABaq1USy41fLiIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278283; c=relaxed/simple;
	bh=5o9nHRExWJmeBFaGYhQUWukdK7X5GSVjn4x/hNXJ0SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyXGw1ihGpxh7x67ytWncR8CAyzzzPndZY1FQCG2cPw2WJJId69UJVzn99qq6SmWKtkJqAt8qxy9/a5WNb3AFBdxh0/Tlvwu43e87wP+xWuAgAGNpilaGp9zoZ0GY/7JO+fLi2wl8jMmYdcjuH5oX65qEdS1IeFa3O54FRxnXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6nSgXlR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso1532446a91.0;
        Thu, 10 Apr 2025 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278281; x=1744883081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IomupBb5aaDCRXzpego0G4BJnUddV6XmS2v4epMW8M8=;
        b=D6nSgXlRnAwR3SpvI+XaKBO0mLD3nHLdPNlZsZ3mUwgO+BJ6C4jjLEXqHgYgYgtJ6q
         Lur4cjqmS4nCNRE/vJEDLgb+F+SE2O4C4ozX1uQy4tp4O9W5wPbQxmIrppx+jOGUquOe
         9zzb3I90DV68e5wC1DaSdF4H+d7j4n1cRYk6RmLIDxJ3ZIHZYngmOywqLTpjN9O8+XCk
         OlJyrfi1cOVrg4fpf6GTT96MCUoYzahDlqk6Xjo5HNc/Mkq8v+wd6HAgK34HzZirydLp
         gR3LskigXc5BrbSMTf+5Ay6vpY6J1MCM/ZfcUj9kgVTjOTYPfvAFCcd/Hhc54MlxzNE5
         uIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278281; x=1744883081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IomupBb5aaDCRXzpego0G4BJnUddV6XmS2v4epMW8M8=;
        b=QnlR/NPekRmHsREN+L0ORql+5rrfSSOXiUjQOTyAn1IsArnAFOFKvDBDLVVAaVscBm
         UX7ZvTvw1ByLCI/S1ItkAdq8iR1XDyBSjAGpDOjSPk/GYLMukoCMO0TPKmajzc9SDV8e
         +9GFP6X0rLjTyf3P2H4tlnaAbOYiqz77rA6iwlMGKJ6upcL8/8qXOse6wAQfXMPP//f5
         RJdDI5CPWOlNjAbal01YEuaxi//FQh5Au6XP0dLVYpYEY9spGeqApGhE+6dAXAD2Ddu2
         Tq70M0UNCZLweHFhMbem0+Fq9X2joi+ugI64sITkjkk9WT/wNjqXIn7oqR5cx3r1ZZE/
         bPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5zeupelfY04Sw9ixVr7shdNjYA3Cd8PAy7CVEw50ood+zI+vtzD40yLwYtFkEqjByCLYsKh82DzPmD5FH0Y=@vger.kernel.org, AJvYcCWxI+aBsP+wP+eSuz35sD6GhGXPWvC7iD7UqA+fPXCCmj+bno/ELWHb+e0pTjg5K5c0zSylBoqQ7ywq3wI3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoZ+qLIK0+XzUfV29gU+BgyKq2SwFuCsxqYfPbQUwQgYKTgyM
	By5/vooh5fI8a6HzO5yYh9/CNXVuD7xqoYrIOTxiGVVTyhr51NXY6jG3zncu
X-Gm-Gg: ASbGncsKLhhJZPCOe7PZQXEqoY3RTqHxsc7KuJ1O7/9rqKHmKEPXa/HnuppZuH6leWF
	/F4cdWmTkO/R+Zl6EA614X1gg9jRBt8dcjo+GqTmnPBK7K+kVMaocy/cnv51dVY/SB5nNTKv9RQ
	yvXwA16B9NWsVcOh7hp3bxP39+8AsC1+Md8x7a2szDaH7CEJzo6dvK/Nt6Vfx0428sSY4PMrFol
	EwHbAkRpBKbr05sVk0aUcb91/ur8hSPAI6LyPnAE+Ht9eAaaxI4n7Ngr+w7JkHLwdv8XMC5ANAf
	molnZN2ZtJU7UCROIf+J9J17+F787P+uc/YPWMhqJQ2Hy1j1/0I1C+QOwf59Neo5p/7c4fEwG/S
	ihu35nd2gF18jVfSMFufeEXN9pw==
X-Google-Smtp-Source: AGHT+IHl+das/+EcyS+modqbfMqm7jXFRcastaWUw/vi2hna16zCG4lKtzeSE09FW2i7Rv5VNgM/JQ==
X-Received: by 2002:a17:90b:2748:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-307986accecmr3457713a91.14.1744278280997;
        Thu, 10 Apr 2025 02:44:40 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:5da0:ac0c:6934:f07? ([2409:4080:204:a537:5da0:ac0c:6934:f07])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10c3dasm3202830a91.4.2025.04.10.02.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:44:40 -0700 (PDT)
Message-ID: <1bceb239-4f18-41c9-b6c7-acd4ce08ba8d@gmail.com>
Date: Thu, 10 Apr 2025 15:14:34 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
 <Z_eHWkSdhfOHxiNe@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z_eHWkSdhfOHxiNe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/25 14:24, Jarkko Sakkinen wrote:
> On Thu, Apr 10, 2025 at 09:51:09AM +0200, Stefano Garzarella wrote:
>> On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
>>> On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
>>>> Fix Smatch-detected error:
> 
> Empty line and s/error/issue/.
> 
>>>> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>>>> uninitialized symbol 'value'.
>>>> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>>>> uninitialized symbol 'value'.
>>>> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>>>> uninitialized symbol 'value'.
>>>>
>>>> Call tpm_buf_read() to populate value but do not check its return
>>>> status. If the read fails, value remains uninitialized, causing
>>>> undefined behavior when returned or processed.
>>>>
>>>> Initialize value to zero to ensure a defined return even if
>>>> tpm_buf_read() fails, avoiding undefined behavior from using
>>>> an uninitialized variable.
>>>
>>> How does tpm_buf_read() fail?
>>
>> If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are effectively
>> returning random stack bytes to the caller.
>> Could this be a problem?
> 
> It should never happen, if the kernel is working correctly. The commit
> message implies a legit failure scenario, which would imply that the
> patch is a bug fix, which it actually is not.
> 
> "Add a sanity check for boundary overflow, and zero out the value,
> if the unexpected happens" is what this patch actually does. I.e.,
> code change acceptable, commit message is all wrong.

Understood now. I’ll update the commit message to clearly state this is 
a sanity check for unexpected boundary overflows. Thanks for the 
clarification!

> 
>>
>> If it is, maybe instead of this patch, we could set `*output` to zero in the
>> error path of tpm_buf_read(). Or return an error from tpm_buf_read() so
>> callers can return 0 or whatever they want.
>>
>> Thanks,
>> Stefano
>>
>>
> 
> BR, Jarkko


