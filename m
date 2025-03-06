Return-Path: <linux-integrity+bounces-5145-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5FA558EB
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AC71899954
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227920012D;
	Thu,  6 Mar 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAQVe28B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EF151990
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297201; cv=none; b=ZD6TY6y4Wa5+rZFL8vRkb6VFVYSHtDeNwirLqjK+xwoMcNTe/TALi3/uuLMQ2ojV/RDnzgqcgpJ7eeagE+f+RYSFgB3OoC4gwpw6H1/7ZOjLsEpUSYiTxCE/rJWENe9dcndW+/cv154TFsXt5Qr1IJyEaAjX8B/85i/GbEOUtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297201; c=relaxed/simple;
	bh=Ilu9uoxP3/UY5gjj9HqRKiI/VZx0XRBuvM5dCoAHRLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOOVBg4rAA+c2l0iV+AD6rNE3dJiXbfoCeOjYwCUT3sXfplUvCMoGWVBT+42IqZI46MfIga8Fr8wpivIpqwmIX1w2r7382dbgEpMjoo6UOoVblkuYUoZzoEPzULEd6pnasMIyqSa8Sq5+enmliG+SVcgkCRyPgSN/kIuQL/T8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAQVe28B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D27C4CEE0;
	Thu,  6 Mar 2025 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297201;
	bh=Ilu9uoxP3/UY5gjj9HqRKiI/VZx0XRBuvM5dCoAHRLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAQVe28BdkqDlL87uIIESSozuhwlvF1mx2vk12UfXepDd+ADfnqWy8ZoHjrOfysc/
	 T/CcKXW5zUhONgejl7UdQusfKZEdC3gLC1Ru90JkrUC3Z3FsUFtwlAUNIt4k8M5fEz
	 sAsyKjjwxrp3hNFKK2X7Y5gW1p4PKWXvCFFrp+pOBCs9+FJaQL8iDdMqRINRWBSr8G
	 j9txtv05fygi5dXZ5npigipUuRN3mqqGh2XzF1AwAGU+aS1a16p0C8IFYRIVzn5XcG
	 MPXediH3+8HvKqep/dlOUW/PNxpY5389d+CpIV50yGgMxh+jPNcKjQv3Gy6FrEAfZd
	 qtfXsWffFBSzA==
Date: Thu, 6 Mar 2025 23:39:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jonathan McDowell <noodles@earth.li>,
	linux-integrity@vger.kernel.org
Subject: Re: Unbalanced TPM2 HMAC session calls
Message-ID: <Z8oWLCVk4E1Ly2cQ@kernel.org>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <f16aae4408cc7bdd98fa70972b70747c26958dd1.camel@linux.ibm.com>
 <1e1f60fae0fa86a4f3c16106836f63cf1709ab5e.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e1f60fae0fa86a4f3c16106836f63cf1709ab5e.camel@HansenPartnership.com>

On Thu, Mar 06, 2025 at 11:30:01AM -0800, James Bottomley wrote:
> On Thu, 2025-03-06 at 13:59 -0500, Mimi Zohar wrote:
> > On Thu, 2025-03-06 at 15:15 +0000, Jonathan McDowell wrote:
> > > We're seeing a lot of:
> > > 
> > > tpm tpm0: auth session is active
> > > 
> > > messages in our logs. This is emitted (once per boot) by 
> > > tpm2_start_auth_session() if the auth sessions is already active
> > > when it is called.
> > > 
> > > Investigating I think this is because tpm2_pcr_extend() calls 
> > > tpm_buf_append_hmac_session() which sets TPM2_SA_CONTINUE_SESSION
> > > so tpm_buf_check_hmac_response() does not cleanup the auth session,
> > > but then doesn't call tpm2_end_auth_session().
> > > 
> > > Looking at tpm2_get_random() it uses TPM2_SA_CONTINUE_SESSION but
> > > *also* cleans up with tpm2_end_auth_session().
> > > 
> > > I'd be sending a patch proposing the addition of
> > > tpm2_end_auth_session() to the end of tpm2_pcr_extend() but I
> > > recall a bunch of discussion about trying to cache the HMAC session
> > > to improve IMA performance, so I don't know if perhaps we should be
> > > dropping the warning instead?
> > 
> > Hi Jonathan,
> > 
> > That suggestion was nixed. 
> 
> Well it's also upstream as
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df745e25098dcb2f706399c0d06dd8d1bab6b6ec
> 
> even though it didn't work out for large numbers of extends.  However,
> that commit introduced this message on a warn once behaviour, so it
> seems to be expected that this gets printed once for some reason.  From
> a code flow point of view, the lazy session handling seems to be
> working correctly, so I think just dropping the warn is correct.

+1

> 
> Regards,
> 
> James

BR, Jarkko

