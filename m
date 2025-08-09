Return-Path: <linux-integrity+bounces-6797-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C1B1F5AD
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687B6625675
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E729E0E7;
	Sat,  9 Aug 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2B7AgyM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92877242D89;
	Sat,  9 Aug 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761121; cv=none; b=R+RW3KcRstQqwKT4Np+g9ilaNiKF1noMzxQWvF9O85Ole5qJ0UAsjQhuLp5nmsCIcEG7Vai65ToQPmS7lzHx+IN9gAUkCwU6JHBIoVhkuaozdP8Z32FgCeesqH7ETmuFDZU2jmPqfRsaUWTwi2uE/OxDi/ed8GIZcrU7PVHQsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761121; c=relaxed/simple;
	bh=I/5KKgloMSjSDFntx1RmPBKXjAroRhWAXfp0tye4A5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzJ/0RPDYSOyxYyDSZdO5xHjzOQIB4Z3Jt3qD6qle0KObUHp1/jeJ1QX2B0DGxVrFcc0LnD44+b9Di2jmAw1kenm/QaUD0aNfpmrd+uyuPFnsna52MMjmi7HVfCwCmgPPhKj0Yianx79Rm0szyVg3yHVPG0IizPMJ8AKzONH5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2B7AgyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA951C4CEE7;
	Sat,  9 Aug 2025 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754761121;
	bh=I/5KKgloMSjSDFntx1RmPBKXjAroRhWAXfp0tye4A5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2B7AgyMkDzuEVrcUMJItbwYpctKX27jv158ph/hQQdjMh0u3FkN21Z88ahuYlRq1
	 PtPxE81VhOw6zzJBKucLVkDh3H0qB7D+01z07a4+xTfmX3/oZuR6Q0GZfaK+wrShfC
	 jSisV7D/gkUGPyNDHrItgcohuB0+ZgPAcbW8mpXLXw4VEbKJ963YFlhB4svZPIUfhU
	 DlcyGjnMP1UOOygwLbdtfXz86j985Ti5Bfk5sW+eJtacbDKCgtVakum2MeoL2sNSjw
	 Fkm5mFCqaVG7lXIMfywMZGsNeJyZ6r7zpuEUedezYBajwy26+nL+qE0z3aviQqWsh1
	 v/dczx79ov9IQ==
Date: Sat, 9 Aug 2025 10:38:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250809173839.GB3339@quark>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-2-ebiggers@kernel.org>
 <aJIMGWFDZejNwAVP@kernel.org>
 <20250805160740.GA1286@sol>
 <aJckvs9mIO_BscPQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJckvs9mIO_BscPQ@kernel.org>

On Sat, Aug 09, 2025 at 01:36:46PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 05, 2025 at 09:07:40AM -0700, Eric Biggers wrote:
> > On Tue, Aug 05, 2025 at 04:50:17PM +0300, Jarkko Sakkinen wrote:
> > > 
> > > I think we might want to also backport this to stables.
> > > 
> > 
> > That's what I did originally, but on v1 James complained about it being
> > characterized as a fix.
> 
> Please put out v3 with backporting shenanigans and I can apply these.
> 

v1 had Fixes and Cc stable
(https://lore.kernel.org/r/20250731215255.113897-2-ebiggers@kernel.org/).
Again, I removed them in response to James' complaint about it being
characterized as a fix.  If you want them back, please go ahead and add
them back in when committing.  I'm not going to go around in circles.

- Eric

