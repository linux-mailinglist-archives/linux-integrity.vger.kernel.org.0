Return-Path: <linux-integrity+bounces-5464-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04DA72CB6
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 10:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060231892B75
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF920CCF4;
	Thu, 27 Mar 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NohFzFI2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107761FF7D1
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068913; cv=none; b=ZIY9dcGfWHXLl8xCzhJFE65j36v8NrFF3mX/f52vbxaTK722eci6tl1aOxWvt6gKrF7XxLQjyE2bCly1qm5XfH7vZEEDiou7yowMZrWp2nBOQZsbwT3oUS1+YEUkd52aUCcPIiMuhcvWUbD/EQhlciJVf9cp8g6jPkDQCqpErjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068913; c=relaxed/simple;
	bh=V7nXQu1ECzd1snnn8NgRK9qAIOJWvh1THW88GlNDZo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omduNyAsvk3aOuMnndFg1sNt11I4UjmAIFC/lhXU87iBGcqBQTCSmI0bDxSfyqYVTvq9szk6uP61DffEpH7XwJZBZGu4eFgyUFfew01XKn5s8NoO0FlzUGtORQnNXpj2U2BCLTVFT+eg4GDwual6kC1ioPoFTxaUcHg7uqrn93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NohFzFI2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743068910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkXA0CSGaLLhec1NiuD/8heU6GNQwO9LkiS1P4clsaU=;
	b=NohFzFI2ccB5murUf6zXK81Jx4zqcQwyb0j2DjcK+/T5FSWJ4jfg7JwgSeLosI0C9lSarU
	h8v03qRwZNcsghw7TA9JoZscF+6OseliLV0+U/8zgppHarBZRzRzRLi74MOKFnmkWWBXFG
	h4UOe51ws1CP1l/9iB0InBr1jJ//d2Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-8LBXWEU0NOKZINryWZptHw-1; Thu, 27 Mar 2025 05:48:24 -0400
X-MC-Unique: 8LBXWEU0NOKZINryWZptHw-1
X-Mimecast-MFC-AGG-ID: 8LBXWEU0NOKZINryWZptHw_1743068903
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5dd82d541so789000a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068903; x=1743673703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkXA0CSGaLLhec1NiuD/8heU6GNQwO9LkiS1P4clsaU=;
        b=D+bQ1FjRq85YxlsYcjGEtgR5Dz4/qNfGFpDf8cnAWhIU2GjO4b6Vo0TBWiKqEoIK1p
         QNv5Orqh1qW5Vhud8rVr5Xng2KTw/epAX2KnBRwJ1xD/ZuAVY79VgpdPWv4bYRktuFg4
         HJm3GyKzbRS5tC0TsMEawcDJ1erqjmNvRxKkTBZzB2mu28eH6cR07UrtFesmbP8Y8EWu
         Mhd3OH64oEiLBTVQrOLcc7iynA+1ih2Xx+m0TLByLWnbg64r75xZB5vCvBq0Pwqd+jmA
         4mA5XQe1ryHRP94nCCgI2H2Mf/0yltJq9Q30h4ZjSWJj1Mrr49EkYBB1myb8Op6QNVTn
         p6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk4A120nY1Ar/cCKWMI8UVhJClAYfSxIlJNw2u0WLowYJi6MNV0pLlitnh/kOH0JRy7eYcnrUuCqHfmc3gZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWtYA0QPrbSxkBm/K8a3p7ZavjKwWPrKA/EaRV6qR/X4PLU4C
	b3RV0JNbt7hf8bwT2csLPYOmfiSzKL0UEXVPdj+Dddkq70Nf7Fk1HX2kRBtlRtPfQAJAuTwhq8E
	1JWiBLzst95Eu09EfvnXR+8E0MXbv1sIVH8rT8fTxi3zMcwG3PRvmfzHeY2Ua5PTXHw==
X-Gm-Gg: ASbGncuz5msg4XVI6RHzEym+KVm87mRK/sBNsou98sgJ/oWsZnOSeqS8Zz49KzTbpy+
	hXxIrjkEyau+8g40YbvFrW57CVFhEmlYG19Fu4ms4s/nmviJ9bq2UIMuCHbklGfd//St0Xxp39A
	JvPgfV/cSnpMf+eu+bf8vZsLlMTIsFfjWX2yZGb57NhPSc0yIUOfjjkX2sqqe14ZrIjfeU1Cgq4
	MuXZk4Q4t2bl7JDJAor64rCDMFAApvnAxPvt/u8w1Pa4NCZi5EMEF/qg9geSNXwadBsQkV3jhmt
	qH5DAbLTrp8kGYAg8/fcWjeBVBdAftkWluj0Dfa07uNPjKpzJ75oVIrm9ZwJv0PQ
X-Received: by 2002:a05:6402:35c4:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5ed8f5f6b76mr2945699a12.30.1743068903053;
        Thu, 27 Mar 2025 02:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECYBEVoCF81aAT+yw30nu+qGDuMQaL77qfuPpJGrMzLEon8pvfMD/dETVYWcOlt5YmfSMM3w==
X-Received: by 2002:a05:6402:35c4:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5ed8f5f6b76mr2945665a12.30.1743068902509;
        Thu, 27 Mar 2025 02:48:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf67e70sm10747368a12.6.2025.03.27.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:48:21 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:48:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Message-ID: <eidmcwgppc4uobyupns4hzqz562wguapiocpyyqq67j5h26qbl@muhbnfxzqvqt>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-2-sgarzare@redhat.com>
 <Z-QxH7aDjlixl2gp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-QxH7aDjlixl2gp@kernel.org>

On Wed, Mar 26, 2025 at 06:53:51PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 20, 2025 at 04:24:32PM +0100, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Some devices do not support interrupts and provide a single operation
>> to send the command and receive the response on the same buffer.
>>
>> To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
>> chip's flags to get recv() to be called immediately after send() in
>> tpm_try_transmit(), or it needs to implement .status() to return 0,
>> and set both .req_complete_mask and .req_complete_val to 0.
>>
>> In order to simplify these drivers and avoid temporary buffers to be
>
>Simplification can be addressed with no callback changes:
>
>https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
>
>I also noticed that tpm_ftpm_tee initalized req_complete_mask and
>req_complete_val explictly while they would be already implicitly
>zero.
>
>So it reduces this just a matter of getting rid off the extra
>buffer.

Yep, as mentioned I think your patch should go either way. So here I can 
rephrase and put the emphasis on the temporary buffer and the driver 
simplification.

>
>> used between the .send() and .recv() callbacks, introduce a new callback
>> send_recv(). If that callback is defined, it is called in
>> tpm_try_transmit() to send the command and receive the response on
>> the same buffer in a single call.
>
>I don't find anything in the commit message addressing buf_len an
>cmd_len (vs "just len"). Why two lengths are required?
>
>Not completely rejecting but this explanation is incomplete.

Right.

The same buffer is used as input and output.
For input, the buffer contains the command (cmd_len) but the driver can 
use the entire buffer for output (buf_len).
It's basically the same as in tpm_try_transmit(), but we avoid having to 
parse the header in each driver since we already do that in 
tpm_try_transmit().

In summary cmd_len = count = be32_to_cpu(header->length).

I admit I'm not good with names, would you prefer a different name or is 
it okay to explain it better in the commit?

My idea is to add this:

     `buf` is used as input and output. It contains the command
     (`cmd_len` bytes) as input. The driver will be able to use the
     entire buffer (`buf_len` bytes) for the response as output.
     Passing `cmd_len` is an optimization to avoid having to access the
     command header again in each driver and check it.

WDYT?

Thanks,
Stefano


