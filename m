Return-Path: <linux-integrity+bounces-7168-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F7B85E77
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935A7189D774
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50B31619A;
	Thu, 18 Sep 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjgGsBQW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AA316197
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211460; cv=none; b=ANs5HL3EYTLy98lC50a0Vunde+/wMqd8hIZnWndkiXgmb6foFhQ36YOWhVJLK1C1BVwEnAMi/vl4RkeO0onfOIFGwPVy7HzkzR3QM2aoJ6FqXTeTtf9pHX06xwGbttl+uVopWuxNqTX16HO453I47uwLnltsc52IfRCjcX2IZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211460; c=relaxed/simple;
	bh=y6c8lw8EKlOPBKyWspS/31sWHR2owEThgD2fvz6wrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFW/BTnqGXS26vAX3qW7zn4brdtVfrVwDOVwas93KvtMzHlDlHMjIf8bnT8KnG1hslij6o9zVe59T8bG+wi9NxJRb7zyrvRM73i/6jYpsqwK4VSIEaN7NTx1RH4nz3Ik2ayq0fyjZU3ebDoTVnw3bCvAb7aEhKeAsvrqpK4mQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjgGsBQW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-828690f9128so158643285a.1
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758211456; x=1758816256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQgPx54SvuoVw16CwN5aQ4H7UCLvlv+FoxUfiYTem8g=;
        b=HjgGsBQW/ujV3dr1oewnRVQi5GiLtqBFU+HTqI6pDGmpiMuWK0EiFL/Naw7PPocwkW
         J3U0jO2QSxjtiVADvZnAmvdyYRh0X5FWI8Biyvlpg4wx6WDJENE2EtRpCkhuEDaTWA+x
         OB/4434CTDCYrgkkvq1FkMA8G7vJ83nI+b9XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211456; x=1758816256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQgPx54SvuoVw16CwN5aQ4H7UCLvlv+FoxUfiYTem8g=;
        b=em5Q0h//Ne7Cc9eg2bzF/GRiV3m64h2oT6mmXD6X2hGgPE0HVNByW3/GIjIY3VFIeK
         kOADWi9dssGGzUmlaEth+XPBtN/97vr1oNVXtEhTgzjJrNj4Q13aKEBoTFM1Khb7GWgt
         loDqfQtm2d5f3Zk67c/h3yTvmuKI/YtynLbZMDSjjyUtxaidBsgVo6afVzo4u3W1JoMI
         8Jlz9ZZchd1rp8LW2LNQP7lqQzlTgcKyRhK3XO9Lar7SmmW+E8aLJDNLb+XWuTup+CLE
         p50nKb1Bds0FpqlswkPkPqTPq7UVhEE8RKSZ/oOG+FmNTsL69suEkyXWJ0AuFc8I8kuE
         waZg==
X-Forwarded-Encrypted: i=1; AJvYcCXG65ii9ep1YHWhcqqcyx22JPfq6htANO08FiubsxjDQj9Y5SOl517ycRGT+zBWPafrdICF8Ioay7FntfYIaso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE+na70sflUnY3mWC5hNCj8H3/JFe7eZNX5B5+dQCdA76lmG5
	CiyP647OmwBElk/qhFrnpJhkIbC28aCbgQvteR4xEztckDScPZG8FRqMmaQSmqBeQAk=
X-Gm-Gg: ASbGncsm1Pa7h56bufGYIM6Kd2lrMD+Zg+lSN8p/lBmT1EQg+r7XcJ0E02M2V0fQD24
	YHymC5cVrzkeIBsIxCWoEC04erKxNLLY1JJ5AVX1sg0usbYlWHnzIHXCApoE1AD5eOWO5Z9JsSp
	/U5Rcu+y32AqKDd+Jom50jzQw1ZDut3DF3nWc48smAKfXJN28wNB1S4aW/Je+EK/b6VGagd79op
	RnSa2dnLB6eVLRko/udQw25hFErK8Sx5MRnF1IjGXtLQsuHzKPiciDzeBjLpwg7E3k+1KXBxSUV
	oQw6D6p2ZWOc7QMK0ssodk1laWfTyg4y/6fGqxct5aNvTRCLCoXZ3NxoXLRMAR0FD8rFJDohBKn
	KBgpsS4HYUAJ1MMBjV83QqsiDleIn78jWcmJluCrQrRtaLuW8XYxmuvAUIFY2BNgWDMxhzyG+qj
	3Ey2GZp7FkLLCzijuDUXiYDB2UeR192Q0C9nLcuH00FKkPxVKHcmYPkha8aa7upGr/tQiTMVY=
