Return-Path: <linux-integrity+bounces-1375-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D75385EFA2
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 04:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314C41C21D14
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9B514A94;
	Thu, 22 Feb 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ooJKEU6y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E1168AC
	for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571100; cv=none; b=mx2x7udK+q4nNiqD6qgjihR6Ud+uh1xEfZSkIW9Ryr2EyPJAEQk++cNBzPxnsiJWMhIKKSRtHPD2ykoWAqbBdsmF0zw+7eElcWu3d+msO51iTNPyxrKxsXs7QoBq1ci/KgrFVPQDB+dRFbYswmTIHsZg09XO5d3ew7yjDrJ7QEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571100; c=relaxed/simple;
	bh=oMwUqFBmwZni3nYHGsNufQX82jUOTPamTsIFOmXTch4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mjjmd0KVtMUR+VCBbhJYgRphH0lnw60a9G/S05mMPSRSKkAlZ4ys9CoUAs0Kxe8+xkRCNIiYOYnpGIszallfP4vW0zw+mxm6RtjQJbf4JedUo5OJpQqLxNMb/5bF6bxIzj8w1nlUedPoklHb2KwRzQbHCHMW7O/+02bvv1cFWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ooJKEU6y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d01faf711so4678277f8f.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 19:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708571097; x=1709175897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMwUqFBmwZni3nYHGsNufQX82jUOTPamTsIFOmXTch4=;
        b=ooJKEU6y1eVEG1FqGLqxfJrbCVeUzx7K43icvQX6+HihQTSFwdYRZrj1Elzf9zOsr8
         lbwsyDjvCf/fkH8fCuVBdCDzXBkyVqtl7M/S9Me/1pPf4Mg6lkpeqc6K3NdC2waNa5C0
         Cngo3DUbyPx2rtaIKMOmkeaV5GHcxt/dSlSPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571097; x=1709175897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMwUqFBmwZni3nYHGsNufQX82jUOTPamTsIFOmXTch4=;
        b=hc77YY0vwEdi9VJCbzsosv6+EMlZmQodLtFkGuJkDdWcB8wtNMHBcgS306zddCz7XS
         UA47RM3kO2Xn1xAt6TzHNd2VGdulncA9fVZZ2UxMRXogLXH8mJRpI+/ENbDORvgDqswR
         xj473vmLD6e4yAYqDnJu1K3zOG6Lm8Ik+9mTlTK1qGsFLehdKld2x4s2HXNvffAg6xb3
         LTYNVjWUPYlv+zOeUHUtOMKJM8fRhWnwy/CeI2zmXOXA0pqbVk7qAMNJj8vaxLPC9J3u
         XJ+Dwi3zCOqiWOAb1yg5em6VZ2FAyZor7sDOFNqxVcTkI8waGR1RetDquVeaDhPH7jFd
         n8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXY4TT3KO56j6zMebbn1xw3c/vQtxzM2ewGPzwFaMfjK3ihnt9mRSAexmzD2OLSp5sZuOYjfbBxrUk3e9VEAEQqVoL/TJrmsU1qvl1LGQa2
X-Gm-Message-State: AOJu0Ywxqvqg/A+AgvIvpQXMcfpl9+tXPQO0bkSysB0OW0cLxfKvWArQ
	dtlwkLuPXUvf9X6/4vlO3fm5X5+6di/A1Q+YTzNm1J8iCS6QtrqRzb05WrmxdvU=
X-Google-Smtp-Source: AGHT+IEz8G6fU4K+3yNmLXt/7u9L6x1bnOwXtDSfi1M9hATKx/IGbEkXRTuSr1VDr3aYclkncYlvnQ==
X-Received: by 2002:a05:6000:1f0f:b0:33d:5e19:e1f1 with SMTP id bv15-20020a0560001f0f00b0033d5e19e1f1mr7547885wrb.12.1708571097017;
        Wed, 21 Feb 2024 19:04:57 -0800 (PST)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id h7-20020a056000000700b0033ce214a97csm18626037wrx.17.2024.02.21.19.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 19:04:56 -0800 (PST)
Message-ID: <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
Date: Thu, 22 Feb 2024 03:04:55 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
 Eric Biggers <ebiggers@kernel.org>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/02/2024 8:17 am, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The SHA algorithms are necessary to measure configuration information into
>> the TPM as early as possible before using the values. This implementation
>> uses the established approach of #including the SHA libraries directly in
>> the code since the compressed kernel is not uncompressed at this point.
>>
>> The SHA code here has its origins in the code from the main kernel:
>>
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>
>> A modified version of this code was introduced to the lib/crypto/sha1.c
>> to bring it in line with the sha256 code and allow it to be pulled into the
>> setup kernel in the same manner as sha256 is.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> We have had some discussions about this, and you really need to
> capture the justification in the commit log for introducing new code
> that implements an obsolete and broken hashing algorithm.
>
> SHA-1 is broken and should no longer be used for anything. Introducing
> new support for a highly complex boot security feature, and then
> relying on SHA-1 in the implementation makes this whole effort seem
> almost futile, *unless* you provide some rock solid reasons here why
> this is still safe.
>
> If the upshot would be that some people are stuck with SHA-1 so they
> won't be able to use this feature, then I'm not convinced we should
> obsess over that.

To be absolutely crystal clear here.

The choice of hash algorithm(s) are determined by the OEM and the
platform, not by Linux.

Failing to (at least) cap a PCR in a bank which the OEM/platform left
active is a security vulnerability.  It permits the unsealing of secrets
if an attacker can replay a good set of measurements into an unused bank.

The only way to get rid of the requirement for SHA-1 here is to lobby
the IHVs/OEMs, or perhaps the TCG, to produce/spec a platform where the
SHA-1 banks can be disabled.  There are no known such platforms in the
market today, to the best of our knowledge.

~Andrew

