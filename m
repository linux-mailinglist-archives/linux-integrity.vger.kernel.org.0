Return-Path: <linux-integrity+bounces-6527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE06AE8B4D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA47BDDE4
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1152DAFC6;
	Wed, 25 Jun 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhUlDfOv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155C2DAFC4;
	Wed, 25 Jun 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870992; cv=none; b=ne+b14SLAfG38rQJGxh8v5BOyD3n8nBSTVKNCWG/OEaxHcogObRd9JuDNVorgoiMglC2Tj5iDA0SOaWabvH3skxZK4xo0SiDsD7yQksRza8vSlN28x1YAsdBfKnh9E0qhKsM0ijPwlzWIVq0FPoJ/mBeqKKp7x2U0YETtklKXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870992; c=relaxed/simple;
	bh=R2ys2tdAkGhb2p11OPXkd5n53kwZkob3IDlhROQoduc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXpFSQq/iComMaeWlhk+gZov0JjrE4O4QksQSrAa15E3PF99bSIbJ2WRL/N67IumHqNm9j9crKRrThANxdwVILGUx5TAORCuYjv1OtqwfsyIUbxEtgosDbsJZuMrm2jMC2Ii7du+Dt1F4uqQTqtjBQhUZfehARTjtXNJyBsYGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhUlDfOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0E2C4CEEB;
	Wed, 25 Jun 2025 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870992;
	bh=R2ys2tdAkGhb2p11OPXkd5n53kwZkob3IDlhROQoduc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhUlDfOvKkvAcRx0Im/EG4SGVu4aIoZZNzNgkcuP8OaY08OcOY4nO8XmWdWgWneB+
	 WsvqjMEaLe4K718UamBa4a7jjaejQ3P3iMLQJw+IwSNTt4w/D5QSA3PU0S28x94/bm
	 a5FeCzuXlXGEvZD5YvewEkzp2d3J8DO7kqOUnvmVta6dlq4hg/KQlBvBBYQXEV61UZ
	 kjWFenc8ptyK39MXNGAHX5SgP/j1I25cQDyNEW3D6g8MdvNnaB8A+G15f1YmTBraDd
	 wNbe7O6Rfg4oAjrqt92N0aDAYeBfiX7dHNEZGTe76rLDbRPXrlc+WKc42ymChEtQIH
	 WRyd6IMTwDf4Q==
Date: Wed, 25 Jun 2025 20:03:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when
 it's built-in
Message-ID: <aFwrzEPUAbLaOAgY@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <20250618102302.2379029-3-yeoreum.yun@arm.com>
 <aFs02ZgVyGTg2cJx@kernel.org>
 <aFvRePYyX/Xuxe8N@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvRePYyX/Xuxe8N@e129823.arm.com>

On Wed, Jun 25, 2025 at 11:37:44AM +0100, Yeoreum Yun wrote:
> Hi Jarkkok,
> 
> > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > @@ -115,6 +115,7 @@ struct tpm_crb_ffa {
> > >  };
> > >
> > >  static struct tpm_crb_ffa *tpm_crb_ffa;
> > > +static struct ffa_driver tpm_crb_ffa_driver;
> > >
> > >  static int tpm_crb_ffa_to_linux_errno(int errno)
> > >  {
> > > @@ -168,13 +169,23 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> > >   */
> > >  int tpm_crb_ffa_init(void)
> > >  {
> > > +	int ret = 0;
> > > +
> > > +	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > > +		ret = ffa_register(&tpm_crb_ffa_driver);
> > > +		if (ret) {
> > > +			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > >  	if (!tpm_crb_ffa)
> > > -		return -ENOENT;
> > > +		ret = -ENOENT;
> > >
> > >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > > -		return -ENODEV;
> > > +		ret = -ENODEV;
> > >
> > > -	return 0;
> > > +	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> > >
> > > @@ -369,7 +380,9 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> > >  	.id_table = tpm_crb_ffa_device_id,
> > >  };
> > >
> > > +#ifdef MODULE
> > >  module_ffa_driver(tpm_crb_ffa_driver);
> > > +#endif
> > >
> > >  MODULE_AUTHOR("Arm");
> > >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > > --
> > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > >
> >
> > NAK
> 
> If you NACK with your comment on the cover letter,
> Would you check the my comments please?
> 
> Actually, this wouldn't be fixed with the Kconfig.

I got into the same page (see my response to your response at 0/2) :-)

Thanks for the patience.

> 
> Thanks
> 
> --
> Sincerely,
> Yeoreum Yun

BR, Jarkko

