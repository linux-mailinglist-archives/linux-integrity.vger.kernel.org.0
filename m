Return-Path: <linux-integrity+bounces-6029-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E483A9EA01
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Apr 2025 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217583ACFC3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Apr 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C525213E69;
	Mon, 28 Apr 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPximnop"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E282139AF;
	Mon, 28 Apr 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826573; cv=none; b=T1Esp8+CgjBilOUBWMQxCgF6Es3j9oydS3+0ZIEtfjbKV3u8W+jYkjWAaoI1vOkjuNehmURh5QKdSZKxF41uQ63m5sFCATXinhs5fh2eKyaSlokNpYusJBs4w6HN/0co/446sqCrL3/NMqRoMYZKa0uzzlSoHohNktW0FBWiD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826573; c=relaxed/simple;
	bh=gz3v87ioQs5PO0ngRoziti1AQO3BGFw3wZSaC9CSs8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaF7n/eO5FPvr+bJIcYxbyOsglq19OxJEU03iIKjxqkFhOUP9aS6Zuhm5bwI+174kbKCq5JmRDQqRxxsKGYD+PuboC+ER3D27mJ7zo8EibsFCUGV6EZ4BJrUaq89pWAdosYdNrHyjX2OvQam5xf0ReA07j8KP/Vq/b9G5KldL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPximnop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BD6C4CEEC;
	Mon, 28 Apr 2025 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826572;
	bh=gz3v87ioQs5PO0ngRoziti1AQO3BGFw3wZSaC9CSs8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPximnopkAxrgRV655KCEfhvJ1fjCkHn8Cnxg5LGMEmrjp+Wb0hcUOj1p00wqeqUO
	 dzJlkTJF0OCpYhqD3T2sHusjTHmrV8HhuFPzeYoC9V6RUTrTkB/0j/UJBuE23ZJbIK
	 TWcyt2JNxEdwdo7bsUjYx8qw7JVCoLMq6jNtjD7NTLAdkRqg7c9ooybXK1uMDVJDlo
	 vfCdlKGblIlmWtEeht8ssisgKsw3pxrKias4RnPnfsZtslh2PmIMouwpR316bapMvJ
	 8JhEytjwyJYy+Vj9ezr4IpLOfyTyA3Y3d6rwFgAw1qPRi8CXbojTuvkhgv2nhhkGjH
	 iQMcp72gl2QeA==
Date: Mon, 28 Apr 2025 13:19:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Huewe <peterhuewe@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
Message-ID: <aA8zBP6h8oG5m4w9@sumit-X1>
References: <20250414145653.239081-1-sgarzare@redhat.com>
 <20250414145653.239081-4-sgarzare@redhat.com>
 <CAGxU2F5SJ9nQfAV-D1WKjsUow_01xjGBRXP4d+q4T=5Bw=yaOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5SJ9nQfAV-D1WKjsUow_01xjGBRXP4d+q4T=5Bw=yaOg@mail.gmail.com>

On Mon, Apr 14, 2025 at 04:59:47PM +0200, Stefano Garzarella wrote:
> On Mon, 14 Apr 2025 at 16:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > This driver does not support interrupts, and receiving the response is
> > synchronous with sending the command.
> >
> > So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
> > return responses in the same buffer used for commands. This way we
> > don't need the 4KB internal buffer used to cache the response before
> > .send() and .recv(). Also we don't need to implement recv() op.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> > - set TPM_CHIP_FLAG_SYNC and support it in the new send()
> > - removed Jens' T-b
> 
> @Jens @Sumit can you test/review this patch again since from v1 we
> changed the core a bit adding TPM_CHIP_FLAG_SYNC instead of
> send_recv() op?

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

