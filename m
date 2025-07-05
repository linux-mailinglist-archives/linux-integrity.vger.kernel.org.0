Return-Path: <linux-integrity+bounces-6636-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36032AFA0FE
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 19:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D96F17C58B
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464771DD877;
	Sat,  5 Jul 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/ZvpIT+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80E10E0;
	Sat,  5 Jul 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751735517; cv=none; b=AVa7Df+By2csYcWIbduhLIHUTsJRsXQj0SOX7mqCid0DcidKxYG9ti6YXP17mpYRRYJYBa/UP7AvbDOf1clvt1rV49Y/79vVqWCVgMrk/FwATF4A0EO4QL3qwiHnKJLGoJUFSffASxBetZsVtOAvJv5RFZRCv+Lpf2rRxRI6RBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751735517; c=relaxed/simple;
	bh=p0vr5I29bsh4kSl+uTpgzLmEmSu/WNqT7YtAdhvTD00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNs3vmeA2MTwg/cA62pvx6AZKHON4EU55XgksZ+LmDBT7c5LBSwAI4Pwaa5U1Anl8kB3NZLRAa7pZ3Len4aGBoq3iQAGH2/YG/i5k5qj3JSQAC8uRCIhm/zeOIYqCFS9tNJuiMUeGLC1XVfAXnySXv79dkmTKseG6YoA/eKsTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/ZvpIT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2DEC4CEE7;
	Sat,  5 Jul 2025 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751735516;
	bh=p0vr5I29bsh4kSl+uTpgzLmEmSu/WNqT7YtAdhvTD00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/ZvpIT+359LZwE9X8lTxVLDthvMLxegQgtcJtTV17dmC/pXiNpzkliZ0ecE7ePD5
	 qHodwTcPOIAbNSmgjdGUlCWubLbZGBSAEz9Xhf6aU1+k25QvI/RK5iGL07M11UPKkw
	 M7h819UVyvz1U8z3uNfC6nkTACe3u+blnvoTFDKnssFtKe3id107clN9rWItY7EDBd
	 THw/+jB4xgFUT9+6yJ5pHrianCqkCS+bM5t9Emjz4oMlbgT6+xa6cNPdgZmRDQVt2j
	 ALWLshR36FkRq11UHymfpvEnNiNKPF+ssPGKLyzwBZ5b5nr7eSEmOfqpiwQYaAg0pg
	 3ddFXcMmOMZvg==
Date: Sat, 5 Jul 2025 20:11:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Prachotan Bathi <prachotan.bathi@arm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <aGlc2I9YGgPyc3lO@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-3-prachotan.bathi@arm.com>
 <aGWvtzhs5ksKgaYo@kernel.org>
 <151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
 <aGdAMg43nHPwgeKn@kernel.org>
 <aGdC8gyO00AB_aPr@kernel.org>
 <20250704114010.0d210c31@pumpkin>
 <aGffUrDSjNH6w6rB@kernel.org>
 <20250705081003.26409484@pumpkin>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705081003.26409484@pumpkin>

On Sat, Jul 05, 2025 at 08:10:03AM +0100, David Laight wrote:
> On Fri, 4 Jul 2025 17:04:02 +0300
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > On Fri, Jul 04, 2025 at 11:40:10AM +0100, David Laight wrote:
> > > On Fri, 4 Jul 2025 05:56:50 +0300
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >   
> > > > On Fri, Jul 04, 2025 at 05:45:11AM +0300, Jarkko Sakkinen wrote:  
> > > ...  
> > > > > Well, that was some truly misguided advice from my side so all the shame
> > > > > here is on me :-) There's no global memzero() and neither explicit
> > > > > version makes much sense here. Sorry about that.
> > > > > 
> > > > > I gave it now (actual) thought, and here's what I'd propose:
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > index 96746d5b03e3..e769f6143a7c 100644
> > > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > @@ -203,26 +203,20 @@ static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
> > > > >  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> > > > >  
> > > > >  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > > > > -		memzero(&tpm_crb_ffa->direct_msg_data2,
> > > > > -		       sizeof(struct ffa_send_direct_data2));
> > > > > -
> > > > > -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > > > > -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> > > > > -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> > > > > -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> > > > > +		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
> > > > > +			.data = { func_id, a0, a1, a2 },
> > > > > +		};  
> > > 
> > > clang has a habit of compiling that as an un-named on-stack structure that
> > > is initialised and then memcpy() used to copy it into place.
> > > Often not was intended and blows the stack when the structure is large.
> > > 
> > > So probably not a pattern that should be encouraged.  
> > 
> > This is interesting observation so I had to do some compilation tests to
> > verify the claim just to see how it plays out (and for the sake of
> > learning while doing it).
> > 
> > Note that I use GCC for the examples but I have high doubts that clang
> > would do worse. Please share the insight if that is a wrong assumption.
> 
> It is a clang issue and may only affect builds with some of the 'memory
> sanitiser' run-time checks.
> Search through the mail archives for issues with overlarge stack frames.

If clang really did that, it would cost at worst 40 bytes of stack (aka
the size of struct ffa_send_direct_data. And if there is an issue, it
absolutely will get fixed.

That does not weight over making a code change that makes the most sense
for Linux in the long-term. And to add, I did show both the code and
the figures to support my claim.
 

> 
> 	David

BR, Jarkko

