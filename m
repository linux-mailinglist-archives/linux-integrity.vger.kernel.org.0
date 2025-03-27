Return-Path: <linux-integrity+bounces-5463-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F065AA72C59
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 10:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB873A84A1
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7F20C025;
	Thu, 27 Mar 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDFMLCQA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52F20B1F5
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067678; cv=none; b=IQ4voXB8ELNU2ue0Ui6xIdl679/vHr09G+4BbdpIYLsLVNoLQtB14wegZTLg3PUHyVr0728OQmQ5QVgCs1TMJmMAAg4wMBGgzcuLGZ5jEYLKKBE590fAkLyI1vMtHNZTjSuy0VNp0h8dvXK0ep4+vrU4k7zoIexylpPPDkWwCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067678; c=relaxed/simple;
	bh=VYJm25E5SBfgKsJrKUJDhLPg0lXKBEdFQtY15OzbjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s55whalC5GKpXN25C0anCDJHIh1w48oEE3LDWh5TfIzG0UpLzoixwW+CcbWJ4jqHo9MzYzOfOjQ6LjFuis9o0p0Sr2pb36L4qsBkYb9o9tNPD3DOQVKI8nVZDGhuREADYfNxwEjVOfTYFXeSmUChmnJSjSHsKkK6+5iwEPqq4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDFMLCQA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743067675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fb5rn7gLPo3ygp5MY8ecDAB9dNjS1ERzuhzJpEg3ERw=;
	b=cDFMLCQAaaEfjIF9IliapEYb2D9XX5+2PaT9cFwv/wZAKFFTjuvWm4vmTz7W3YWqkMZwjU
	OlKRalGqM0BelcE4q3Eff2ewzMBV4nPK6LQSwSdjTEUfrNYgCgRCFjeoQpeECtHbsq7jvr
	kPn/PC0YY7DuLBJGqBEsdgv56kI7sHI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-8BhWjUFnPAy1Pv-CFBBnFw-1; Thu, 27 Mar 2025 05:27:54 -0400
X-MC-Unique: 8BhWjUFnPAy1Pv-CFBBnFw-1
X-Mimecast-MFC-AGG-ID: 8BhWjUFnPAy1Pv-CFBBnFw_1743067673
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f6eso784286a12.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 02:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743067673; x=1743672473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb5rn7gLPo3ygp5MY8ecDAB9dNjS1ERzuhzJpEg3ERw=;
        b=psVg2LRjbqG//OGAJSpptRfMkwA3CdjUusOo8a4D67hyvRIvhVSoEveAxeUDDDNrcr
         A1gOY033a3WD6vHXnzIsoK6Pd414k9AmAQonox8+pX4BZ8M0FGmCOya7ZVBtKiPCZqs6
         elMP8OS1TRpVewdCkB2i944u/joALq/aoNAC8rqxgn6+1Huakk35wzSRFtx+ZNcYNQHS
         OUJh97FGwXlzF0sg0B+rbM2AU3VTtF5TCe+2sSzh7ONvGdJNqnNrB6AejxXqDRx/FWfv
         8n8TUKly6XN0N/LbZia5EGv3VKOg6m1Ci74J1k8sTLKKqjSZXg/OpwCMe4yP7IEROwbd
         bGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfFGiWJPBEAp1PJYiYW0aIyG5M4m0cwkNqxPOA78OVhrz2dZdGdpjdiBKWtPgJOVSPn4J/A3bqSS51f+w2xCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkm6ooxn1FTidt4nu15spFU0dCgLqZ5fcv0NMQyvoyw6AHJeow
	7/01tZ+JlyFSBBl24G6Dk7HgyaoFXwKdgbTr1rO+D2JSpFsgKgKJyn31P4vndV6z28CC2osVShW
	xOBH9GZej5ei7T+X+Kb4CoeoZTI5SjJPWI7Azmt2yaUphGQ2yLuRzNjxamC9eJPvlNA==
X-Gm-Gg: ASbGncvzgL5FajGJSw2Cdc3BWeKuOOHvNlq47xPIcQ558+QGt19iTdgKZ71EyYff+qq
	IS6e7A/HhyATfi+l2E0buWzGz6Ul6uaYdIbUgnHRncsHyfiWpzomMZK1HrPUclEr6JcJsvvb6Zu
	W9s6+zmlEJlrNT8Ua6ptZv4PQ4/ZtFugF0pzq6wKVezJpGttp3DJpZjRdzE161c0m7tYP4ZaUBV
	NzqeEkIxkDq3bGWYnUpsC+3YF+UH/ZUp+H74WUeSXARZ8QSjueU4nkNzbBJfjsuil574UnEIzYT
	s2/yjKw50/3VLEo7T0aIg6dwrzZXdSYCAw+gqWnwV5F5C6DHNO5vDzDTFfvr0F72
