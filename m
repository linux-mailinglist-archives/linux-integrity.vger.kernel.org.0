Return-Path: <linux-integrity+bounces-5045-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF29A4C70B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B9D18964AA
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC982135CF;
	Mon,  3 Mar 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPVGhCdH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A3215040
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018920; cv=none; b=ugFr4XX59+HfSypb795sIs24UOjJnrQEzYOu244TAbwZh1LXUTtuEMbrEtqYe2glr3AApn96fYfLTErEuSauB4cTAMhAKtK53IrSyknDikOP5H1bXCnVKhCZFiMaiftFYp2GYe5WomnmyLHKOZ/H3stQ2TTPBoqHDE2F7y/1gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018920; c=relaxed/simple;
	bh=LbJNoTrvq+2ziXPQ6cPoGKYMHLbQOYW28RIh2EZ+nAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H97JdSCyk5w7Eg1opx72hH0B9QO5I0oj+TQAjRc3+KMQ4QUmCAv3McWW2pAAf2+EcauD4O1JmMsp3nhuxmaWId9PKIqUt1xRbGB7KVWOr5Zh99B8+sgyG5Pcm9i3L6giAOI0gtYRuLRojDxgq0aBdoxOS1vxIMFQN/5Hh3ybyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPVGhCdH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaU2dnDpqgEzFLAHxVwOT4KJt49Y2FVgJePw+X7Ose8=;
	b=LPVGhCdHO0vuhuIYyMLbvC0JERbzKsqhW8WzA8fo/Z0itfo91uvsdxzcuwDZkr+qVuzy0n
	ar33qAsYezmbEnQAGwRURVcgW9F0tdhnn9lx3uXyVeXFSUf+xnYX8yYRGGiJsXxvEOtWUr
	RgWsX6JuDBTE5KBBVHQc2Wb+Sa1tVaE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-oRV8d4qqMVq9DrXJvwP_JQ-1; Mon, 03 Mar 2025 11:21:56 -0500
X-MC-Unique: oRV8d4qqMVq9DrXJvwP_JQ-1
X-Mimecast-MFC-AGG-ID: oRV8d4qqMVq9DrXJvwP_JQ_1741018915
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f11e6fdbso1353759f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 08:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018915; x=1741623715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaU2dnDpqgEzFLAHxVwOT4KJt49Y2FVgJePw+X7Ose8=;
        b=rwta+rK76x7zRfh8xrVdDsh1UGYkkEa74gEdhBqx8kTPKjrNwm6K/aenWT5k0vw9Z4
         sp+jdJFuHoOtH8DUwOynjQzeYRVI3YeYWWYzesB2fhtkJE/LsDHixHqosu8ERwVMGNQ1
         XczidwTJOs4K7eb03dup6z2rcuj7+IEIuTHTc22yGPc/OEreXM0ZlKApD8osWtQsMoV5
         5mdB0WnDYa64760lIKdfb8ph4KpmQx3iSVYRJmkrATsesSjGYVcq3X+omsHl3W+n5R7C
         AxHcoT3Q59JeXSHeTUnHpBS/+6iQfR0tSqBs4GZqUWhkndnLjdacmZoBm1qSBLVOMlkz
         8XVw==
X-Forwarded-Encrypted: i=1; AJvYcCX09ZimM6oUyEPoyA/nbrRh9yxLG1RSuTPZqipN1OSca7VSdosgpwB3HzYNllmoBw1TiDaOWkd6AR6QsosY4Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6Er76FbCtfwmmZ5/a/XmcSMntTqZm4nUwZVXxxAlxqVa3qiX
	PQ4WpJsomsjnYwdXzkf9GIC90JFtBuf4ZG7q0K2wpvMJ3/4d4muCZh2h9jTbGUb014BZTgMNoF/
	+Ayf+d+XVlY945cXVLO6R+tWT487x7nDPOY3Z1yL4T+qA3IRrD3wVzKg3oFyJVkhuBA==
X-Gm-Gg: ASbGncu+1nOwcavDih47TcEuCUzFeaOYNNWu6drvB+cyPhecacubXjvtccaQzCJxI4U
	AIcEIW4cVBAAi4Vr+btA5MpNiBWZwajDMxxCrdVn2YQYQJrXddiXWCKZ8DqopzQttsOCxp4EjzS
	tZ3cN7JOCBCRsUk0cK7igKuOuf/H+h7Qcj3C9LAmapacIwE3LcZrb4/Hhud0OQuZDCp8RZDRTjB
	sE+RWmhz210uYNrM94AXnM+ALeA67qz2ev5/iGyagHMFS/NBDjj7cyX6OBOgEnI38Qlq/cS/OCN
	ZabXbQjG6Yc/735p1AznTQB7EMqDWIQ3zugkzu9/9QlobZTmG/p5uQTqdMZTJcbI
X-Received: by 2002:a05:6000:18ac:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3910454634cmr5710015f8f.48.1741018915183;
        Mon, 03 Mar 2025 08:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6QrksmkiLyGLOBejTcc1pl1o5yPlizUYl4FhTdgmEYaBVAixN64pSnMJJOGRErw/KFrdszA==
X-Received: by 2002:a05:6000:18ac:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3910454634cmr5709980f8f.48.1741018914747;
        Mon, 03 Mar 2025 08:21:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965f3sm14808634f8f.9.2025.03.03.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:21:54 -0800 (PST)
Date: Mon, 3 Mar 2025 17:21:49 +0100
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
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8Jmps6AF_geaHUw@kernel.org>

On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
>On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
>> +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> +			 size_t to_send);
>
>Please describe the meaning and purpose of to_send.

Sure, I'll add in the commit description.

Should I add documentation in the code as well?

The other callbacks don't have that, but if you think it's useful we can 
start with that, I mean something like this:

	/**
	 * send_recv() - send the command and receive the response on the same
	 * buffer in a single call.
	 *
	 * @chip: The TPM chip
	 * @buf: A buffer used to both send the command and receive the response
	 * @buf_len: The size of the buffer
	 * @to_send: Number of bytes in the buffer to send
	 *
	 * Return: number of received bytes on success, negative error code on
	 *         failure.
	 */
	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
			 size_t to_send);

Thanks,
Stefano


