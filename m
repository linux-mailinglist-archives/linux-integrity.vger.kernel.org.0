Return-Path: <linux-integrity+bounces-3318-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E9953A50
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2024 20:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C49B1F23CA9
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2024 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E555A117;
	Thu, 15 Aug 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiMF/ATj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E19476;
	Thu, 15 Aug 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747445; cv=none; b=Z2Mb3fvcpAIvzkfpWfDSwvl3S78zDM6q8n4rSwbixrBU3wlPHFZi69/IP7yzRbyMZXrlCIoWU9+bQlqoNYskiuUktWX3MXfrCymjnIXwzyCzJHluYVHfx5L662llb/86MVvEBBsWB7pbQarNUXSNr/8iAa6Bd+5iRNg/1cE49Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747445; c=relaxed/simple;
	bh=wB34uxLPt/6z3AG1aaoxVmooJQuxcmXQGXY3yY8/79U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aAlAD3c4ImIvD3ihGrrEoJMRph/yIdwRTEsq2Phe4/RMBlMdzYvTNycxLATaM+nJLLDcRGznscSwwSy/oHrdwlQ98IooPeyyB5JJOpe3dXF0OjN19FRfzc7o45Irp2WzW20YBseRV6bTe6sBkvPTmGSprnfouigFDkKh/gD5Qc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiMF/ATj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C017C32786;
	Thu, 15 Aug 2024 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723747444;
	bh=wB34uxLPt/6z3AG1aaoxVmooJQuxcmXQGXY3yY8/79U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uiMF/ATjF8FWpfFmEC6OJj0rpLFehpcW2zVIMXPWgTQbLC0kf4p6dqjX0af3F/R8c
	 2MUdcASKruRmKTafQWL0OxI4Dl6nrviMaFke/2Wsxf0Qcuw7PlYqgTo15DbGKRrgS0
	 2H9AWLDGV+i/BE8aMU3elNZdK3MONxBWiRnVNyeSKXtPKVv1pT0OwHCC45U00Gv3o4
	 6++MButK3KhryTK135J3qZdiMzkk8ha0dCcE/OqHlTMjlkJHoax64t02+6UYJflpaG
	 l9QT4SwyNGapLmV5cjDonhA+v7gtONYCTlNIULgRY2wmOJVuYiISH+oR3XCyu9wl8c
	 0/7oKKps1z5eg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 21:44:01 +0300
Message-Id: <D3GPGYHWPGFL.1S13HXY9ALZCU@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [RFC] [PATCH] tpm: Clean up TPM space after command failure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan McDowell" <noodles@earth.li>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <ZrzY_LWIXABkqd-S@earth.li>
In-Reply-To: <ZrzY_LWIXABkqd-S@earth.li>

On Wed Aug 14, 2024 at 7:19 PM EEST, Jonathan McDowell wrote:
> We've been seeing a problem where TPM commands time out, which if
> they're the last command before the TPM device is closed causes a leak
> of transient handles. They can be seen and cleaned up (with a flush
> context) if the /dev/tpm0 device is used instead of /dev/tpmrm0, but it
> seems like we should be doing this automatically on the transmit error
> path. Patch below adds a tpm2_flush_space on error to avoid this.
>
> Does this seem reasonable? The other query is whether tpm2_del_space
> should cleanup the contexts as well, rather than just the sessions.
>
> (Obviously in an ideal world we wouldn't see the timeouts at all, and
> I'm still trying to work on getting to the bottom of these, which are
> generally infrequent, but happening enough across our fleet that we were
> able to observe this handle leak.)

Seems reasonable without this story ;-) I get that this is here because
of query np.

>
> From: Jonathan McDowell <noodles@meta.com>
>
> tpm_dev_transmit prepares the TPM space before attempting command
> transmission. However if the command fails no rollback of this
> preparation is done. This can result in transient handles being leaked
> if the device is subsequently closed with no further commands performed.
>
> Fix this by flushing the space in the event of command transmission
> failure.
>
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

I would consider fixes tag for this even! I think it can be
classified as a minor bug. I implemented this feature together
with James Bottomley so would be nice to get some feedback
also from him (as a sanity check)>

>
> ---

Just as a tip: if you put stuff here like supplemental commets the won't
get included when the commit is finally applied (also a popular place
for change log).

>  drivers/char/tpm/tpm-dev-common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev=
-common.c
> index 30b4c288c1bb..c3fbbf4d3db7 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -47,6 +47,8 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, =
struct tpm_space *space,
> =20
>  	if (!ret)
>  		ret =3D tpm2_commit_space(chip, space, buf, &len);
> +	else
> +		tpm2_flush_space(chip);
> =20
>  out_rc:
>  	return ret ? ret : len;

Can you send v2 with fixes tag and James as cc.

Since you have such a long cover letter you could possibly:

git format-patch -1 -v2 --cover-letter

Then just move that text in front to 00/01.

BR, Jarkko

