Return-Path: <linux-integrity+bounces-7352-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED643BB062C
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D21945BF4
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Oct 2025 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDC2EBDE9;
	Wed,  1 Oct 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz5ng6Bo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A9278158;
	Wed,  1 Oct 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323182; cv=none; b=uY9NmWzgxb1VuJz9dHsphHlz8v79f/14L4QagiLmjyEFaVZ3Yp//zcl8CvMO9BD1SX9T74KRCdVNJukdeHXcv60ZTZSznWyNZPo8DsPVWLuEEAg0Srk6gt4lu0YXqxRBFBlYnLd/Iy5aFnZu+jTQ2J2sLvovGAlnLFcvHe7mGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323182; c=relaxed/simple;
	bh=s9cMI0NQ6Ghw1OeMLa07wrwdZ05xUb732GXBSIqGFvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbh3q4cgqbD/idxfjKJN4mTDk3/HAM4RWRTIoYzcG+cTacRXxP3QGwUvFHfKJfyrj8x2yDDxggWcxYRKg1C7hMwK3AVNQjorzScta6tmDhmZo34Rs575zHKVYQ0C8CLhbHiyyShIG6CShV57wf1ku4kMMA5tduL+Hc1ZsA+ke7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz5ng6Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3192C4CEF4;
	Wed,  1 Oct 2025 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759323180;
	bh=s9cMI0NQ6Ghw1OeMLa07wrwdZ05xUb732GXBSIqGFvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bz5ng6BoKKY/o+/webLqSD6ZbY7l3wci5aQg/hJ7lEWnI6zOgk2hjk/dto+6YbfzZ
	 XIakcR0EwE4jtediRa59Nx7yQj+RGQ2P4UIqtb1H3ttxHpZsaYSIlbN3t9d+GWHkIL
	 23J20PczNvwSOet5Oj05LxclVItO4W6K9ubwqD9Xy2D7yA4MFjHQVPGPP9rhBHGMda
	 zAu6bPfhbqP9T3llsXqm0nsoF7kFrIQY2XIUAybkdZNIcT3CWT0eySkcDkOWXhDUgZ
	 U25ULVyLtx9fRi0oEFLo0OaigyxWaWXXT1GDJiqg6xSrLivbSQbPxPWEyB1h3cB3MX
	 DUXNkk5QTYxPg==
Date: Wed, 1 Oct 2025 15:52:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
	dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] tpm: Cap the number of PCR banks
Message-ID: <aN0kKHvc0DRWJPbo@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-2-jarkko@kernel.org>
 <aNu6W0GagfCliWTx@earth.li>
 <aNvO0ZsZz_jkmpoi@kernel.org>
 <cf3fb265dd70a23d598fc3d68562b4be5355e7ae.camel@HansenPartnership.com>
 <aN0NcIlyrUsejMXW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN0NcIlyrUsejMXW@kernel.org>

On Wed, Oct 01, 2025 at 02:16:04PM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 30, 2025 at 10:17:22AM -0400, James Bottomley wrote:
> > On Tue, 2025-09-30 at 15:36 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 30, 2025 at 12:09:15PM +0100, Jonathan McDowell wrote:
> > > > On Mon, Sep 29, 2025 at 10:48:23PM +0300, Jarkko Sakkinen wrote:
> > [...]
> > > > > +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > > > > +#define TPM2_MAX_BANKS		4
> > > > 
> > > > Where does this max come from? It matches what I see with swtpm by 
> > > > default (SHA1, SHA2-256, SHA2-384, SHA-512), so I haven't seen
> > > > anything that exceeds it myself.
> > > 
> > > I've never seen hardware TPM that would have more than one or two
> > > banks. We can double it to leave some room. This was tested with
> > > swtpm defaults.
> > 
> > I've got a hardware TPM that comes with 3 banks by default (it's a
> > chinese one which has sha1 sha256 and sm2).  swtpm isn't a good
> > indicator because it's default allocation is rather pejorative (it
> > disables sha1 whereas most field TPMs don't).
> > 
> > However, if you look at how the reference implementation works, the
> > user is allowed to define any number of banks they want, up to the
> > number of supported hashes.  The only limitation being there can't be
> > >1 bank for the same hash.  Field TPM implementations are allowed to
> > constrain this, but most don't.   The question you should be asking
> > here is not how many banks does a particular implementation allow by
> > default, but what's the maximum number a user could configure.
> 
> It needs some compilation time cap as the value comes from external
> device. If someone hits to that value, then it needs to be increased
> but as unconstrained it's a bug.

Maximum eight banks should be spacy enough for the time being (and for
the foreseeable future).

BR, Jarkko

