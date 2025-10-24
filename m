Return-Path: <linux-integrity+bounces-7524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F7C07D1A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC31C256CF
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FCB31A7F6;
	Fri, 24 Oct 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL0dsQ0v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD972FF169;
	Fri, 24 Oct 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331838; cv=none; b=XjglBHpArZ6GOsxe3acovqvmOCqsscjcsEvH8D4O7abl+ao7NGyITqx38uHyt59Yhi4x1sIN9opJEAsJaphDAU618IO6Leok+Npn5Vr8292ez89Xa/rOo+2s1V26Cf4jttMu6JuQL1kr+vkvPL0roqnSH6jEpnenUeg69psQ+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331838; c=relaxed/simple;
	bh=rs7pgTz+6/lllI9GQMbhWiFipksS/qFcyNhMz7XVixY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSWfZxWFat58cRUVt5WTdg+GYqDKanUIMjqoAhZUcdK9pao5NtQLRqiOU05uCJZR++On7F5WKha/yKerLTXKwPEbTprfJiZiS3QjI67LOYgeK5paXHHEGI0+HjQlUan/Ku0NtkQHNCbTIIv2oH+NiopoHk3Mp4wE7+KD8+nr8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL0dsQ0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CFC4CEF1;
	Fri, 24 Oct 2025 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761331837;
	bh=rs7pgTz+6/lllI9GQMbhWiFipksS/qFcyNhMz7XVixY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL0dsQ0vZllZeJyXWdny+jxcd3v881M6J26itqBz6AUwBuzxk1bz7svxtQgNmegQ7
	 Gexcfmpi41y3VZD3AznL+rTy7ycqKUpfSr6b3RATeM8iTLsycjnBOdKazIjgsIlWkv
	 MNwNcdaGXGmI87f8UGtwgX+9oPjcpPz2TN7Re4i/x8F9Gk5BdelpaY/uD4GT0bOyKN
	 +bfQWjH6Es2EiXP8RKbb9qP3kT4GDQrfvreBJ7W/Igm2f22Zjcx0HBQMeg49ZROSj7
	 Q0dLLEtvjuSUSBkk+I8ClZOUPK1/KPgGCmgDZ9c/D3mLC2rrpqz0MurW5D6S3ccQ95
	 Y7wFxT0kl5jqw==
Date: Fri, 24 Oct 2025 21:50:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, keyring@vger.kernel.org,
	dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] tpm: Cap the number of PCR banks
Message-ID: <aPvKetjkUh-_f0yl@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
 <20251018111725.3116386-2-jarkko@kernel.org>
 <aPYg1N0TvrkG6AJI@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYg1N0TvrkG6AJI@earth.li>

On Mon, Oct 20, 2025 at 12:45:24PM +0100, Jonathan McDowell wrote:
> On Sat, Oct 18, 2025 at 02:17:16PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > banks. Cap the limit to four banks so that out of bounds values coming
> > from external I/O cause on only limited harm.
> 
> Comment no longer matches code - we cap at 8. With the comment fixed:
> 
> Reviewed-By: Jonathan McDowell <noodles@meta.com>

Oops, sorry I'll address that and add your tag! Thank you.

BR, Jarkko

