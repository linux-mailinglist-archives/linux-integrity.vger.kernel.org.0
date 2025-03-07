Return-Path: <linux-integrity+bounces-5177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9253A56C43
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280B23AF523
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A821D3E6;
	Fri,  7 Mar 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF9uQAcS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16921CC7E
	for <linux-integrity@vger.kernel.org>; Fri,  7 Mar 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361881; cv=none; b=Kx1lvtUXzMUy0rcQ6FJDOywYanJjHVY3ExsA/oob4pgMpRbAMN39bXgY458GECKQxPLJ941X0OWPzWkzZ1pAw6cSEwSZ15ClLJzZ2ZQ4+MKBx3Al6pw4ieAE+60tw7BbwQ+dQIVbhbWDAt7/WFfigB35mPd7fXJQQznDqUCqZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361881; c=relaxed/simple;
	bh=UaKgYKgRNweERNpL0sYd2eYOjEHfRdISZiNE+9EOqdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuF5dp1BG6LDsEpUoyKWXglBp808jfsGrHIuuZcQ6gnozx7F0FUPIRDJ9jpos9hPchXV98St4o6ex7hj94x0hCfoKB/75DkVSB+uI8qy7imViZp6qxotKadzERTgySKTYNvThDPtZEzlIEGHC9Z2cwpfraJWtX0g0ztwU7hpryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF9uQAcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741361879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCEnBg90XzFtM7VUQEX7isG0VF2FTRraT+UhcAxtG0U=;
	b=RF9uQAcSKZxf85Z6ImZCGnjT033M2BIC6Hy1Dq2NVfkylAuGtIF3NUdKXiz2H7U5IoqFef
	pvgRXUfftdl1rad5FDe2OtdEQ8zqXQF50CwS+w74CsOlZMTTcvw2mqZ84USIn7pDy69Fln
	IDVJwqFJ6Gu0FqtF9wxycbO52bHrBek=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-zkHo0syINLO2fKCYnThAfQ-1; Fri, 07 Mar 2025 10:37:58 -0500
X-MC-Unique: zkHo0syINLO2fKCYnThAfQ-1
X-Mimecast-MFC-AGG-ID: zkHo0syINLO2fKCYnThAfQ_1741361877
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fc9861cso713403f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Mar 2025 07:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361877; x=1741966677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCEnBg90XzFtM7VUQEX7isG0VF2FTRraT+UhcAxtG0U=;
        b=cWNnRPS7nZK58nm3pabAt5/cuboqA9ibDmFLiBu3POaOITRjq/lTJ2Tk+RbGwMC46C
         xutQSvBFvweZr2bPtdvvgzndrIw+2ZVXvgZ0lvhqZEEM1x0VZz+VV9fvj7kY12wxVeVx
         LJIQ6iXcl88XKq8H+G7mycCLAWEtKI3ya5r8Pc+1dkMc0XdH2SZDUldYAmnOm4zXk2Qe
         XSRj/jpJ/w4SNPNCAOqd+taORzT21n82eTfLb4/CIBnumVww3peLGs/SzmofCr0ofS1Y
         8DLazjdQP38FibZBT+EV6EikZWZqDJq2UdDyXz2nZ6LmtyUh32JKfMjnpxGKbSezJ+y6
         aqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiXU7AZHKwXBWhU+yo4CqVUT2mk3Gq6DVgeUqYAfmQb7O7TNl4PKQ4HXZ0n1Z409cgqgoJMGQsPc1/DA+0j6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiugE1oSJusUrz3IWfbLUDEZzvQE4GGq6gpR89MYdDEerMEv0N
	uQu6kGhBEstlvYkxRfp7g4jCS+pTYVuEeAl9j4n7n+IBZyp1vcnCj3tpfr8yu0uOlMU8cqiiS2f
	iwIyiw3ngz8Nud/qkfKdFo3qIOMsxJEWKciDXegrz7m2RkkI97I+jjKbGBEjo2Ct3Aw==
