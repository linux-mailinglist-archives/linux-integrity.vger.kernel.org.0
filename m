Return-Path: <linux-integrity+bounces-4559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058BA10DD8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E4F1643C8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431B1F9A81;
	Tue, 14 Jan 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UrgA7cLW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B31D47BB
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876021; cv=none; b=mWPKmHlqzGfCfW6LUY2v28KfgVu6Tu14uHhhHdigBZGPkyeM8+kblWcEIUEdd86JzUJnvjumo5RChbYQ13ZrsVb1E0os+YMA8LJC2RfjPcKdeVazgt+BAKYuUFcbHx4o5ZcKaxXk5/k2S91ljAXmzt5A6MrrW8MkEpe4GfYaQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876021; c=relaxed/simple;
	bh=u70UZQQ6rrjlX6HwoBxIlEBWzFfCa1RmDu5GKrBIlwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eebqyPTTDxmkOPiXprr+BYNyGbzRoLgfww5aWTvi1DAnNEC/YyINB7i6rELHnAHLxS9rGC5Zt8QJiKQZ+wn86cc3pA0uoCxr6fKM4ji+i5vifI0gPwTE6W1UAVgObDHgUl4D04oMA+VjpxMv1mHRSk0a9z8LzYW2O/H44I5oOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UrgA7cLW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e8814842so561541285a.0
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 09:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736876018; x=1737480818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AE0+MZyBKWqlPeBgME+af5vIGaihr4hRouPkFE36rIs=;
        b=UrgA7cLW7vFsXaJYpsRTu0EoPSArvAR9KVt/4JQZSmUT+H8zo1wmhT78r27J0twEzW
         9nfITuYYUa1Zeg+OvSmNB6Ok9ObmdozY71krxfVx64bRjc3L+NopKu+x8efap5esbC8i
         fCd7f93aXxAO1nwPFLw8lXgKbmlu9RNUGz8I9ABBpRJLPtiXlVZITKDVkO4JvtDLLOMg
         PYCuN0DP4YeHgqVwG0mjBnSIKIc/ug35trSDiV/YMq9+5C5Uucs+h0GrGsc7Vz4MEeRq
         dlsF5YuKZZ9wpp0ebAS/PCfundHlCYHosdOomDAmb7AUWpfnB2QpV5eQEYltTWpirEMw
         Y7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736876018; x=1737480818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE0+MZyBKWqlPeBgME+af5vIGaihr4hRouPkFE36rIs=;
        b=k8Grxi8yZ/F0u0gTtsb70Yt6R0BVlh67AcRzinqCQLyEF+rD1momubaLKo67ammB8y
         6MpKhqCm80NYBBdUvvBH98o9P7zsORaMAnRsb6TWzyLVRMgbrfJnhfnNDoCHYXAODDUK
         fBJjp9TuMNeMSX3mbD5bUpqhLHte+1zEjyd1s0TNSSLNFkX7FDvPOLi8H5DdtqdvHEv/
         LYUYZXBRiI2BRCBvtLD3YMij0gt6ljEjInkLUIplGtOlPJrTxKQyfyGFKyB1GhKv0zyr
         dvQghtv0sMT3dVDV0TWqzbR1GWac5U58U4B3MxcAQRBch5aqRHLO1/WOr3D7aHxgJPpU
         VAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUirc5Ey44rgFgeROZRlj4d7dKBLO3oaT4ZXbYQ1ZPEN6FQ/Ly8fhOtlOVBxH+YDM4Dwi8KyCET7xrl866sNxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbB1G1GYvo60c9Jo6+MniQI/Z+IEkb1gsau4w/WWlEu97nSn7n
	Ank2MvXyrIVaLsbZWaD0FuqGUE3ndQ74ajKL+YbzsSpzU5Q24EhSe1/fS/ohbXc=
X-Gm-Gg: ASbGncvLtvaKolBj0RnKIRVVU45Nxf0bz7abmc7C1OPX27QAkqzAcy1WFREvq5qiMwN
	k07j8PyAnZtMOXdGMlqyQnbMW5BXdKUswVr8f9OMCDHBqvlw5AtLF16/dLJGL+NRWy1VbaFQqV5
	D0G8DLaHHenG2PBhVc7/zXTPHK8E4+s3EuS4UzLkzsAWhhQoNeRkK/WgId1wgfujxDd4R5zOqtd
	9M5MdK6YlTVfYiow0LfKK2ocndbVD5eW/J9pLnKi6ERotvKD+Y31aSma51TdX1rgl2lpzNNOwb0
	6cAoRYWpz//+f9IplQgaY6pSzgDwcg==
X-Google-Smtp-Source: AGHT+IFRhteXjfiktcSVEFWKeer5Q7R8iGRjkKhk3nK9D37c1uhceHVW0TcXnbzSolSoDFgCOgCQYw==
X-Received: by 2002:a05:620a:2b9c:b0:7b6:67a6:5adb with SMTP id af79cd13be357-7bcd973d017mr4021472985a.21.1736876018296;
        Tue, 14 Jan 2025 09:33:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce350304bsm627970085a.71.2025.01.14.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:33:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXknI-00000002OrX-426c;
	Tue, 14 Jan 2025 13:33:36 -0400
Date: Tue, 14 Jan 2025 13:33:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org, x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20250114173336.GL26854@ziepe.ca>
References: <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <20250114130720.GJ26854@ziepe.ca>
 <2yyqhjkxl56uqv35smrq6mdddufcpoj7fgon4n6h6zwei4kryu@pkwhln6b57ga>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2yyqhjkxl56uqv35smrq6mdddufcpoj7fgon4n6h6zwei4kryu@pkwhln6b57ga>

On Tue, Jan 14, 2025 at 05:51:33PM +0100, Stefano Garzarella wrote:
>   Otherwise we need an intermediate module in drivers/char/tpm. Here we
>   have 2 options:
>   1. continue as James did by creating a platform_device.
>   2. or we could avoid this by just exposing a registration API invoked by
>   sev to specify the send_recv() callback to use. I mean something like
>   renaming tpm_platform_probe() in tpm_platform_register(), and call it in
>   snp_init_platform_device().

You should not layer things on top of things. If you have a clearly
defined driver write it in the natural logical way and export the
symbols you need.

Either export TPM stuff to arch code, or export arch code to
TPM. Don't make crazy boutique shims to avoid simple exports.

> > Meaning that you'd export some of your arch stuff for the tpm driver
> > to live in its natural home
> 
> @Tom do you think we can eventually expose sev API like
> svsm_perform_call_protocol(), svsm_get_caa(), etc.?

We have lots of ways to make restricted exports now, you can use them
and export those symbols. There shouldn't be resistance to this.

Jason


