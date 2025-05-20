Return-Path: <linux-integrity+bounces-6261-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3FABDFFB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 May 2025 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7084C3449
	for <lists+linux-integrity@lfdr.de>; Tue, 20 May 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20403265CD8;
	Tue, 20 May 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdU3uf01"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1022B8B1
	for <linux-integrity@vger.kernel.org>; Tue, 20 May 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757238; cv=none; b=fSQZq2nLQKNMg4Z5mi+6P5yZjNTElqqH0yk0XJvtiJUjccabwmsYmw3YSyfIkHPg1yqzxWjTF+nIh93ND2gh5a/PKfE77FHL7Bpbau0WJAVRgXcfIIgmDISs4VpC2WUWqgqHPpF/K7ZxF8IfP5Fe7HvRbs84//RgWYdCUCtm5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757238; c=relaxed/simple;
	bh=yWls8QfeA9fpnOgrHlH+dO1UEqW/dxD0zbRNGuCAoh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCrQP5RGLFpnRsYDL1Q9k1rdWKveFVL2esVvvpQzD/C2tn4C5MT/1WKhCx56jBiA0BP50rVm+I2rwEkoh5196GclpLeiLAsqm3gDd9/IkZo/cZ9T44q25xqY5Cc+M4EDQzCg0Bj9Z8k1yUmQ7K6LU7My9ZcWGg0dRcsEQQTZHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdU3uf01; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747757235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybC/xEWalGJ0RhCZjvyrvjbHro7QE2FQq7vzTeEzDcM=;
	b=cdU3uf01e8iI0rlmtlRxetvDnYI1n5XpXw1mQSrd+LtJE3y741/MlXYGKi1XyNjQoGbeA8
	isosUULxv6qLYrMaDsdT+SwKrL8Y7vuS30ENSkmDzt1uSHvysU+AsVb2F3c9cp9DAbRv8f
	z5Pwtb/3cZLumaDJUUFLMBbM/w5vafU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-5j5Wq_oOPaSHKuFgXW42IA-1; Tue, 20 May 2025 12:07:03 -0400
X-MC-Unique: 5j5Wq_oOPaSHKuFgXW42IA-1
X-Mimecast-MFC-AGG-ID: 5j5Wq_oOPaSHKuFgXW42IA_1747757223
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-72e1e89b532so2782930a34.3
        for <linux-integrity@vger.kernel.org>; Tue, 20 May 2025 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757222; x=1748362022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybC/xEWalGJ0RhCZjvyrvjbHro7QE2FQq7vzTeEzDcM=;
        b=KJcGpL9arHYy/4StZJ2q2qF9B0LLc7PNP7jOk9u8nqEW0JBIF5sK3Tr2znCRx8VFmp
         Q04lMmbn0ALK7IH4g2WWhJi9xwiryvHoTErCPaS8TplMxUZQ8SazndKqCjvqNv+eWsq1
         HG3qZOYZdekupYtQHynBNhb4XvN8c7Oz0oMtcsDxU40cako/xn8Qx0zMF0YA6WbHqikN
         Jyl91KPkqJFt7m6A19GHXTd+hZtfw5f4Aj8qZ6nRpVi14147GudHrG2gptyxN+7urCjM
         rSU5DhU9ESjYKuTkcjGgGEHV/uXwtkgEmaebGsYGWeoqer95CX6Pm/v0ZHQakXalrfGm
         wJRA==
X-Forwarded-Encrypted: i=1; AJvYcCWD1X5XewhJlvKdHDFZc+mTt1cMso+Z9N7jVdxd2WPmYzhhFu33Th7InBHSRelZcLpECQm4vkJz/NCp+bSsNSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMw6MbExe9N62R+vp9Ka4v4AFcPR1xYekjTZDQyABeCrlYoyI
	hS8JxZz//ffcMgmJ6tyOdRVg5KxqGvQaabTNQIPebTlJMhShVp67sGLAZKFexM3cJ/AKqsRSJPL
	kJHpjuaEOj1oFQULX3aUQOwuJmEp8YA1ZrlM43orYEi7HJRRzTBQNuCi7LaFrC9WKYmtKs7g33z
	/f18hCvly2aDDhsQYuTsyBiGAnIU2OX0EA6nthWQyySJX5rNqMN4rN