X-Gm-Gg: ASbGncu8ubPMyT3dVJY/zxhTnf/3qIcmNgL9MCWJbJrOUlqeRi1sBJjwN4sljFqk8WX
	neule/XVZWYdNEsX3veQBy+wsMz5ZNhqk23WGEkECMnslrYigv+WT/WwUyEPJi11H6/wb2vKimU
	EB619uj7P8WfNNXoNDfqw8HCQwxdOl9jfRvQ8ssBkPiq6ALw0T+5yscLqd+4tHuu17SsVYqINCh
	WDYNVhCQi4E+dDJZPygFVlDugB29dRdKiIViZZknORetrviz7Fz7C1ga+gYY0BYKq4tdKKcEXcO
	f5arD2IZGb4iYa76hMkWIsPEojOFOxyDb2AQRGgj176VUFIyyTVlCULW0rgty15D
X-Received: by 2002:a05:6000:1fa1:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-39132da91b9mr2467054f8f.50.1741361876987;
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIJMvm5xV/SzBS3SsEtyfC9KwyMaXW507M9hj1kZ3KsK4zYX0qBeDOTEmMi3doGmekM7Y1Mg==
X-Received: by 2002:a05:6000:1fa1:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-39132da91b9mr2467028f8f.50.1741361876487;
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd9470e2sm54526185e9.33.2025.03.07.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
Date: Fri, 7 Mar 2025 16:37:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <tjo335oq47ogyobxzlopuxwqzto6gzm4gezqs6umphndehothu@5u4hqukop36i>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
 <Z8oehuPVMXbgjAxz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8oehuPVMXbgjAxz@kernel.org>

On Fri, Mar 07, 2025 at 12:15:34AM +0200, Jarkko Sakkinen wrote:
>On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
>> On Tue, Mar 04, 2025 at 10:21:55PM +0200, Jarkko Sakkinen wrote:
>> > On Tue, Mar 04, 2025 at 06:56:02PM +0200, Jarkko Sakkinen wrote:
>> > > On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
>> > > > On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
>> > > > > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
>> > > > > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
>> > > > > > buf_len,
>> > > > > > +			 size_t to_send);
>> > > > >
>> > > > > Please describe the meaning and purpose of to_send.
>> > > >
>> > > > Sure, I'll add in the commit description.
>> > >
>> > > It's always a command, right? So better be more concerete than
>> > > "to_send", e.g. "cmd_len".
>>
>> Right!
>>
>> > >
>> > > I'd do instead:
>> > >
>> > > if (!chip->send)
>> > > 	goto out_recv;
>> > >
>> > > And change recv into:
>> > >
>> > > int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> > > 	    cmd_len);
>> >
>> > I think I went here over the top, and *if* we need a new callback
>> > putting send_recv would be fine. Only thing I'd take from this is to
>> > rename to_len as cmd_len.
>>
>> Got it.
>>
>> >
>> > However, I don't think there are strong enough reasons to add complexity
>> > to the callback interface with the basis of this single driver. You
>> > should deal with this internally inside the driver instead.
>> >
>> > So do something along the lines of, e.g.:
>> >
>> > 1. Create dummy send() copying the command to internal
>> >   buffer.
>> > 2. Create ->status() returning zero, and set req_complete_mask and
>> >   req_complete_val to zero.
>> > 3. Performan transaction in recv().
>> >
>> > How you split send_recv() between send() and recv() is up to you. This
>> > was merely showing that we don't need send_recv() desperately.
>>
>> We did something similar in v1 [1], but instead of your point 2, we just set
>> `chip->flags |= TPM_CHIP_FLAG_IRQ;` in the probe() after we allocated the
>> chip.
>>
>> Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
>> avoid that, I can restore what we did in v1 and replace the
>> TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
>> think it is fine).
>>
>> @Jarkko, @Jason, I don't have a strong preference about it, so your choice
>> :-)
>
>I'd say, unless you have actual identified blocker, please go with
>a driver where the complexity is managed within the driver.

Yep, got it ;-)

Thanks,
Stefano


