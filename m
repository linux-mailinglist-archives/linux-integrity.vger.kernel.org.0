Return-Path: <linux-integrity+bounces-5603-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D619A7B89D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 10:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173CE178FBF
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14346185B48;
	Fri,  4 Apr 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaonLrE7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD311F94C;
	Fri,  4 Apr 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754467; cv=none; b=mXl2Mtb5M1MwMRVP9piRRU3Wt7yzAVCZ0GpvapGYROPQvla2MbkyLFXfiqsLqe0SdFiAOM87cQU6spQUvypK3KggXN59I0fGsNOaAcE6mGFuKK7/urCW1pHqu5uumpMogVm4dWZTSb+OjZJ3xXgwPDH4BnfC/aqKTtlhIKppu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754467; c=relaxed/simple;
	bh=847p1n2XM/fNx9MeXiMIcuHP1l5bB2Xb/LDGMyZx9dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibx8TqViQGQUbXgw42/8JIoaAvEbfK3o/s4VMbdnhc4DJyWky10u0BFu8L+myGpEepdqmPi0ONkI8iAdGn8gffztQsyxTEf6GqCRSkoQrZ4wj2Tx+Wo/NKrw8iUeL6Cn07/XoiBpegUmfRDwlSbk3YuNSBwSVa0gvPIYuN3gtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaonLrE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5304C4CEDD;
	Fri,  4 Apr 2025 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743754466;
	bh=847p1n2XM/fNx9MeXiMIcuHP1l5bB2Xb/LDGMyZx9dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaonLrE7GezuqGL5gi/BOuVi/Pw82DmxFO/4xHbCEc0IaLzze0p4toFJiHn3G0/Jy
	 Kg1UdX4kA+ochl4+JZzFTe7JSfjrqzC9+26NU65W5xJL2IePYTM6h84I2GRpVCV9T3
	 vM3O3qvLsErHQWhR91lBtRwTfeCeo/8d8jMkjD0dkR19J9DqlchEOXBvcxrEI7Qb0x
	 N2F85iP1lvfVGZk278LqcArjLvZManbMGGT5tIf0aS8qVlf3mEnJ5kIzOiKinNvjOr
	 fKBIWZJCzR0hOquV6SGj5Akz2VS/z2kZ9ro5VJBMPBq7jjb0ENBJNgz3yFAhU7w3bU
	 xOplO+NDYgCgA==
Date: Fri, 4 Apr 2025 11:14:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeout B
Message-ID: <Z--U3sDhcv0YYUag@kernel.org>
References: <Z-6Gau3aCB7B3pB9@earth.li>
 <20250403182519.8412-1-msuchanek@suse.de>
 <Z-7YHkb_2Dpz7GpV@kernel.org>
 <Z--UYjUAYehDqOla@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--UYjUAYehDqOla@kitsune.suse.cz>

On Fri, Apr 04, 2025 at 10:12:18AM +0200, Michal Suchánek wrote:
> On Thu, Apr 03, 2025 at 09:49:02PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 03, 2025 at 08:25:05PM +0200, Michal Suchanek wrote:
> > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > C) can reach up to about 2250 ms.
> > > 
> > > Timeout C is retried since
> > > commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> > > 
> > > Timeout B still needs to be extended.
> > > 
> > > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > V2: Only extend timeout B
> > 
> > git format-patch --v2 ;-)
> > 
> > NP, but use --v3 next time...
> 
> Where do you get git with such practical options?

Oops! My bad, sorry.

$ git format-patch --v2
fatal: unrecognized argument: --v2

~/work/kernel.org/stable/linux 2254ea2ccee8
$ git format-patch -v2
# success

BR, Jarkko

