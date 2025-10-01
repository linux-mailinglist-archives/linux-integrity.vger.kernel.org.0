Return-Path: <linux-integrity+bounces-7351-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27DBB01CB
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BE43BF5A6
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Oct 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B42522BE;
	Wed,  1 Oct 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbiCCtlg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBA274FDB;
	Wed,  1 Oct 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317364; cv=none; b=pxPJLu8/joEtpDjoZB8ikkeYKHHK83qGOPvYobwR7ww1wp2jit10DapzY8Z/9OmX6PjSuxTlH1uKsTlJYtY6cPbpCBJCxAZhm8chQ+QtOC6umJUvt0oPy7gjE/gJiK16aWwPmUC8/c6rleNONH7gI70HlJmy78GJcdBJVYQelXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317364; c=relaxed/simple;
	bh=bUx/7BTH1hCyfECcWtOZvdI3uVYqeFNSGQXtN04Em5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLhZHUhGvJ7QuwcJG1CLRenjSdSGcA9+V/CSBbFzyJSrxQaPwhLwUnj4vZxYz83aTpo4xAkFqJJib7hrpoWLl11e825IGD1OE8BpDNrNE5g58yl/Ur3rGJ7zxXZ6aVbKESYdITt9cwNzjNVoRpI91sdlEVwCn9YDXaGLx0ACaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbiCCtlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FFDC4CEF4;
	Wed,  1 Oct 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759317363;
	bh=bUx/7BTH1hCyfECcWtOZvdI3uVYqeFNSGQXtN04Em5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbiCCtlgPyzATTQAgQHiybkW7R74mbv5M9AL5x4VrMpI18J01+6ZSdRUbeTyGcrxr
	 fYarU2RhpeCRulQwEyKBbM+OgdYhxdqBS0LkBriJidx6cswLqVaH1FgZEIzwBL+1Oi
	 0HOoS/uom2SR93muJ2bXpHDdl3FkGX2Jjatkr9X95Wunegao4AOEMTvwW+Ek/TB7B2
	 B5ylr6CGhDG1ZatUHPOvF3O8hkN2MSZtY0rkufcK6pWdP1hDJXf7NGlqHpLW0q6gMq
	 IX+9o9d0Ylu//a4VR5Oox92W/u+aGtmar2Ndp0eszrtN21/ucfNJicfDGdKaGGV1WQ
	 L+MA7+Zm6ZOHw==
Date: Wed, 1 Oct 2025 14:16:00 +0300
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
Message-ID: <aN0NcIlyrUsejMXW@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-2-jarkko@kernel.org>
 <aNu6W0GagfCliWTx@earth.li>
 <aNvO0ZsZz_jkmpoi@kernel.org>
 <cf3fb265dd70a23d598fc3d68562b4be5355e7ae.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3fb265dd70a23d598fc3d68562b4be5355e7ae.camel@HansenPartnership.com>

On Tue, Sep 30, 2025 at 10:17:22AM -0400, James Bottomley wrote:
> On Tue, 2025-09-30 at 15:36 +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 30, 2025 at 12:09:15PM +0100, Jonathan McDowell wrote:
> > > On Mon, Sep 29, 2025 at 10:48:23PM +0300, Jarkko Sakkinen wrote:
> [...]
> > > > +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > > > +#define TPM2_MAX_BANKS		4
> > > 
> > > Where does this max come from? It matches what I see with swtpm by 
> > > default (SHA1, SHA2-256, SHA2-384, SHA-512), so I haven't seen
> > > anything that exceeds it myself.
> > 
> > I've never seen hardware TPM that would have more than one or two
> > banks. We can double it to leave some room. This was tested with
> > swtpm defaults.
> 
> I've got a hardware TPM that comes with 3 banks by default (it's a
> chinese one which has sha1 sha256 and sm2).  swtpm isn't a good
> indicator because it's default allocation is rather pejorative (it
> disables sha1 whereas most field TPMs don't).
> 
> However, if you look at how the reference implementation works, the
> user is allowed to define any number of banks they want, up to the
> number of supported hashes.  The only limitation being there can't be
> >1 bank for the same hash.  Field TPM implementations are allowed to
> constrain this, but most don't.   The question you should be asking
> here is not how many banks does a particular implementation allow by
> default, but what's the maximum number a user could configure.

It needs some compilation time cap as the value comes from external
device. If someone hits to that value, then it needs to be increased
but as unconstrained it's a bug.


> Regards,
> 
> James
> 

BR, Jarkko

