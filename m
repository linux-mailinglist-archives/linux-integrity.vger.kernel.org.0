Return-Path: <linux-integrity+bounces-5483-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F115AA735BF
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA99E3AEE9E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F61946C8;
	Thu, 27 Mar 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQp6Fq33"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD5176ADB
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089844; cv=none; b=YZju/gqqM59THwAhCnt9JBEvpQklDO5XQ1AybTZ+0Y97FfzgoJE7e279SfC1aT7QSOqq5rkeXF1pJCNk3WJ3WMG5qPMeqyHjoblpPh7aroWHoAqqCHUripPdGO/NA9ZF5fnllrJ/og7VM2HVk3N2iJSakrPakwmQaRpcvUJV1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089844; c=relaxed/simple;
	bh=qnzyEE09SZhDRDJ0WiICCQ/E3IQ1fEs6f/i6o9E83Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDsrvPPR7vrMUWJv8Y9iT2uw4unPsiYA8NXB+pMUDlnZhRQommfdzbnpDnTFhwGCHsSe73wc+7okqk6z4OvTeY8uMuq/cm1bLyii14wjKUc+rjcWJyAJRzPtIOw1QTliwv3AWlEjdupLBRX2NZ5UWNg9MnGS/PzLFoKCKoMspPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQp6Fq33; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743089841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFK7RsCREQDGF8kx/OiRKPVegGlb+uhCY2SliHPC3Zw=;
	b=RQp6Fq330aJFeTwIrAqD1SszzkgS8Q1L3nO6QMO1IOsX8wBoFzD6DZuypnAc8tYbZ5Cbd2
	9lax5Byl47lYDZrBbV7Y46H7Xnnp38RGT2Pc1K46/1btnGRNtkmVoLXvcJnASvicBGf2vd
	aere+39pg30ZfcJnXC3JxHvXY7IsjxY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-0PyRrVKLPhq-zdhQ9VB7kA-1; Thu, 27 Mar 2025 11:37:20 -0400
X-MC-Unique: 0PyRrVKLPhq-zdhQ9VB7kA-1
X-Mimecast-MFC-AGG-ID: 0PyRrVKLPhq-zdhQ9VB7kA_1743089839
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39142ce2151so553389f8f.1
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 08:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089839; x=1743694639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFK7RsCREQDGF8kx/OiRKPVegGlb+uhCY2SliHPC3Zw=;
        b=cXxe0afs4nCZcTPCQJMf/4mZYBcPR1VDb6WT6Ptmk7lxWaf2elbLzFD+8lmTnFAx2X
         53M1xe2/uCUeem9ly6dLwVBZvocwJCBEDzYaKmuKdt+O30+GMDGW1VPvt1TWJLkldC+/
         1028BUJunQGOKUdkH0tldv+4MWn6npW5ggUKSA3UywMi6chO5y4pwZj7JCQ03Tvw1YLt
         qnKpGOovGvGukzrTNOTv6V7TRPYxh7tpL2oG0F5sahWQ6PZlb/qpzbIRmqkcFCECCfZw
         TRwpyrswuzEUoPuuHfIZvVCDYWQVrnWbdJe7p1slzAz6LtlAKZ0spFQJzZrYOLMtfHPf
         /VjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDVxH7KzF3OBJhsltFcvlzZd0XgdzrM/xD+TkU8H8nrrudXLpSAqZk8F3S7A9YqmhwjpZgp+7KDAjZhMjc+4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8oDlSacWjCMHDmNyuqF9MDA7Oo3sePUFwCJ5OjvqKfzA5ZRB
	wWhT5uKFI6E4aPBcx4jjcQclu8Ovd3Sa/aRyaM5lmnpnDN7g2KNoC3kIR4EusQOLhj46y7FSJN0
	JZI7oU4kIyfDNTPZWeX3a4Jo7rorSmfz0v0FQBrm2BDOcZWrnTjkBc8jWfr6jdQanzNIBI64gM9
	x7
