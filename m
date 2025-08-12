Return-Path: <linux-integrity+bounces-6799-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C4EB22CED
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF25681D7F
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F498305E0C;
	Tue, 12 Aug 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2AsagCK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1D305E07
	for <linux-integrity@vger.kernel.org>; Tue, 12 Aug 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014629; cv=none; b=WfdbcBQFz26YTcMtZ+LNRa9CmNSzGZT5L8wzHWoNpbfWArV+FKj74/yaOYDf3dBBULPgld23XIFIpYdhLE//U+x07SRxy5Nea+zX1p0goNnBsN3Ao7ZWxjBOMI6FK1azoVr7zFLAwh3K9Q8jjatNDwRC6mjurt7hyJJhfKq47Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014629; c=relaxed/simple;
	bh=jKFq2UYK9G/eT5exmyxtjmqr+dY/6lUO+/FISBE2p/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5XnYWNFRmt6UDSk0scDHt0b9sarBl93YarZ43lFXjIRsQCijI9ievuvcby8+yH5nBmEpiH9GbwU6MfCCkKjZJPsAcVy9a/NXMCaa/C9+XhxxQ/sC/tsT9dApWTA636KxOx75JJvbaJWVGLuHNj3Chh+e5fEHrxLkNj/X8b7Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2AsagCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40942C4CEF0;
	Tue, 12 Aug 2025 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755014628;
	bh=jKFq2UYK9G/eT5exmyxtjmqr+dY/6lUO+/FISBE2p/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2AsagCK3Yn/GA9TVSEDTGFi45pn0i3WPN0/clJ5YnU68NJ809ulhDU+ZDLSzLhPQ
	 Bu9PSyUIuLXoEdXGXDc6dcQID3T5aXWTZgPifmB4KFOmW/UheBS/ta0mbU8taJuHZP
	 VMVRaYzz4pwnsRNKU8TCwY0Dsq1hLFPOO31lJWsjpDgofNNoW2we652VqNUYL1Zxlh
	 iAy5Ar62Mo484w6lF9vnC+9W9B8hOK79LjVZnXkeNU9Bhhujz535BV8npoTdsgAhFq
	 NlHQaj0pr/soTHoBv7jXeilZLax2oeMXorhwwc6X+fcERPFqN1iMkI0DmHb2EJb17N
	 7qtUHPq6MFrtQ==
Date: Tue, 12 Aug 2025 19:03:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aJtl4MOJ5hYU7mWy@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>

On Fri, Aug 08, 2025 at 02:32:02PM -0400, Denis Aleksandrov wrote:
> Ping.
> 
> Just checking in on this patch.
> It has received a "Reviewed-by" tag, and I was wondering if there is
> anything else needed from my side for it to be picked up.
> 
> Thanks,
> Denis
> 
> On Thu, Jul 3, 2025 at 8:00 AM Denis Aleksandrov <daleksan@redhat.com> wrote:
> >
> > Hi Jarkko,
> >
> > Thank you for the review. I'll add your Reviewed-by tag to my local commit.
> > Please let me know if you would like me to send a v2 version of the
> > patch with your tag included.


Hi when I tried to apply this:

~/work/kernel.org/jarkko/linux-tpmdd master* ≡ ⇡
❯ scripts/checkpatch.pl --strict  0001-tpm-prevents-local-DOS-via-tpm-tpm0-ppi-operations.patch
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#13:
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>

WARNING: DEVICE_ATTR unusual permissions 'S_IRUSR | S_IRGRP' used
#31: FILE: drivers/char/tpm/tpm_ppi.c:348:
+static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_tcg_operations, NULL);

WARNING: Symbolic permissions 'S_IRUSR | S_IRGRP' are not preferred. Consider using octal permissions '0440'.
#31: FILE: drivers/char/tpm/tpm_ppi.c:348:
+static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_tcg_operations, NULL);

WARNING: DEVICE_ATTR unusual permissions 'S_IRUSR | S_IRGRP' used
#32: FILE: drivers/char/tpm/tpm_ppi.c:349:
+static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_vs_operations, NULL);

WARNING: Symbolic permissions 'S_IRUSR | S_IRGRP' are not preferred. Consider using octal permissions '0440'.
#32: FILE: drivers/char/tpm/tpm_ppi.c:349:
+static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_vs_operations, NULL);

total: 0 errors, 5 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-tpm-prevents-local-DOS-via-tpm-tpm0-ppi-operations.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

So could you fix those up?

BR, Jarkko 

