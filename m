Return-Path: <linux-integrity+bounces-2093-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BF8A3C55
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032611C20D08
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECC31A94;
	Sat, 13 Apr 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGPWL1iA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114591D55D
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005610; cv=none; b=pQWp7N2buA9KvpPzArHi6sTctW8U7uHok4x7Zz/rZ/ByK86wpKsBQzniZP2p22j46WZuogqpmGf9OfhoOt4G814AMbUIH7vfuoGSnuhgfYCypmBCpv8rtwxdi9iYI+zsV1bpKJgUPsr/bmHncMppSG0awLT8nrlSFmP4023WZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005610; c=relaxed/simple;
	bh=HR3cVbKUF8BvB6Cv/ei+Pn0cas5cm34XU5Q7MNbQh9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUck4CKQYlC4ZMIHrl6ImQ4oBjBBNrpsHK5Q3QLPyLCmHn/9U+zc4dR0AOvgXLdpapqDUyL5iVQsVsq7iZXbfpZcU8zC1xwduKDAA03c0Rwfs34K4B1tzxuo/F7RcbtnaE0tr70p555GSXSZ7Kxbh1K/+55AEwdWptZuAMqgl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGPWL1iA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d6c1e238so1953302e87.2
        for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 03:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713005607; x=1713610407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tp3V5G3bWrspZApW8t6O6GCOiJicNYvqdlqoQdt7zEc=;
        b=JGPWL1iAcH7HYBks4U72auxkNsU0p/KHme1T9PZ2hf46vWb6+mDTpEpUGTc0zClsN4
         3JSfVvXKOhyoa9GZf7YS1HFJhsbO4eNjDFK0uz5zS2Urfj0x0YUtqKBGcry9Q82AQbNb
         OPq4nvEEssEe78g7vm2gcN3vzqQ3dxQr0sigjlkVvGwX+h5mwxljIldR2WOAzH/MZ9q6
         lsoo+37xvUi028HQwBDM4+VanhjIolpAL812WnK+n6YRzonjEtudYg7IGWw2po6/xx6D
         juEFwCTG3ayII8ZSb8+i53ZXANKqNloqIjO8hMU6XG37znZWGWxKmQQ1VQrZDwhXsPGc
         JVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713005607; x=1713610407;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp3V5G3bWrspZApW8t6O6GCOiJicNYvqdlqoQdt7zEc=;
        b=JlG9o7fBP2IAD+UwOjMeSt7nki/4uFDsCII6g5yw8GP7jcwqLasRLlPydMGXTgabMX
         Q2vCsUlOAwhORlKYu5Ralg18C9m2opcMtXQUiHVmjrI//zb46WkTXynw9d1QwCa4GKQ+
         SUhJCe630XQEw+GcNEadxebuSRggH+4lIXNEIXrZbQvZuEGEB1EZdktUTXitJOo7FnYT
         qsY4Gg349sf1WnC0+Kd8v6UMJC09StwnTdynBDQKD1FUEFXdrHSOk4RZkmB9SrlHlv7e
         39ROAhdBAFklxu5tOXlvoiSn2A14zyQhgAGptXZXzJ0zRK6q4CTLPSftYPJl4J+fLzef
         AFnw==
X-Forwarded-Encrypted: i=1; AJvYcCVOv9x2whdx4GCqNMvjltqs7/OWmulCNhcW6+Uu0Mmev0VQXm/nlbwg768+zuHhsgDlz0u1SMCRrHlDhrxAeqdaJTrPeE9rs9bUs/LYNn7U
X-Gm-Message-State: AOJu0YwY9Xto41LMbEOvH2IRNE8TZ9rr5OttPSPPjwzBBeNM7kGPIocL
	jpCj4nOthTr/jkDlrA4N5qXB96TrNuXefn43WlKXz+SQMa2AquZ1Xx3LbdT0e/Q=
X-Google-Smtp-Source: AGHT+IG9re6t40lyf8IdYltt5CBUI3acIidUi85hXApG7sv7vG/8+wTH66jZ1tx84BINBT6FBsVnlA==
X-Received: by 2002:a05:6512:e95:b0:518:8d5b:d44b with SMTP id bi21-20020a0565120e9500b005188d5bd44bmr3196326lfb.38.1713005607098;
        Sat, 13 Apr 2024 03:53:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id sa41-20020a1709076d2900b00a4e03823107sm2841723ejc.210.2024.04.13.03.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 03:53:26 -0700 (PDT)
Message-ID: <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>
Date: Sat, 13 Apr 2024 12:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
To: Lukas Wunner <lukas@wunner.de>
Cc: "M. Haener" <michael.haener@siemens.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
 <ZhpjozjbeWrb0OTl@wunner.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhpjozjbeWrb0OTl@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 12:51, Lukas Wunner wrote:
> On Sat, Apr 13, 2024 at 12:43:38PM +0200, Krzysztof Kozlowski wrote:
>> On 13/04/2024 12:34, Lukas Wunner wrote:
>>> The other patch just adds an entry to of_tis_i2c_match[] in the driver,
>>> pretty unspectacular:
>>>
>>> https://lore.kernel.org/all/20240413071621.12509-2-michael.haener@siemens.com/
>>
>> Then why is it needed?
> 
> The binding requires two entries in the compatible string used in the DT,
> the chip name followed by the generic string:
> 
>         items:
>           - enum:
>               - infineon,slb9673
>               - nuvoton,npct75x
>           - const: tcg,tpm-tis-i2c
> 
> This allows us to deal with device-specific quirks, should they pop up
> (e.g. special timing requirements, hardware bugs).  We don't know in
> advance if they will be discovered, but if they are, it's cumbersome
> to determine after the fact which products (and thus DTs) are affected.
> So having the name of the actual chip used on the board has value.

So you say devices are compatible. Then the second patch is wrong.

I cannot respond to it, though... so NAK-here-for-second-patch.

Best regards,
Krzysztof


