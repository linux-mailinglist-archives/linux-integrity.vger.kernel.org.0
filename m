Return-Path: <linux-integrity+bounces-7274-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C393B9B0B8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E693278F1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626E2FC03E;
	Wed, 24 Sep 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clZD0j/K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE419CCF5;
	Wed, 24 Sep 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734786; cv=none; b=jeenL6Vb2Z1XruVgk0z0LE1UPe4Ja7ePbgSvybKqr2LL0xDuXasJxZ5O03zshRQOC1x29KM4YDi+Lv2z/vwKHCIsryyEdQkYr8kUAVUjIfb+oyin5FkkkidcB9QXbftqxGQ1GgCFZkZ3b0ADISdef76I0+a1vy7ppepy/yukvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734786; c=relaxed/simple;
	bh=i+A2vWIRtoLeacGPcvyb2UkQD5W9u2B8lzyc2pZreBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3w6DhGzcxEM2RAklV93QLgqWEar01g6QyGmrkJkxxIgOQBy/vdd/kYhU2/Nd+YV8Fm8GYFqoNOM7Wvacy2DHwiCibgYO5PhSRnqkJdPZk0QEtgIkXGNYv5m12WPA7nlvJzETagKYF+9NJ6CHsaBMe70hCRubc4FS2OVmqiSyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clZD0j/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04047C4CEE7;
	Wed, 24 Sep 2025 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758734785;
	bh=i+A2vWIRtoLeacGPcvyb2UkQD5W9u2B8lzyc2pZreBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clZD0j/Kz+BWC8Y5o+6LPwUuHT+oeyeRC+k8JLMNeDiOsfMDQDbD9uP+tHh9lGtZy
	 HZBe5Earfa+qVEE1umiHT89Ryq6nrtxjpefE4eYPY2U6tqau0nQGl7z1GbPlXBc0WC
	 f/r7Jmivws2dWzWzgHxWxhG+GszxS3jO4036I8HASXnuHeh8+H/h84GNpdQF2liRQB
	 Wp//FZt/PyXHu4NZBxeeLvs1yJ6p7KZi4BpmCdacJXHA6LhIeqJc+Ox9erqypNeHrp
	 DOnCLzWEH7imNerjRm9t5jelv1Co+VYZnoTpAmVSRZdUypYaxNQN946e3B9kSCzVil
	 quSTYXFuIB9yw==
Date: Wed, 24 Sep 2025 20:26:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm2-sessions: Remove unnecessary wrapper
Message-ID: <aNQpvQBV43dhS6ad@kernel.org>
References: <20250922115009.3053664-1-jarkko@kernel.org>
 <aNOtTIRBrzN_AAMa@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOtTIRBrzN_AAMa@earth.li>

On Wed, Sep 24, 2025 at 09:35:24AM +0100, Jonathan McDowell wrote:
> On Mon, Sep 22, 2025 at 02:50:09PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Open code tpm_buf_append_hmac_session_opt() because it adds unnecessary
> > disperancy to the call sites (and reduces the amount of code).
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> I don't have a strong opinion on whether this is significantly better, but
> for 2 call sites it's not unreasonable, so:
> 
> Reviewed-By: Jonathan McDowell <noodles@earth.li>

I'll explain a bit of context.

I'm opening tpm2-session knot by knot and once it is like out and naked
my grand plan is to create a single function tpm2_authenticate or similar
function that wraps a TPM command into an authenticated TPM command.

The main priority with each patch is to do at least microscopic amount
of more than just pure clean up. The tpm_buf series and this series
sort of converge towards the same common goal. I think this is a good
way to move forward and refactor complex functionality without causing
major risks in production.

They key topic on this all maximizing the decoupling and it goes beyond
just "fixing tpm2-sessions". By doing this process we can more easily
re-use parts of the driver code in early boot code and sort of create
enablers for e.g., Trenchboot.

BR, Jarkko

