Return-Path: <linux-integrity+bounces-6144-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C50AAC541
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE79F1884710
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9EB665;
	Tue,  6 May 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9JVcOvV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC527FB1C
	for <linux-integrity@vger.kernel.org>; Tue,  6 May 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536818; cv=none; b=A+c3dxg9+tb3Z0BdtFzk71X/zXnQK9tHFQifFO70sbizoGcLMYxwS0UVdq63+A+tALVicQUOR63u/t18yBTqGArFoq/yI21yyoyaBhQtolw919dotaI2iaLRwRdszTGDwnQiqw4RNyGy9dWZCGSejJhojdiMj23v7BNDUgdargE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536818; c=relaxed/simple;
	bh=qSelRs1fagJ/RsJmCZ4KbDzbcT/dlzDg34lSjalVGCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abEdz8GfbAMQ4ln9YxDbE6TSSQuh7cMY4X3NHpvVLumu3Ab97OWp6c7L1IfJFildTFJhFwIW8bTviiROksiXA/jw0pmZaJShy44jaORL/qT5mMlyn9AFXqSJ5lM/uEunD7MkoXACR3DdMxLmPMX1TeEaCX58C4zoBeEpc6UiRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9JVcOvV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746536815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO86tWyczy+PSJFwu9JeGgAOBATj+coLncLYSH0L/gw=;
	b=b9JVcOvVim3ocxUoEd9GGWkozBYb+e2m3yOs/HBL+7Hpi+R6eFfvzveJtTApt2LCPBLgQO
	Nlm+6hs57Hzx8en+AfPvak8QiVkiK0f564oxXW/+Y04uHdyE403etTiAmavQ1zgCW9DZX8
	L0i2Rw5I/ogMeyg7Dcv6/meKTYHkDbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-8eXgHkiLOJC_k3f1CZZD8g-1; Tue, 06 May 2025 09:06:54 -0400
X-MC-Unique: 8eXgHkiLOJC_k3f1CZZD8g-1
X-Mimecast-MFC-AGG-ID: 8eXgHkiLOJC_k3f1CZZD8g_1746536813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so41506105e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 06 May 2025 06:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536813; x=1747141613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO86tWyczy+PSJFwu9JeGgAOBATj+coLncLYSH0L/gw=;
        b=JaAlK9cJ4lBsDHGo8adRGRibFWZz+TLdtpMBWt1ML/3rTDJlPxJkoaMN+Tl15nW5O5
         Vu1afEdOyqXzsUiDXnJfQag8Q+4rIwUpo/2zrQsh3Q2XvEpMdhCEElvELYTt5ueflMli
         JGskt4rCaffsaoAEVv96+n/2vZH/VeyCzY2DARKQBiR1Qz7pvavDzcC7I4l2pz2k75UA
         szzNPj2BUXBnUeGJNgxZJqknn0+9QuGI/S57+mXSzCpToyphbZS3IeGKZWZuqlndushs
         E+O+QzOTOpLaFVqTEqfujXm7QGTX/MARjn2cKhm7Fr6xSjiUMr8+ikLbMNpFrchxGwQQ
         91xA==
X-Forwarded-Encrypted: i=1; AJvYcCVYS6hifGk2JaA0tRfCm6TNUzDXJWHsbrFi0Aee6gWyi1KXf4/eafUQ1UQ71+JOg2tpgGhNWoBA2NfYNcV9a5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvZdUhcYKFt0jE5Unex1TRLxHId2rMCJ0LEBr9gBVn+zNY8BJ
	r0ZroumQiDVJ1RA8CLDm1cHFhgLPtFYai3oiRuQMTBAkqpzUvhyX31jOFg31VXLoZNI8JNQNw35
	W4hOau1+PmE3lagbSO1XzyIM5RJJyBbOkbGksrn6lDregsHopvWa9aOnLzbd/VhY/TA==
X-Gm-Gg: ASbGnctEnvcgsp0BVEosIGFL5PzLM5nMp8eadytQQkI1aiJP26wvF3yGeTaIBqYxuqz
	vs5YGJ5b71T81O21hqQDZrGxLvNdfFYbDkLoeFRjQpq5tgJLk3glKq2WKWVHC7Eh1Y9Y6Cte+34
	9jQ9ULnr/PhhCxqxoXa3oPuFpDfL7lWU2Cn1ttVTlT74y67zYkXPfR5I5UNiZQuGk2/bvvgjO6o
	ArFs8EBo0zMYfm67WMK/mIkdr02l8G0yAG3to237aWMvS98+8/dhGb3QslinKFQBFjtuV2TFBKB
	3QIuzrU7ck43cARF
