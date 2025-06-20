Return-Path: <linux-integrity+bounces-6491-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D9AE2492
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jun 2025 00:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66AA1BC56C7
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD76235360;
	Fri, 20 Jun 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7AEBWiu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205130E842;
	Fri, 20 Jun 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457051; cv=none; b=WnncHKAvIio3px6Tny+gW3gupg4VEIUGHGGMkEKgxu3tDbq8Vz4WdOGosAXoTxvmfvuxfMQUhFpFQYbIGtDPC9rVjV06lEjhXSyalVUEoK84ewoFOSfPo0pXijLZkSK33xQI2AskiMBEsSmINUeoR5AfoqNoQwg9z+PgMoC3tCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457051; c=relaxed/simple;
	bh=d07hJ6Rjbq+PSu/Ww0M3IcYcg882+W7cQqBcsa8aD+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu1m69h+IiWsgI1uSC7etWLrZS2ph9ZAxVrYPCieHlwhDYPYnVChMAJ5U623zb1myNbya30FuY53BJKlpLjPhIXITJquO8WAWrDdxm7D9nfaPeaWsjrEJ4u4pdK4Zs3EY8/AjsiCXOqHcTUII6b6VsnBSR1UcdxNitHrXKUaUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7AEBWiu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54690d369so1957381f8f.3;
        Fri, 20 Jun 2025 15:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750457039; x=1751061839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oz8QIOYbFj0TNa6sGufzeLOjJJb6kmsCaDn0dfnPyAc=;
        b=d7AEBWiuJTSXn1JqsAhHIJGZAa3ow9G35pF8yO3TAmsFeyKD7LyJdhpalJd112pvv0
         CUAL/RZtQhZTDz/lfF3CCgeds6gbFsol/UYHFhdiC+t2fNNZVBgsZhFTB+TO5FjGLj2J
         tRW0EjK5mGyRV0jtyJizjw6769Q535gS1RTI+/sLSskY9zRy57SjkJ4csfGrgzSeOWoO
         /3tM0xDaAdtUq5Kmn49GewGrwvY0SJZ3qxbKmahlhPbov4WcTFPEabFFgkeUS5szEsNf
         jQC4bUX3Vgfuibjwo00DJpQfzRcJlKbpp8jH84A1XLWOyaOxmeSeGvPsqsfbbGmzZM5x
         WW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457039; x=1751061839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz8QIOYbFj0TNa6sGufzeLOjJJb6kmsCaDn0dfnPyAc=;
        b=t2X2WD5Dwhzqd/SzkZa++mBdJiXJ72Vx2I4nD+GIKarjquMHlPcE8SZiUGfFYV19vY
         Oolr5pVB2klnXQ1ItQ4EZGZoqU5fNy3BI0PYXn6NCP2oWWiZF/S4ER3F8V5Aw2hHOz5B
         jHkICL5B/2Wa2T1qgX0siWh/3NUybk2SycjYxymd1fwAhikxx2+JVMc6baaU4p9G9MkI
         DN/fcfimKJ07SxH/igZNSaF8Z5OJ+Fbdc3dbpopULKdnYT7vpVygVVWcNpPQOzQBbId/
         qjy8EYAJ/oT7LHIUwaosI/eTDXNz3eIJFv+Pr7iJ+p5Jfsdhcqp6PMABisYOoXNVDJpt
         QJDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlVqa2lhmHLy3axiFxlzf9Xx93KYgixkMfcioZz5UzFf3tMIReADvNMDuQDE4cn0nhjoAv7T2TcLeIRxZiAbo=@vger.kernel.org, AJvYcCWAoQoifqzuDWUK7T+456xCavU1wcGdUin5mX3fvuT8Y7GJ9UHnGbzv/uJrSY84g0L4zwqgAUfa1mkl7j0R@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1n/hgDr2LcmUw/bQ2+T7gjDQG9djTRzNfcIZMHPw39r/QWLE
	by+nk0RYAOORW22vIpjTSgEhYgxxZXkFsKuHaLdK7CmB6OTL+rZxVgm0
X-Gm-Gg: ASbGncsp6Rl495UkDVL8V3X3rMHmSpQd29bbVce74OtocNxWaNedIbkGbQRBWVIKxc7
	Cm6BPBpkmY6Tk2QGg4SLBnAbSOZhq/PUSZt/VhpFRfQHB9UhzfEzzqL5PZksvc0N9VvKKGHwuDi
	jlVEbYCQDElUYDNz+aBGZKAog2hXupgmSukdl0YTqxrMgkJEcButhzJvVJaj+YIuPY7j7VwAZpE
	M0nyCSs3niccuV7kMV3ZRGY7TZVDFT1F293YfAxar6XzkAvgIHZnx8jdht5E7uE7k85USzNiIAc
	NpD+J2SqMaPoNJHdya2xqaSt+0gABmtnBKtfpN0mgrKbeATE6iyxsYnB6yzIEusWoffOUbTHutH
	KZL+94SGDBD/oVU8itmjXOpymrxnt5NZ+VWZfwaIN7NCzg+34cnGBrZcaTgYbVjnN
X-Google-Smtp-Source: AGHT+IGctfem5DT2m4nFhQuJ4Ql5AdykZp/1cRHFZZ0EB27pGUBXKqGZQ2qdPRZGMP7sSzFGmKuuPg==
X-Received: by 2002:a05:6000:2002:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3a6d12fc180mr3969857f8f.59.1750457038982;
        Fri, 20 Jun 2025 15:03:58 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:2d99:6c72:4a01:6a78? ([2a02:8012:e013:0:2d99:6c72:4a01:6a78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb5ecsm37586885e9.8.2025.06.20.15.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 15:03:58 -0700 (PDT)
Message-ID: <d8167814-875a-4a3b-9b44-331532eaafb4@gmail.com>
Date: Fri, 20 Jun 2025 23:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
To: "Orlov, Ivan" <iorlov@amazon.co.uk>, "peterhuewe@gmx.de"
 <peterhuewe@gmx.de>, "jarkko@kernel.org" <jarkko@kernel.org>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "noodles@earth.li" <noodles@earth.li>
References: <20250620180828.98413-1-iorlov@amazon.com>
Content-Language: en-US
From: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
In-Reply-To: <20250620180828.98413-1-iorlov@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2025 19:08, Orlov, Ivan wrote:
> The current implementation of timeout detection works in the following
> way:

Ah, I forgot to remove "& use ktime" from the commit title. If there are 
any comments regarding the patch content, I'll fix it in V3. Otherwise, 
I'd kindly ask to fix it when applying. Thanks!

--
Kind Regards,
Ivan Orlov

