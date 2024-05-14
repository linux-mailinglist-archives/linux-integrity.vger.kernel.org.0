Return-Path: <linux-integrity+bounces-2389-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350F8C5778
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE60B21397
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89C1448C0;
	Tue, 14 May 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS7hjd5e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC06D1A7;
	Tue, 14 May 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695228; cv=none; b=ZU9y/AKtfIBr8nQXz3ZNoLEThY/2nVetChZHhXH2Rc1QjtTO8eaIEKyJRqtcYGkgrv/IY8tmITnQbRr0kGqMJrOPHK2SznmEUDny32eFaTHsUI7pb72GVbV7k6qN63FLGualOigz/1LNAT031JVmSkpOlb1Cd6Qzyqu++bX0rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695228; c=relaxed/simple;
	bh=j0dzL0HrEyzT3iXZm85NNMPwglJU2P1cUebvjgEaIlY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gvzDXc1cP2kugt/Ez2geCjxl6NvZceDmnfT/tX1wj3CWQssTtwZHcnK77nE1pA5DvbgSodJH5/ISpe+dmmwF67nzc+b6jhFgJgbsMo72fV/5R4EZONo3Fuhzue9hPiuJW7+ScAczC9e0N9dzkZrjVlwGps0jG1e7sPQiCjSXnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS7hjd5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDBBC2BD10;
	Tue, 14 May 2024 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695227;
	bh=j0dzL0HrEyzT3iXZm85NNMPwglJU2P1cUebvjgEaIlY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZS7hjd5ens9YbfEG+awL6UZghjnt5JHEcDclEDGEtOT9/K+oEoBtSu5N12Ue3xYCz
	 sJE7HcNH58JhIReebqGvl4RXC8ZHbY8PcEMWZUTviUMlMga97xdN6rsGIUf3Uidpp0
	 lpnvUiTOFDlLyRDiGnA81xS3TigtgWaKL4h3uSxtTSnDtTXOF4ZB8FP0Nkh3P0WIgI
	 o2ke+DPxtYGoY24wSsKqSwWxqrJPu5axunilVi0fZO9wiWYZHHkmO1ABBxzpeZY5ef
	 Q/sJpfgYsW0dxjokq97HJUE7ADRAfA3B7smB8Fd3KsTL8Ju6E+OKi1lu+NWKBGydhN
	 SawgGBPqvWYJA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 17:00:23 +0300
Message-Id: <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
In-Reply-To: <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>

On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> For example, a cheap NAS box with no internal storage (disks connected
> externally via USB). We want:
>   * disks to be encrypted and decryptable only by this NAS box

So how this differs from LUKS2 style, which also systemd supports where
the encryption key is anchored to PCR's? If I took hard drive out of my
Linux box, I could not decrypt it in another machine because of this.

>   * if someone steals one of the disks - we don't want them to see it
> has encrypted data (no LUKS header)

So what happens when you reconnect?

> Additionally we may want to SSH into the NAS for configuration and we
> don't want the SSH server key to change after each boot (regardless if
> disks are connected or not).

Right, interesting use case. Begin before any technical jargon exactly
with a great example like this. Then it is easier to start to anchoring
stuff and not be misleaded.

BR, Jarkko

