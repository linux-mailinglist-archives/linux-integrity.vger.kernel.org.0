Return-Path: <linux-integrity+bounces-5107-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CCAA4F986
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 10:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD641892C15
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC60201261;
	Wed,  5 Mar 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTRdKlBO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD71FE468
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165660; cv=none; b=bQAZOZUud2yoOFDT97ANn5U5eM4I0AopKV9gouZUtum1LtnXhwLmwyyFoaP8baUKUxf86ElpahRfY5CLaJhZOO+SbZRKOcGD4AGTcWE0sgfOKOmPQBfQ66gqwgOnNB5PE2mD9PpiP2XN2yE1LmMU3CjgkkhkH3XdlzhxUy3qH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165660; c=relaxed/simple;
	bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3babHW9Vp2dX3cfAwnnn1oasGbSrhsO5Mrdv/BCrB/qH8nx+fyYrxo9X4gNI2S2eXFfNcOJiZgPiBbhVoVQjZPM9qjNONoZfo4gfo7t0sadT32T6Z7Xob6a+ToSZ+/ELP+fAVRWIx1U/566E6NTJx6GBFNriF+ezB1LEVRc3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTRdKlBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741165657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
	b=RTRdKlBOGcXlh9JjYYd1zZgfU+RXhBN2Ixr4gzWvRfM0MJSvuFWIiY023cOV3SXmLsEUUY
	xJbW6cbYYeJehcQLlJQXNBAueIlNhYR53QDTZ8u9dDoy/gOlXB4dt9xpfvQZMxKYSURn7E
	8zvXsDPHYpslOhRD9qY+X4u/cVgYbg8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-OPouQR17NDaeNvv5ObHQjA-1; Wed, 05 Mar 2025 04:07:36 -0500
X-MC-Unique: OPouQR17NDaeNvv5ObHQjA-1
X-Mimecast-MFC-AGG-ID: OPouQR17NDaeNvv5ObHQjA_1741165655
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac21873859aso42855866b.2
        for <linux-integrity@vger.kernel.org>; Wed, 05 Mar 2025 01:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165655; x=1741770455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
        b=m7S93KQtvMsGOjV3NnK5Por6DpPk/dATQP2uOYRbalzN/qwEWMashg6W7ne2xZyL19
         4/jyrToucfQP2lqnt6XxxK5ELFRtNMcmzDAtTCEOHYUP3dUQgTXz47+UBXU8+QS5A/O9
         9j2k//w5jgsc90uhZhVbx+kgBYI0FEYH1Djg3E9C/QlfPIDQyxm7WizOCfuuNOco1Yga
         nOcZm/Ljujjue5VMnbztRAq5AXcOXFUuTBeiziXFF6nX0/+eGt3KBpgZN7A4+l5f+aCN
         LDtO3Sjb/walQgxccO95gFZE+KvCis7yf062rBGtACmlpksGtdyRdKVGUPlsiOjJT/cq
         zjmg==
X-Forwarded-Encrypted: i=1; AJvYcCXfu9n+t6vfuGhqnA8CC53JgdvFtQ5kfIpIDzW9XeiB/kEVF8OjMnGOvtUKy7eHVXbjG2NfcFblnJtd2dX19wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRstnQoMJAIHUy7P3BFM4ExaRCgypKqcUyx336VBsFHRNjlPcz
	Jl0vNFx7eHhDHBTdfG8olCwWq4vg9tBAjDUqlCbKkttuAS9UXZIxNvrzjITkhiAhr7Hft5PD0ck
	4ssy0WUUWMihTznX7DaC5l6VxB9MSUNYzj44QaJAjZpJhjs+A+rehyn+UdQ3KY5qVBg==
X-Gm-Gg: ASbGncumsUg/48NlISAGRDaJNQEELo3nCTtzF6Btlz3hBgSLNp6B1CXRg/L6PkLNQ1Y
	5iTcW+Uug9NhxV5EwjwPCLzrufj6YX2t8noBL48Dzl2GYSaOuR4zHs0wBoQ3u5HCuxhPEI2qTXb
	cvisnDodrrFvuX1igDnqslAXsOfIGa5xIAYMl7qwQvyn96g9BM6BwiXKloC2X419fBneyvb2WLL
	TP1SHJfNVAhHYWU5zqXCN9Rsf8CsFpSLeKwvZEjpV6PAE46qEXV2calQiYKDx9VStM8uoQ2Thes
	u/B6xxKBqUL8BEmhJNffXbr8ZrGc3Kuv95Llc+cL58++ehIN8UzOy/GN0B4dHDul
X-Received: by 2002:a17:907:1c18:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-ac20d8459e6mr251659466b.11.1741165655273;
        Wed, 05 Mar 2025 01:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3mtYAsZxhVAJSSQRaDW6E8YonUSexggQDnhx967E+2X1tR/N3HMP/nk3AgqXd36cQEhZhUw==
X-Received: by 2002:a17:907:1c18:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-ac20d8459e6mr251655966b.11.1741165654712;
        Wed, 05 Mar 2025 01:07:34 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7931de88sm476985366b.185.2025.03.05.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:07:33 -0800 (PST)
Date: Wed, 5 Mar 2025 10:07:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <u3hnfqimgnavrhy4wxa63zorvbjomj5ptoqrn4aqnr5wlnjtxs@xyy6d4merpvy>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <Z8JoMrUm9Dnoqgoi@kernel.org>
 <tpi74sl22zqngutzbqp7ajz7khwom2fgth2n3i77houwdqc3gl@obkhgfcagubh>
 <Z8c4Avw2y7k4JODe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8c4Avw2y7k4JODe@kernel.org>

On Tue, Mar 04, 2025 at 07:27:30PM +0200, Jarkko Sakkinen wrote:
>On Mon, Mar 03, 2025 at 05:46:16PM +0100, Stefano Garzarella wrote:
>> On Sat, Mar 01, 2025 at 03:51:46AM +0200, Jarkko Sakkinen wrote:
>> > On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
>> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
>> > >
>> > > The specification defines a protocol that a SEV-SNP guest OS can use to
>> > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> > > in the guest context, but at a more privileged level (VMPL0).
>> > >
>> > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
>> > > to verify that the device is actually emulated by the platform and to
>> > > send commands and receive responses.
>> > >
>> > > The vTPM is emulated through the TCG reference implementation, so this
>> > > driver leverages tpm_tcgsim.h to fill commands and parse responses.
>> >
>> > Why? Please don't.
>>
>> You mean it's better not to have the external header and have all the
>> functions here to prepare commands and parse responses?
>>
>> As I mentioned, I did this because there may be other future drivers that
>> could use it to talk to emulated devices in the same way, that is, through
>> the TCG TPM reference implementation,
>
>Sorry about harsh comment. I think we discussed this (MS simulator
>caused confusion). Anchor this to SVSM spec and we're fine.

Yeah, I think we are now aligned, I will try to fix in the next version!

Thanks,
Stefano


