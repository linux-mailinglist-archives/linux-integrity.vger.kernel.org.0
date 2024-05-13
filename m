Return-Path: <linux-integrity+bounces-2380-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6828C4802
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DBB281EF8
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D937CF25;
	Mon, 13 May 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmhAuAtT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253517AE5D
	for <linux-integrity@vger.kernel.org>; Mon, 13 May 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630581; cv=none; b=DLEq2wKjbvyZR2YEpj5z5GQK6Lb+Z+IF/qpC+Dbi9t+w/eMsbJkOv99GUbHeNRUBfWOnizcgNVBNzsp4/EwL8SBvEu7fqbSGNJHbYFM3Ce1BtPt52T+hlbY+ECb22a2OCKiwnBifyKYDxqyOco9vLZZHz2s4CtCgAeugwyl78S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630581; c=relaxed/simple;
	bh=vN/oZPVUM0VbKTBMpMyTJSQOi5UZXcQoj84jhnHinmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyLVfP8nC2tsEHM/P4R9cde38oWPJGOmExN5YCGVCsydFg0a0AzV7Y0+7NWj/tXoq7qeB4mVLv4vG7gjxZ+iAlMCua7ZQCJP+O3DQOMhWDInl+bz3Jp5nFrqHoaX5DDPTzd8vfFLg65f33xvU5mDBTTgdMHXNBo3f4ew43tc/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kmhAuAtT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec41d82b8bso45552045ad.2
        for <linux-integrity@vger.kernel.org>; Mon, 13 May 2024 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715630578; x=1716235378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5nQNVYZPxKaKLdJxSwXvg5R8/O6lRnjptx4J93d4hY=;
        b=kmhAuAtTSRBDjVwsZJH4oVuUmfzhyMrIe8cZ8Tud4FCMLKQJmxIGplZNKhVLJgzmRV
         tTKI1lYGHn9XnIB+sI2nL0ONOCBEHPt3qzI9U2BlCTOq4Hv925YxS5K+nm2HpA2/aejE
         vTRZOyRXiIOGvH38XcbhF3rqnjcco6JwEtorg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630578; x=1716235378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5nQNVYZPxKaKLdJxSwXvg5R8/O6lRnjptx4J93d4hY=;
        b=IiIy5KWigTPaXiHOMTU9UqQ89dZAojhyOJPI1nr4mxREPLOOwx6WXGYQ2fwHRRPkxZ
         Ek/7LKZjI+5e4G4pFx41R3QkBqlzyPf5e8fVymXwWnRV9vxK0XJCHKKJ9ohUm4W4IXk2
         ZGGjQbK31j7RdzuGxLiGrCLyQ54iSr5qf0ZFaMK+A6M8zp6qhStG2/aP9VTUGibUQETC
         ADI4dbm14baEsjgwJK51JfeufM+roqPlYZE8fQ0wuXfRgeRVbZfQ5mZqZxn43aXisYeS
         YVeFZUvw8peq5H1W9L9d2JtUs644+SaNLH6ZyFUtKDvJtHAHSGXQwUaMVFnL+T9wFia9
         neng==
X-Forwarded-Encrypted: i=1; AJvYcCX/9TUBkPv98rGutFKoB2JaP7nAb5ZUO13VU2i+53scn4GFY5JQ54DCGllRBQ6dp8QmbAzcLsYD3d2z+kjm4kjXRwVG78o7wp8uUFSSmsC2
X-Gm-Message-State: AOJu0YwFjBOlAGQsVov9eyUGoBq045zJ8OjWcVzliWHzqV7JjYV6nyOk
	K6r1LtgM5BL1Z+fmEMUtlGuEuAeSWrTfGaaEd9S5dkrw4w/eAacOk7WD5MQYWg==
X-Google-Smtp-Source: AGHT+IG/kQjGxArMBt2gt0E87feuvucE0+UTE644XiSYwvBHzgRi5fADgV7o5cADuhUcHPkhpx2rNw==
X-Received: by 2002:a17:902:ce85:b0:1e5:11ac:a283 with SMTP id d9443c01a7336-1ef43d0ada2mr143038325ad.9.1715630576456;
        Mon, 13 May 2024 13:02:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1368desm83578025ad.233.2024.05.13.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:02:56 -0700 (PDT)
Date: Mon, 13 May 2024 13:02:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	x86@kernel.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] x86: um: vdso: Disable UBSAN instrumentation
Message-ID: <202405131302.51918C1C1A@keescook>
References: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>

On Mon, May 13, 2024 at 03:10:24PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> The UBSAN instrumentation cannot work in the vDSO since it is executing in
> userspace, so disable it in the Makefile. Fixes the build failures such as:
> 
>   CALL    scripts/checksyscalls.sh
>   VDSO    arch/x86/um/vdso/vdso.so.dbg
> arch/x86/um/vdso/vdso.so.dbg: undefined symbols found
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

This is fixed differently (and more universally) here:
https://lore.kernel.org/lkml/20240506133544.2861555-1-masahiroy@kernel.org/

-- 
Kees Cook

