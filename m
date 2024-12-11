Return-Path: <linux-integrity+bounces-4353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CD9ED076
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 16:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E771885BFC
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697B1D63CA;
	Wed, 11 Dec 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NXUb3s1z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A71D5CF5
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932442; cv=none; b=n1SLMrXMOB/svRt2uuLxojGYnf4hnrT1CHWc5sAUTWLFE51zoSfCJUMz0hVKmtR9rkm3fuLNqLxGxGU4dj176mr35ca6KVLSv/EOOlsV/MsbzMZ/W/zy3XHC3yf7babxBRcM8athzQd2Eic+QjAaGPeybbG9guXO923F1qgMwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932442; c=relaxed/simple;
	bh=acS43lYKRsASxAvzHa41X02Mk0KgLiEkzt4AOcfTWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBjvU3iNfuPsHTJ8gsWzx03Mo4KGfJc1UIjJhbUkCy2C3ZEz6tmLfp9oIuuQGUehhyoHXV+xVNXlLNK8YkmgYE7GIhrsdZc4QW0RZHIzbwqMkRCJ7DmV5bFYGGzKJjCnpLABVnprHEmW56PFCt87Sn/or8pA2F7ZX+u/in6UJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NXUb3s1z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46792996074so3712551cf.0
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733932439; x=1734537239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acS43lYKRsASxAvzHa41X02Mk0KgLiEkzt4AOcfTWK8=;
        b=NXUb3s1zYxdUm+p4YKQT0/NSFppGhHiLtsGCarKYmwuJYT/xdMI1owd2SZ7VtwGXuW
         ppzr6wc8mkJqT7tCFguHB/HNJFb9kdkKuR/s84zMZVrk7g2vgCH4jrHT0EOW6VbFE0G9
         5BiJlc4v6eyl2g4XWES5Sgh5jcQCrhJny8TBCWV/mbgLGKkc6cfNaNwKfAZv2Wgg82M2
         jGgAqBRtSXrs8LPA1FeIpAMRAFXjBu/LJ1Tt+IlzkG5CTexDcYDq2pUnnUGJ5KhMQbe0
         4cXtWftLvFQgCcFIAiWeDVVnDfpmTkpPfcO6QITvcKi52KHjNDncwreu43dUReP+ffCi
         0qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932439; x=1734537239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acS43lYKRsASxAvzHa41X02Mk0KgLiEkzt4AOcfTWK8=;
        b=bjdZxUSdB4wdJa0EbaAgnGi99uIkxw2vAoXCpidsvcpmrSK9wRvfjuxCoexYq5SUXG
         n7JyydD+MyuI6BudrbzC2+pHvYXPP/RF0PYmvLUKlRYaLOR39LkiJyvQOYY4tfoBIfIF
         2yv4lAgm4d97/v9UsvxzB9TipTpqJx+Y0jn+qU9x9MpF0G80EJbGqGssVMeOkJ7jsl7c
         YhgbNksuZGo4kPyroXRJrEY/1Afg1/X9B4CUNfPOfsgLwh8sOlGTIALgG75xKbD4egDF
         qYOjx7i8EvnJ2xFGSPhWeSnvGWQBp7yphkcM79QH7jLpe+u8EYJATyZVuhFaspdGqW6f
         7VBw==
X-Forwarded-Encrypted: i=1; AJvYcCX1YR0jRB/YxLAwJmBmoFOhA3NlZrqkh2qNbKCyQftX+uacVMIFqe+NchpP83qLziNQeu96F7XnMp4VmeMRlqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDegVuIYJjdJ3Ic08w+IiP3EYAApQTFot037joSFEXRPwenOYp
	B/wLsiIoEuiLqppvu5PBIuCiF3kgdSe3zC9/voQYzv0vvlrjdSRYpq4t86DBY8s=
X-Gm-Gg: ASbGnctZD5CwHkZ4dgxOsFHBIjK4Z8pFnHZ0khOqFFr0CGsh3Cz10dFxf5MUtOImosy
	HFcOWg8YZuDlHl1/hfin1PIE1q7LtzaooDPIzVAV1PqLOHvs5NsxjjMpW1gOgHhTDmLmp/MDoE3
	C2hPkEi+I9Fz+FdY28GGdAqkSXedgY/UDgtaGTjw25PeSm3q+9EjxpO7xmnhuutoeqwnC6xeTWy
	mKY38mp0Rj3sPXvsvQcgdwb4BhCdQDJDGbFl/mfr6AbshE6phSryEl/Q4dQluXWlPXlmUWxmAcU
	wqFirorvQ/9qULAuWM02padcYfA=
X-Google-Smtp-Source: AGHT+IFyKgaWbAWL5zmxllWMao0jgd1A6vhhNs0OHpVvZrEMlEGUevgAeQu56QZRIPr4+iKvNmtGtA==
X-Received: by 2002:a05:6214:c4e:b0:6d8:a730:110d with SMTP id 6a1803df08f44-6d9347d32f1mr53465126d6.0.1733932439591;
        Wed, 11 Dec 2024 07:53:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fe7f5sm71209356d6.80.2024.12.11.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:53:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLP2E-0000000ADon-1lQR;
	Wed, 11 Dec 2024 11:53:58 -0400
Date: Wed, 11 Dec 2024 11:53:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org, x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20241211155358.GK1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>

On Wed, Dec 11, 2024 at 04:38:29PM +0100, Stefano Garzarella wrote:

> Except for the call to pops->sendrcv(buffer) the rest depends on how
> the TCG TPM reference implementation [1] expects the request/response
> to be formatted (we refer to this protocol with MSSIM).

Make a small inline helper to do the reformatting? Much better than a
layered driver.

> That is why I was saying to create a header with helpers that create
> the request/parse the response as TCG TPM expects.

Yes helpers sound better

Jason

