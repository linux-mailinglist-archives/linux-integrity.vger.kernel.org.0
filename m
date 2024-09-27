Return-Path: <linux-integrity+bounces-3710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9497987F2A
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3261F2245C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24016E89B;
	Fri, 27 Sep 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3JoG31Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC66BFC0;
	Fri, 27 Sep 2024 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421165; cv=none; b=inkO7nBk50kX+kssAmOX8J6VGmK1otv2KUWax2ru1ROatATLXjBPzImQVOmSnqJNF6dHhqvIsxmiEonIDTzOMs2ZzjLYAansxeS77jaYcMFs5v09NJrMhYk0WBLbHH9ShIdc4U+r2l0uyp+CieWnfGOEX2gQGlr3iTEq3n3BYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421165; c=relaxed/simple;
	bh=cio1o5IurKNwuIpAly/OV6gI1NaIP2BOcW/IDsaOapg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFg7X7XU9tJjv1/1whEwyfWYUwH4ZV5ZkM0ha07T6U+I0E8K+rw1G4tev/52EKlMUtMfXNTslHEUgIdzb4HT29slz17F6UDYmTBdQxXipQZ/Ahus8PY5sEWyqH1ZKqDAOCE0fh78mc1gYfF2E9wXVTq/yPlDLLd75jWgaSbsrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3JoG31Y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d24f98215so243494166b.1;
        Fri, 27 Sep 2024 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727421162; x=1728025962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+Ffj+Tps2rgenFO7SDx+Hw2LCXpsYIAcy4tw3rNXyQ=;
        b=F3JoG31YdPdS0ZI+eVXIQTkDvjtB51MXvFTRuksQg9tx/XH3FaylQPCNdq8NctFAF6
         W0qy7FI6K2vJV8sTaswRS59+cEQfhLGnOGPPQmEtz/BcL1KNHv+Ds9eJ640zHvs0QoTR
         nVQwue0VuSqm3V3Gp8KXvuYPjd/VcmJV5AEU85iYBnOtw+8iEMKUk3BjDX1kxeJn6fSL
         I7PAzRLi0TvbyFe5jzSwbuQEuk5oW1z3Er/H8WOSZy3xpksp0UZBrptz0e7XO7Bz3nPp
         sQAdxFWnmJh2EMN8q3qCpLL33V1PJy3XQQGudwhJr6bMh5YnKpV7RytNxCdQfUyzN5Za
         mPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421162; x=1728025962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+Ffj+Tps2rgenFO7SDx+Hw2LCXpsYIAcy4tw3rNXyQ=;
        b=MnfCSsn+iHqAkIPTX0LUAdNVrD7Rd2uW6Cu6HS/KyADHHBlZtkKOunCYhdhP5JE90F
         r4q3LRZbCeglZHgzivwcXydiJRSszuOrY9bbX0ODiBkhtklZRLSMmj9OMLtMERFNcTkl
         EC9WgWiWbdfNgd4BHJujFW+tTpFvgfcmrRTmobwlZfyjTD8cnZSckz2ROkvAXYw2Vst3
         c+qA/Wyefl/zcOY1vCEPnHTOzRtNYFbJv9Z8YHGeySuZ/8zHS7AJ1DjBF2cvWfN+zoEv
         gL2xLXERAymFQZUHV2p6bVoa2qSAsOPRI9jcRVKcAIN2QXcTpkA0u7zAQ2O6XTrnCn4q
         TYMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4XJSwNxhM3bbNysPc+q9ZcizK72M0hQw1zaBXfOIKPveie1IIaXDqVdQumIW3gFejuBXIDZDj0Q==@vger.kernel.org, AJvYcCWo9Ulfh4vZXMDlG37dUTwPNm40U4s9LBIHeZe7ptD1qyu2C3nGUInMrnZaDMIyHgMDouS3HIHyTrEmZ7rFfK6b@vger.kernel.org
X-Gm-Message-State: AOJu0YwAw+TNf1ml8sKjJEdO8DngO2r2VJt/U0z6yxE/g/yBv0eubMIs
	L+72xtHdY0WJGiFLTZnOAQEQczbfoLNf+meBvDK9GQMCi6ghL215
X-Google-Smtp-Source: AGHT+IHxmODD/qFIHB5xnYxt+qaFwv616CLTVcHa9VfoKBfORQh79v5gKph6zFK7BABbBwNgGfyjtA==
X-Received: by 2002:a17:907:981:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a93c48e900cmr191497066b.13.1727421161716;
        Fri, 27 Sep 2024 00:12:41 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776cesm91496366b.40.2024.09.27.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:12:40 -0700 (PDT)
Message-ID: <08fe559f-f5b8-497f-b7aa-6e61e5c1aeb3@gmail.com>
Date: Fri, 27 Sep 2024 09:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 snitzer@kernel.org, serge@hallyn.com, wufan@linux.microsoft.com,
 David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
 <CAMw=ZnT=3n+1n6z0HE7JPNFX07fAJS+5W+SeO4pddrcUcEpjZA@mail.gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <CAMw=ZnT=3n+1n6z0HE7JPNFX07fAJS+5W+SeO4pddrcUcEpjZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 11:28 PM, Luca Boccassi wrote:
>>
>> Do people use veritysetup (libcryptsetup) here, or does it run with its separate userspace tooling?
> 
> This is used with libcryptsetup commonly, and often with veritysetup.
> It is fairly easy to test in a VM or on baremetal, it is not required
> to build your own kernel - that's the reason for supporting
> secondary+platform keyrings (the first one allows you to enroll keys
> in MOK, the second one for UEFI DB).
> We would even have a CI testing this for every PR and merge in systemd
> on Github, _except_ there is currently an issue (unrelated to
> dmverity) that happens when nesting KVM with UEFI secure boot enabled
> on top of HyperV, which means it cannot be used reliably on Github
> Actions. Once that is solved, this will be again part of the systemd
> CI integration tests. But it is used regularly by developers on their
> machines.

Hi Luca,

good to know that libcryptswtup userspace is then used here, thanks for the info!

I have some more questions, but that is not related to this thread,
I will ask in another mail later.

Thanks,
Milan


> 
> It might not be commonly used by kernel developers, I do not know as I
> am not a kernel developer, but it is becoming more and more common in
> userspace and among image builders. For example the mkosi image
> builder, using systemd-repart, can very easily build distro images
> using signed dm verity. I am at All Systems Go and just today there
> were multiple talks by multiple people using dmverity images for their
> distros/platforms/products, especially with systemd-sysext, which is
> all about signed dm-verity.
> 
> In 6.12 we will also have IPE which allows to enable trusted code
> integrity checks that cannot be trivially bypassed by other userspace
> processes running with root or caps. This has been, still is and will
> be for the foreseeable future, in use in the Azure infrastructure.
> 
> Hope this provides some clarity, let me know if you need more info.


