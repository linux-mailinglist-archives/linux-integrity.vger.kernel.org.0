Return-Path: <linux-integrity+bounces-6630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6411AF9E98
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373C7566E6F
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA88B248880;
	Sat,  5 Jul 2025 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL794L6o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F71DD0D4;
	Sat,  5 Jul 2025 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751699408; cv=none; b=adDRshVhfCQ9w+DFP2T2i+/itQZf/KAKHkSpRd78PFHKBPFa8MMxhdyf/UerBCaoefjjeB3d1nbdDVRt0wMWW23wQ3Lb4JZC3YMoE6azCpjap5C63ms6k450e6D7QCQwQy2CC5ho92oSYLukH9HdYajizDGfLUAF5/zYG+K5vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751699408; c=relaxed/simple;
	bh=LvpZBH7Yveq9YRhSphaKsMkLGPc+63OIb3tHftMzm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/+u9+LD0z+xYFKHz1ZlxLx8IAZkR/WQEMaWJrRkmFMSgCAMqe0CHG8UgkU/7ExtOnPgLAHEszjJJ+6XdlleUd0+MVViWFVnlkHjPlROXISyEGCW5Zx6o+9EmqM1Bu/hqRWt7vvpPu/OYcsGlHuW7uQfqMQ2f/8N+q1VH+Ikuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL794L6o; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1040837f8f.0;
        Sat, 05 Jul 2025 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751699405; x=1752304205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwGKDGYZu3zU20tyaWGV7f0jUHSIerDDzpIeaZ0z7yw=;
        b=fL794L6o4JpxDz+/7XoFATfWI74B/RQfFxkkMH7ufTa4d/JolKUZAl/kcnNFNIHc1D
         6dhLDD0pH/T7BcKcfefOLbQA2k5sEQFo2HepPSrwzKjI058JAzJocj39P06upv7/nC25
         bMIhXJOdjlqVOH6vfvK/vfSufUIPKoGRPDOZoMBY43UfPitQUKxDclzSZ0lItXol2rSM
         W+RuiRh1fQIA/e7JMievpv1vkIW/XFrESoIbTYswBLQyn0Pb1kpEWM4yVfzwtFxo542f
         6a/alFECa9Krs5sQTjMZH4SVKT5wPUT0CIcZHtuVeDxBndXMzZT6iEwSv+2seZO2NtZC
         pozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751699405; x=1752304205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwGKDGYZu3zU20tyaWGV7f0jUHSIerDDzpIeaZ0z7yw=;
        b=g9UW/evs2YE711nFtHYBn+HP+WGrsea/mFpc+4qUn2VKhDOSqDfMXR9tOwVKMrOSsG
         2oK/6v9HErzg0/85wSUyFG5RTHrtW6AylwHYNLrbNra06NhZSpLyn2Lmdb5UnQql69kn
         iAilfOWFg7HHoQEt+V0zJ1XF5ZLSAYPNHhGEUFU5I2sO5YyFzC9lfBZH+jxbCe/SF0WK
         FLH/LSLgCxO2B7sfwQpu91cvt4NuzXLgtEcRQ/OiAvoVbSQNbWSEn3K/ICdHA7uReurz
         xV+dhcfT5AsqdCp9YeE7ZoXWnEonGWUSbFQ8WoJTeacsoyyl4rHqyD1sQZPbI5TFCRix
         O21A==
X-Forwarded-Encrypted: i=1; AJvYcCWQZVETpKspl1Mg9QxR7hkZdG6BxPYuDxfUJ8fxtbM6uHsUmYa1z+tu5f1KTd1wGEzlgECLhALFgSHvlFAgTEI=@vger.kernel.org, AJvYcCXwz3VaFCjjwsFdZcaV4nC9q3aqkTNYiZW2+3dcpdRHpM86f/o6lhK+VTNox2LBZiLzKzw5LYUO2rnL4TtJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoQoFx05lcxU+nJvjt5Tg+PX0on84/xNxjUmjYNxlYODqA02O
	PwC7+JsJzZmD/vbxEtIYkJA7hT4unf/WFcnnsB3ytMTU+SkS4TzyGl4m
X-Gm-Gg: ASbGncv9OAuwcqUOWDyMq/HmWG4GTsoMm1wBI7Z4NSj4pkanhMePzrZn1YrWVUfvI+L
	FlcX/97QCPVr85GHNf4ZoTNKzqN4vzwUrtAixlvSnkCnQ/2sz5qscQoR7/unygzF5AfKdtP11Ww
	ACfAsWaM1c+mSAK5Bkpeo3y77wONWzGgmQ2fEPaZ75dw2CmyrR+y7S5LLAqhSedVxoCMfObiFDK
	bhCCYbEDCZ/ipoOIQMlDLaJxfjzc92uA5Ilb5XQ136aZUe4u3PHUcjpluezXPVD4G2uHm11J/IC
	77/HeGTWVFM3xfezlnu6/aN8ceEk7sg7fs9HQog5sY64TE37i8AQdjOK9Cck1VTbDfqKBsmyS8h
	TVZ4jv6m3l6WAhD8N1g==
