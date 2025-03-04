Return-Path: <linux-integrity+bounces-5072-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFBA4E998
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092A8188CA2E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C306298CDE;
	Tue,  4 Mar 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joDFe+0p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F6253B48;
	Tue,  4 Mar 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108448; cv=none; b=U6lAtk0lfYju8Y+23aIM4Uspdaa+7GGwKb7g76IQySDZN2V8n+lnfpjPP+CfsHjSzAZjVT1JexJLX6XaLzAx0IL3NOtZleAEcwrXL1ndhGexyXCA1uvyBezIbtQN9XqbNM5x1ZypyLy0OJ48AID1dHTNJYVhWTSAvfJeA7gShk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108448; c=relaxed/simple;
	bh=lyvR9xDw1gIv8pbokG323uD09aikAyftbk7mfo8NNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l94uBzmH/oo8EZ4LR4JGJZJ4ow+YB21/sfZiKcJtMkiOO7d/CeiYlUuI0OZ0h01W008wF8WbG5Ig/dx31nXTlRKKh/Y1exVQksTWjLa1TDICOnR8AbAn1G/0DUuzj4/PCcA2aeA46XXZ/LmDPrrI04nZ8RegmLLg0rLKJw2ZPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joDFe+0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D45C4CEE7;
	Tue,  4 Mar 2025 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108447;
	bh=lyvR9xDw1gIv8pbokG323uD09aikAyftbk7mfo8NNDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joDFe+0pXcHLdWRsbGMGA+SwAXkvCJ1I9wQ6GkiKx7DlZyl53N4QtNflDHGW210In
	 51RHRKfs1d8V/xaNVwNjUQoHpu/GW/RhVPwup50Bfwe87ojh0SHVOLChlg9DOionLs
	 E9zPOMct6aPNo5/VEh5qP3YDsO59fXa1qqdE+00/W9VTjXMovGqhj+IYmbFO7795yW
	 Tij0hOmq7zXy9fMGcaTPYt6ySca0ybatgURC7bXu4G0yh/pGOE95gBmYBoHehUBlkw
	 4JnAzfHt8p95CA1Y1K51LaqPVdOssjM0JTOJ1LSOim01OypaXA0DrILbJ096B8a4BT
	 L/j3wIn3ZaZuQ==
Date: Tue, 4 Mar 2025 19:14:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <Z8c02uhRhpGYbDUO@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
 <Z8JncxQM7Nkit0Q6@kernel.org>
 <7dltjdc4csdao5djx2jkjnvm72ubhagjwvgrpyqrr3aeo5cicn@cxrxusjpgce7>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dltjdc4csdao5djx2jkjnvm72ubhagjwvgrpyqrr3aeo5cicn@cxrxusjpgce7>

On Tue, Mar 04, 2025 at 04:23:51PM +0100, Stefano Garzarella wrote:
> > This commit got me lost tbh.
> 
> Now I understand why you got lost, my bad!

No need for apologies, just merely reporting what I do or do not
understand with brutal honesty ;-)

> I checked further and these structures seem to be specific to the vTPM
> protocol defined by AMD SVSM specification and independent of TCG TPM
> (unless reusing some definitions like TPM_SEND_COMMAND).
> 
> At this point I think it is best to remove this header (or move in x86/sev)
> and move this rewrap to x86/sev to avoid confusion.

Yeah, I do agree. We can commit to SVSM specification because that
is the target of this driver anyhow (not Microsoft simulator) :-)

> 
> I'll do in v3, sorry for the confusion.

Absolutely, np.

> 
> Stefano

BR, Jarkko

