Return-Path: <linux-integrity+bounces-7405-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2559BCB96D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 06:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A173E4EA073
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85F182D0;
	Fri, 10 Oct 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWnL9W5v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3494414;
	Fri, 10 Oct 2025 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068914; cv=none; b=TrUsFCGDkGQON0vYjt724XCVvzpKLaOGsZy4ll+n3HiwEqj63A0A0CsUcfQ1OOBl5S0aqqXzqANCHM19514nJXtV6JqP0Wxl9QCwBsIVqzDvRC1Ru5KmGpewo5QMuP+D+cCr7usj1eS2979PeetOHOYVot7WnYp7Iy9xerGXHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068914; c=relaxed/simple;
	bh=ib5Tf65cpQlayck4K7tgp8Or1k3DMe8jI4294TCf+lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKfPmqUyPCsd9NmhbQHHJJ4Egcgz14ZCmIT+KN/PBKQjWlRKPfYBUqXD6O2tXA+T2PWXVmfFy2iwm01San1hdoErbXHj/ymYil3aYM7LBWjCsny6p9EWBI5HDZB3JNhENRF8aYxsv/+NyZy0+2KjVAlOn59mkfQKhfItobTKiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWnL9W5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C4BC4CEF1;
	Fri, 10 Oct 2025 04:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760068913;
	bh=ib5Tf65cpQlayck4K7tgp8Or1k3DMe8jI4294TCf+lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWnL9W5vGzXbDLuylqiULwSwob3LvjKENf9T6IoEveeZmQzCT3FliMHAaMpSrsQ+h
	 CrwWMsvftpyz2VcREwRxWa9GFrXUEDFo5n1V0U/EaQx9Mevtkmv76VTVQeZes1qcTK
	 HyyE9DC7RfxYO0gNv58bSUHnFVJcg8QK5bF9TYNytRi/f91f0zVvBJs3WFDp9QIqi6
	 LWJABgQ5Kq4GZPJ8iLc2PZIvl3zKumPg7GouQ48wOShiMWpbLYm4LEwIbVBAW5YAKH
	 m0mgUhwPQFSEWRHB40K9eE4cHdgEvDIL0vwIDLSgmrLDpS+lwiw13vLaj7E+w7aVwu
	 TcF04YMC+d4kA==
Date: Fri, 10 Oct 2025 07:01:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use designated initializers for
 match_table_t structs
Message-ID: <aOiFLjI9iqtEPDdk@kernel.org>
References: <20251009115817.368170-2-thorsten.blum@linux.dev>
 <aOiDqjEyowUkegbd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOiDqjEyowUkegbd@kernel.org>

On Fri, Oct 10, 2025 at 06:55:26AM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 09, 2025 at 01:58:17PM +0200, Thorsten Blum wrote:
> > Use designated initializers for 'key_format_tokens' and 'key_tokens' to
> > allow struct fields to be reordered more easily and to improve
> > readability.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  security/keys/encrypted-keys/encrypted.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> > index aef438d18da8..76a6dab2f4d2 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -62,17 +62,17 @@ enum {
> >  };
> >  
> >  static const match_table_t key_format_tokens = {
> > -	{Opt_default, "default"},
> > -	{Opt_ecryptfs, "ecryptfs"},
> > -	{Opt_enc32, "enc32"},
> > -	{Opt_error, NULL}
> > +	{ .token = Opt_default, .pattern = "default"},
> > +	{ .token = Opt_ecryptfs, .pattern = "ecryptfs"},
> > +	{ .token = Opt_enc32, .pattern = "enc32"},
> > +	{ .token = Opt_error, .pattern = NULL}
> >  };
> >  
> >  static const match_table_t key_tokens = {
> > -	{Opt_new, "new"},
> > -	{Opt_load, "load"},
> > -	{Opt_update, "update"},
> > -	{Opt_err, NULL}
> > +	{ .token = Opt_new, .pattern = "new"},
> > +	{ .token = Opt_load, .pattern = "load"},
> > +	{ .token = Opt_update, .pattern = "update"},
> > +	{ .token = Opt_err, .pattern = NULL}
> >  };
> >  
> >  static bool user_decrypted_data = IS_ENABLED(CONFIG_USER_DECRYPTED_DATA);
> > -- 
> > 2.51.0
> > 
> 
> For me this look like a "convert tuple alike initializations into struct
> alike initializations" type of change :-)
> 
> In a context the change would make sense. E.g., if an optional field was
> required.

If we had struct initializers I would equally nak "convert struct
initializers to tuple initializers" type of change.

BR, Jarkko

