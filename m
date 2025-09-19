Return-Path: <linux-integrity+bounces-7197-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56EB8A124
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 16:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008383A8D48
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377C257849;
	Fri, 19 Sep 2025 14:48:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D31283B;
	Fri, 19 Sep 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293285; cv=none; b=g2poEhNQy0IR531PsoCHVA22iT1lv5wc/CJ5BLrKYwRhoreZ6CAtJDxh2E9mTV4vmdl0KH6KOZTq5pJGiEJ5ytnhld3IYCnFV1x0gIDWOip4j0oyFOtTQzHmDSYY3TfCbSGR8B7215oJwpJJ1dOOgUN/ZIR45Upi/G9vmMe3thA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293285; c=relaxed/simple;
	bh=xXApoE135ME80W1ETlhFWC0gNzuVztqfCYabcm54yKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=balQ+eX3+8xTA2hMsuhOQcZyNdc4Ko/7XFrxK4AspB/sitkPvppi+nVRoMb8meSBFKk1Bm565Wlijm4Twn/8koMMgqR2XaWsfgTuIIOMe1Z624vN5ruadfS/zNJ4hglwTAylz/U7CbPYAzEgFPRScwhEMqm5vnzAyGfvbmcmn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0BC7B969; Fri, 19 Sep 2025 09:47:59 -0500 (CDT)
Date: Fri, 19 Sep 2025 09:47:59 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Jouen <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
Message-ID: <aM1tH2RNVgRnuZ5w@mail.hallyn.com>
References: <20250918193019.4018706-1-jarkko@kernel.org>
 <aMzSyCQks3NlMhPI@mail.hallyn.com>
 <aM0A1hceUC-RJdo8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aM0A1hceUC-RJdo8@kernel.org>

On Fri, Sep 19, 2025 at 10:05:58AM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 18, 2025 at 10:49:28PM -0500, Serge E. Hallyn wrote:
> > On Thu, Sep 18, 2025 at 10:30:18PM +0300, Jarkko Sakkinen wrote:
> > > The current shenanigans for duration calculation introduce too much
> > > complexity for a trivial problem, and further the code is hard to patch and
> > > maintain.
> > > 
> > > Address these issues with a flat look-up table, which is easy to understand
> > > and patch. If leaf driver specific patching is required in future, it is
> > > easy enough to make a copy of this table during driver initialization and
> > > add the chip parameter back.
> > > 
> > > 'chip->duration' is retained for TPM 1.x.
> > > 
> > > As the first entry for this new behavior address TCG spec update mentioned
> > > in this issue:
> > > 
> > > https://github.com/raspberrypi/linux/issues/7054
> > > 
> > > Therefore, for TPM_SelfTest the duration is set to 3000 ms.

D'oh!  It *was* in the commit message all along, sorry.

> > > This does not categorize a as bug, given that this is introduced to the
> > > spec after the feature was originally made.
> > > 
> > > Cc: Frédéric Jouen <fjouen@sealsq.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Looks good, thank you.

Reviewed-by: Serge Hallyn <serge@hallyn.com>


> > fwiw (which shouldn't be much) looks good to me, but two questions,
> > one here and one below.
> > 
> > First, it looks like in the existing code it is possible for a tpm2
> > chip to set its own timeouts and then set the TPM_CHIP_FLAG_HAVE_TIMEOUTS
> > flag to avoid using the defaults, but I don't see anything using that
> > in-tree.  Is it possible that there are out of tree drivers that will be
> > sabotaged here?  Or am I misunderstanding that completely?
> 
> Good questions, and I can brief a bit about the context of the
> pre-existing art and this change.
> 
> This complexity was formed in 2014 when I originally developed TPM2
> support and the only available testing plaform was early Intel PTT with
> a flakky version of TPM2 support (e.g., no localities).
> 
> Since then we haven't had per leaf-driver divergence.
> 
> Further, I think that this type of layout is actually a  better fit if
> we ever need to quirks for command durations for a particular device, as
> then we can migrate to "copy and patch" semantics i.e., have a copy of
> this map in the chip structure.
> 
> As per out-of-tree drivers, it's unfortunate reality of out-of-tree
> drivers :-) However, this will definitely add some extra work, when
> backporting fixes (not overwhelmingly much).
> 
> BR, Jarkko