X-Google-Smtp-Source: AGHT+IHYg+BfFBK700LUYb6rC8sK/+2zYar9/pzekkdyH36Nnonb0XBe2l90dgnR4ocPCRfpkSvONQ==
X-Received: by 2002:a05:6000:2913:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3b4955971d5mr4451054f8f.29.1751699404886;
        Sat, 05 Jul 2025 00:10:04 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba29sm4259385f8f.2.2025.07.05.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:10:04 -0700 (PDT)
Date: Sat, 5 Jul 2025 08:10:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Prachotan Bathi <prachotan.bathi@arm.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder
 <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <20250705081003.26409484@pumpkin>
In-Reply-To: <aGffUrDSjNH6w6rB@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
	<20250626184521.1079507-3-prachotan.bathi@arm.com>
	<aGWvtzhs5ksKgaYo@kernel.org>
	<151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
	<aGdAMg43nHPwgeKn@kernel.org>
	<aGdC8gyO00AB_aPr@kernel.org>
	<20250704114010.0d210c31@pumpkin>
	<aGffUrDSjNH6w6rB@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 17:04:02 +0300
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Fri, Jul 04, 2025 at 11:40:10AM +0100, David Laight wrote:
> > On Fri, 4 Jul 2025 05:56:50 +0300
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > On Fri, Jul 04, 2025 at 05:45:11AM +0300, Jarkko Sakkinen wrote:  
> > ...  
> > > > Well, that was some truly misguided advice from my side so all the shame
> > > > here is on me :-) There's no global memzero() and neither explicit
> > > > version makes much sense here. Sorry about that.
> > > > 
> > > > I gave it now (actual) thought, and here's what I'd propose:
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > index 96746d5b03e3..e769f6143a7c 100644
> > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > @@ -203,26 +203,20 @@ static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
> > > >  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> > > >  
> > > >  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > > > -		memzero(&tpm_crb_ffa->direct_msg_data2,
> > > > -		       sizeof(struct ffa_send_direct_data2));
> > > > -
> > > > -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > > > -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> > > > -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> > > > -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> > > > +		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
> > > > +			.data = { func_id, a0, a1, a2 },
> > > > +		};  
> > 
> > clang has a habit of compiling that as an un-named on-stack structure that
> > is initialised and then memcpy() used to copy it into place.
> > Often not was intended and blows the stack when the structure is large.
> > 
> > So probably not a pattern that should be encouraged.  
> 
> This is interesting observation so I had to do some compilation tests to
> verify the claim just to see how it plays out (and for the sake of
> learning while doing it).
> 
> Note that I use GCC for the examples but I have high doubts that clang
> would do worse. Please share the insight if that is a wrong assumption.

It is a clang issue and may only affect builds with some of the 'memory
sanitiser' run-time checks.
Search through the mail archives for issues with overlarge stack frames.

	David

> 
> OK, so... here's the dissembly (using objdump) for the  unchanged version:
> 
> ffff8000801805a0:	8b020260 	add	x0, x19, x2
> ffff8000801805a4:	94011819 	bl	ffff8000801c6608 <__memset>
> ffff8000801805a8:	a9035a75 	stp	x21, x22, [x19, #48]
> ffff8000801805ac:	aa1a03e1 	mov	x1, x26
> ffff8000801805b0:	aa1903e0 	mov	x0, x25
> ffff8000801805b4:	a9047e77 	stp	x23, xzr, [x19, #64]
> 
> [ Off-topic: note that how a2 gets optimized out with the zero register
>   so that it is probably a parameter that we don't need at all in the
>   first place? ]
> 
> However, in the changed version the matching snippet looks factors
> better:
> 
> ffff800080180620:	a9017c7f 	stp	xzr, xzr, [x3, #16]
> ffff800080180624:	f900107f 	str	xzr, [x3, #32]
> 
> Further, look at the stack size in the original version:
> 
> ffff800080180524 <__tpm_crb_ffa_send_receive.constprop.0>:
> ffff800080180524:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
> 
> On the other hand, in the changed version:
> 
> ffff800080180524 <__tpm_crb_ffa_send_receive.constprop.0>:
> ffff800080180524:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
> 
> I don't know, at least the figures I'm able to measure with my limited
> ARM assembly knowledge look way better.
> 
> BR, Jarkko`
> 


