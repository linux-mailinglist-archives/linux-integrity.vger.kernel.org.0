Return-Path: <linux-integrity+bounces-2118-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A338A437C
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Apr 2024 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0334B1C20927
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Apr 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE713473E;
	Sun, 14 Apr 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnx2CSd8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46713443F
	for <linux-integrity@vger.kernel.org>; Sun, 14 Apr 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109441; cv=none; b=OuWPrMjWOqwPCoMdg4DJFBpaMY0hCIhtyk4P5qntnQ5KAr7QfZ0KTpK4L0Fe8RfFK6B3PfpyEqukWk9IU6+D8QwztF2J4Gvt2Bn26f3NE+0zfqegZVfwNiN5ykIm2sb2cgZLa21nu//ucEf2qR3E0Emf2KnJLXyW1jI5Ky/PQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109441; c=relaxed/simple;
	bh=rM/zZ19SsomcGL4Q22Ri2+/vmBBE8hSCxOLnkIrVZV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hVGmDcGk5ynrQw4/lrSQ1v7PMufPgr95isszQjXMF4zi0GkQb8KBxitkWLL+07duj57sxWM/gmhW1LOPhKHOouwfoO0dyMi97coo4G7+zwTea0/5XFl76+hoOdZp4dvGiqsD4Il5fJSgwG7lIjiB7UP1qp+0Hh3/Mi8PC0xnqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnx2CSd8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5224dfa9adso380691066b.0
        for <linux-integrity@vger.kernel.org>; Sun, 14 Apr 2024 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713109438; x=1713714238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qeal0b8xcQSYS7bxWMu2Wl0VNhf2UUEMGzukE/4gris=;
        b=hnx2CSd87ComQvEpw0z0B+te/OZ0e3vdVPUkBhNh+vB/omG7jSq1DhxdswPTTUcLvc
         p2KRUGvxG/QnAzQaKIeuLpN0Z9XvHq4Ino0ikeBG7YNl5kZx6M71sxp6pQZCHXfkZ5H1
         klFp287jkxsjysaiTAZ8ystWGRsm1LWCEydPl15Rvy0ifCxaOGAkyVYURq6DFSOV0YYv
         n0zib4l2U58bIJ/n0QhQf2cJBG9ugzZg0KReyNWuB6dQ3Yh03emxJcW3nHBFEkY+bbBm
         LTdjh4AAPzM3UIQRphOkm+rapnd0XJPjCr+XE2OZGlF7gM5VSr5HQkvb2xfX1Em2GorS
         RxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713109438; x=1713714238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeal0b8xcQSYS7bxWMu2Wl0VNhf2UUEMGzukE/4gris=;
        b=spEqkmL8db/259YsY77uvA3u+XxJ4jkYEbt5qLIVk6+LyRkt8gNbDRZWptY4exqzls
         G+HKhEQhkqlj3cgWGZUkoI8dzc7mE6Z1zsFVRBEmtocA3N7VNGzNC3w4vgeHm+wIOrwM
         rRpxwbjyvQej/OC6NW5Ry6JMcTx3l6ra4sZE/3wE7OlOkFMeXCrTJtFY5WhWjTvY2pn7
         lgyMHTqbltiCPQJLwc18c1V91tgnNMSnmjNVlE9CCnf6ylBN1MIvpfGE2q8Yh1KVoeu/
         vrlZIEEz5sTXVE7D1L8j39m37Owd6ccpzF8UG2Jrr7JsoDRWQhUIowhUDXqvS5arweLz
         fOIg==
X-Forwarded-Encrypted: i=1; AJvYcCXLfqOnRWvVtGMcG1jn+fRjwYKfaNhrqeZDylYW1bi7VnB1mbY/vWZZaNZ45Q6lwB8pM0Tf4L6OpTFKzuMe1ouQ1d8Tlp0wG13u9uFsnF8K
X-Gm-Message-State: AOJu0YwJByVQtLi5i7VX1FgFmih75BgtVPF+NDyOVvwYhAT/ep2dwgnT
	DSDyg0RRTAn0qtlvg0s3ZTLuXLqQyg3gIsnkmHENZzr4G4o/ALNlTknBnQ==
