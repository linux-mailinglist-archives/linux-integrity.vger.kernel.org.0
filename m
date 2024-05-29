Return-Path: <linux-integrity+bounces-2697-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F68D3676
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBDC286809
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A7143864;
	Wed, 29 May 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ez+C4jKi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D8363
	for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985955; cv=none; b=HWEnM/BnyOYpGIH30rZHPYkrqdNrHAlmiPaD9IQ+e+9eWiFlBblsP/nImXqBttiaxtvkNYK5yM6IshIseVjcvxj8nCtxn6kEoJ3gaPMjMM3EzfgKoxmTsJth5xCKTu6dpCUWFHkQhMslvvGAClB3hSt54qiEy5RkIt+dAe7jwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985955; c=relaxed/simple;
	bh=mxaVOoEEeabIJFwESBG7zsM71ZeLRrJxdxrWpetz48k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVtetvZVYYgiuCNZHuCKeCc2aJmSu0lx3LGpuoE8NFEVhUySXtq8ciBGdqoLXG1VZMhIJawH1b6hFs8wnz6p6wuWqJinCEXSb15yI1m9dE02y3D3JsKms+TXTLd3B8XAhG6810CYIohUoDiBrJLL0rvhKiwFqcGy2iwH5oEnUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ez+C4jKi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52a54d664e3so950068e87.0
        for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716985951; x=1717590751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xP8YTSXByNPqBUy85RaieNqrUTD4dzfHTpen8E3/PaA=;
        b=Ez+C4jKiTWToffHqVKnndQpFUIKUdyiwVJR6GEDErT/9zcRu+76HHEOWR6z4d6kEZb
         YL/tRlA4hQZe7TvBCuJjc4qw+yOb1J1rsZzOLkEYGixQHgBwBILwVHYHntHTye7MBLsS
         x4ut4DLQj0rNgd4+BcJaxf+KvNwE3DErjdcjCvdboLKwB9QZWAKbZgIt6SbozMwSy1Es
         51xxDMZ0sBXoybZ2+GVEP0GOwYUYiweO0X+jyzwZoJ+RlqC8fb8htDaPI+YxB3tXHBlo
         OaPxDo30RmjFcATBXQ0abr99uWmXpGGGKPh+bJRQzoKqj46XLsVwASTMq/XgbbPMDzGd
         dEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985951; x=1717590751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP8YTSXByNPqBUy85RaieNqrUTD4dzfHTpen8E3/PaA=;
        b=isTseeG67n2C2RvF6HqXzImlcVXyGGIl/ycaDJrwCzXKse62ItEmwlPKtDovod+6zq
         FQqLj16JSRlvrc6x27ueK+RqAN3jRS2Q5JzisUJUJmt0CvagznU60dT4o+97xuv4pE+i
         4FdxQscxsXgadE1hI+rfs9gPMoP0RZLD3ThF4acX76fuudvqbH6XoUcAI1cwJLiP3lGl
         6Uj65wEBopbLeUL5iWNI1Q1CMYE9wYMJUPWaWyAuYmS6rJRXuzKSm5wGujGsdKYFZs1L
         rPAtu2hryFS5lay4xuhNR7/93Ny/mRVBMAixWhgyUshO964i/k1q0s5b4nEsiBsV/Gq/
         tSPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGmTmwfXw7sgVGksf7TAoTd8X3KJdnULfEeAxXNOjjMS97jz3geZbx25GdtSpfBw+p7LCvD0YE5YBpwjZl+we48vYbZuMXnjq8pmE6RMa0
X-Gm-Message-State: AOJu0YwAu6uA92bnwD6lP5qge2EwkjF0H+eEZ3XxIsAhj0oz69mSyjnw
	YdYvYi4Er+/tdSRJFZLlijJ5Jl7oBDTh0etGISAgcUARUGhV7jtt2DutTSj2tQ==
X-Google-Smtp-Source: AGHT+IFsmpMiQMUpDqLeoM3x4h/V0MZ93OjE6b2mNRxKzOHAIZsQtsd0Wl949z1hPOQQjB4pvnNiJQ==
X-Received: by 2002:a19:914d:0:b0:518:dfed:f021 with SMTP id 2adb3069b0e04-529645e2b3dmr9411386e87.24.1716985951411;
        Wed, 29 May 2024 05:32:31 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852496343sm8401461a12.59.2024.05.29.05.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:32:31 -0700 (PDT)
Message-ID: <b9b1692e-fbfe-4b4e-9769-fb7c88d7b5c7@suse.com>
Date: Wed, 29 May 2024 14:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ping: [PATCH] tpm_tis: don't flush never initialized work
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
 <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
 <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
 <365c120f-dfb0-4155-b83f-e0b8d4ead486@suse.com>
 <D1M4L6MZ6IFC.21HFGZ10104Y0@kernel.org>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <D1M4L6MZ6IFC.21HFGZ10104Y0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.05.2024 14:26, Jarkko Sakkinen wrote:
> On Wed May 29, 2024 at 10:47 AM EEST, Jan Beulich wrote:
>> Has this possibly fallen through the cracks?
> 
> Not possibly that is what exactly has happened, sorry.
> 
> I tweaked a bit the commit message:
> 
> commit 2c0943eba0bd765e1e4a90234e669a26a9304b74 (HEAD -> master)
> Author: Jan Beulich <jbeulich@suse.com>
> Date:   Wed May 29 15:23:25 2024 +0300
> 
>     tpm_tis: Do *not* flush uninitialized work
> 
>     tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
>     called, in which case tpm_tis_remove() unconditionally calling
>     flush_work() is triggering a warning for .func still being NULL.
> 
>     Cc: stable@vger.kernel.org # v6.5+
>     Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
>     Signed-off-by: Jan Beulich <jbeulich@suse.com>
>     Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Does this make sense to you?

Sure, that's entirely up to you.

Jan

