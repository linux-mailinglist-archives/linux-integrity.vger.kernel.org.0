Return-Path: <linux-integrity+bounces-7185-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1EB88181
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 09:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F6A3B6900
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59E2820DB;
	Fri, 19 Sep 2025 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmufGwD5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE42AD24;
	Fri, 19 Sep 2025 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265563; cv=none; b=clfP/G8easvUyxCzjkLd92cxzAo3YsbL5d8ConE8+bwshxXCKm14TD4MAhGcxyTwMpfYB+tK+fl7W1926T2kKR1YqDpJzQxBx6zFK5aj4E5Zjxr6HlbenQPsky6GUcT5OZ4kheHaZR9BHm2JgQYlhSPESvhJ6URLNJAZTjyLGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265563; c=relaxed/simple;
	bh=84xYEim6RGfAM9GMFeYPBe7TSteWCcWYGwU+ojdGs4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbXQ/WuSTZtVTcko8Z3YBjIZOuDaMnATIJ8gwH82ifwNh9ZuBicigoZijaLjfgA4GLn9SbLYfXMBRzI1hnVZz6cvj+SA/NMMQK/zeVaTSbkleD2iJVBXKDdKOp+cpXAnV8XJ7vMvEEyOaE2/r+ekQYdlu+VBQ7uRArH356+QVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmufGwD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CC2C4CEF0;
	Fri, 19 Sep 2025 07:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758265563;
	bh=84xYEim6RGfAM9GMFeYPBe7TSteWCcWYGwU+ojdGs4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmufGwD5PypHaIg8i3wpcHJPC50wiVPrtDYyubc0/WwoLRbHUgJKqEUHS0X6tZLpT
	 T26t+cuEyKNCZ8JPhgqqfAsG6pte3U2Wmtaajn5c23NkI5XAodq9wwVzbooOMpPS9f
	 r4jlLeDgujy3+FkvLgtHlrIiBrsOAOgn1zmJdb4wvIjLlGkxrzDGhabw4a5bgWxB8u
	 A/GkkV6LYaUCkhP+wWCie11YTdPPAbxZySX9EGqDD7AHqXrAiUzeNVD876rhS5uI1b
	 hgQ+mNzVRGEO347M350yUVwaMMbdMf8KJRjncSQW5sxowJjPzLJJ/V3twivN8qtXUN
	 OEQOPGyRaywIQ==
Date: Fri, 19 Sep 2025 10:05:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
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
Message-ID: <aM0A1hceUC-RJdo8@kernel.org>
References: <20250918193019.4018706-1-jarkko@kernel.org>
 <aMzSyCQks3NlMhPI@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMzSyCQks3NlMhPI@mail.hallyn.com>

On Thu, Sep 18, 2025 at 10:49:28PM -0500, Serge E. Hallyn wrote:
> On Thu, Sep 18, 2025 at 10:30:18PM +0300, Jarkko Sakkinen wrote:
> > The current shenanigans for duration calculation introduce too much
> > complexity for a trivial problem, and further the code is hard to patch and
> > maintain.
> > 
> > Address these issues with a flat look-up table, which is easy to understand
> > and patch. If leaf driver specific patching is required in future, it is
> > easy enough to make a copy of this table during driver initialization and
> > add the chip parameter back.
> > 
> > 'chip->duration' is retained for TPM 1.x.
> > 
> > As the first entry for this new behavior address TCG spec update mentioned
> > in this issue:
> > 
> > https://github.com/raspberrypi/linux/issues/7054
> > 
> > Therefore, for TPM_SelfTest the duration is set to 3000 ms.
> > 
> > This does not categorize a as bug, given that this is introduced to the
> > spec after the feature was originally made.
> > 
> > Cc: Frédéric Jouen <fjouen@sealsq.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> fwiw (which shouldn't be much) looks good to me, but two questions,
> one here and one below.
> 
> First, it looks like in the existing code it is possible for a tpm2
> chip to set its own timeouts and then set the TPM_CHIP_FLAG_HAVE_TIMEOUTS
> flag to avoid using the defaults, but I don't see anything using that
> in-tree.  Is it possible that there are out of tree drivers that will be
> sabotaged here?  Or am I misunderstanding that completely?

Good questions, and I can brief a bit about the context of the
pre-existing art and this change.

This complexity was formed in 2014 when I originally developed TPM2
support and the only available testing plaform was early Intel PTT with
a flakky version of TPM2 support (e.g., no localities).

Since then we haven't had per leaf-driver divergence.

Further, I think that this type of layout is actually a  better fit if
we ever need to quirks for command durations for a particular device, as
then we can migrate to "copy and patch" semantics i.e., have a copy of
this map in the chip structure.

As per out-of-tree drivers, it's unfortunate reality of out-of-tree
drivers :-) However, this will definitely add some extra work, when
backporting fixes (not overwhelmingly much).

BR, Jarkko

