Return-Path: <linux-integrity+bounces-4553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DCBA10763
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 14:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343CD168CD4
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74C234D19;
	Tue, 14 Jan 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LQsFjL50"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86E23098A
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860045; cv=none; b=VyBj7O3wouvrGm+fRUmNP1E4eJoicWkqXzsT1D6HTdDp9ap87NoCm54t6LvCCdeAyg6XkoobNk6nixaQBdGipcRjEMoXGTCHC6AJ3+V2xGr66J/Wq2w0W66VhXf0RSjqwD9U2wnDIOp/WCySc2oONPQWs2GxZPUOt+oyd7+GzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860045; c=relaxed/simple;
	bh=/avICbdPpHdjemOQvkLGAY2+9dfeloypzwM49yfXZ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oojKpAc633ol+MAjPlCC4LOLPa+al76eBi1tjTE4skLd2KX54vSu5R2QR/KENNU/BHZiyG6TjtZCWECmZxWCTKU7CozOG+j2AtQFG5RCFKjPa60C0Qvg/qZmv56FtQbewoHT96vqzKCmAQ4644/cK9gRf6fCZyLlreOr8r438N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LQsFjL50; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd1962a75bso43424396d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 05:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736860042; x=1737464842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TbuYi0/uhpyIsEsjZiVCHU/0H6AIyzAzvX2PVA6CnY=;
        b=LQsFjL50oooI+CayDX5ewn/omBqtoeqN9u1guEYka1oIK5aqJcGXPu42aIYmBpVd0h
         gK6ZAH4VWW95bnThaOCHO90Mr6bcnqcb1aizzIAbA9RYQT/V9g1R6k77uAf5I6Gst7mW
         78xdyPRUcGd0h/ACazOzotcMN2LfIuCVOrHnxuZH3sz9kslWBrW6rGcaRPjAkRJLqIBN
         59eIC8cBFKYx+GqzdZBsFEfkJnsGHVxkAyKIAM0DiNja5uAZkcf7JwV6ipFZ0NaX6VMH
         KvyBLIU6lII0pwcvkfSigsh9ucohloB1ndeT02w6bXbO/M5Z/REQbFqYaOa2WCE27bjA
         s8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860042; x=1737464842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TbuYi0/uhpyIsEsjZiVCHU/0H6AIyzAzvX2PVA6CnY=;
        b=cfilf5uWwvhZqJse0kBqTJVvbR3t3JZrBj85POQ78Tn8NSQqc+SBqxHyOWTNMTn98I
         xDuXnnWMx2OizoWr32pcQYqsxTahDqsJ/dn5fd7C4pXC6sWl98TgTuQPlGuxXL75NP+U
         7ZAy/2AM6LlxjGDGmDOuQ85HqWxJFfYNnZKfmsw5vVGt59FEza3Lj2Fmk/GVtHyy04ea
         Ff8eH1cD+y6/k0w/1eVeBK1HAxboAolfsCVXhNYaiozBpC+LqIxkXdzy4fjJepywYe1+
         p6O5v31dEK11G9uuFqlSblBm8fGq0I9YR7OeT8kA7jH5RGz5N5xMZmdS4oyUAg5EcK5+
         IqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlO//IgVgSqkMjLYUTWW525FhFjLN3QDr4rex2ngm5ycX1hMXi+J0OIfVvnvgUIys+Rss1LL/pF/27ZFA9bRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHNIjwCe0oO5P94MsN56gu96yk7rAQEKxNOpZt4VP22I9eqRf
	avvnO1Qp61KQOgbDU56xXRpexB9y2667S60PuL0uFlTrvV3MBpRY+r77DIMOyyw=
X-Gm-Gg: ASbGncs7weNZiLC5y0IoHxNZ1b4um6KTrNHFw3VYnjJ+H0hPl6/3jAAxT2R/BLwNGXZ
	FAUXXBqW7xJ1nH6SRJ2Zyy/pRxNspggdxjDU3ztvcJzJMHhThLetx0ipvsUWmPtif7wtkYiQIDw
	gX/BoatUyDgAcSvNNeu9/qP6EqfoMoTX+8foHlpJJEnaRfYWb+LKAv7p1rIV00yPqWTfwSZX2Z9
	sRI+kw2jTF8A3PuxPZ15hLKmHcJztARCMd4tMB8PhUotvxLUbML5H5Jj59adMXhDuxT95V5GHn+
	JEn7bvEWmhb48cZOZb/GS1P/nMkqjQ==
X-Google-Smtp-Source: AGHT+IGLd1udhy0Of2yDBsH2ne4/vF+q3n9lb8J+wsePBP6osAhl0cEquesspYzUnUKjTPWXZsReXA==
X-Received: by 2002:a05:6214:2686:b0:6d4:36ff:4356 with SMTP id 6a1803df08f44-6df9b220effmr448916986d6.19.1736860042256;
        Tue, 14 Jan 2025 05:07:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73b8fsm52418026d6.72.2025.01.14.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 05:07:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXgdc-00000002Lxg-3sFN;
	Tue, 14 Jan 2025 09:07:20 -0400
Date: Tue, 14 Jan 2025 09:07:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
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
Message-ID: <20250114130720.GJ26854@ziepe.ca>
References: <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>

On Tue, Jan 14, 2025 at 11:42:34AM +0100, Stefano Garzarella wrote:
> Hi Jarkko,
> 
> On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
> > >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> > >> So to use them directly in sev, we would have to move these definitions
> > >> into include/linux/tpm.h or some other file in inlcude/. Is this
> > >> acceptable for TPM maintainers?
> > >
> > >There's only me.
> > >
> > >I don't know.
> > >
> > >What you want to put to include/linux/tpm.h anyway?
> >
> > At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()

The intention was that tpm drivers would be under drivers/char/tpm/

Do you really need to put your tpm driver in arch code? Historically
drivers in arch code have not worked out so well.

Meaning that you'd export some of your arch stuff for the tpm driver
to live in its natural home

Jason

