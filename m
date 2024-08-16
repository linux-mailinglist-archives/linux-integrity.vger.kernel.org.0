Return-Path: <linux-integrity+bounces-3325-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E0954759
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B61C249EA
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9319D886;
	Fri, 16 Aug 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="G1pjVnaO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D319B59C
	for <linux-integrity@vger.kernel.org>; Fri, 16 Aug 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806081; cv=none; b=X9Jsb852cb3b/Q3FtN/E+4xCYBJEHb9+u5VSeOthEFszV2NUmQm1g1TdTm/XiYMUqH7Yj3HrwE3Px+G5G4tp5cpWIkddDaPid0Wd1guy1em7CqIj5XwmVso0HROlaPQb1Mz40rwYKn07cpv7fj0JXCbHhjdUro1RfxzKbfL7mQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806081; c=relaxed/simple;
	bh=jOVkyCZRwxwfPGY4eymxAuwM3qMtwzLVgjzO31sjmjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukKhO1k8KoEpaMFikH+y6MT3STPB1ILwgPyA4ITB3XlZ4/U8sSdtgRomRa4wqMG97Qxpn70C3lBIw7GV7bMSr3C4pD9hvy+l5gLpwFAxCropo/koNEYFlGEY9kyZMStArwPg+OpEGnwGmpxffoGU0T/REyY3XMubmN/9wi1OvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=G1pjVnaO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efbb55d24so3417611e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 16 Aug 2024 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723806078; x=1724410878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4qsz+7mQYKMGsKT5Lq9NXZ6sjzsnZVAWwIJdiaA3GZU=;
        b=G1pjVnaO1TgbyjtkCz9qqyrWZSXyR7ZOm941OMfE7aKU+U28+4pM3i4wi7GoLOoxga
         MWr9aA4A62yroM1UkSaxnWs6VY8CoVvkTXH+sRtPYcmuRykSwTCf+4l7qJ82DVQIcLzu
         Jsdy5PurQQtk/R5eTWQKl6Oyj0fCA75pFEQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806078; x=1724410878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qsz+7mQYKMGsKT5Lq9NXZ6sjzsnZVAWwIJdiaA3GZU=;
        b=KCTtAX+msH9ckIsRW85hfELfQ/spgkMWh+hgGrwOGIJJM646jKRe1C3ywHXIHzaQgx
         gktzLT+Ulzhu4xpRotlozpnaOKzquxt4vTEzsJpsgJn36Nmh2RuKxbTWQVdPvi5YEwSF
         dnFTrrCTCAJY6weyywBAaa7OpY82dmt9u2HXIL2NKoKB9KY8Q1rcsND6jwhA0pRn8i+8
         qCjPmupukiusnY+gkD2CMFVlHkQ3nV5rOTm1vSlHnK1DeM3tzJVFTpEHOyZ2MBHZ9Q+Z
         stxscGW+FHbG/qnJztP7/hJl+zAhrg1uLCx8Y0OF+BD61hle7WfIj2ZZGCO3poT2k8qf
         6U/g==
X-Forwarded-Encrypted: i=1; AJvYcCXyS46vtEPQORWs5VmCIaz6dagB3tFVoZWOvLANUKnc0paAycFsM3aQUFy71J6QRZ/d+7YJ3CaBV2AFDnGrIuZXHBsgB2QJhJ5EX1Xvl92f
X-Gm-Message-State: AOJu0YxMuBHZ7gOd5Lp/S+0oRz0tZxG5/FCu6XMFzUiD+40rp8fzHkbW
	3w9M7Ije7s5WdcBzG713EjC93JFfhCMjufVAk2lLxD6TEvyd0jE6BrCuLnpf8j0=
X-Google-Smtp-Source: AGHT+IE4AZiVE7kjprocqnllW5JlMr4sYvdQRlM74n9w7KXPCquuL65elKkFvCQuUxcO79Gv2cLBjw==
X-Received: by 2002:a05:6512:3d28:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5331c6e4088mr2153159e87.55.1723806077291;
        Fri, 16 Aug 2024 04:01:17 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6ae6sm238812066b.35.2024.08.16.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:01:16 -0700 (PDT)
Message-ID: <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
Date: Fri, 16 Aug 2024 12:01:15 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Thomas Gleixner <tglx@linutronix.de>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <87ttflli09.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 8:10 pm, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
>> On 5/31/24 09:54, Eric W. Biederman wrote:
>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>>>> but why would you not at least *prefer* SHA-256?
>>> Yes.  Please prefer to use SHA-256.
>>>
>>> Have you considered implementing I think it is SHA1-DC (as git has) that
>>> is compatible with SHA1 but blocks the known class of attacks where
>>> sha1 is actively broken at this point?
>> We are using the kernel's implementation, addressing what the kernel 
>> provides is beyond our efforts. Perhaps someone who is interested in 
>> improving the kernel's SHA1 could submit a patch implementing/replacing 
>> it with SHA1-DC, as I am sure the maintainers would welcome the help.
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?

No.

The use of SHA-1 is necessary even on modern systems to avoid a
vulnerability.

It is the platform, not Linux, which decides which TPM PCR banks are active.

Linux *must* have an algorithm for every active bank (which is the
platform's choice), even if the single thing it intends to do is cap the
bank and use better ones.

Capping a bank requires updating the TPM Log without corrupting it,
which requires a hash calculation of the correct type for the bank.

~Andrew