X-Gm-Gg: ASbGncvYCLOBaUYu5yr29hdPG7D8y87MAs3fMkIySAACn5k5BD8jGrQfFL5gpH5Gh9H
	GCY/cxJHpdGsVnQ5YLWezeWUIHO+NGQ2orh4L79A0l210kZP++TwZ5zNCgPAUFN+4vNU=
X-Received: by 2002:a05:6830:658c:b0:727:372e:600e with SMTP id 46e09a7af769-734f6b1a0cdmr10030130a34.14.1747757222616;
        Tue, 20 May 2025 09:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ly9i72+pYbDKe5Sks+06FCcNtf9xBC0iJ/paWfH1AFYyUe0Qn2IrAf+QY1o3hDZlmKZQmCGNGBhAxWj1dLY=
X-Received: by 2002:a05:6830:658c:b0:727:372e:600e with SMTP id
 46e09a7af769-734f6b1a0cdmr10030067a34.14.1747757222132; Tue, 20 May 2025
 09:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514134630.137621-1-sgarzare@redhat.com> <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org>
In-Reply-To: <aCVHQ-LRqHeEVEAW@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 20 May 2025 18:06:50 +0200
X-Gm-Features: AX0GCFsTmlbq93tR0wE4C3RUpx9Z1D4kjkNOv4wLeycQRtYZ5zeOxDpm0iB8eVA
Message-ID: <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jens Wiklander <jens.wiklander@linaro.org>, linux-integrity@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 03:45, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, May 14, 2025 at 03:46:30PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > This driver does not support interrupts, and receiving the response is
> > synchronous with sending the command.
> >
> > Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> > ->send() already fills the provided buffer with a response, and ->recv()
> > is not implemented.
> >
> > Keep using the same pre-allocated buffer to avoid having to allocate
> > it for each command. We need the buffer to have the header required by
> > the SVSM protocol and the command contiguous in memory.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v5:
> > - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> > v4:
> > - reworked commit description [Jarkko]
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
> >  1 file changed, 11 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > index 0847cbf450b4..f5ba0f64850b 100644
> > --- a/drivers/char/tpm/tpm_svsm.c
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -26,37 +26,31 @@ struct tpm_svsm_priv {
> >  };
> >
> >  static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> > -                      size_t len)
> > +                      size_t cmd_len)
> >  {
> >       struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> >       int ret;
> >
> > -     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> > +     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
> >       if (ret)
> >               return ret;
> >
> >       /*
> >        * The SVSM call uses the same buffer for the command and for the
> > -      * response, so after this call, the buffer will contain the response
> > -      * that can be used by .recv() op.
> > +      * response, so after this call, the buffer will contain the response.
> > +      *
> > +      * Note: we have to use an internal buffer because the device in SVSM
> > +      * expects the svsm_vtpm header + data to be physically contiguous.
> >        */
> > -     return snp_svsm_vtpm_send_command(priv->buffer);
> > -}
> > -
> > -static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > -{
> > -     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > +     ret = snp_svsm_vtpm_send_command(priv->buffer);
> > +     if (ret)
> > +             return ret;
> >
> > -     /*
> > -      * The internal buffer contains the response after we send the command
> > -      * to SVSM.
> > -      */
> > -     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > +     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
> >  }
> >
> >  static struct tpm_class_ops tpm_chip_ops = {
> >       .flags = TPM_OPS_AUTO_STARTUP,
> > -     .recv = tpm_svsm_recv,
> >       .send = tpm_svsm_send,
> >  };
> >
> > @@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
> >
> >       dev_set_drvdata(&chip->dev, priv);
> >
> > +     chip->flags |= TPM_CHIP_FLAG_SYNC;
> >       err = tpm2_probe(chip);
> >       if (err)
> >               return err;
> > --
> > 2.49.0
> >
> >
>
> I can pick this for 6.16.

Great, thanks!

Stefano


