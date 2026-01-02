Return-Path: <linux-integrity+bounces-8148-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB8CCEEFA5
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9004E3003F4A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8F2BFC60;
	Fri,  2 Jan 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecQyVXZ2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D1233D85;
	Fri,  2 Jan 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371504; cv=none; b=LUG65HMDyh5OWl8zM03whYfEHBp46w5OK7PlCbTBGM8T3bRaVd380TzoqP3IMSNRMNkRIxPOHXXdSYDFxeEF4eAWYjGi7kPQcFeFPVojSaMRjJvdgFgwZc82zNdWuVB2npFnAomXlfnwvztsz5ff0ExQ90y70sWWHefwhAVwFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371504; c=relaxed/simple;
	bh=xi1C51kz2snF5LoYlFVMZl0Z1hfaMqv9N2ZkxjaX4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW3KNuRLcYxnjj9dj4LRHhghFE0Q0fDla4nBzOnQOEdItP5f1sbYQRNnByi5tCQlMfCYn6++DPyZG6D1EC2rKOihy9XMkfFt8fqxcSPSTcU+hnFw0YYtZt2o+qNi+M2MNnhzUpdN83P4PqEGDSIUFQcc+K13ePesBAHNVi8NAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecQyVXZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA1C116B1;
	Fri,  2 Jan 2026 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767371503;
	bh=xi1C51kz2snF5LoYlFVMZl0Z1hfaMqv9N2ZkxjaX4Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecQyVXZ2jFb0zP7QJw4hcMbrhC46MVJBqsqnIeeXypf/toWZ9dJ92WtmfUeAolt97
	 Z/XIhiYX6jOdJlRzYNLkfg8mexeM8QHKhTtUjPBkQL8tE58hP5ak2G+qowVab8ieqx
	 YNuCT4l9MFIs3eMMMRbRMd+SsrfWXjJFAjVABuJZ8VlLZSa5lL+cu6G9Ol86Ke3I1e
	 ziU5LHKXiaslfHxknDhjx+sZ8zVyCEa1c7BOuuNNhVBpDOTDmgc1F+YbooxD6bat9z
	 7Lrw5zBNVazN1soSv7SPMtZtqtrNwSEbE+6+VTbd8mS3OfZkeo87lpK9owUWqgnrhm
	 ete9TtRDJilqg==
Date: Fri, 2 Jan 2026 18:31:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 07/12] KEYS: trusted: Remove dead branch from
 tpm2_unseal_cmd
Message-ID: <aVfy6lcJ0F6vzY_I@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-8-jarkko@kernel.org>
 <57e69d4fd5a40899cd779ee04f29f33009c97431.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57e69d4fd5a40899cd779ee04f29f33009c97431.camel@HansenPartnership.com>

On Fri, Dec 19, 2025 at 03:54:47PM -0500, James Bottomley wrote:
> On Tue, 2025-12-16 at 11:21 +0200, Jarkko Sakkinen wrote:
> > TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always
> > does set up either password or HMAC session.
> > 
> > Remove the branch in tpm2_unseal_cmd() conditionally setting
> > TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised
> > at run-time, and thus does not cause regressions.
> 
> Shouldn't that also be
> 
> Fixes: b7960b904861 ("tpm2-sessions: Open code tpm_buf_append_hmac_session()")

The implementation has pre-existed before that commit so it did
not really cause it. The call path was just more masked before
open coding it.

The code is of course exercised in !TCG_TPM2_HMAC case but it 
by definition does nothing.

> 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > b/security/keys/trusted-keys/trusted_tpm2.c
> > index d3a5c5f2b926..3666e3e48eab 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -451,10 +451,8 @@ static int tpm2_unseal_cmd(struct tpm_chip
> > *chip,
> >  			   struct trusted_key_options *options,
> >  			   u32 blob_handle)
> >  {
> > -	struct tpm_header *head;
> >  	struct tpm_buf buf;
> >  	u16 data_len;
> > -	int offset;
> >  	u8 *data;
> >  	int rc;
> >  
> > @@ -495,14 +493,8 @@ static int tpm2_unseal_cmd(struct tpm_chip
> > *chip,
> >  		tpm_buf_append_u16(&buf, options->blobauth_len);
> >  		tpm_buf_append(&buf, options->blobauth, options-
> > >blobauth_len);
> >  
> > -		if (tpm2_chip_auth(chip)) {
> > +		if (tpm2_chip_auth(chip))
> 
> Since the statement above is that the if is always true, why do you
> still have it here?

This is still necessary for !TCG_TPM2_HMAC case. The commit is pretty
much exactly in its described scope.

> 
> Regards,
> 
> James
> 

BR, Jarkko

