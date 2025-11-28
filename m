Return-Path: <linux-integrity+bounces-7735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B81C9265E
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26EF234B277
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED343074AC;
	Fri, 28 Nov 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxSBxInt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33152405EB;
	Fri, 28 Nov 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342284; cv=none; b=HGjnsNvLV6nndefkB6Ue0EkaGfZ61dQT101ldbCT/o3Q/XkGwQ7IMOVyYkQILhyYQ8mNJV9DUDN9li4dfHkoB2ql9Vinte08pYefnwEcgYkROevLnDN6OpmVx+785mOJUuLg/sZSTQQ2bnQvx9yjVxaXbqPjDlqMSgvzxie7yU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342284; c=relaxed/simple;
	bh=lqhEPZYTo69HENyWJFPeUE2T8M+1HjRNx+6yWHWrN0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa7Frx8ijCXAT6vvj+KV4JG+N+KV1CdTaAjtvEy5UuL/qn/OEFjIgq4tNPzHoHUFoTL6XgPQG+L6WLTJ9CHJU4biG2ZW5SKf2qA2EAhQj/QS9E1HeE/ynfPipsiHpCV/GOornDhJRLgxHM8g6hyNhYQMYjzPW086h4Y1w91rLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxSBxInt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE779C4CEF1;
	Fri, 28 Nov 2025 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764342284;
	bh=lqhEPZYTo69HENyWJFPeUE2T8M+1HjRNx+6yWHWrN0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxSBxIntYwpDfn4EKbgba9WyTgoGJoUd+T4G4taGjpfc41+l5OmuGIirDIKJQQrfw
	 WDDJxtYUrnYDunqmnuwNlF2x0yL0VDx9MNyIDnKNiemzKsZCMrTUvLZQvtG4CwOan8
	 qcHHF+aW8vhZ3ot3g2prLdHnB94ryg1xISKE6JegAxmiSXzkhGwB4LPhGhhxy3QSDg
	 WDlBUxWfDC9I6zPQdtuSbTVgVUg5l2I91TJ2iZ+lZ061tAk10blCXW4BZ3xuZ6pM5b
	 iWGuW8ksedZgBxTQ7r+XSlmPuNZqetEOfkgxw5vfxKvHEcJiw3Xa6TxhBBgRXiUBzx
	 2SfQWd+GLgNAw==
Date: Fri, 28 Nov 2025 17:04:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1
Message-ID: <aSm6CP6avMrqPbAO@kernel.org>
References: <aSjP_BsakvhxSDYR@kernel.org>
 <86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com>

On Thu, Nov 27, 2025 at 11:18:27PM -0500, James Bottomley wrote:
> On Fri, 2025-11-28 at 00:26 +0200, Jarkko Sakkinen wrote:
> > The following changes since commit
> > e1afacb68573c3cd0a3785c6b0508876cd3423bc:
> > 
> >   Merge tag 'ceph-for-6.18-rc8' of
> > https://github.com/ceph/ceph-client (2025-11-27 11:11:03 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-
> > tpmdd.git tags/tpmdd-next-6.19-rc1
> > 
> > for you to fetch changes up to
> > 35ef1e24392ff0f3b28654b452f9720f07e9533f:
> > 
> >   KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-11-28
> > 00:17:26 +0200)
> > 
> > ----------------------------------------------------------------
> > Hi
> > 
> > The first pull request for TPM driver contains changes to unify TPM
> > return code translation between trusted_tpm2 and TPM driver itself.
> > Other than that the changes are either bug fixes or small
> > adjustments.
> > 
> > BR, Jarkko
> > 
> > ----------------------------------------------------------------
> > Bagas Sanjaya (1):
> >       Documentation: tpm-security.rst: change title to section
> > heading
> 
> This shouldn't to be in there.  I think you might have missed the
> discussion where I explained it was supposed to be a separate section:
> 
> https://lore.kernel.org/all/50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com/
 
I can iterate this pull request and drop that out, and while at it,
add Roberto's reviewed-by tag to the bug fix to the bug fix that caps
the number of PCR banks.

BR, Jarkko

