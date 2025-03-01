Return-Path: <linux-integrity+bounces-5027-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2CA4A6FB
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601D5189CF67
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5879CD;
	Sat,  1 Mar 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ToxcIgwB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93E101DE
	for <linux-integrity@vger.kernel.org>; Sat,  1 Mar 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789014; cv=none; b=ol4n3GpMUl0FMnlFFHLzaJNpAGaPKgTHCqsrZnTX7C/6MgE3DBecC35JUTrHWz0zTWS7ChOixtmPVy4DaZzwLglaEtU1LcmX7J+Wc3SFHCWQPcLG8JmBmAITbnz8msbfSnvwE5JNv/vZVQruycHX6Ao9V1bcEpXd4/bfWGUonUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789014; c=relaxed/simple;
	bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkFwQUgIfWr4HTo8Hw9Zo6IBX1Y9p/TOHfdJqzIw3Cu4pRDcxgOV6sPYns+pwxfvfHNq9tOc/hcp8hbNDXhpqNugNPBur0tkzR0T4x1cY3ucRwnwxJGUlk62/vTx9Lpe48B8bRq72ZarCoFhSmJZKXapi5yZ+rnx2pZlxUY71Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ToxcIgwB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471f2e1bea9so24926421cf.2
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740789011; x=1741393811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
        b=ToxcIgwBZa5Y4Xfz+fYUCsTYGbroHOttcem1B9019DL9MINjMdAUU4KLHzcnHFrnpM
         Ck0FYt6pw6Qtog8Ncwn8NmtJ+sE88j+kND/mmGSXfA4xXRJtTda/2RYMbl84iYDVJ8m1
         JdPrwE2PplqQPyaFAy70e3+eqBqweLAMuXRnWx3f/rd4hszEwDPaJnGXkHYo4Vhn+JgM
         VQCJ6tBdEhZ9r0cae0PWoYK/SEh6w6hFELn/6v/3mBKmH8wxpAk47qaB6Qmm8SVKVW89
         JlzfQ3vXSvhxfU85tBIEqnMvaqQeI2ht2pOPdANLBEn6k+jJUqHtcqfvhAbULj1aPpWs
         epiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789011; x=1741393811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
        b=Z0E+dZFPskUILvFlDM7Us3k9McvhHCwfzBOEufv1l37ZxPGjD5r8mbDdrQtpOMBLHD
         zP7i2tdgxvI4Vp2w40kg96ZjwGfLsV47xDTI1nNSKIzkuhT2znPB2CijJZLDpLyFWuLm
         bzebtqe9YhUaEfFOItbUS2yKwYcUkhlgWi3DWaw+XH6jQKo895pMRy3G/Fi1ZJCqbJzm
         tYxBTK0m8CEsPZCjgCqk3T4fDeMNYcPZuG1pWpUEhlbuEfVDL3+VurCWi8XXjmJ++ulp
         U84s/tigG3592M+ir1JSQTt4/6K5mbwsiPHB3sJGCYYbSh0CFJdL2H27Ekkq7C0a3p/H
         bolw==
X-Forwarded-Encrypted: i=1; AJvYcCWXM9XxC/lqQ+YX5KksqFFnbVT3jCmPFS5ie0eTayRcu0UoyZgnQshXW9S5tK6ekC9NjAxJc/N5s5bSWvk2LzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdcAIcAhSwRUEDVdkXgzEbQrARegEFaP9wGXwe2YK2GS4SPbv
	DGohvGCT2NYgZMUlWGgE7da0/oVX+pT5IhSQr366Q21MOByyw3AxEA0H2j38FRA=
X-Gm-Gg: ASbGncv6SfblzTGCxXYX0O19OhMmB6dQwG3KxCaRyZskg/DuKD1JlLd24VlQy+RIJfp
	Qjp0kjGqFwP/XkA8xt5PG783cHsmJ7Lbhz4ZfY8hm8nUiOqB3UknMI4A9Bke6iRpL8iXtBAlPqo
	hCn6ABERB3sWDtMAWFE9d1JTznMN+JprqWRz1YPXfqwU4KwAQn2GyxZQtsHBLpDUdE8sibsEHUg
	iqEHR9sTvEIqSGYJch9GhSXRMH/8+1Y8ITb+DJM6g0G1DPGR4aJunL3OMevAe0H8UrxN5mvDBmz
	MqnndHpYIAns3s6GF0vLITb6SvrVS3T71LSo49aJw19nV2vMeX+33SzdgoE5cCseI0PnWecWpln
	QBlVQjrCvKQDme6gxYQ==
X-Google-Smtp-Source: AGHT+IGoKXhCq1vdLsUCIzF4lunmHcwYw+D3mRuNmPD/25PERj7Y5vHDBX7k1/qClqDvWD+UHansAA==
X-Received: by 2002:ac8:570b:0:b0:471:ef27:a30a with SMTP id d75a77b69052e-474bc08cb95mr87868941cf.28.1740789011339;
        Fri, 28 Feb 2025 16:30:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf857sm30749961cf.38.2025.02.28.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:30:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAk5-00000000VNV-3jdd;
	Fri, 28 Feb 2025 20:30:09 -0400
Date: Fri, 28 Feb 2025 20:30:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 0/6] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <20250301003009.GP5011@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:14PM +0100, Stefano Garzarella wrote:
> I put RFC back in because we haven't yet decided if this is the best
> approach to support SVSM vTPM, but I really like to receive feedbacks
> especially from the maintainer/reviewers of the TPM subsystem, to see if
> this approach is acceptable.

I didn't look in high detail, but the overall shape is what I was
thinking about in our previous conversations. Very little TPM code is
under arch/, we have a nice simplifying helper in the core code, and
you have a tidy platform device to tie it all together.

Jason

