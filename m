Return-Path: <linux-integrity+bounces-6581-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A8AF163D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1854A7ADFE4
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6652727E0;
	Wed,  2 Jul 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P9mFCleB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C68275106
	for <linux-integrity@vger.kernel.org>; Wed,  2 Jul 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461050; cv=none; b=KnbuGLO516xzOFCAqsxtJeut/MR313hadD5seWHiGxSsnQBWjuCEiBowkDN2cLvMK/BU79KtlJmnyrx/rss1903LRtryntGhlXLUxKC9MW5RS1Ha+63krceYY0jLSj5WfiNqGuPLQNHQ3R1vK/ha3kNr/1qPHX34as5dJKJQUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461050; c=relaxed/simple;
	bh=MkBWoexUNuPm89yzPO9r953l1XFedX2yqDktEhA1TuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDDdGjSMmzXten4dqCWkN+eRX1c7ula3vgP8N7GrKgWvStqgE3nP+iV+rP3cZC27lTwlkXcpV1N38qLnIj8ocJOZiINZelQQhd5jgGsel5Z5fnJXjuIbRYClbXIpkGLPFmtMWUYbgNwnmQyP/2rC3WQMiivgBjmk9pTN54F0T3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P9mFCleB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d3cc0017fdso473554485a.3
        for <linux-integrity@vger.kernel.org>; Wed, 02 Jul 2025 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751461047; x=1752065847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1U/jcJUt63/R9ojtJdyruc5PkgT9HoGw/OOSpSJ154=;
        b=P9mFCleBocJg7k62fstc6AF8qbEQelyuzhLdz0POfDWpOv6o68Fb3iWlQAeCpWwZ2g
         EWhIbNE4eu2d6kvawbhIMbEz6B6qJBKsUA16lUiGgFm4M6pDy43N/8xVh/UTEyTbm6wJ
         WsboMueXheasQPWLSF/PbtDiOmUZ1cbdqC8rnLVAAGZZ/xmz7pnMkXOj2hJJYWRWgNfA
         BNBn3P+pwaTX6YORtEAMmR+fQC4xlY3GfWen3TUG6DkClcLPZmBD91b3abfWNnDOvF9S
         i6U1vyOaqqTYKLVCS02hT4pixeT4g2/VBdtpg3vvHHwgSuPK000ERFHx7lVr1CSuIRw1
         UMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461047; x=1752065847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1U/jcJUt63/R9ojtJdyruc5PkgT9HoGw/OOSpSJ154=;
        b=E8+NYy3dt5d/RC6EMSsrI9TiRqfL5LBLeb+g0CxQPANSLWqZq1XD/iACkrYJPRFlhQ
         o3FpPHo9j8021faQeNiK8RiXgin6ZDqep6rN8s4GCZHfsq7PpSklLFIXan+8xED3Q8kZ
         QSHpCgJy1+fDYsT6PI1dePjn2I6IIBMpa4YOEGeliuEbEmH9XfCF+9fl1KodDPJ3hoZM
         P8ufWP+usz4a22Ob1f003bYxDgNIq8xcocJ6Vfwv32xD1aemyI0/Hqv2eey9P9baQwsR
         c35nndrA/Wx2vbK6y+IeZSvuIDu/27G2gTE1NHTgTh3RbR+w4Kq0q+lHyfGqXOoeqt07
         e+cw==
X-Forwarded-Encrypted: i=1; AJvYcCXF+kdklhsPXmrY1NO9/484VSR6byrRpjBLxyUMXf/RVlsrs13IGE7zFDaZX3C2maRD9tfhB+NzuHkbTmTGVZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFa98w25Nod/QI+NDU/FxL23DpEIjNhXwUVWLlqEybPEPifci
	GkrcvywNswp0FEbeh7OCgnf1SqwMhVV3tFe4l/fHQVOu5TFVskhOASU30NhavICz510=
X-Gm-Gg: ASbGncva4TAYqi1lIV07UNfGT2Li6VMR7EZZuuS+jklfRNsL6/Z7DJ1u/2PPtbwPq3v
	cxbtEKdXcOTmxTHBwrWKqO4YtbyOLo2oaA9xu1MV4nB/Ut8YJ8mQB0hwjTi6vj76FQvlMI8i3XQ
	6SRtxmmoAb+dHv+NEaQtZTLSku/D71O7g+pZgX7/Sv3GO++Is1CKIB1iwKF+40kXyJz6SeD2uQU
	j9BWjrds2RaQoD0+I5zvKED1k7fPqZy9+EunNNOvrmSAyqFwH3qrvZsNt0f33pUODXWmnuBoEiR
	fDKdMsFcH016+4nL6WUpjqim68t6FK7EYegH
X-Google-Smtp-Source: AGHT+IHUMiBPjG0eWEZJypXuRy9Vl0pcPIQatE88RekI/5Jeu9Byi7LTA10RE7s734tKjAic64bqaQ==
X-Received: by 2002:a05:620a:2492:b0:7d4:4c7b:9701 with SMTP id af79cd13be357-7d5c47831e7mr344047785a.35.1751461047340;
        Wed, 02 Jul 2025 05:57:27 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443204feesm933663885a.56.2025.07.02.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:57:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uWx1h-00000004bTR-3GW4;
	Wed, 02 Jul 2025 09:57:25 -0300
Date: Wed, 2 Jul 2025 09:57:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Managed allocations for tpm_buf instances
Message-ID: <20250702125725.GA904431@ziepe.ca>
References: <20250701145136.82726-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701145136.82726-1-jarkko@kernel.org>

On Tue, Jul 01, 2025 at 05:51:35PM +0300, Jarkko Sakkinen wrote:
> @@ -32,28 +32,30 @@ struct tpm_readpubek_out {
>  static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> -	struct tpm_buf tpm_buf;
> +	struct tpm_buf *tpm_buf __free(kfree) = NULL;
>  	struct tpm_readpubek_out *out;
>  	int i;
>  	char *str = buf;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
>  	char anti_replay[20];
>  
> +	tpm_buf = tpm_buf_alloc();
> +	if (!tpm_buf)
> +		return -ENOMEM;

apprently this isn't the style guide, you are supposed to write:

  	char anti_replay[20];

	struct tpm_buf *tpm_buf __free(kfree) =  tpm_buf_alloc();
	if (!tpm_buf)
		return -ENOMEM;

Jason

