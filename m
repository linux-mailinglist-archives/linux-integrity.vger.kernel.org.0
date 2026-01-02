Return-Path: <linux-integrity+bounces-8149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC1CEEFB7
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498763015EEF
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649372BD5A7;
	Fri,  2 Jan 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt8Abn01"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321919463;
	Fri,  2 Jan 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371673; cv=none; b=OG0lHjzy6JnOnLk9+pHBaM9E4atPPbI+bnwnWRj/oBHWAVN1uHFJJ+MuMde+w8S1lWe6dcN6do63NH2JPO5Q7wqN/gqGQpVAvupNJOQHc+B+ViB6pqiPMVA/cIZCSZuUAVOlw/o4j9IfzT4t0d75+G0v6nsnmP6Cfe/lRLXp/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371673; c=relaxed/simple;
	bh=rdDco2Nt12tCcDoQl8nkByq19ivw3QiRrAvWh7fUeio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QivsoSW9zQStgVoPkzbKNGenV/tlRNjDjAgYbszXkY0b2Zn3nnaHATkgw4yNga8w6FNMaMIuKAadB9gfAprWpFSRTGk7Ej2nbTO/pin7w7RdfyK5UMiFW7vzAUByQyNIoAL1ZJb2fif/PH5FUjng8bQIFF58vFKbmFonSbCMhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt8Abn01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29728C116B1;
	Fri,  2 Jan 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767371672;
	bh=rdDco2Nt12tCcDoQl8nkByq19ivw3QiRrAvWh7fUeio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kt8Abn01zcWYIDBDg4v9rKXwpKjbNGp0eOa80+PBkMPr6l86whSgs4ub6IpqG+OxN
	 ygQeOX7Od1kNUOYMTuOP395ZwEUmlp7Acjinuz1nELd1H/WJeNidXkXEzFKkwnJVyB
	 JfHy8skoOCYz0QUIzHqW9f/qrK6JDDiEBiYmq0TynKDkZ7MJT9u04EljLR/AXBKrQc
	 aARdV8xNj7IbkpMeM0IdTV8ZKftKAZE1IbJZE5YuPANBXayOibVpnQli7wPrT6TE7E
	 deJugaaw3aS01uR9p4qzmaGKWafXD3czIOj6fzVo4TgAAemDoajBrO94v1qPW6lqb/
	 33xpk+Fd4gYew==
Date: Fri, 2 Jan 2026 18:34:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/12] KEYS: trusted: Use get_random_bytes_wait()
 instead of tpm_get_random()
Message-ID: <aVfzk6S7bCCjMBtr@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-3-jarkko@kernel.org>
 <aUUZKu2xaZvEdq-2@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUUZKu2xaZvEdq-2@earth.li>

On Fri, Dec 19, 2025 at 09:21:46AM +0000, Jonathan McDowell wrote:
> On Tue, Dec 16, 2025 at 11:21:36AM +0200, Jarkko Sakkinen wrote:
> > Substitute remaining tpm_get_random() calls in trusted_tpm1.c with
> > get_random_bytes_wait() thus aligning random number generation for TPM 1.2
> > with the removal of '.get_random' callback.
> 
> Had to double check we wouldn't end up not getting all the randomness we ask
> for, but get_random_bytes_wait does indeed DTRT.
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thank you.

BR, Jarkko

