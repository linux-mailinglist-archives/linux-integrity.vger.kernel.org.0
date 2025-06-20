Return-Path: <linux-integrity+bounces-6488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C67AE20CE
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E7916FE13
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D411F5842;
	Fri, 20 Jun 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iigmng9N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446FA17BB21;
	Fri, 20 Jun 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440207; cv=none; b=Aj0s+0HO/OIghgKI6ukG91UMZT+iEqw7mcBbHeUwfA6i4qDVSp7h+oAyoXOg/nhdjtwxmitYBSHm5WPT/EQR8D2sacTp07CNZitT4fy+aAWqcJIOHtr2KDOfUMR/Cc0vZ6I8JCPhyhMo5YjdHABGcKl5C+3PRw7cLE174KUpQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440207; c=relaxed/simple;
	bh=1FVG3+vsqZJiGktX28SNToZ4jbNHZ5c5S0jgq+mh5YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfheyAt/rjE4JotzNqkYNVhSboCc3QQRq+2petwTavgRwOHJh6S6lE2m3F1auTFNu8Hduf9WfaKEZbIwS1G3RAeU+EzRlqI3/sqFgbMMXbDjEvXR5aFE15FNHjMFFou5n8I9e+Xh3/IaaNv99yXiwzMPL8Il7xOadu5Aaxl/8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iigmng9N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2161955f8f.1;
        Fri, 20 Jun 2025 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750440204; x=1751045004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dopQo/jMB1GNpla7tWv4BWvvwbZb6QJsZK0piWaVVRQ=;
        b=Iigmng9NhmxW4pcZXSrewvgMh7Wq/noCLT0WqHCYn8W/3h/h0iVnnBzX96fu0jZliV
         wEyBGDwCGIw0sCcN92SzLq2cOhC8I4K66Qc6mHnpQea1mQkvAvB9Bqz7PjjHVpecBFjd
         dO3dMn+kLqFS1zuES/vJ/QraMNoq0FTQ2owSxY6u2jLeKD3pZ3plkEyCv9Bbhd7t+VFk
         ttwzQS0GylJ3e6Z6G834Kt40pC+l8M8MgYSlpkUMgxIioV90nmkXvCwXnJKnDzr9oJMh
         s0Ru02BPOVS4C+nzGsPUhpjp9XDxULkV6PeC66PpFoZmq74PHph1tuH3c1ULVSC6ysI7
         fznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750440204; x=1751045004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dopQo/jMB1GNpla7tWv4BWvvwbZb6QJsZK0piWaVVRQ=;
        b=BkH+/3inZ/MgEgitzx8XQB4glFTyZjM6UshYDnhx4lB9XYAabgi6Y05NKHaWSLf01D
         Oy7Yf6fRuRPw3w3E+ASVMwLfKChLoAwGFf3cG/6iIrf7UhIsRNIEs64n6kj9p9NrgqiJ
         dY3g/cREll6YoaPkCBK//cY529CboGe0u0k8aVtRGatc+GlO5JCnE4gqFdSLFBzrFjfa
         Se+oBT2RHUPmQgPYssqstEVQv7CnaIgzp/VP+LtIifobt6HXjRDP9Kd7e/2hIHFvNUmb
         ufSet/T7pz+y/ZKcc10dw5S7x62z5zbwuDMLwfLecVuAzk6M9ZNeRma3K5y8kB+T4S4f
         lK6g==
X-Forwarded-Encrypted: i=1; AJvYcCUO9dvKSUiI0oShUUyJ9WzWfjxK4eyhXgb4dD/4Ifkg4IXHKEwU3fPsHJOY3Dtm85Prqs1+yeqFKMtBDPGS@vger.kernel.org, AJvYcCWx0D2rDtMhZQfyD/033jpvo3ld56hqjC/EVKCsFLWP7QhE19hKPgbhMSfL3BInERclmt9NNA+5Wsh0aMWQqZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwosy60cg2zUwFyopUBBPDDPQDOHEwbank4Zbn1RBCVq0qgx8c
	BAQOX+S/PgwQIUZuXAylxx6mT+gZ2/l1AOfOXgZgZyWfdLZ+0R3xM+bB
