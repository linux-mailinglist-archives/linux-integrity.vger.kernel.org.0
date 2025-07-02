Return-Path: <linux-integrity+bounces-6592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786AAF657C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2853BD6A3
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC2245022;
	Wed,  2 Jul 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5BagjG5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F01DED52;
	Wed,  2 Jul 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496133; cv=none; b=CY2hcd2bYgtM8dq6he3hex9lPhvATuCaNZaGOK7iy6ggWdbmtcYLwwsI88wxACD5MLFoF6fFuIemBLzBgDsw6a59kYQUD8wOnxoOT2Iv5aO3qQ90e2jPoiUfvWs4YMCGL0O6xTuU6CurZZCFLfhJqBJ3+wUOZcbPAU9/d/PaPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496133; c=relaxed/simple;
	bh=Qlex3J95n7fWXidhlCTd4uELRhp1holqYUtR8DTuccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1R+g6KhRvrG5/OkjRnBECnQYbahXsHrjfSR/GFV47qEjx7Gc/16rgZdaIb0n11MR6/dRbvFoQdOhTkmB3nEzOA5avU2DkooLIGFW6xt2xQSQWCmbdJQqcll5pq5MWYNmo3Q1M9kErosPOwdPLQnTPP7/qEFCazu2XPgIEIcGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5BagjG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D6CC4CEE7;
	Wed,  2 Jul 2025 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751496133;
	bh=Qlex3J95n7fWXidhlCTd4uELRhp1holqYUtR8DTuccA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5BagjG5whxkRyCMsdar2lYqammWFThALos8csRvFrpzACoGEqBPupv9MLdOCh7cZ
	 Q1CcMjUpev3bQb3W6rH3DHMrvmy8hVGcqHdUenkA+eDJxIJO+RaR8zGSHf5y+rD06T
	 +A7jLI0zxLcqnW4iaEm0Y/+S0aMX1/2EpobYAkjyJPYcIHO/diVGWiakMy5IhYpNI+
	 CX7ym/gHNeiywWrQJOjT2mbBVJarbfBVla0YbXeVgzNrrp3huCFIDpk2MzMeYQ3Rod
	 oWjUTkQJATermMWTiwLeGAivlgniTH74KAJE+0YF0uApPXx+2Wcun1wMhazjBZyZ2R
	 DM4III4UYxzUg==
Date: Thu, 3 Jul 2025 01:42:09 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <aGW1wdJQ2oFpGQwq@kernel.org>
References: <20250701145136.82726-1-jarkko@kernel.org>
 <20250702125725.GA904431@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702125725.GA904431@ziepe.ca>

On Wed, Jul 02, 2025 at 09:57:25AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 01, 2025 at 05:51:35PM +0300, Jarkko Sakkinen wrote:
> > @@ -32,28 +32,30 @@ struct tpm_readpubek_out {
> >  static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
> >  			  char *buf)
> >  {
> > -	struct tpm_buf tpm_buf;
> > +	struct tpm_buf *tpm_buf __free(kfree) = NULL;
> >  	struct tpm_readpubek_out *out;
> >  	int i;
> >  	char *str = buf;
> >  	struct tpm_chip *chip = to_tpm_chip(dev);
> >  	char anti_replay[20];
> >  
> > +	tpm_buf = tpm_buf_alloc();
> > +	if (!tpm_buf)
> > +		return -ENOMEM;
> 
> apprently this isn't the style guide, you are supposed to write:
> 
>   	char anti_replay[20];
> 
> 	struct tpm_buf *tpm_buf __free(kfree) =  tpm_buf_alloc();
> 	if (!tpm_buf)
> 		return -ENOMEM;

Sounds fair to me. I'll shift to this direction in the next revision.

> 
> Jason

BR, Jarkko

BR, Jarkko