X-Gm-Gg: ASbGncslj14+3l8oa00Jub8bkqbhBdjVmLQP/BNosEpNe2LKrNoM42i+9fy8JmkblLI
	3/qRiMDEXWL8RaKXLt3QWFVVpW+SUgqf1J6Rc0DuU5urmSUTk3ceqMuqsiYKbm3hZZBAvDbOO9u
	47GkD6F+alsDXtYsbhmSfvxux0vjnWDyXCpgFqKy4uKse/9AhuWMj4whwvwdoDRi9omT6vr6GRU
	3hv9T2Le6cHTJglqNi1kvnY9VRpRK4/jnvfcSfTghuntA+u7qqmYyuD4sxqousVfoEivHV5cqZ/
	oAc8E9II6Rqc0MUx7fpSWsDF8UJdGQBUXXX5IsUr/7j/7emB2yi9YreV0A22YNWn
X-Received: by 2002:a05:6000:2913:b0:391:3f4f:a169 with SMTP id ffacd0b85a97d-39ad175bf85mr3118545f8f.32.1743089838993;
        Thu, 27 Mar 2025 08:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiZcHoFwp0VdacVvgmlY4YT/HkKYT+1vUl9P2aKDuscGeuEHQ+PoWJjg4v6oTuSINpFMBLJA==
X-Received: by 2002:a05:6000:2913:b0:391:3f4f:a169 with SMTP id ffacd0b85a97d-39ad175bf85mr3118513f8f.32.1743089838413;
        Thu, 27 Mar 2025 08:37:18 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39abfc2115asm14199964f8f.4.2025.03.27.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:37:17 -0700 (PDT)
Date: Thu, 27 Mar 2025 16:37:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <bxm7fa2st6glsegemyxbwj4q47azl7h3qmg4vo7o4xqa4ahstj@frtabtwa7jok>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
 <Z-VRWy8jLkA0cpow@kernel.org>
 <56428ff1ac4355482df881e6226518c2a62beb6d.camel@HansenPartnership.com>
 <Z-Vn91fADShpp65e@kernel.org>
 <Z-VpjSZSMOk73_Dg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-VpjSZSMOk73_Dg@kernel.org>

On Thu, Mar 27, 2025 at 05:06:53PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 27, 2025 at 05:00:11PM +0200, Jarkko Sakkinen wrote:
>> On Thu, Mar 27, 2025 at 10:12:36AM -0400, James Bottomley wrote:
>> > On Thu, 2025-03-27 at 15:23 +0200, Jarkko Sakkinen wrote:
>> > > On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
>> > [...]
>> > > > > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
>> > > > > *chip, void *buf, size_t bufsiz)
>> > > > > 	ssize_t len = 0;
>> > > > > 	u32 count, ordinal;
>> > > > > 	unsigned long stop;
>> > > > > +	u8 status;
>> > > >
>> > > > Why move `status` out of the do/while block?
>> > >
>> > > I'm not a huge fan of stack allocations inside blocks, unless there
>> > > is a particular reason to do so.
>> >
>> > The move to scope based locking and freeing in cleanup.h necessitates
>> > using scope based variables as well, so they're something we all have
>> > to embrace.  They're also useful to tell the compiler when it can
>> > reclaim the variable and they often create an extra stack frame that
>> > allows the reclaim to be effective (even if the compiler can work out
>> > where a variable is no longer reference, the space can't be reclaimed
>> > if it's in the middle of an in-use stack frame).  I'd say the rule of
>> > thumb should be only do something like this if it improves readability
>> > or allows you to remove an additional block from the code.
>>
>> Reclaiming here is only shift in the frame pointer, nothing to do with
>> reclaiming resources or freeing locks. Consolidating value state into
>> single location does improve readability as far as I'm concerned.
>
>Anyhow, I reverted that change given the feedback :-)
>
>Since I'm late sending PR, I'll put this patch to my 6.15 PR.

Okay, so I'll not include it in my series and I'll rebase my series on 
your tree.

Thanks,
Stefano