X-Google-Smtp-Source: AGHT+IGIwAd/uoNV9XL+0qecZOvEJzFlnVi+Hy8TF9s9PCR5fJ4tPFqi0Aa5Sz/TtZFISSFPPfxp7g==
X-Received: by 2002:a05:620a:205e:b0:825:4783:5c6a with SMTP id af79cd13be357-83ba29b6c60mr12732285a.11.1758211455131;
        Thu, 18 Sep 2025 09:04:15 -0700 (PDT)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836262b559dsm183650585a.1.2025.09.18.09.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:04:14 -0700 (PDT)
Message-ID: <6712e20a-0fa9-44f5-ae0d-f4d9c3324028@linuxfoundation.org>
Date: Thu, 18 Sep 2025 10:04:13 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest and cargo
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
 <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
 <aMwf89qekCuAdD1L@kernel.org> <aMwh95tMxB7sMEzy@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aMwh95tMxB7sMEzy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 09:15, Jarkko Sakkinen wrote:
> On Thu, Sep 18, 2025 at 06:06:31PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Sep 16, 2025 at 04:39:37PM -0600, Shuah Khan wrote:
>>> On 9/16/25 07:48, Jarkko Sakkinen wrote:
>>>> Hi,
>>>>
>>>> The pre-existing kselftest for TPM2 is derived works of my earlier Python
>>>> based rudimentary TPM2 stack called 'tpm2-scripts'.
>>>>
>>>> In order to get more coverage and more mainintainable and extensible test
>>>> suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
>>>> is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
>>>>
>>>> Given linux-rust work, would it be acceptable to require cargo to install
>>>> a runner for kselftest? 

What is runner for kselftest in this context?

I'm finishing off now 0.11 version of the tool,
>>>> which will take some time (versions before that are honestly quite bad,
>>>> don't try them) but after that this would be something I'd like to
>>>> put together.
>>>
>>> Probably fine - how does this impact kselftest default run?
>>
>> OK so this was early query: I might introduce such test as part
>> of series that hasa waited for long time for an update [1]. I can
>> use tpm2sh more easily to reproduce equivalent crypto as kernel
>> does and make a test that can compare the results in a meaningful
>> manner. I also plan to relocate tpm2sh as part of git.kernel.org
>> custody from Github, as its main dependency tpm2-protocol crate
>> already is [2].
> 
> Some motivation context, I left out on doing the aforementioned
> patch set because I did not see importing TPM2 keys useful enough
> application but recently I've been dealing with remote attestation
> and that levels up the feature something quite useful.
> 
> I.e. so called attestation identity keys are persisted to the NVRAM of a
> TPM chip and it would great if kernel could at boot time reserve
> selected (in the command-line) NV indexes and wrap them up into keyring
> keys. Since in UKI model command-line is signed that effectively locks
> them in into controlled use only through keyring as kernel can
> guard that via the device.
> 
> I could put tons more detail into this but point to open up this
> complexity is that getting all cryptography right is easiest done
> by reproducing it in a test in user space and comparing the
> results, and Rust and the crate I did give sort of powerful
> way to describe all this. And also because of the complexity
> it needs to be anchroed with some kind of sufficient test.
> 

I would say get this in a shape where you can share it for review.
We can discuss the changes. One thing to keep in mind is dependencies
for kselftest default run need to be minimal so these tests can run
on rings with minimal tool support.

thanks,
-- Shuah

