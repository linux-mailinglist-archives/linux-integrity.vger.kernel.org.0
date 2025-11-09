Return-Path: <linux-integrity+bounces-7615-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACCC43D85
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 13:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69C2188B0B4
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109462EC0A7;
	Sun,  9 Nov 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4XHjkXy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FE2EC088
	for <linux-integrity@vger.kernel.org>; Sun,  9 Nov 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691348; cv=none; b=sS70KpKE5X/JEm3OzS3eXW+Pp0pm/HRTso5Qd+CvsO2pX+5AKgd68130cu1fRU7Jd4tzuxRyzQjldJzK7rXbg+Jj05qUmJvFVQHIy9I5AyC/egfyQ758KpLGBA+VroULfuDh7UnTDAmslGxE/74Umf0tQArPtbzKMx7xt0ukP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691348; c=relaxed/simple;
	bh=+Fj8UCA6PFYAVUdnQDCZ7U9phZKfSbyakTHFESM1D7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzif9+UVx/B6pgr6jV5WFiR8oH96ybfg/FJshx0OcTFBw6eDAItboJ4AbijJtonBWw8iXCe44Z4Rz/RSYWjK6Da9dR6XPOyPfnTzlHprVhKYjB1VxKNXILyPgl6LukxID/sRV1zEFPODQfHVO23ew9I5gdBFquwQ+B4eY/7rNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4XHjkXy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso1650521b3a.0
        for <linux-integrity@vger.kernel.org>; Sun, 09 Nov 2025 04:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762691345; x=1763296145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Sfh23gMPuSgFh9wP8m+RA7LgOjNZR3fljD+XVnQlZc=;
        b=K4XHjkXyWwOD1LN3ttrU8mst/IAcGQcqk2M9yWKv7e64+MzXp8wpEXrcMDoAwTqUnb
         ZiL//Etns/PYZb7FkedKuwlCAlRp37sFby0uLvMW0ZYkzL019tAUWAlURcaG99c+TZZ3
         X7YdOxvxy6qZfavELowgl64T9VUBJrowrbs1jAmE8vl8EA5i0aP5Vty21a4ivZn3JvUO
         4Mey0Y3jBNM51ACA/AUhPc1J0wetkLw5ZqmuwzHiGGJuVOxJsr/LCmO/pNiJB9f587bz
         +WH31G/7h45teVibVEq7/GNhhd/qSYcsuQD003aKE/+7wznOTIx6w4bFV1EgsJHcfT96
         w+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691345; x=1763296145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Sfh23gMPuSgFh9wP8m+RA7LgOjNZR3fljD+XVnQlZc=;
        b=LtmY0/C3qQzfY/dAdeYOMUSIu/xGLDkaCu6wIbojuOAXAmSJEOUBFjuAeRFPg8lsp7
         11EjWk7QYDGTBtH43ql42EFAVyeIvmi/Q0S/7OusxmM8igsd+U4bLsAOVkScpzQa8gp2
         iFLEYQkJz3ujt+bsHWnwPyfSIG4W4VNSUZFSz+W/+AsThqOjFuOzQjrf/gvqkoz9S2gd
         r5gmESNOZeTvLaTtUXyFyCnBOvqnqcfz9bU/xsyDawjdQE+R1mKR1gs/mQy4WTh1BaJY
         GLp57v2ihMy0XypU1DFlF/JWL9VV+k03Fjzd9w9r7hzYneIGv92H2MZGXl6EdDmuHnrB
         tzsg==
X-Forwarded-Encrypted: i=1; AJvYcCUKV7i/87UnL5CPQJlOklJ5ROfOPRg+TH3msSyHH4W4nTSEBbzfmtlyRNT2N5m3E8B6pAGE+UzKQr/2rRQQ+2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBCS/Qb3eodM+7TgSMibVCKs4g5vOgpToxgEnVwyMuKjmjFxW
	CW70Q+h2ZsP2F0e7cr9G0saW0mYDi4WAxyKZWNk48LB8O1usypMXuNv+
X-Gm-Gg: ASbGnctoAhpkrVsWDRfbd/IAu7IUUU3PQwGlvB9UUCPe1rsDqa7uru0cbisTVXr7p8+
	tsH9dBg3ILCND9NH4k26j/s6EH0z0HISIZ28XFG9V60YPCHz8U/edaSUtn2RHb8Gxit0sNKSvdl
	cTLiEzyourmTEYHRW9Mol4gNAgE2+ZlIJrNWDfsxuRX57dnpmprjceCo4iHzvVouRiMNfW+Ccqy
	H3SnrpiBiXC9RdtoowrwRriITinSruXcH4igH3u1qAtZtH7eI4+YiSiV5xbQlhRqiVVE7XlwGKS
	OgtyWJLn0T0E7L3xl7h98QXSyzTp/yZtYlExQbMU8CdDak63jLsTIhH6LQB0YJSfKgpzJmH5xEI
	xdxovWwZmrxJspu8Im3AwDdp/xcpVHTF49OX1K2+y0U5xelzcbpSLwzaPxRW2MdPsmDIccsR4iq
	1XknDIXVsZyJ1CMYyJRw==
X-Google-Smtp-Source: AGHT+IEkKiASBAM/v8nmSr1bnyXvE15oiC0TbeFeqMLmzAA0Ln0KLA0nGZWhrWf0I/1B3xOi0IZyGw==
X-Received: by 2002:a05:6a20:734f:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-353a428d5fcmr5965129637.52.1762691344990;
        Sun, 09 Nov 2025 04:29:04 -0800 (PST)
Received: from [192.168.1.50] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm10211085a12.21.2025.11.09.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:29:04 -0800 (PST)
Message-ID: <e5e3a542-ee07-4fe5-a6d5-2bc5b2fa873f@gmail.com>
Date: Sun, 9 Nov 2025 19:29:00 +0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Integrity <linux-integrity@vger.kernel.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <aRAdiUB9otJk5i9U@kernel.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aRAdiUB9otJk5i9U@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 11:50, Jarkko Sakkinen wrote:
> On Tue, Nov 04, 2025 at 08:13:12PM +0700, Bagas Sanjaya wrote:
>> The last section heading in TPM security docs is formatted as title
>> heading instead. As such, it shows up as TPM toctree entry. Demote it
>> to section heading as appropriate.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>   Documentation/security/tpm/tpm-security.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
>> index 4f633f2510336b..bf73bbe66db2fa 100644
>> --- a/Documentation/security/tpm/tpm-security.rst
>> +++ b/Documentation/security/tpm/tpm-security.rst
>> @@ -153,7 +153,7 @@ protect key sealing and parameter decryption to protect key unsealing
>>   and random number generation.
>>   
>>   Null Primary Key Certification in Userspace
>> -===========================================
>> +-------------------------------------------
>>   
>>   Every TPM comes shipped with a couple of X.509 certificates for the
>>   primary endorsement key.  This document assumes that the Elliptic
>>
>> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
>> -- 
>> An old man doll... just what I always wanted! - Clara
>>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Should I pick this?
> 

Of course!

-- 
An old man doll... just what I always wanted! - Clara

