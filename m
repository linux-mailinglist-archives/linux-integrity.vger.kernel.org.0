Return-Path: <linux-integrity+bounces-2359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1458C1F8A
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2024 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF13B1F22428
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2024 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910515FA9D;
	Fri, 10 May 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml0DaCEw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EF15FA7D;
	Fri, 10 May 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328765; cv=none; b=q6ue/+uGMftA1YQoECtBoNZYrXGBQYQ597I47Gq8TQw6g57oiK+XGSjpje38f753mZUjO8qEyQIbcjQYjI9TCSmJ65wyk3y3pjOKxjXe8mpVNiXaBEK79pHmYCwTOI0ZwH6k5pp61W0cmYBUC62Y5c9xCW5VQx7/ZtFBZae1lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328765; c=relaxed/simple;
	bh=63LkKxQnPfNPFz4Ce8J7HQ+Gp+UglZPRuwLqfkkEBus=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ika6esgrg/O9Gn2xmzsUEjYXz2naMOrKpM3xfW9Futt9znu1qq9QIth1RIQHK1Cra4e+8KTxMU4g9djOMzSvzj37KM0/NpjgawCmmJUmP/UwZpKt3vrPUJPy2K6/xzHeo8/d3qYlBep/8V1sQP5xHj+Wv3laJLMipEkOwvFO13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml0DaCEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC741C113CC;
	Fri, 10 May 2024 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715328764;
	bh=63LkKxQnPfNPFz4Ce8J7HQ+Gp+UglZPRuwLqfkkEBus=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Ml0DaCEwmyQJ+cPHaXugULPb202ZJ8XY/7ZY2ttRkJoRrBw1snl+vKk/Hrmoj9xt2
	 gQeK5NkRW30ddPPzFoxvcABS5IEGuYgcc607+72b2ModNQj5oDuoU1s7HEy2DtOm63
	 Ld21K2lyXEzS2XwAEfdgrLpheYWs79xqNSR83usZxSG99urtXZo6WiWozjJmzNWQn6
	 Q1dkCPph2QpigJ+mpvIeWfZU5oJVZg/gN2NW8k+pPAfCACD+9lONTCDG0L7PNUvWj4
	 bA6t4y3ldK5WD17Gxti7jwB1SOGWvjSF3fN3MW+SKLuqTwlNMRzf/1R5+bKmFVzJYS
	 DrUf4fB0rfNaQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 May 2024 11:12:40 +0300
Message-Id: <D15TAQ4AQ2KO.28SP4AL9V89BL@kernel.org>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>
In-Reply-To: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>

On Thu May 9, 2024 at 11:04 PM EEST, Jarkko Sakkinen wrote:
> Hi,
>
> These are the changes for the TPM driver with a single major new
> feature: TPM bus encryption and integrity protection. The key pair
> on TPM side is generated from so called null random seed per power
> on of the machine [1]. This supports the TPM encryption of the hard
> drive by adding layer of protection against bus interposer attacks.
>
> Other than the pull request a few minor fixes and documentation for
> tpm_tis to clarify basics of TPM localities for future patch review
> discussions (will be extended and refined over times, just a seed).
>
> [1] https://lore.kernel.org/linux-integrity/20240429202811.13643-1-James.=
Bottomley@HansenPartnership.com/

Two former PR's (keys, trusted keys) look a bit different as I realized
that my current script does not scale too well. So I do in future use
a method where the subsystem name is picked from MAINTAINERS and I have
crafted aerc templates [1] for each subsystem (also CC lists need
tuning).

This will get better and more polished as I get my scripting more
polished. If anything went wrong, it is mostly because process changes
have their glitches :-)

https://man.archlinux.org/man/aerc-templates.7.en

BR, Jarkko

