Return-Path: <linux-integrity+bounces-6655-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236BDB0B1BD
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C295F1AA0B89
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE280C1C;
	Sat, 19 Jul 2025 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7SJuOgP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9860DCF;
	Sat, 19 Jul 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752956381; cv=none; b=uDrsQc5ryaKWbF9XUrPPl448mO7ioJLFZcyMNoQiUqvMHdIbqYW6BeLuAAJGBfsRQgmIp1g7h8rWjYJQZ1l8Pk1btlM1Yxa/ugJ2GttPeB5tAYpcUib1ost8dGkPrEyAYqs41U2u2ith1lpeuAiiBy0kvxupkZaQMthtQpK9dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752956381; c=relaxed/simple;
	bh=WUOZ4CBvuT6G+tNJzZLzusExlVIshtY5HhSOaMb4sX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLxQnc0ijCGtiSsLLYQn3UxTXiAPQ7MKCEGxienbEsZ89YE43LLDnk6SG1z9NQjiVPUP7jaiHE+jekTQTTTCRwOpQ9OTUkeE1p4OIlW7B6Nj5GgUHL17V7EJoj3LSvmI3jmjoCqFe6t2FxDYIzp48Y9GvekrAmuHmsD6HsLV5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7SJuOgP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45555e3317aso19093235e9.3;
        Sat, 19 Jul 2025 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752956377; x=1753561177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRTVIYptpnDz3fJVjJC5j5+H/NQXJSGI0Hk/vnTQ4/o=;
        b=F7SJuOgPjRueqpyZFQ4Mnj+vGpBmQx77rR2dzTSGn2P5oLUe0Tp9hm+q27oxSAsynO
         nXaBQGWjImBbbda8GdR365fMhh/r0imXW7HP93lV1DZIs5Jm4bfsyuwRTMbf1X5xSOLn
         4bs26QEs5t5qaiShJa6NHsDXvBEqhDa7lpcT+s8jXd0tpj2o+VFkA1ZmKibS0TSqwGCE
         Kb6awNTsEfYjg6ll0FK4ogxMHHrVZTqJj1jgcxtc9NBPkGiF4ukgMLSaF+ilS5xVJfRI
         OCpiKfTNd1xuiAfQsJBclBjHV2u4fnLoIEaTAErMCLQhMMg3ghZ7AJ4Cf1GktIbLGK4m
         8s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752956377; x=1753561177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRTVIYptpnDz3fJVjJC5j5+H/NQXJSGI0Hk/vnTQ4/o=;
        b=GdSgzx1cSD93A1Fv0rt9F1aKAekssJAzAndKM/H69iNrBtsyte83+5hzGqCdz7pPXW
         LetX1e3vzy3Faw935JrloZJ/exg641Lt8UXDEum7/rsNwHURDnyYqdwJtwwhJ1Rdz4od
         tL1nYTxNJPrOe8UCCo+YP+Dw/Nc7F3BS77yPZZOdx9yryW6Rg6XmB3yEIJyGVLyrHgMV
         dUvcMOJuPMbS7hfWB7N5fkFQhCnfVVpH9aA9wbmgtCUqY8YLEecYQQXuM8GQqDbFfJRU
         Sny6lqLkw9lq8kIOdgTk1bvQX+aayTtmA2Tqo68pd7UEkaAGrVsFQPAG38bNDYYlpHX7
         Tm6A==
X-Forwarded-Encrypted: i=1; AJvYcCVcbBfbd93wQMQCB3341FnEGBkr0wxq6v3Yyl+bt9yd4wyOnVVA9XNCqx/swxrGZVSfDmIEYOqYEGaApHtl66U=@vger.kernel.org, AJvYcCWTom39gYm0H6tAcS2YTSO0hv8YHq2VxzBLByCRC6CPdhzAYkuhk91vWpPYNZ1hE0ZLWvPLTZAwFn2sB+un@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrWUzaDfYwqyqQ2RNkSE327I34u3aiSs/k9+POm0MvpDEdCmr
	wiev10LCgzxrCGfoz3U/ChDQfxRfuYn6qUEi4D0N1mTLicajJkahOnV2
X-Gm-Gg: ASbGncuYhy7ppFXCoowA/43hnuwZ7T8r2MiVBQsyL4k8U/sjAOku4f+fwJ45SjWQLNn
	jWpnANQarbpSoinda6zlDg8Wgme886cSdGpftqF+V719ROtOfkXW8+N8h4vYQLDQGEy5ESEp2r4
	kMDhFtsBl2agBg2mNsNKCuCabLDZXo5VGVE0AFoOvEN4X9d8P8xewEveUTPOqRCpyMmCzqVhG6S
	S/RFeo/PzDGnzC3piKGKxRJhyGfy46S+ywcXrb+QvYAUrgaRGean9ggZJdK3jaj7FpzCdSHPcx/
	gf1DoLBjIx6sLzWbP+g3ue8RiCpDQgIx4K9WOLHB7SPQiCSbl3Tf0ovUNG8VsBSWg+YqG8suRnw
	3g3Vu4MRbMIv8ieHrjIxPOM1lFS59LaomRVUYRlR9yTTge1Hy8HpMrcVNrrDext89Yo3W3m6E5I
	sy6eWQ6sGSSAqA+g==
X-Google-Smtp-Source: AGHT+IHieEJ74dUxyzUV1h/rd1uzDov8dae+Y7vMOy+mHC8LdGNQSchURWlWs5YFDkuGz6ct7/aM6A==
X-Received: by 2002:a05:600c:3f09:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4562e38aab0mr132251265e9.18.1752956376990;
        Sat, 19 Jul 2025 13:19:36 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:6193:613e:2fb5:a70b? ([2a02:8012:e013:0:6193:613e:2fb5:a70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5b78d0sm56392135e9.8.2025.07.19.13.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 13:19:36 -0700 (PDT)
Message-ID: <c37b4aed-4a7b-4206-bc61-67a579933ba7@gmail.com>
Date: Sat, 19 Jul 2025 21:19:35 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, "Orlov, Ivan"
 <iorlov@amazon.co.uk>, "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li> <aFwnG--lzZO0mQgc@kernel.org>
 <aGeYqQG15lb2_NaU@earth.li> <aGfwPbMZf-SHshXH@kernel.org>
 <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>
 <aHuDj36Qa6iKsvkn@kernel.org>
Content-Language: en-US
From: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
In-Reply-To: <aHuDj36Qa6iKsvkn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2025 12:37, Jarkko Sakkinen wrote:
>> I believe this option would work for us as well. Please let me know whether
>> you'd like me to send V3 or you feel free to send it yourself if you want.
> 
> Please send one more patch. I just came from holiday and now have
> hands full backtracking last two weeks.

Hi,

I've just sent a V3. Sorry for the delay, these were busy 2 weeks :(

--
Kind regards,
Ivan Orlov