X-Received: by 2002:a05:6402:354f:b0:5e5:bb58:d6bd with SMTP id 4fb4d7f45d1cf-5ed8e27e417mr2747654a12.10.1743067673037;
        Thu, 27 Mar 2025 02:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvTN/A/WKtnLN9cOk1VAV/IoHZ/Wxw0yKAUmRflhbh8sggckBhsPUWwhNfAktSzO/FSF0l+Q==
X-Received: by 2002:a05:6402:354f:b0:5e5:bb58:d6bd with SMTP id 4fb4d7f45d1cf-5ed8e27e417mr2747630a12.10.1743067672368;
        Thu, 27 Mar 2025 02:27:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf6797asm10811435a12.16.2025.03.27.02.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:27:51 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:27:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <6mpece5tkoie6ngv3j3xzjkotn6x6wu2vjs7pc44ns76z6v3d2@c6jinanngw5o>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
 <Z+QQWe/upJuVpU8r@ziepe.ca>
 <Z-QV5y1JGBDpsPuH@kernel.org>
 <Z-QkGUenPAMid63l@kernel.org>
 <Z-RlbEN9BoKnTN2E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-RlbEN9BoKnTN2E@kernel.org>

On Wed, Mar 26, 2025 at 10:37:09PM +0200, Jarkko Sakkinen wrote:
>On Wed, Mar 26, 2025 at 05:58:33PM +0200, Jarkko Sakkinen wrote:
>> On Wed, Mar 26, 2025 at 04:57:47PM +0200, Jarkko Sakkinen wrote:
>> > On Wed, Mar 26, 2025 at 11:34:01AM -0300, Jason Gunthorpe wrote:
>> > > On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:
>> > >
>> > > > Generally speaking I don't see enough value in complicating
>> > > > callback interface. It's better to handle complications in
>> > > > the leaves (i.e. dictatorship of majority ;-) ).
>> > >
>> > > That is very much not the way most driver subsystems view the
>> > > world. We want to pull logical things into the core code and remove
>> > > them from drivers to make the drivers simpler and more robust.
>> > >
>> > > The amount of really dumb driver boiler plate that this series
>> > > obviously removes is exactly the sort of stuff we should be fixing by
>> > > improving the core code.
>> > >
>> > > The callback interface was never really sanely designed, it was just
>> > > built around the idea of pulling the timout processing into the core
>> > > code for TIS hardware. It should be revised to properly match these
>> > > new HW types that don't have this kind of timeout mechanism.
>> >
>> > Both TIS and CRB, which are TCG standards and they span to many
>> > different types of drivers and busses. I don't have the figures but
>> > probably they cover vast majority of the hardware.
>> >
>> > We are talking about 39 lines of reduced complexity at the cost
>> > of complicating branching at the top level. I doubt that there
>> > is either any throughput or latency issues.
>> >
>> > What is measurable benefit? The rationale is way way too abstract
>> > for me to cope, sorry.
>>
>> E.g., here's how you can get rid of extra cruft in tpm_ftpm_tee w/o
>> any new callbacks.

Yeah, I agree that your patch should go in any case, with send_recv() or 
not. It's a good cleanup.

>
>Measurable benefit: no need to allocate memory buffer.

That's right, I read the whole thread before responding, but that's 
exactly what I wanted to highlight. Implementing send_recv() we could 
completely remove the buffer for the cache here in tpm_ftpm_tee, 
simplifying it quite a bit.

In tpm_svsm instead we allocate it while probing anyway to avoid having 
to allocate it every time, but we could potentially do the same (I don't 
know if it makes sense honestly). We do this because for SVSM any buffer 
is fine, as it can access all guest kernel memory, whereas IIUC for ftpm 
it has to be taken from shared memory.

>
>Let's take that as a starting point ;-)

Yeah!

>
>On that basis I can consider this (i.e. something to measure).

Okay, I explain this better in the commit description for the next 
version!

Thanks,
Stefano


