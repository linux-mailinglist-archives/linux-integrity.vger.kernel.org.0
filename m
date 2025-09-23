Return-Path: <linux-integrity+bounces-7238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D5B964F2
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5A188A489
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F123A99E;
	Tue, 23 Sep 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwkoxTcn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25C1F1302;
	Tue, 23 Sep 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637854; cv=none; b=FXn5I6cPCDlUlgVs4R5xhmguRjB9Ri3of+gxPhvWJpq2CwHdp/mzRCVwa3irbrOLieyzxvA37h0NRlcfeHO/4MFwbnmAyH1/B3Kn9tu984Mu0PfQ0bLFBLJBDrxhL+Vmtr5E82csa16ioB2Qn/L19EjqwagZqiF6tKm6YP6bZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637854; c=relaxed/simple;
	bh=f1gnF4CY3mqLm66wb0RGULNA6m7JWI1pfKLSmiEJEJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWW22VQR9l0J3mUv1Ktz4JiRqdx1M7TxPqOg0SJCslBCdbR0n2NbLzq4kFb1by+9nYx4b91Ivo4pUsqbX3G46G7wEKTwxignROKPjMiBvQKSZzl0GYjn4XEU7MuXVy4UUACHaYFaw0thuSnmPSfcDUpKxJVVjs3PHzJRtBq3Sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwkoxTcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45DCC4CEF5;
	Tue, 23 Sep 2025 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637854;
	bh=f1gnF4CY3mqLm66wb0RGULNA6m7JWI1pfKLSmiEJEJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwkoxTcnWSMi3fwcbOR7J6X9XT4RTHLKCsUfWfpMc7JXTHX46muHMm67xnRuIpLas
	 wh4jYpC+36tB8KsuVSZwCFzmhkmjq4szHTA0tz5P5KT1N8oR8D9+WdT8faSOUOpOGS
	 8hgkelBgch3mfuandpFaFJsd9oBbXdrx1slfO5bmMaSDP8ACzAGx8FuHOdBSWos4cl
	 EYxhwhZJxWDS0DOwjEwdK+KoJB0xRkSCZX6y/QMSpIrLPYNh9O2/L05UidgcEbhh37
	 WbzGg05ZeZiJxhxb1VTmwU54MlLJgvwlWhDyBtRlZjZ0Yic/pIrub2BaCyXLbopiQE
	 SNIRGVKM3xURA==
Date: Tue, 23 Sep 2025 17:30:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 4/4] tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
Message-ID: <aNKvGlyNUBKc-Lo9@kernel.org>
References: <20250921020804.1088824-1-jarkko@kernel.org>
 <20250921020804.1088824-5-jarkko@kernel.org>
 <swkdunznhlk5atrdfsiud57uzcvkmknnarzfh6esq3xzy74tmk@2qqsv6tvdtlw>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swkdunznhlk5atrdfsiud57uzcvkmknnarzfh6esq3xzy74tmk@2qqsv6tvdtlw>

On Mon, Sep 22, 2025 at 10:46:36AM +0200, Stefano Garzarella wrote:
> On Sun, Sep 21, 2025 at 05:08:04AM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Use stack allocation for TPM_CC_SET_LOCALITY, as it has known fixed size.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > drivers/char/tpm/tpm1-cmd.c       |  2 +-
> > drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++++-------
> > 2 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index 11c16ad9b2a7..433908cfb4a9 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
> > 	int rc;
> > 
> > 	dev_info(&chip->dev, "TPM_Startup\n");
> > -	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
> > +	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
> 
> This change should be squashed in patch 2, right?

Yep, sure thanks :-)

BR, Jarkko

