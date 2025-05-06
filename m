Return-Path: <linux-integrity+bounces-6140-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A1AABE36
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FE4520889
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A926C390;
	Tue,  6 May 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jBoj0p6R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9F26B0BE
	for <linux-integrity@vger.kernel.org>; Tue,  6 May 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522243; cv=none; b=X6+0ZrlrJfm7TiabSRDWkKcv+MM5mGXUc8UAUSOv5EmIxcXmXFWV0aaJKsOA0al71zwfxKsCx8l3ijmSaSoCzvuL0MqIoCxLPfwLlG76oYnw3qgYlXyekCesa3i3GyTxlEF++oxQ0HMK60lizPQgGeb3U9ehj/68lJkzaHhBBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522243; c=relaxed/simple;
	bh=CYrUYd8mpt/pd4KD6BaMlj8hw459WQl4N1Iww3g2R8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXoYXR3Gq7rAy7wjgZiskYsOjuxE/brSkashBR3FkizyPQdwwh6fs928h6G1n+VlLTywQlhnZky/mYm78B1lY0KpyqaSY+n+6dKbv4859iqdBus4o1G6Op1PVx3fMHIDD6xCo2KWcGp8oss7YI4onGRg93bqU8fCIvMyIyf7lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jBoj0p6R; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a03b4963-55aa-4a75-b795-1e8f0db7ec89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746522239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KFTuaLCT064dVhFWKhMxEVyhB0wfcxXovNDaHCOdCI=;
	b=jBoj0p6RQohY/jOz2Jnac4g2pw8xHPcE7ZeD3UI9EOi4ZhbYlOfqGKcM3g2CHK9pAHH/V4
	el66Ih158FXEHz04+wN+9a+V+khnD2Yt9XM8jJ82w28UlfPpBDWbQ45nFqmyNhUBIyykl7
	58H/8Hv2bYWGCyrJH75t1cbButhGDuo=
Date: Tue, 6 May 2025 17:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO
 DRIVER entry
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, lee@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
 jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Huacai Chen <chenhuacai@loongson.cn>
References: <20250506032053.11147-1-zhaoqunqin@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250506032053.11147-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/6/25 11:20 AM, Qunqin Zhao 写道:
> Changes to Loongson TPM driver would be best reviewed by the Loongson
> crypto driver maintainers.
> 
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v8-v9: None
> v7: Added tag from Jarkko and Huacai
> v6: "tpm_lsse.c" -> "tpm_loongson"
> v4-v5: None
> 
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
I'm just curious. Why is this patch kept outside the tmp_loongson patch 
set?

<https://lore.kernel.org/loongarch/20250506031947.11130-1-zhaoqunqin@loongson.cn/T/#mf09225c286a8e2b92a677720afafb9e20be57a18>

Thanks,
Yanteng

