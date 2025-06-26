Return-Path: <linux-integrity+bounces-6543-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF4AE9C01
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BA41C42604
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC56E271464;
	Thu, 26 Jun 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUeM811Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC337271457;
	Thu, 26 Jun 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935509; cv=none; b=W6hLuJ6Ls5CZ4w2DF77sjHTHD09A5Hbl9OglQ5969D877640g5HPxBdXwAIMURKIQ4hW8NtWMJw/cPC3qZIF+xUWgkCNq7sMKosbGaHWYyG0zH4h1WCMpC2uQQHN6h6fcudyrkLKBVq0tO1MOf+O3d00UHHisBy7vTBNKMg7VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935509; c=relaxed/simple;
	bh=vMb+SU98WS5/JN7fBR8wAP4QdLYbO3ss3ekl/6OODKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG0RGklnxAdWsTTknlL8JJMT0bPZ+pTDNhDtNfwWoEC813s/s1sdj0GR29yOa88KoUFXeYZiJjaibKEHuEXU5Sw/8D4CsCQKOF+pWgcplzlMvmbJmcUns5mD4kapaIlY4oGa7yF8ckdJpsf6/SB3iDqA62irhiMz49D47VhyfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUeM811Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4408FC4CEEB;
	Thu, 26 Jun 2025 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750935509;
	bh=vMb+SU98WS5/JN7fBR8wAP4QdLYbO3ss3ekl/6OODKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUeM811YItX6OaSewbUEAhHdpFGD3wYKQa2QVcSmVId5Dj/mMl6L7LoWRqKhxveT2
	 tXTLkCf4rhFZefW42S7eeV6NwMONV8yhphbQ0+iu6rwxDfvLD9gK86jgJIf6LPX5L2
	 zqxlizeZhk7oHQJe03DJnMQqBu71G8rYoIW+QqKA=
Date: Thu, 26 Jun 2025 11:58:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sudeep Holla <sudeep.holla@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb_ffa: Remove unused export
Message-ID: <2025062651-distress-bagel-3718@gregkh>
References: <20250626105423.1043485-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626105423.1043485-1-jarkko@kernel.org>

On Thu, Jun 26, 2025 at 01:54:23PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Remove the export of tpm_crb_ffa_get_interface_version() as it has no
> callers outside tpm_crb_ffa.
> 
> Cc: stable@vger.kernel.org # v6.15+

Why is this marked for stable trees as a fix?  Seems to just be a normal
cleanup patch to me, what am I missing?

thanks,

greg k-h

