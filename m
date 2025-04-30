Return-Path: <linux-integrity+bounces-6088-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C70AA4AF6
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348274C351F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74956259C9B;
	Wed, 30 Apr 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BApprQi7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB224728A
	for <linux-integrity@vger.kernel.org>; Wed, 30 Apr 2025 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015510; cv=none; b=rpoojuNfDkXtEkcr04zFKx4NFnTerso/liryz/RR2SuX40HlA7diqI20h2bJD+0Vjfg9a3iVnvva9SFk2NNuj+3p+6ocIMcoUstyMNpQymYmHKbxmEiCzXUdq0AHUlHKxSZIVqAv8dW7Y8JlKOf7J6wZNoQ/1U6svcRuuWSNtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015510; c=relaxed/simple;
	bh=jLQ7VSocQYR71p+4p10bsNmcteCmdXgdSrNIPdrCjlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aciooI6ObjfwyxQkiDoRXPvm/G9o2dWQSLsOtVHN4cDBO9Yaqog1rK1osrjyu80q1qpcu6iRXk0xvksltdqMvBVIKQ9JBWB8GJTtX/7hpOzoPybf+VSASCq45oXJHaSEip6rB7WHJygOeIrYWJSW/CvnKli73H5pw66kvR/Skqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BApprQi7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f05acc13so99647846d6.2
        for <linux-integrity@vger.kernel.org>; Wed, 30 Apr 2025 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746015507; x=1746620307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+V7cm9jvinYzZ6ye2QtNYnV8/h1lACQcCRpp+snmxs=;
        b=BApprQi7IoHjfzY16R72gtdF43hbuQnsMLp3Qi+93iGBpfA8SatViUBBG0y39LiF2v
         dbJSzUWB0ZjSv/z0WSmu5I98Kc621IYD45FoKZ7KzqNaNwoWmw8uEy189ER/zxYnnX5f
         QqyNKcIAVUhwVSBPw94/pTN5STnY0NcI+yVBA0dKctBJJct8wyDjDplEHucsm5Z7x56d
         WIAwwyJbkDqIQugzkMMLvUJxVhBxHGoPUitEgbL60l9dbSfSKzMquPeM4/tyCFLMH7+Q
         xH+FJk5bzSdrd+TKAdXqFJbduN2vIJHLafOiaqpuBtVtUO2LuVZm43qJ0M0mZsd+1Q+Y
         ObxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746015507; x=1746620307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+V7cm9jvinYzZ6ye2QtNYnV8/h1lACQcCRpp+snmxs=;
        b=l5iVe7aG4NJg9r+jvjgsVPFR3TNdph13NsphAJ5NW2hiKejPvsgmbwUImRhhgROJ0a
         ME3aaWsyE+Gceu3i+qPeFsk+3IWWUm4oDsGh7Vhyx4skuGE4NQLKPvqNNJHGxHPZwfpv
         ytiEZPz7hbZ7ZZUe9/cf8cK8tl3ogmDdyLMhiCv0rlkHy3CdwsjhdKM0bPS5jCQ8W7Ec
         /2EPCu05SCMvFuS4ycBuGYBvajjUm5LP4YdMrrt/ka0Vz17Dr2hOqOiE1CEvukWCrqAZ
         fu5J1wnEiL6tFnhetmaJPoQ/MXlU8UxNfwyHiOgBWuy+lA4+CJ+v/NXlgHvoWH+GEOA0
         z93g==
X-Forwarded-Encrypted: i=1; AJvYcCVakaeziDcXSgBRik7OTokI7snmEt5WXm3sB61P+O2eVdS48C298A42kYGIIkJtYMgKptnv5EyrmBE2WXqmWX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNrGM6UlKRP31uRgffhB09+DYr8jPvu54i7gQCm/T3nM5BFBG
	1qAmCFSzZssvEYHURBxeO0+ywLLZPUzjDT3c70UIJ/10UAo5V8m4KzVwRASzZSI=
X-Gm-Gg: ASbGncs+3ZSepet6+yjfsSKAEWuAZ40reYamow3KnMMZ8GgAx7GErP1A0BgjUS9Vc8W
	qOfI+S8Lz9C3PWNRbB6tnUSYlthlpv7e4hn/l2z6Yyv2dYmCZ4zfcxzDl3xAjnQgiLcJWvwSnTW
	KbcA85wFWv0DeeqvB/ANSn1eAGgqzfnR6Tfr+m0E5/qavFMmTXti6OCdjc6duafkk/re12/Ljjt
	SxioRE/5E0CRpxv6IVdbpiQJl/2rQfim8M7h6jarE7E2g1FDXTq1kK8vLOtikaRnIp0ziG2SDG9
	snK0sNq9hr5e1uBzS/nRPoa2fFXrNE6A1C1wpNstcwek8exJrrPrMxz7TjW+idjsLH7L0F9D8ak
	BAXBW/O0c0K3LXnHtJcQ=
X-Google-Smtp-Source: AGHT+IELliOgWL1VLuF3keZ0L9C0SuC6eT6G/zrGEIVhFJleyHOjZQlXG23pL+OAV2vZNQZVoxOzXg==
X-Received: by 2002:a05:6214:40a:b0:6e8:f17e:e00d with SMTP id 6a1803df08f44-6f4fe057ae1mr42658596d6.14.1746015507283;
        Wed, 30 Apr 2025 05:18:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe70a07esm7585906d6.57.2025.04.30.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:18:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uA6OQ-0000000BFaw-0xHr;
	Wed, 30 Apr 2025 09:18:26 -0300
Date: Wed, 30 Apr 2025 09:18:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V4] tpm: remove kmalloc failure error message
Message-ID: <20250430121826.GE2260621@ziepe.ca>
References: <20250430083435.860146-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430083435.860146-1-colin.i.king@gmail.com>

On Wed, Apr 30, 2025 at 09:34:35AM +0100, Colin Ian King wrote:
> The kmalloc failure message is just noise. Remove it and
> replace -EFAULT with -ENOMEM as standard for out of memory
> allocation error returns.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V1: remove trailing space after \n
> V2: remove entire message, originally just removed a trailing space
> V3: replace -EFAULT with -ENOMEM
> V4: send correct fix for V3, actually return -ENOMEM
> ---
> 
>  drivers/char/tpm/eventlog/tpm1.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

