Return-Path: <linux-integrity+bounces-4672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB3A237D8
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4519116579F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2025 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E931B0F00;
	Thu, 30 Jan 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx8pxG8b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728112C499
	for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279867; cv=none; b=lsQlT5pTuXFfu47+hrkem9DVto40LYVD4MWX/mST5Z6HiG4BRzgdzIn3QJNefipP1C2xvO8CIWNy8MLNoS0dOYX2r7hoQYrZgmuNBVJElkewmMqS0bameLRjBiPupVxNWzzg5RS/ILKnf8wREoLfDMVEezF+foP9DEQjRMSrQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279867; c=relaxed/simple;
	bh=LNekG1SFJQv4K9o2tdQJo0Gy8WzCy83cIR6u1nB9aoI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dsn2MbrbueQ9I+urW+LeTNgyp6LKcs0QQXo6GYziN9aXUNnmGY/c5NGGf8SlS3QcP10iRyPBmf9+6Xms77DuVatY9sQ8xw/qQPilTqRga0J8DQtPVNzUTUU4vE1h8H0Ps/hkKGQfMWiSSzS6kx6MhiyZXLqUPoUv+0Z6rNiNbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx8pxG8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A4C4CED2;
	Thu, 30 Jan 2025 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738279865;
	bh=LNekG1SFJQv4K9o2tdQJo0Gy8WzCy83cIR6u1nB9aoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx8pxG8bSvOuaSFv//zj3GTUftuexrsb8gYgOwQnX3EyiA/BMunGAJ2YuGBeq8Ivt
	 fuU8viTQ10YcKHrDR9JnUZa7bufZ52h6PCmBp80evcYKu+ZR2hnHGg7i41Jy2GdOnq
	 Zq8zpD86XhPZnR45xLiLVhJ7BWG6G4pjdRSoMtTj3n0VkQXtSEF40l+4t4YsXiRg3g
	 4c456PyjL8GToNVJ834esv4Y1XM4Ojz9SULw7Sb3aT794FPEHSnO7FTrLH13p2UkBQ
	 bk5frgjXmfxk0KvstDOyF9nAy1zidwJ3ZEkxOz3pLlwOxLkghewUaTM3zN7oUPQCV3
	 kKyKWYBsCjr1w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jan 2025 01:31:01 +0200
Message-Id: <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan McDowell" <noodles@earth.li>, =?utf-8?q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: TPM operation times out (very rarely)
X-Mailer: aerc 0.18.2
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz> <Z5pRKcZKc3FUzP8Q@earth.li>
In-Reply-To: <Z5pRKcZKc3FUzP8Q@earth.li>

On Wed Jan 29, 2025 at 6:02 PM EET, Jonathan McDowell wrote:
> On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Such=C3=A1nek wrote:
> > there is a problem report that booting a specific type of system about
> > 0.1% of the time encrypted volume (using a PCR to release the key) fail=
s
> > to unlock because of TPM operation timeout.
> >=20
> > Minimizing the test case failed so far.
> >=20
> > For example, booting into text mode as opposed to graphical desktop
> > makes the problem unreproducible.
> >=20
> > The test is done with a frankenkernel that has TPM drivers about on par
> > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > reproducible, either.
> >=20
> > However, given the problem takes up to a day to reproduce I do not have
> > much confidence in the negative results.
>
> So. We see what look like similar timeouts in our fleet, but I haven't
> managed to produce a reliable test case that gives me any confidence
> about what the cause is.
>
> https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
>
> for my previous post about this.

Ugh, this was my first week at new job, sorry.

2000 ms is like a spec value, which can be a bad idea. Please look at
Table 18.

My guess is that GUI makes more stuff happening in the system, which
could make latencies more shaky.

The most trivial candidate would be:

	status =3D tpm_tis_status(chip);
	if ((status & TPM_STS_COMMAND_READY) =3D=3D 0) {
		tpm_tis_ready(chip);
		if (wait_for_tpm_stat
		    (chip, TPM_STS_COMMAND_READY, TPM_TIS_TIMEOUT_MAX /* e.g. 2250 ms */,
		     &priv->int_queue, false) < 0) {
		     	rc =3D -ETIME;
			goto out_err;
		}
	}

On the other hand, for me tpm_tis_send_main() looked initially weird:

	for (try =3D 0; try < TPM_RETRY; try++) {
		rc =3D tpm_tis_send_data(chip, buf, len);
		if (rc >=3D 0)
			/* Data transfer done successfully */
			break;
		else if (rc !=3D -EIO)
			/* Data transfer failed, not recoverable */
			return rc;
	}

I.e. no retry on -ETIME.

But I'd fixup instead tpm_common_write():

out:
	mutex_unlock(&priv->buffer_mutex);

	if (ret =3D=3D -ETIME)
		return -ERESTARTSYS;

	return ret;
}

It still can be interrupted by a signal this way. Retry loop would
block too much.

Not sure if only the increase in timeout value would be enough or
should the both sites be fixed up.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific=
-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf

BR, Jarkko