X-Google-Smtp-Source: AGHT+IEGCR2A0TEt7r0Gk9m7GvY98tz8M2DFoxG2MKT/vG94bCjV2loqAUmc+V6HDB9XYphDXkRTJA==
X-Received: by 2002:a17:906:eca8:b0:a52:6b76:c722 with SMTP id qh8-20020a170906eca800b00a526b76c722mr218907ejb.9.1713109437702;
        Sun, 14 Apr 2024 08:43:57 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id l21-20020a1709061c5500b00a473a1fe089sm4317187ejg.1.2024.04.14.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 08:43:57 -0700 (PDT)
Message-ID: <acd54b09-c5b9-4548-a24f-95c503e20139@gmail.com>
Date: Sun, 14 Apr 2024 17:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm-integrity: 4k devices report 512b discard alignment
To: Eric Wheeler <linux-integrity@lists.ewheeler.net>,
 linux-integrity@vger.kernel.org
References: <447e2027-bfe2-9c21-a5ad-291e16b78f28@ewheeler.net>
Content-Language: en-US
Cc: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mikulas Patocka <mpatocka@redhat.com>
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 xsFNBE94p38BEADZRET8y1gVxlfDk44/XwBbFjC7eM6EanyCuivUPMmPwYDo9qRey0JdOGhW
 hAZeutGGxsKliozmeTL25Z6wWICu2oeY+ZfbgJQYHFeQ01NVwoYy57hhytZw/6IMLFRcIaWS
 Hd7oNdneQg6mVJcGdA/BOX68uo3RKSHj6Q8GoQ54F/NpCotzVcP1ORpVJ5ptyG0x6OZm5Esn
 61pKE979wcHsz7EzcDYl+3MS63gZm+O3D1u80bUMmBUlxyEiC5jo5ksTFheA8m/5CAPQtxzY
 vgezYlLLS3nkxaq2ERK5DhvMv0NktXSutfWQsOI5WLjG7UWStwAnO2W+CVZLcnZV0K6OKDaF
 bCj4ovg5HV0FyQZknN2O5QbxesNlNWkMOJAnnX6c/zowO7jq8GCpa3oJl3xxmwFbCZtH4z3f
 EVw0wAFc2JlnufR4dhaax9fhNoUJ4OSVTi9zqstxhEyywkazakEvAYwOlC5+1FKoc9UIvApA
 GvgcTJGTOp7MuHptHGwWvGZEaJqcsqoy7rsYPxtDQ7bJuJJblzGIUxWAl8qsUsF8M4ISxBkf
 fcUYiR0wh1luUhXFo2rRTKT+Ic/nJDE66Ee4Ecn9+BPlNODhlEG1vk62rhiYSnyzy5MAUhUl
 stDxuEjYK+NGd2aYH0VANZalqlUZFTEdOdA6NYROxkYZVsVtXQARAQABzSBNaWxhbiBCcm96
 IDxnbWF6eWxhbmRAZ21haWwuY29tPsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AWIQQqKRgkP95GZI0GhvnZsFd72T6Y/AUCYaUUZgUJJPhv5wAKCRDZsFd72T6Y/D5N
 D/438pkYd5NyycQ2Gu8YAjF57Od2GfeiftCDBOMXzh1XxIx7gLosLHvzCZ0SaRYPVF/Nr/X9
 sreJVrMkwd1ILNdCQB1rLBhhKzwYFztmOYvdCG9LRrBVJPgtaYqO/0493CzXwQ7FfkEc4OVB
 uhBs4YwFu+kmhh0NngcP4jaaaIziHw/rQ9vLiAi28p1WeVTzOjtBt8QisTidS2VkZ+/iAgqB
 9zz2UPkE1UXBAPU4iEsGCVXGWRz99IULsTNjP4K3p8ZpdZ6ovy7X6EN3lYhbpmXYLzZ3RXst
 PEojSvqpkSQsjUksR5VBE0GnaY4B8ZlM3Ng2o7vcxbToQOsOkbVGn+59rpBKgiRadRFuT+2D
 x80VrwWBccaph+VOfll9/4FVv+SBQ1wSPOUHl11TWVpdMFKtQgA5/HHldVqrcEssWJb9/tew
 9pqxTDn6RHV/pfzKCspiiLVkI66BF802cpyboLBBSvcDuLHbOBHrpC+IXCZ7mgkCrgMlZMql
 wFWBjAu8Zlc5tQJPgE9eeQAQrfZRcLgux88PtxhVihA1OsMNoqYapgMzMTubLUMYCCsjrHZe
 nzw5uTcjig0RHz9ilMJlvVbhwVVLmmmf4p/R37QYaqm1RycLpvkUZUzSz2NCyTcZp9nM6ooR
 GhpDQWmUdH1Jz9T6E9//KIhI6xt4//P15ZfiIs7BTQRPeKd/ARAA3oR1fJ/D3GvnoInVqydD
 U9LGnMQaVSwQe+fjBy5/ILwo3pUZSVHdaKeVoa84gLO9g6JLToTo+ooMSBtsCkGHb//oiGTU
 7KdLTLiFh6kmL6my11eiK53o1BI1CVwWMJ8jxbMBPet6exUubBzceBFbmqq3lVz4RZ2D1zKV
 njxB0/KjdbI53anIv7Ko1k+MwaKMTzO/O6vBmI71oGQkKO6WpcyzVjLIip9PEpDUYJRCrhKg
 hBeMPwe+AntP9Om4N/3AWF6icarGImnFvTYswR2Q+C6AoiAbqI4WmXOuzJLKiImwZrSYnSfQ
 7qtdDGXWYr/N1+C+bgI8O6NuAg2cjFHE96xwJVhyaMzyROUZgm4qngaBvBvCQIhKzit61oBe
 I/drZ/d5JolzlKdZZrcmofmiCQRa+57OM3Fbl8ykFazN1ASyCex2UrftX5oHmhaeeRlGVaTV
 iEbAvU4PP4RnNKwaWQivsFhqQrfFFhvFV9CRSvsR6qu5eiFI6c8CjB49gBcKKAJ9a8gkyWs8
 sg4PYY7L15XdRn8kOf/tg98UCM1vSBV2moEJA0f98/Z48LQXNb7dgvVRtH6owARspsV6nJyD
 vktsLTyMW5BW9q4NC1rgQC8GQXjrQ+iyQLNwy5ESe2MzGKkHogxKg4Pvi1wZh9Snr+RyB0Rq
 rIrzbXhyi47+7wcAEQEAAcLBfAQYAQgAJgIbDBYhBCopGCQ/3kZkjQaG+dmwV3vZPpj8BQJh
 pRSXBQkk+HAYAAoJENmwV3vZPpj8BPMP/iZV+XROOhs/MsKd7ngQeFgETkmt8YVhb2Rg3Vgp
 AQe9cn6aw9jk3CnB0ecNBdoyyt33t3vGNau6iCwlRfaTdXg9qtIyctuCQSewY2YMk5AS8Mmb
 XoGvjH1Z/irrVsoSz+N7HFPKIlAy8D/aRwS1CHm9saPQiGoeR/zThciVYncRG/U9J6sV8XH9
 OEPnQQR4w/V1bYI9Sk+suGcSFN7pMRMsSslOma429A3bEbZ7Ikt9WTJnUY9XfL5ZqQnjLeRl
 8243OTfuHSth26upjZIQ2esccZMYpQg0/MOlHvuFuFu6MFL/gZDNzH8jAcBrNd/6ABKsecYT
 nBInKH2TONc0kC65oAhrSSBNLudTuPHce/YBCsUCAEMwgJTybdpMQh9NkS68WxQtXxU6neoQ
 U7kEJGGFsc7/yXiQXuVvJUkK/Xs04X6j0l1f/6KLoNQ9ep/2In596B0BcvvaKv7gdDt1Trgg
 vlB+GpT+iFRLvhCBe5kAERREfRfmWJq1bHod/ulrp/VLGAaZlOBTgsCzufWF5SOLbZkmV2b5
 xy2F/AU3oQUZncCvFMTWpBC+gO/o3kZCyyGCaQdQe4jS/FUJqR1suVwNMzcOJOP/LMQwujE/
 Ch7XLM35VICo9qqhih4OvLHUAWzC5dNSipL+rSGHvWBdfXDhbezJIl6sp7/1rJfS8qPs
