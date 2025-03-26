Return-Path: <linux-integrity+bounces-5437-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B973CA7164E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3603A496C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D71C701C;
	Wed, 26 Mar 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5oQwf1X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2B1A2632;
	Wed, 26 Mar 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991079; cv=none; b=QILVDNOmA59aFOX/5leh+TWo+wyb8tjLOSfntzij+OU2asKWil2b2yPV7/LwMd3nyXeOHY3OpO6jjgfFwOBrDpoyITlO++gn5/6CeJnaxWCv+DMNa8mXALy3ohXnIXiKWDmeFMQKVEOChxV5YTXE5qNcApwQm4F/pW6ypv1pLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991079; c=relaxed/simple;
	bh=I4aAtoXcp4D+di0R3eD2oZvCXhk++HNE6yAkPHEq7+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZrG+l7gKSnSQL/pctoQxSJ0S65mUjh5aqX0qoyPAJwM5kb1sYma4qBP9Ukq2SNQf0QacBwCwIgnuZ7Dn31wIrYzhVY1PbJOeZ6Ut/5TUZrkffnI5xhfHc2R1Ss+l+hZT8Rrfgu1Ejx/My/WqQJQRqvzlYAmavLF7qRjS1NyZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5oQwf1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF3C4CEE2;
	Wed, 26 Mar 2025 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742991075;
	bh=I4aAtoXcp4D+di0R3eD2oZvCXhk++HNE6yAkPHEq7+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5oQwf1XGe1elkMMxGis5jNX7zG9LFWzC1bkKtp6S5KEtRMhTkYA5KMzp9Bbe2CR7
	 qbclLpHlDO8HYVxtKkDDlUdFPgwY9nwNeohCHK5vfqSC3EFbL52uc2R61c99IWaUf1
	 9CJtK4PCbAr+Ua5zv1tQGw8DFumUQRtN3y54vP87e4RjbWMLgTLmCx+ULtH+F09EDi
	 yHDI51Jn/G/k9RGGUAyVx24F3T8SgiYw5g8h7PI3w4uyHC2OBWkQ1mxmrsuobUxR7I
	 Y9FQx17iPrPdeyAC2DobiIf7uZHsJF8dVJ/T+IFT2nEDC+n/PVdA7g+2t8JhZaMm6Z
	 sfQfNcFfV74bg==
Date: Wed, 26 Mar 2025 14:11:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-Pu4FhcntnKii61@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-I86tWMcD6b_YeM@sumit-X1>

On Tue, Mar 25, 2025 at 10:49:38AM +0530, Sumit Garg wrote:
> On Thu, Mar 20, 2025 at 04:24:33PM +0100, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > This driver does not support interrupts, and receiving the response is
> > synchronous with sending the command.
> > 
> > It used an internal buffer to cache the response when .send() is called,
> > and then return it when .recv() is called.
> > 
> > Let's simplify the driver by implementing the new send_recv() op, so that
> > we can also remove the 4KB internal buffer used to cache the response.
> > 
> > Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v1:
> > - added Jens' T-b
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.h |  4 --
> >  drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
> >  2 files changed, 21 insertions(+), 69 deletions(-)
> >
> 
> Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

I've knowingly even peeked at these patches because of stuff
in-flight.

Generally speaking I don't see enough value in complicating
callback interface. It's better to handle complications in
the leaves (i.e. dictatorship of majority ;-) ).

BR, Jarkko