X-Received: by 2002:a05:600c:870b:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-441c494849emr95875915e9.27.1746536813077;
        Tue, 06 May 2025 06:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKiHs9FSOU2le8jbaL7mKTZ2hCbrm+SIQCEe6ODre4sZLo6XvFEwTUhXm7CFs6cxte9EBTOA==
X-Received: by 2002:a05:600c:870b:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-441c494849emr95873295e9.27.1746536810872;
        Tue, 06 May 2025 06:06:50 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.145.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecc89sm213870385e9.9.2025.05.06.06.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:06:50 -0700 (PDT)
Date: Tue, 6 May 2025 15:06:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Peter Huewe <peterhuewe@gmx.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <pxtojuqebtk7pa5vjbhmiulydmgyutsbgxg2j5b6ziyxzqls35@qmmmcn4uwzie>
References: <20250414145653.239081-1-sgarzare@redhat.com>
 <20250414145653.239081-5-sgarzare@redhat.com>
 <aBJGkSil1YAzSXsg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aBJGkSil1YAzSXsg@kernel.org>

On Wed, Apr 30, 2025 at 06:49:37PM +0300, Jarkko Sakkinen wrote:
>On Mon, Apr 14, 2025 at 04:56:53PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> This driver does not support interrupts, and receiving the response is
>> synchronous with sending the command.
>>
>> So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
>> return responses in the same buffer used for commands. This way we
>> don't need to implement recv() op.
>>
>> Keep using the same pre-allocated buffer to avoid having to allocate
>> it for each command. We need the buffer to have the header required by
>> the SVSM protocol and the command contiguous in memory.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Similar comments, and a bit redundancy does not matter i.e., they can
>have pretty much the same explanation.

I see, I'll replace the "So we can set..." paragraph with your 
suggestion on the previous patch.

Thanks,
Stefano

>
>> ---
>>  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
>>  1 file changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>> index d3ca5615b6f7..db1983072345 100644
>> --- a/drivers/char/tpm/tpm_svsm.c
>> +++ b/drivers/char/tpm/tpm_svsm.c
>> @@ -25,38 +25,32 @@ struct tpm_svsm_priv {
>>  	void *buffer;
>>  };
>>
>> -static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>>  			 size_t buf_size)
>>  {
>>  	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>>  	int ret;
>>
>> -	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
>> +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
>>  	if (ret)
>>  		return ret;
>>
>>  	/*
>>  	 * The SVSM call uses the same buffer for the command and for the
>> -	 * response, so after this call, the buffer will contain the response
>> -	 * that can be used by .recv() op.
>> +	 * response, so after this call, the buffer will contain the response.
>> +	 *
>> +	 * Note: we have to use an internal buffer because the device in SVSM
>> +	 * expects the svsm_vtpm header + data to be physically contiguous.
>>  	 */
>> -	return snp_svsm_vtpm_send_command(priv->buffer);
>> -}
>> -
>> -static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
>> -{
>> -	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>> +	ret = snp_svsm_vtpm_send_command(priv->buffer);
>> +	if (ret)
>> +		return ret;
>>
>> -	/*
>> -	 * The internal buffer contains the response after we send the command
>> -	 * to SVSM.
>> -	 */
>> -	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
>> +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, buf_size);
>>  }
>>
>>  static struct tpm_class_ops tpm_chip_ops = {
>>  	.flags = TPM_OPS_AUTO_STARTUP,
>> -	.recv = tpm_svsm_recv,
>>  	.send = tpm_svsm_send,
>>  };
>>
>> @@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
>>
>>  	dev_set_drvdata(&chip->dev, priv);
>>
>> +	chip->flags |= TPM_CHIP_FLAG_SYNC;
>>  	err = tpm2_probe(chip);
>>  	if (err)
>>  		return err;
>> --
>> 2.49.0
>>
>
>BR, Jarkko
>


