Return-Path: <linux-integrity+bounces-4330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CC9EB39F
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EA6162C42
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4921B0F12;
	Tue, 10 Dec 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WPTuXQXz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10141B6D09
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841629; cv=none; b=Fy+GRmJ7CjnD+Bt+0P2KlWletfRg6LwtzESnf96I/h+zbB90ZvMsFoE+tEHVNMJur6u5TR1Aq0wmPsQO34a34eMqezu7koFmuMBAAcqbmioDt8gA1M0wdvtuIMUhyj/znuADk6tzn6rbmILRGGWXDc5267VrgZSshPd/bTfUiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841629; c=relaxed/simple;
	bh=JoIVFUb4lqiuj92k/cmstv6/5QcjCYKPkCz58/ijs6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaMnbeJg0ZqURqgWsk4RbH2MV+GiLG61b6tJ9fyz+c2H9hbsOOxa13SYiC2EjC4XCmsnF1IUoL0mEYr0R7NrOCslkuIjYWbwCQyFJBzj5chByAE8pjlIWI6qA1GrtDpeaW7IOYVt6rCPKPxOqkZMveFmz3HHoa1FeQNHPOUDpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WPTuXQXz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4676aad83d3so17574931cf.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733841627; x=1734446427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taRWKmra+p/mbT7xIVp84lXpkBlUdolqun+ITMGMMTc=;
        b=WPTuXQXziMlHsrLczT8kwWvWQGLqjT/KnyqLoTGt4K/afL7l6qA46PQVReK5QKwdX2
         fD4It1RI0keA41ovPRaYXRcH5YxyF7qhZLZ9k6aEoZ4tEzNzzT46mp5cFQtl83C+0b2T
         0tOdzi+oo3MlUaKb4NtvhEEqN17/VEndh7uBOZ472VZsuEmezWNQ7wa2sM2dvze53eVM
         7WfY97VrUchwiXHLQ30RO3ytnNHreoJ1/PJPtsUoIrK/1sfY/DzQ9PrFw2nEBtC40+5S
         qH5qMTl7fkS8DFjqPqVFqVuIb0Xbhd1mpdVzIpYQKWQiWU8u0sYJDDD/7VTqd/CW7qVh
         3AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841627; x=1734446427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taRWKmra+p/mbT7xIVp84lXpkBlUdolqun+ITMGMMTc=;
        b=PVUmOrsNhKpiV5wslHgn9STSMDmon1IXhKxPUAuCowHpB25E6m8aTtBsMB+XdwCyKK
         gLxVINc3bfD0xM96zk0r4VdcWUoDWVkFwlhwbpEi3uYFeWGgRFzRaeVN/z/O48+Bsd6p
         Mjheoj6FYuiHJTSHat8r7yBoDcEvwiDQ2lbxEYJj9WqGbHHHqYjd2dzO84jV/nDfGp6C
         diEn+NTcth61/B3nLWl8YFL7qSAU9f+Mr2au/qCdd3oLs6aAvPwvBJ1Ax3r+5xoGCCtn
         +/mtQtHwxlAiyeiBKbJNp8yQUln4KlkEPlN51Xjn8q4rzuE2OniXbGhnJShbpCrm4whj
         94qg==
X-Forwarded-Encrypted: i=1; AJvYcCUmkPLDDC8kIqmPlEwsiqcwU1kMjJE2J10CMsFhmNszl2dG63R/yd6FaEU3moJ3G0ogMZy5ipeXstnFr4guH68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eeZY57jWWWHrKGRi/XhN15wRBc1wfrb0ZP1TSzFw7JmcicQa
	+W5j/OFotDfgGo4ZrP+KHcGONVsu8Tw0QOVWkWiX3BrsTC6igAJtaq2e4oX/zq2awbNCRBrcgJj
	z
X-Gm-Gg: ASbGncsMUFrkcy6NZiZu0WRcrjZYVXoHcfHPmaRPZANfI2J/T1e20jlEKFHEHYXAfkJ
	ESycGKnlOabSPS+rsNjJ9OzcQ0oo9H4V51ctBFJi55O7BsvNpCdNgohVY/5ZxyLjtRX/ff936o+
	7wHbBXfDNUQafEI2Xc6KvChAau8Bd9KYSw7vInWI7WgYOlikYZeccHbyUhyiW4L+1TE4+lTwz/Z
	kZF6NKtbmKT4/raT5ElPJRZ2Mn9yHL4F79HvdXCfiGQXV0Kq92brryxNihL16aRXSZAE8f+7M78
	J78C0aAzVTfkv9D9BlRZJcm6XnQ=
X-Google-Smtp-Source: AGHT+IFkLP9MbL2WiKPj9SIjMVoZeZhAPlq2JNQ88ChV6UcoHjYV2Ck4cRh8p9LeNsUH6YMFLbLSZg==
X-Received: by 2002:a05:622a:98c:b0:467:4c21:e396 with SMTP id d75a77b69052e-4677205d427mr91007131cf.55.1733841626900;
        Tue, 10 Dec 2024 06:40:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm26750421cf.30.2024.12.10.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:40:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL1PV-0000000A2bC-3DVn;
	Tue, 10 Dec 2024 10:40:25 -0400
Date: Tue, 10 Dec 2024 10:40:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20241210144025.GG1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210143423.101774-4-sgarzare@redhat.com>

On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:

> +		if (platform_device_add_data(&tpm_device, &pops, sizeof(pops)))
> +			return -ENODEV;
> +		if (platform_device_register(&tpm_device))
> +			return -ENODEV;

This seems like an old fashioned way to instantiate a device. Why do
this? Just put the TPM driver here and forget about pops? Simple tpm
drivers are not very complex.

Jason

