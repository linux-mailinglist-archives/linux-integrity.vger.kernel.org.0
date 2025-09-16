Return-Path: <linux-integrity+bounces-7140-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA57B7EE6E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 15:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005311C0747A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56822BDC02;
	Tue, 16 Sep 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkAA8D/1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D129C339
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062381; cv=none; b=g77j+pqzZAXPTK4iTaTaNStn3XHhowNGzdsx7RmihwiyUK64bG0fIHeAs20oTKmXtArEOTZqeCGjp37H3lrmBl7BLOgmH5kUq85dIRaJn3uCSDZXkYFDIaWsk2o1mbcc6RLUkc0oj3o9vEQGBi2ueKI/Gcykw8hAGGKpB0M2wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062381; c=relaxed/simple;
	bh=k0SOfZoXTL+6XpT7LDFJn/Tq3Mu6JeeevxzxgIaMsmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4ht0uWQCYEadwGVafYuoR5yzb1MIMFP5ohVBikJrQH94z6oxh6eIy+bI4cB+S0Ub2WMo/GEUgfBMPFbfqurlOngiJlUltJkmCqef3VvxUIlsNRMimW0JLAUbjN83koHn2+XkFc4TxGsOO7GZUGt6QKwivi7WPQ8Ft+coPGsyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkAA8D/1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80e2c52703bso532883385a.1
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758062379; x=1758667179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywdaVb62eCR3TvAc/4+sZpZzoYKTPBN8q6oGAifJQEA=;
        b=BkAA8D/1/6NCcFJlQD8q6QQQHj1raguXwPyrIhw4GIJc0ZO1z+tfSWboWr2QU0rGLE
         NxgxmMth1RzQF9hnJP5SxRc8XH1VcPypk9OTPa81T3CU/HdKfAytIe1/xgFT9XgqQx2U
         DStqeNofIvkJqE/Y5KjU5n3gz683riqFw3Q4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062379; x=1758667179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywdaVb62eCR3TvAc/4+sZpZzoYKTPBN8q6oGAifJQEA=;
        b=aH3lsyFcT0K7iiDH0FWcZEL1U+TsOUq/vd1FuGdfJAOZ5PlsgluFfpT9hRsoO+phFn
         7LJu0I8T2wdk1WHMMS03bMRed25o5b3eFm7dkZMvjRXdoWTm3Dowq52JEmOEfk+QRQdF
         qEMM3SIHkGinHef5OSg/sjmlbqtWfv+X2Tczk291LZ/TbdU0AhUx3JiRlAUMkY+8XScL
         UCzrKkfjG6NVupbh1rVpZ+HA1ffwC2UrFi1f4Qxe6kdLf8tqJ/JdsM+zq2X5bJPhDMQ1
         og48aIQmlVfByrKF96TfgjovszDIXAylmSqNW0fdFMXUFwrcAeFxvisWhWyo8go+bCOw
         ZaAQ==
X-Gm-Message-State: AOJu0YzLJ37mVYxI4w0Fn2C08ofUgbT4zAMHJBLDeqV9nydz2YQqnzbm
	XK+P3CDCvx3M35sifD0UFmvFQzrVdU5qtwq5o96JZ20Vwf6h23y0pXLqwNjDonmuN2I=
X-Gm-Gg: ASbGncvtSl/RxjT4ssix0NmWBMfSvUNhPOJ7ga167gmei58oAbWjjfsp59jugHmIqro
	7ZJw5euZcnj48m/ppiSgPiZsp4saNEM+G0JT1cZW/d8Gnc2x7OrD97t7XlY8D61nQnvGRq1SZh2
	VPfcLFtBZZQLztSQVUKJeEHcbak2Jy17ZcbidNzUqR+hhn/M+h71pgzwqqr6teJF5ouVp6AxoMX
	vSv10ZbCR6XdOJ15QXfIeREPHoxUFq8KinSgbU6hr6kSsxMdQXfdEUXE180jelpOz2dZszfkVLV
	tsvn9hkpkXfQWhoSDAxVHGsGNgGGXPUgqkVk0J9zPWy1pfHtRsReTJfJwPpRmtaaGuI5cCFjeG8
	sqxU3iDaXwlJp0cPOtxqblk/25o/lrlGSQPueg/MA74hJYQvRZ05e4uHS4FO+m5KZQAaFY2FMuc
	Qp9JLfSE09GuyFZGfwO9qxbPtG3YbrRkJN6YHh/00dv50=
X-Google-Smtp-Source: AGHT+IESNgABLBfvwr4hM4tLIKI9UIhpBPnDVjoN9Ta2vfOV0RzKOw0gmHxxKYKx1UMzPUGBzABwLQ==
X-Received: by 2002:a05:620a:450e:b0:811:1212:1b6e with SMTP id af79cd13be357-8311390c126mr173485a.50.1758062378651;
        Tue, 16 Sep 2025 15:39:38 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639cb2562sm87328371cf.13.2025.09.16.15.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:39:38 -0700 (PDT)
Message-ID: <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:39:37 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest and cargo
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aMlqouOSU8XN7V5H@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 07:48, Jarkko Sakkinen wrote:
> Hi,
> 
> The pre-existing kselftest for TPM2 is derived works of my earlier Python
> based rudimentary TPM2 stack called 'tpm2-scripts'.
> 
> In order to get more coverage and more mainintainable and extensible test
> suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> 
> Given linux-rust work, would it be acceptable to require cargo to install
> a runner for kselftest? I'm finishing off now 0.11 version of the tool,
> which will take some time (versions before that are honestly quite bad,
> don't try them) but after that this would be something I'd like to
> put together.

Probably fine - how does this impact kselftest default run?

> 
> NOTE: while tpm2-protocol itself is Apache/MIT, tpm2sh is GPL3 licensed
> command-line program (for what it is worth).
> 
> [1] https://github.com/puavo-org/tpm2sh
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/about/
> 
> BR, Jarkko
> 
> 

thanks,
-- Shuah

