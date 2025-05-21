Return-Path: <linux-integrity+bounces-6286-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E16ABFB6F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3894E637C
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2C22C325;
	Wed, 21 May 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5UxbfYH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD90190696;
	Wed, 21 May 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845722; cv=none; b=UNubZer1SNHAK9xv1xFvq/mUd2B7XoToG4M26BdtTjbeKP+SaWsFkElsHROopZx8DSWWTE62pSFzYwDfEg6SYuZKvPL20311FQnYbUz/T1nuUlKHqvQ3ctdcyy0gkO+9xUaEprqkxjBAdyrVR7YXfGGrS5c6RbkFXH1V4OlaM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845722; c=relaxed/simple;
	bh=fNlJI98IRmJku5DUDB7KU0NTAR5l/AoBK5dNhkMKy3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGyK0AXacsYYpe9feDCBf1qXQk28fr5WqLGVHe8QMWEi8Vmg5+gPix/M1+l5UrteXCmCN2LP2yhgQc+xeOQ/kx1tEMQ9Cu7yzcKTeuoX0V5o7i6bg76Nyf0tMnRRXOo6VaaLGudLnLO6s4QCKHEfw30sSAZQAn0tbAD1U0KgiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5UxbfYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C091C4CEE4;
	Wed, 21 May 2025 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747845721;
	bh=fNlJI98IRmJku5DUDB7KU0NTAR5l/AoBK5dNhkMKy3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5UxbfYHZeoYDuN5ngewjlWzVx7fvv+BRtndc80ovjhiG8g1I0PHO5ybTj6Lu6x7z
	 g36JHRBWYtNWkCBo4PMkcy0oVlBeyMphixat7L/44FREl/Q339WNexmioK64JLpHrr
	 ovP+rgZvQ9g6LwFcH/HDCu9vpS3tLCd/GJAcQWnttlw4kKAxt0ie+p9RLIYWYKjjhH
	 93rSYCm1Z1xfN5fXmFJkD1WSt0TC4uayOcstPRMB2i+aKB06sSd7LdyWxS+W5yFd8X
	 bdNdzs+Y/THmEK3YDLZn9UkbD1V8YTXfyH5h5kHwmICgedMJsRAjUNUWn2aXZj8rj/
	 RKYVBmYwmsZHw==
Date: Wed, 21 May 2025 19:41:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aC4CVUXpThAyKQdf@kernel.org>
References: <20250514134630.137621-1-sgarzare@redhat.com>
 <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org>
 <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org>
 <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
 <aC2nBCxkvWWz5y5E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC2nBCxkvWWz5y5E@kernel.org>

On Wed, May 21, 2025 at 01:12:20PM +0300, Jarkko Sakkinen wrote:
> > I tried, but the last patch (this one) is based on the series merged
> > on the tip tree, where I introduced tpm_svsm.
> > I can see that series in linux-next merged with commit
> > 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
> > but I can't see it in your next tree [1].
> > 
> > How do we proceed in such cases?
> > 
> > Just to be sure, did I use the right tree?
> 
> Thanks for the remark. Lemme check tonight. Hold on doing
> anything ;-) We'll get there...

I just rebased my branches on top of latest from Linus. That is what I
need base PR also on, and:

$ git show 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
fatal: bad object 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07

I'd use git cherry-pick on a range to take them from linux-next to a
mainline tip...

BR, Jarkko