In-Reply-To: <447e2027-bfe2-9c21-a5ad-291e16b78f28@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 3:05 AM, Eric Wheeler wrote:
> Hello all,
> 
> I'm not sure if this is a bug or a feature, so thought I'd report it.
> These are all for Linux 6.6.26:
> 
> If you start with a 512-byte backing device (logical and physical):
>    # blockdev --getss --getpbsz  /dev/nvme9n9
>    512
>    512

Hi,

this looks wrong. But you should send it to dm-devel list (added to cc) ...

Maybe also add lsblk -D (and lsblk -t for block sizes)
(where you can see inherited values for all layers).

And I see similar problem in dm-crypt with 4k sector but 512B discard granularity
(on 6.8.4 - LUKS with forced 4k sector and alllow_discards).

What is interesting, for current Linus' tree I see discard granularity 0 (?), but
with Mike's DM for-next (with use queue_limits_set fixes) it correctly shows 4k.

(Ditto for your integrity case. So perhaps linux-next is fixed.)

Milan



> 
> then format+open with 4k sectors:
>    # integritysetup format -s 4096 /dev/nvme9n9
>    # integritysetup open /dev/nvme9n9 integrity-nvme9n9
> 
> and find the dm-X device:
>    # ls -l /dev/mapper/integrity-nvme9n9
>    lrwxrwxrwx. 1 root root 9 Apr 13 17:09 /dev/mapper/integrity-nvme9n9 -> ../dm-189
> 
> then check it's discard_granularity, it shows 512:
>    # tail /sys/block/dm-189/queue/discard_*
>    ==> /sys/block/dm-189/queue/discard_granularity <==
>    512
> 
> The sector size is 4k, so supporting unaligned discards seems at least
> strange, if not invalid, and dmesg complains too:
>    # blockdev --getss /dev/mapper/integrity-nvme9n9
>    4096
> 
> Relatedly, should the physical size of an integrity volume "properly"
> report 512 to match the backing device, or is 4k correct in this case?
> Presently it reports 4k:
>    # blockdev --getpbsz /dev/mapper/integrity-nvme2n1
>    4096
> 
> Finally, this is what made me go investiage: when you issue `blkdiscard`
> on the integrity volume:
>    # blkdiscard /dev/mapper/integrity-nvme9n9
> 
> it causes dmesg spews the following:
> [ 2508.364637] device-mapper: integrity: Bio not aligned on 8 sectors: 0x74ff8000, 0x7f0f
> [ 2508.364856] device-mapper: integrity: Bio not aligned on 8 sectors: 0x74ffff16, 0xea
> [ 2508.365070] device-mapper: integrity: Bio not aligned on 8 sectors: 0x757fff0e, 0x7
> [ 2508.365973] device-mapper: integrity: Bio not aligned on 8 sectors: 0x757f8000, 0x7f0e
> 
> What do you think?
> 
> 
> --
> Eric Wheeler


