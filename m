Return-Path: <linux-integrity+bounces-7181-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE2B86B65
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791D31B216DA
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F12D73B2;
	Thu, 18 Sep 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NipuHruV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713534BA3C;
	Thu, 18 Sep 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224248; cv=none; b=RJoLQK+UOhYSrgkU2sMjFi68ev7gG3a+ui4r4XzkxyGCY0/cz8uuqRV7XINdtt8MSHsVYi1EgS81ydYhtXC81OMSa0Xs1+pHGZ86VFpH726PKF4ukOrJrIqeKDklEBX3bskuQ6TU4OkB+mxBNEI8TCwCP3QgPE7ZUalRr5C4aqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224248; c=relaxed/simple;
	bh=+EB4SzBfZR/amiQ8BIqGBgbta9naOpf5ImXW+P2rNYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT/hUXkEX20SK32s9M9dXmwChwvmIQ5QkqWzSPALwQQOQBpvozR7QMfgtPzXZTwwNLZ1Cd+FobedeUOmj0AZT/N0v9Bza8hjzH4/quAQru4YVC8fMUl23goIqZB6dWe0iCOC3GtV6Kds5UAzxPX42H+BVSCNcXn0y2ZxZbt/p+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NipuHruV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6E0C4CEE7;
	Thu, 18 Sep 2025 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224247;
	bh=+EB4SzBfZR/amiQ8BIqGBgbta9naOpf5ImXW+P2rNYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NipuHruVDBqIIsFRVOz4Gnvt8yMQT5tTBpBLtOcfRMqRwRZD/RuSmoCGwad7JyL94
	 lyhlKVonQmuwEUWGB23lAW4PClS9nsxu4k59++1wDl322rJT/eFU71G4vOIuigaaEk
	 Ms+nwALU3MGDgftrvflW3GDBp7chYIC/YTetaUK9ANOLWVOInwYhZhUT8KFIdeV+uc
	 QtsDbi8uLt7OLXjEcWB70R7KZA2o/wNRyEBhXUTKqGoqjPIr+AAJG0IpbtMCgIIpa/
	 gBIfjZwve+Bt2+Q8q2fXYHDnQ7TaDaEaORhgd3H3qYYtp4jZ/J03ZCcAe3ibeqPu7e
	 aCQnLmVAlBpXg==
Date: Thu, 18 Sep 2025 22:37:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Jouen <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
Message-ID: <aMxfdLZeQWha0tQg@kernel.org>
References: <20250918193019.4018706-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918193019.4018706-1-jarkko@kernel.org>

On Thu, Sep 18, 2025 at 10:30:18PM +0300, Jarkko Sakkinen wrote:
> The current shenanigans for duration calculation introduce too much
> complexity for a trivial problem, and further the code is hard to patch and
> maintain.
> 
> Address these issues with a flat look-up table, which is easy to understand
> and patch. If leaf driver specific patching is required in future, it is
> easy enough to make a copy of this table during driver initialization and
> add the chip parameter back.
> 
> 'chip->duration' is retained for TPM 1.x.
> 
> As the first entry for this new behavior address TCG spec update mentioned
> in this issue:
> 
> https://github.com/raspberrypi/linux/issues/7054
> 
> Therefore, for TPM_SelfTest the duration is set to 3000 ms.
> 
> This does not categorize a as bug, given that this is introduced to the
> spec after the feature was originally made.
> 
> Cc: Frédéric Jouen <fjouen@sealsq.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Add the missing msec_to_jiffies() calls.
> - Drop redundant stuff.

Run also through kselftest.

BR, Jarkko

