Return-Path: <linux-integrity+bounces-6766-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B980B18790
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E375805D7
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61628D821;
	Fri,  1 Aug 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boPJekur"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28511C3C14;
	Fri,  1 Aug 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754075067; cv=none; b=apFUbtiH9D8jbt234M0Ef0ZvkNia9TuajejCxmEmU2KJOj9vCV2xZydaF1Yym4L2VTW6Fz/GhbIyGnwddhRQEeaUHe7xD2G7jUOnSBKPqT3YrVXcYju6/kja32MeAXgYPUBtNIu62WqFcSglyvy67G1dVB9adIf0COzk/moY4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754075067; c=relaxed/simple;
	bh=HJe0kFKAC7sQpZV/+M2j0ktEYyu9CBSPr7LmwnC8U3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRGqSpiHjGNpWYQf6q99UYyiuPmz1TqZG76ASR5YfaYHOqSGskQ4ZWCTkHlKVVPXT9WiIcLRo9+QC4GyXhT5H1xeX83BLjJraC5s3RyTgiFsd/+hDTWCvKYm1ppXwxmR5Kky/fonBEMIFjjFF3CGyP+tpzGs5IvXpHgMZseMzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boPJekur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39664C4CEE7;
	Fri,  1 Aug 2025 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754075066;
	bh=HJe0kFKAC7sQpZV/+M2j0ktEYyu9CBSPr7LmwnC8U3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boPJekurkkIdE6DwfpOTN7FPSF48NXkNA0M7l2AtV+DLYrzebpLhtiJ2pesD5gMsb
	 YK828FSqkg3wRoVF5XsL45kS2q3DRs3b/SY0R2EkK7Gkl8jnaOO0fLcxYak29LCEn/
	 oWbl52SFq84EiA3N0O+kAw9mjXyz5mzCriPRFLg8d+b17lWBjMeVrPNhZZ1iZiZbLh
	 LR7s3r4ZJfCqNchvPOvtZAXEGT/RoUCD4Il7f3yMrES7yqCQg47jGpw1N+cMagyjLr
	 bhOiPuIIb2pjlbQEjKZSvnh2lUiBHdoAPtyICIu3MLv2Xa1ST7lccfgUQ5Qj8I2XfL
	 c1T2GL0dJqGgw==
Date: Fri, 1 Aug 2025 12:03:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250801190331.GC1274@sol>
References: <20250731215255.113897-1-ebiggers@kernel.org>
 <20250731215255.113897-2-ebiggers@kernel.org>
 <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>
 <20250801030210.GA1495@sol>
 <ca85bbe8a3235102707da3b24dba07a8649c3771.camel@HansenPartnership.com>
 <20250801171125.GA1274@sol>
 <2da3f6d36dccb86f19292015ea48e5d7a89e3171.camel@HansenPartnership.com>
 <20250801184026.GB1274@sol>
 <321c09c7cb2edb113ce9a829d37c0ae5c835e17f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321c09c7cb2edb113ce9a829d37c0ae5c835e17f.camel@HansenPartnership.com>

On Fri, Aug 01, 2025 at 02:53:09PM -0400, James Bottomley wrote:
> On Fri, 2025-08-01 at 11:40 -0700, Eric Biggers wrote:
> > On Fri, Aug 01, 2025 at 02:03:47PM -0400, James Bottomley wrote:
> > > On Fri, 2025-08-01 at 10:11 -0700, Eric Biggers wrote:
> [...]
> > > > It's true that such attacks don't work with one-time keys.  But
> > > > here it's not necessarily a one-time key.  E.g.,
> > > > tpm2_get_random() sets a key, then authenticates multiple
> > > > messages using that key.
> > > 
> > > The nonces come one from us and one from the TPM.  I think ours
> > > doesn't change if the session is continued although it could,
> > > whereas the TPM one does, so the HMAC key is different for every
> > > communication of a continued session.
> > 
> > Again, tpm2_get_random() sets a HMAC key once and then uses it
> > multiple times.
> 
> No it doesn't.  If you actually read the code, you'd find it does what
> I say above.  Specifically  tpm_buf_fill_hmac_session() which is called
> inside that loop recalculates the hmac key from the nonces.  This
> recalculated key is what is used in tpm_buf_check_hmac_response(), and
> which is where the new tpm nonce is collected for the next iteration.

tpm_buf_fill_hmac_session() computes a HMAC value, but it doesn't modify
the HMAC key.  tpm2_parse_start_auth_session() is the only place where
the HMAC key is changed.  You may be confusing HMAC values with keys.

- Eric

