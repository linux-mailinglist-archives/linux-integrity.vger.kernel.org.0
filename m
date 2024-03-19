Return-Path: <linux-integrity+bounces-1791-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F738805D7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 21:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DD1F230AC
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1505FB86;
	Tue, 19 Mar 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGsz5KCV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF705FB81
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878850; cv=none; b=IJVSQ+4ujhtHRO4NyAWclc9BVYsO3QGEjn1doQLaQsVZ8LOiZRC8sVCa6VRxP7Cu1WWAN8I+0uiI7quNQuErmgvMcQV2TCZPXCthAViZV2sSyAnpv0XclGa23u2wxi7r/GoSVxkd3XL3mnf+A64JuOa8oNso9QTxVukL5KqXsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878850; c=relaxed/simple;
	bh=Ieoo0q0TiYj78kVEedUaHeCKTl5LxiNupXcsPfqikcs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J8/SIBg9m9aCALnLgNVRvvZMRfIAB+7OqRITM9F78v3QH5U1fFoUTUAgw6jZL8N7JWj2SVP/4mNWLfPpWG0YJ1tMb/+l7TIPSE6LGnAQd9MLOozvvdOpjYOR4sC8h3CZqo6J7s17eYSqsRWG8HglX6JkJ+EyyrHUr8dYKZy52dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGsz5KCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89434C433C7;
	Tue, 19 Mar 2024 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710878849;
	bh=Ieoo0q0TiYj78kVEedUaHeCKTl5LxiNupXcsPfqikcs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nGsz5KCVoGzZpEKW1NCjz1edHpy4A1TX1k0iAuvWKKesVwsFR5jPSlxkh6qDw8BVN
	 AYl7QUeNZa12vg4rTJcH60qR42caDVLxNxbaYrep3LV/0d2q54vPxaGZ5h3lG5Io6H
	 DeRSCnJAcXiRRbsval6WbgQNfgvp5fQqxnJ1Lu/26tp1xxI9tyf/aKt1GYBdNQB0hp
	 yVCbItEVz1nCJoiPPVkcOQDBeQdQJGgeTowho0CP31ST1gAr7RvvMUYwsgzaEMuQwt
	 bhWu4gI/5pcguouTu4mBjpLnFzSStjBobckmU/vehSbTxggKXqKSjTC8ALMvHTIzal
	 GpEovZ0Afcqmw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 22:07:26 +0200
Message-Id: <CZXZXNPX9VUP.1VOSQNSGQYX7A@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by
 preserving chip Locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Adam Alves" <adamoa@gmail.com>
X-Mailer: aerc 0.15.2
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
 <20240307224957.29432-1-adamoa@gmail.com>
 <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
 <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
 <CAHwaaX-j37rq4+DCNSRAgPmeQmrYZiX2sLv4ugBjPJSj9LPxcg@mail.gmail.com>
In-Reply-To: <CAHwaaX-j37rq4+DCNSRAgPmeQmrYZiX2sLv4ugBjPJSj9LPxcg@mail.gmail.com>

On Thu Mar 14, 2024 at 6:31 PM EET, Adam Alves wrote:
> Hi Jarkko,
>
> I have an update here. I would like you to check if it makes sense
> before I submit a patch.
>
> The problem might be related to the chip itself which leaves the idle
> state whenever the locality is relinquished.

There's no real discrete chip. It is a TPM living in the firmware,
namely management engine.

So first thing to check would be to update the BIOS entirely.

> I probed the chip while operating and noted that the
> TPM_CRB_CTRL_STS_0.tpmIdle bit (located at `regs_t->ctrl_sts` on
> `crb_priv` structure in tpm_crb.c) is always cleared whenever the
> locality is relinquished.
>
> The result is that this chip never becomes idle since after going idle
> the locality is relinquished (`tpm_chip_stop` function in tpm-chip.c).

This can be verified as tpm_crb does print "goIdle timed out" if it does
not go to idle. Should be visible in klog.

BR, Jarkko

