Return-Path: <linux-integrity+bounces-6625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF281AF90CB
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598931C8479C
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E682BD019;
	Fri,  4 Jul 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSEJ3/xZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C5286418;
	Fri,  4 Jul 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625616; cv=none; b=TbpC13zlmPJ4X2ERh46GzQ38f0TrRDIieSuQ5uHCKhN0ee3idPDmmbEL7J60ipu7mHnmnjIKuvpLWctQ7yoiuo+3XNSXTJusV+EGCbbGrC815vNoymIvFOHO721x8pO7jPv9RLXsu0KkMyNeXtGBJH/z/6C2an+dcWPmx2gxe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625616; c=relaxed/simple;
	bh=9UXDUg8PAd5tYI7z6Z+7INFUZp8wOl7XFwS2K9NVrHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqoKyd9CorigJNfA2XzEHAWjtqL0qfflqWeQp6k6vWUe9S5iVO0bQCb4INzkAzRA6Hs4S1Te44+HsOBOzUKNNRo3HI3YcROOScXm9tujrKmQVT6o+3z3YYHktBppXGWz6fzf+QDPhdBY3poH6FxfyVy5Z7sJnhb61HlxWGSRi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSEJ3/xZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453749af004so3619835e9.1;
        Fri, 04 Jul 2025 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751625613; x=1752230413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6Iq3/+8plHi10Ss9ehAabmq+DIYKcedVFnHzqlluoU=;
        b=PSEJ3/xZWuoqdSIerUxo0dHf0t9WNeXMrJfDQWtHoGqJsmeHth5tRi0rVcarlIv1ld
         QTlcK8le/14GZaM8kWx8h6MoDafsElmos3kFjVItPdCwDRHkr+EDRHYJl/l0EA+mqKDC
         qVd4sDQ/aJmVCyjvTCJ0uzGTBA6SdvP9DRt4rzOYqwgjyEl9BJRf1QoTXHJIuMERyxod
         rHihRbDIrJvwTt3WfPkAOH18nn7yeJZYDbxRcmHWajPzBQyTUxdMYGp4aOZ18sjdYl7n
         YFNGkLWe1XKhoILZLWlMm0/xCDxRgBtgXs0BB6HIRIVIrsYU9TZgiW/TAb77qhrfZ6oP
         maXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625613; x=1752230413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6Iq3/+8plHi10Ss9ehAabmq+DIYKcedVFnHzqlluoU=;
        b=F2ua51J2ZRBJWG3S2G8EoptIB47Y7Sf7wlyP65p/UCEqlDlGIzzwvO32Ox5t3Wz224
         dw8tVLt33gT/b4eKGW/GhFke5FSwOFk2SDdxATqq8HGhLulKlm63Ub/6X927gaaDOe71
         3A453r7/cKaz3RHEzJQkelX7BhKEEgtoq2j0ZOudYJEwwRrUwbqWOImTmtCtBO8WZ2p2
         0UUmJueZxNl8iPFZr7xK2/0+rIZDCriiWcNmef2FZYXNdNmZXAE4z90MGbzRX57BoGEl
         ZhtE1L/s6ChqeWeBO0AguvZ+afBVEvQAjCmhUEQorWwNRQqltdoB8wAXkIgV1Y2RsSau
         v/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrP+V5is9Egagk3Ym9owvHc+9jZPxQ/i2lrn2OC4KKX3JXAhOftU6XRWgBH2tZfYHUaSSYxSNRgSFWdBtC@vger.kernel.org, AJvYcCWk0SNh1lDxMLTFfNeIso2cj7sd6vnfpx8ESdPJa3izgWlvKT5Fggjkjvuh4bvrxWgoI989G38bZTXJh/JJuq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpMAFX+B+LYWRwZJt8zHaJrerwu9g6wbW07K3V9bjpOnqL4/g
	s6kTIM0wc3r+wFwgnILfsD47dtbnWRuTyu6jtWY6FA7jngMDOBe5YvhY
X-Gm-Gg: ASbGncsxOOoepZvifOorzO0qdln8GWSrgldmJQGSI264iXV+g8Mu82M9zp1YPdGrxTZ
	IUeq9+WYRwYF911KNQbxpFdWSqcxdBBK5RY690DkDbimpLEklsbcLvotkVFNwzz7PpzCGW6Wdo4
	6BChkAHwXZk4nytPSjcSsQurqqLrE7l+eDK6a7j2j+mnOAzRjdc0sJWKLX23cSmkwbwvPWLAzor
	zsvCIVHqJCygLFflSw20zhqBVHEPj7CnHjSjbIj88NeWjieaf823USSnfojdn67j2hWBAhZrMVc
	lHq0zDaHrQ8t6fLHtMVAOq1wTwiav6+UjLI3aMxggwnWv0fERh5xLtLJJq1GoVaaugEwu0FhOZn
	7v6VXw/Nk46IQZooJgQ==
X-Google-Smtp-Source: AGHT+IH3FPFahV2LWODXrm0judCjRbWI2BLLJZkrPEdqsujvImFUOAeEFcDrKBUXbFsNn3a6NYrTSw==
X-Received: by 2002:a05:600c:620b:b0:451:833f:483c with SMTP id 5b1f17b1804b1-454b306fa68mr19923165e9.7.1751625612692;
        Fri, 04 Jul 2025 03:40:12 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a4e1sm2150193f8f.74.2025.07.04.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:40:12 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:40:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Prachotan Bathi <prachotan.bathi@arm.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder
 <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <20250704114010.0d210c31@pumpkin>
In-Reply-To: <aGdC8gyO00AB_aPr@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
	<20250626184521.1079507-3-prachotan.bathi@arm.com>
	<aGWvtzhs5ksKgaYo@kernel.org>
	<151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
	<aGdAMg43nHPwgeKn@kernel.org>
	<aGdC8gyO00AB_aPr@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 05:56:50 +0300
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Fri, Jul 04, 2025 at 05:45:11AM +0300, Jarkko Sakkinen wrote:
...
> > Well, that was some truly misguided advice from my side so all the shame
> > here is on me :-) There's no global memzero() and neither explicit
> > version makes much sense here. Sorry about that.
> > 
> > I gave it now (actual) thought, and here's what I'd propose:
> > 
> > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > index 96746d5b03e3..e769f6143a7c 100644
> > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > @@ -203,26 +203,20 @@ static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
> >  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> >  
> >  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > -		memzero(&tpm_crb_ffa->direct_msg_data2,
> > -		       sizeof(struct ffa_send_direct_data2));
> > -
> > -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> > -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> > -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> > +		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
> > +			.data = { func_id, a0, a1, a2 },
> > +		};

clang has a habit of compiling that as an un-named on-stack structure that
is initialised and then memcpy() used to copy it into place.
Often not was intended and blows the stack when the structure is large.

So probably not a pattern that should be encouraged.

	David

