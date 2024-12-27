Return-Path: <linux-integrity+bounces-4490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F99FD60B
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5F73A2A6C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EA1F76C1;
	Fri, 27 Dec 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Zt7lHEvL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385B1F8662;
	Fri, 27 Dec 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317621; cv=none; b=uNvAe7/yW0X3GSkdXbumO3YktC3Rlx8KWfw3pJ0xsB2fN3nvf/oCJ4LD03LLuMAP5YTBfaQwuZb3u4U77kKm4ECIwvaHIl2s1JD7ZbEeFzNAei9DuqamRc+JPv9Fgn3mcUZEjz6MNtYuFNI0xv/JFTKi6OiohySQ1KnXZeFGFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317621; c=relaxed/simple;
	bh=m34uzEhxEFm8Pkht0brnD9Kz7nFsyXOA51OvSgJ3DVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwZxSr1T4w2vXyiY764psuWD3H3mgidp+uVcNYi7bwVk+oUpL6RefFEyuNWz/1ScBpJJegJXZcrtJPdEM+Jt0UnheX1+QXy08G1DaA0kXt7I9nk+SUM3cUMi/vZuPAX8xOrDN/g2dFRiso3pboANu7kpc/1VGix2tLPV4LFktns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Zt7lHEvL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3561110408FAF;
	Fri, 27 Dec 2024 17:40:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735317617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDOUthU7q4/qupG9iVWUrtQQQgRrjg8BgH9r7Z4OERQ=;
	b=Zt7lHEvLwnywX5A0iM5lO0i7k4jf5RIQ83CWlR2bzGay7UL/7+g2+qTg3IZmXU4KXylfSN
	Hh1gvc3zLKckwYYkaFPMsBMN05W+XG5kEFZ4LbfCfhF26vK/a9VeiHNELD7YLtzNgeBWqM
	oBnf6P/wBGCTB95Z3A4BiW5+tL6+v0/XfrfhpJYesN6bC/B9SBaSaOkcn3G1+mNTCr//fB
	ACw6jy1BznDqBB9IuRAedQvwbnKl9j+Kp+Ju/FLxo7jwcKl3HegOkCBaU7Q7Pp8MJ1xZI3
	ss1YtUf+TzaKfAI/CIJi88q3ZsPkgjwUqmrIAAWAerhK2zZCiYWIbFTkB6mCNw==
Message-ID: <1a7826ed-5f0e-46ea-bc44-32a389b99171@denx.de>
Date: Fri, 27 Dec 2024 16:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
To: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Peter Huewe <peterhuewe@gmx.de>,
 Rob Herring <robh@kernel.org>, linux-integrity@vger.kernel.org
References: <20241226171124.83735-1-marex@denx.de>
 <81c31cbb-c632-4558-b415-7bfe5c527c75@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <81c31cbb-c632-4558-b415-7bfe5c527c75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12/27/24 8:00 AM, Krzysztof Kozlowski wrote:
> On 26/12/2024 18:10, Marek Vasut wrote:
>> Add the ST chip st33tphf2ei2c to the supported compatible strings of the
>> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
>> Profile specification.
>>
> 
> Where is any user of this?
Submitted to linux-arm-kernel in

[PATCH] arm64: dts: imx8mp: Update Data Modul i.MX8M Plus eDM SBC DT to 
rev.903

