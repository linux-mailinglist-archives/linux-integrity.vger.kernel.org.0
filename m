Return-Path: <linux-integrity+bounces-6385-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683BAD284E
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0067A86E8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E72248A8;
	Mon,  9 Jun 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZBsVfKA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D87224898;
	Mon,  9 Jun 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502839; cv=none; b=g26p4BsNWohvHC8jQNrhFpovD2M4uVZFNv7Ln6cEOd7VbBdMAWaSXwuuSqok4QIFAZMe4pBsHSSfsSb1/lXiw+wqs0o8qzo0C5VUoa/GtHn261N0niICgJ1cNGgC0LVjOG+GqOL0vXx/OpeO5XjEkrDGRl3Qqpz7R9/CoJ+RJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502839; c=relaxed/simple;
	bh=M/coZXhQQ5JmlbDvSNuvMpg57QjB4kX+quGxRRZiPos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx0DkXYb+obBs28usu4u5R32MildpazbFncI3PChY3AV9mksPPiK+Gj5TOsjcYIAZAZPsKT1v8Na761FKuwicSES1ewLQoYbBsZLF9I6sNvOHoZAqdSoHPS3lXp2RNY+jj2IXV5Xg8CYkFvOAjbdYmJL2Les0XLOwDdqBu0b6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZBsVfKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB12EC4CEF8;
	Mon,  9 Jun 2025 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749502839;
	bh=M/coZXhQQ5JmlbDvSNuvMpg57QjB4kX+quGxRRZiPos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZBsVfKA4+cQciMNAA1531xF4xjKiihVj3AcVb/X7gF2q0P/DUUVV8U9APsM58oXf
	 NHhe1LOymRiY/ecwoaftWdCpWedETJ/KJfXAPi/V8gobDUpES+AxvPL9wA17PanmBt
	 U/AJWaHK5GwBHgUzI4sNEPHQ6zwp941I3DppEjq9Yj9MK5gOIXcal83X/b/XNcb1CX
	 feQWADzw/R97zYRs+iiKBPJ2QKLJxHN98JvGwrCQUHecICn/NXS50aCunWFYNn5WSC
	 n1UJ1GiSVz2ciMjXD6+Wjpa24r1Tkr4X8hW3ey80fFJF/pJC0H7nR7fEMjOJ9E9Uys
	 J5sxMPfqBk8KA==
Date: Tue, 10 Jun 2025 00:00:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] tpm_ffa_crb: handle tpm busy return code
Message-ID: <aEdLc_OpTNvsk5pl@kernel.org>
References: <20250609141600.3601340-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609141600.3601340-1-prachotan.bathi@arm.com>

On Mon, Jun 09, 2025 at 09:15:59AM -0500, Prachotan Bathi wrote:
> Platforms supporting direct message request v2 can
> support SPs that support multiple services.

What is "direct message request v2"?

> If the TPM service is sharing the SP with another service,
> it could get an error code of BUSY if the other service is
> in process.
> We need a way for the driver to retry sending the message
> to the TPM service until it succeeds or we know that no forward progress
> can be made.
> This patch adds a parameterized variable (default 2000ms)
> that indicates the maximum time to keep retrying for.
> 
> Prachotan Bathi (1):
>   tpm_ffa_crb: handle tpm busy return code
> 
>  drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 24 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

BR, Jarkko