X-Gm-Gg: ASbGncv6h6cTfjUNCGNwrADG8LK5oTinVCV0howkJDw+3Go4JhfACdXZySSt1Ykss3j
	Hycz21526J1IXee+3X9MSQ++fiPHUJBdYgAfF+mzanK/67TslP2AVneE8tEmAT5qxoEAbT2Ncv2
	jtf25SdpDCDTHwd3KWdM9FnJO5wmpMQcs01kVQkAOqy+OxR3ws/n4W55Zy/7h4FeeGFfVO4nF+8
	JWLWTOrwzrqSSXKaQaHYzBNrWyIHvUtb6zDb4U/xupQS+SkMiNuEfCbOG/GlPLUz+6J3jL8EhV4
	lFIO5zYABbGxetj1858Uy//ta00GLd43XTgUcXmRi+onaIaOdNDC0gs5PjXybooHK20WFwTaExh
	Pij+gnh0pdBXhjswRpSi0il+QAXItvX2kW79L+NaabypLEr6jmPxp0w==
X-Google-Smtp-Source: AGHT+IEHe3xcEpiZiexq5RgR7WRzK0PVXNEfILz9EZgxjafypoF2XxLbYMMfbcUKdrR1eaw1lt7ewA==
X-Received: by 2002:a05:6000:18ae:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3a6d27866c8mr2702655f8f.5.1750440204225;
        Fri, 20 Jun 2025 10:23:24 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:9139:5f50:46fd:9f3f? ([2a02:8012:e013:0:9139:5f50:46fd:9f3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d128c7d6sm2649846f8f.99.2025.06.20.10.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:23:23 -0700 (PDT)
Message-ID: <8112fd6c-4be7-4d61-9d5e-372e2499cdea@gmail.com>
Date: Fri, 20 Jun 2025 18:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Fix the timeout & use ktime
To: Jonathan McDowell <noodles@earth.li>, "Orlov, Ivan" <iorlov@amazon.co.uk>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
References: <20250611162508.85149-1-iorlov@amazon.com>
 <aFVhDDewVHneFXnO@earth.li>
Content-Language: en-US
From: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
In-Reply-To: <aFVhDDewVHneFXnO@earth.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/06/2025 14:24, Jonathan McDowell wrote:
> This looks similar to the issue I fixed in 7146dffa875c ('Fix timeout
> handling when waiting for TPM status'), I assume you're actually seeing
> it in your systems? I think we're starting to see it (rarely) now the
> other issues are fixed in our builds. As a similar approach does the
> following work?
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm- 
> interface.c
> index 8d7e4da6ed53..18ae0767fa60 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -127,7 +127,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip 
> *chip, void *buf, size_t bufsiz)
>           goto out_recv;
> 
>       stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> -    do {
> +    while (true) {
>           u8 status = tpm_chip_status(chip);
>           if ((status & chip->ops->req_complete_mask) ==
>               chip->ops->req_complete_val)
> @@ -138,9 +138,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip 
> *chip, void *buf, size_t bufsiz)
>               return -ECANCELED;
>           }
> 

<-- This would solve the problem with usleep_range taking arbitrary 
time, but unfortunately won't solve it for the guest VM scenario: if 
vCPU gets interrupted here, then it still will account the steal time 
and time out when it's woken up before checking for completion again

> +        if (time_after(jiffies, stop))
> +            break;
> +
>           tpm_msleep(TPM_TIMEOUT_POLL);
>           rmb();
> -    } while (time_before(jiffies, stop));
> +    }
> 
>       tpm_chip_cancel(chip);
>       dev_err(&chip->dev, "Operation Timed out\n");

--
Kind regards,
Ivan Orlov


