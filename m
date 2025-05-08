Return-Path: <linux-integrity+bounces-6163-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F56AB0445
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 22:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABAD1BA4DE2
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECEE20D4E3;
	Thu,  8 May 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5aKvbvo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649C29A0;
	Thu,  8 May 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734455; cv=none; b=JCq29rc2gwv0J6OCfjYTJZlddf3zy1M8YmWy6iOzsky9jIg5Kq/SMPjPq6muDGqXniUIfz0JpnvDvUctVuVbywYYelC6JbFYXgIwQN1VZp7v+68y83NVLGVo/xA1gJdhBCeZ89VaNU5U0hPumK8ZOkFj9PqS1rNYbo0MXzn+G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734455; c=relaxed/simple;
	bh=RkjjpKYG+r35+gc9d0tTnqu/pElbyqXWwGFn4pZKP4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc0f3oWJB1j5n+Ik5BFDcS4ZwDvuNmED9BRHjBrp1vDmI8+shIrBrihCGJil+V2lieLZzg5kPb+ZDlqm8bqjxqpKR3GvwNN8w4G67pgWgyAIsfmUXOpi1hf0ZtA8VkuIzXHSm+efGdaMZ1AoZNlja/vuPZsMqsx0BckER5NP6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5aKvbvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93FDC4CEE7;
	Thu,  8 May 2025 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746734454;
	bh=RkjjpKYG+r35+gc9d0tTnqu/pElbyqXWwGFn4pZKP4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5aKvbvoZXXzxoR08YFj5FH5BYBKSoSB5/P6wBMQaV75fDXFA7Zlnr2BGbwqroxU4
	 se3IIq+1q6ZCT6StAGKBgYyklxpO9vZqxh+7+j96coWFcBuJiRpQ9TzxENPmgeY1zi
	 L9dEOl/IE3bWTKodiCXQa1hmweDbecZLdE24AOlPAUmynQ+YnJzDM5bAvErNcQyElo
	 T0SYuZRCPAbKY1HY+B5LZmStBmb78AFhB5pGDL9NFTzQ3IJFJLK50MAhTJLyh8NVEs
	 1GbawfQ4AVJazKSphVFxJEhd4yNWLMmnDj44J7nR+KePu3+Ku/P+2NsX1MRg1YwLy9
	 MQMYF0SOMcLEQ==
Date: Thu, 8 May 2025 23:00:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Huewe <peterhuewe@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 1/4] tpm: add buf_size parameter in the .send callback
Message-ID: <aB0NcS-LPZ8q-h5B@kernel.org>
References: <20250414145653.239081-1-sgarzare@redhat.com>
 <20250414145653.239081-2-sgarzare@redhat.com>
 <aBJETstuSlBUMwj1@kernel.org>
 <o72kb2x2jjxyzgyixeva42sk3lr2wwphnyhkcdbxxgfevoqp3n@ir6rwldztmt7>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o72kb2x2jjxyzgyixeva42sk3lr2wwphnyhkcdbxxgfevoqp3n@ir6rwldztmt7>

On Tue, May 06, 2025 at 02:56:54PM +0200, Stefano Garzarella wrote:
> On Wed, Apr 30, 2025 at 06:39:58PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Apr 14, 2025 at 04:56:50PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > In preparation for the next commit, add a new `buf_size` parameter to
> > > the `.send` callback in `tpm_class_ops` which contains the entire buffer
> > > size. In this patch it is pretty much ignored by all drivers, but it will
> > > be used in the next patch.
> > 
> > So instead "in preparation for the next commit" just plain say why it
> > will be needed. "next commit" is a fuzzy reference :-)
> > 
> > Same goes for "next patch". Neither can be used to query any possible
> > information. That sort of makes the whole paragraph useless, once it
> > is in the commit log.
> 
> Got it! What about somethig like this:
> 
>    Add a new `buf_size` parameter to the `.send` callback in
>    `tpm_class_ops`. This parameter will allow drivers to differentiate
>    between the actual command length to send and the total buffer
>    size. Currently `buf_now` is not used, but it will be used to
>    support devices with synchronous `.send` callback to send the
>    command and receive the response on the same buffer.

definitely to right direction

> 
> Thanks,
> Stefano

BR, Jarkko

