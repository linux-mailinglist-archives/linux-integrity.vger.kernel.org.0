Return-Path: <linux-integrity+bounces-6078-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB9AA4508
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CC161468
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BBC214223;
	Wed, 30 Apr 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="qqJaDh4/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623C1EB197;
	Wed, 30 Apr 2025 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001133; cv=none; b=sEpYGPw794DGREubyNig9pzftiLMgxUpYmQLlG3XQft4hbD8vJol/O3wf/mjwdWqjD6bcPHEvdVnVF0NSz+bwhfNrbe9RM3xDFehkLofQlIMr+zPi56XLklVsTsH4ysP+S1zyeh3lV4o1B4QQDGx1H+vCemt4DjHsAkmTa0/Klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001133; c=relaxed/simple;
	bh=bHAZEpmXSdLpFJLUjkk5FAmT9/oL5KYYAbtM4RoPUsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVQG/XzuwIioJiPoBMH0O/JxDSLuQn+eoJavYE34l7ZTnY93GK7sEgVwafWIq6kGMSkg+/oMN/wXSX9KL/ehVXz+UyhAAkKPzNiDkimONHDUY+mmZP4p4voBzvOO7X+rHtSeYOYzs8ZHaug3WmCEC6aEI98magsO1gdjuv/c8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=qqJaDh4/; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Dne3ROVglvwR4BrHcAfMFGXqQGQiHsk7Mm78Fflzfng=; b=qqJaDh4/YAUUQBOKMyxhXy2rF2
	cRRkqbQ+60E67dd6gwWYxPTZuJDkUey3DHgcraCZtebWZysBFL/3Muq2S1pzbOFIb2frhAS01Y9EG
	EoY3lOBUgKFFqpd5ig9U/u97qV7dgvZ9ReA2Vk5tPXmeeb46Gnv0bunoiNfOXyYIsQmdg6gU1aA68
	ImQKJfgAHLB7HhaxyqxBZLRWB8Hhuf9nkj5E2xp4LlRzft7P0RM/qNcqRHeYHVoMXNxOAhevkWSCy
	/5sbtpCBz7cV6rggl7ssRGReA9RKbNTsKaRkyJrBgqB1rmXvAXak9+QPjlFQwkMlZbY12rYteB+88
	NGsJtYCw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uA2eI-002Cw4-1L;
	Wed, 30 Apr 2025 16:18:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Apr 2025 16:18:34 +0800
Date: Wed, 30 Apr 2025 16:18:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, davem@davemloft.net,
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
Message-ID: <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
 <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
 <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>

On Wed, Apr 30, 2025 at 04:14:40PM +0800, Qunqin Zhao wrote:
>
> Sorry to bother you, may i ask is it fine to move  the Security Engine base
> driver[Patch v8 1/5] to drivers/crypto ?
> 
> The base driver uses MFD  interface  to register child device(tpm, rng) , as
> done in
> 
> "drivers/iio/common/ssp_sensors/ssp_dev.c" and
> "drivers/firmware/xilinx/zynqmp.c".
> 
> Thank you, and I look forward to hearing from you.

I don't mind at this point in time.  But if this driver were to
develop features way outside of the Crypto API in future then I
may change my mind.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

