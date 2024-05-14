Return-Path: <linux-integrity+bounces-2391-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546D8C57F1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D3F1C21C6D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF72153BF0;
	Tue, 14 May 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRS60n9W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08C15383F;
	Tue, 14 May 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697056; cv=none; b=qWeyKi5RCcTQfaIIuFzkJiq/BfWRQV7oxZidEcUJyLjG15e6EiuJjHoeRJ0hjQNiXU150sbv/wqEkBetPT/6IRwqDfP2smH2JAxOHiiOOMRBSmqmyN4FpQNAXVuFCCrMRs08q6vRlFp+I/HpxsE7QRhj/I31pTZq3nu55xQq2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697056; c=relaxed/simple;
	bh=2eqOscpDd11AOzITS2akWXa2ETFPtKZfiGkX9/iKc4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QShJjwcSdpcfz0VskcA5t0qjMEpUe3nogr4UI65nqZgRgk61dMrisOBF4BDY2LeceXLUQm5QZlOCS4jv6Ac3GPQlqxCEi0WsCwGjJ8oW23aV50X0bhNi1maMDbyVBKzv5app5RSAHUcVHr0od8l/MeWGAAkgOdc2aFarx2u2SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRS60n9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC4C2BD10;
	Tue, 14 May 2024 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697055;
	bh=2eqOscpDd11AOzITS2akWXa2ETFPtKZfiGkX9/iKc4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRS60n9WmS35lU2eQ7883wrPh9NkXFD8fCezaOoEJBIrzjjpx6wDdkY5fdlSeiBhw
	 +PSIaYsbA9hxtq0z0oWm9Vk8Gu19kvGNmUcljyPnU/GSlIyjNtYmBPiKrnRiku38TU
	 ggviF4ejnlB0Kj9/dXVcQaVv7OxB2TOPyt6GkHgeGCq2APC6VkB2jBNc1LlIy/csh2
	 xePvZB/6yfpTW4tWa0AEJJp3k/QNT373NK2oJIwhpemZ14IiUKDpaZYn1YWE3rYgrY
	 10Kobq2qgkvyQxE9tYp1eGWs+cDkl0y8Rj4QWLYIopRa2nuwjjvn9m99z/qGd6MIBe
	 4uEW+rPmagsyg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 17:30:51 +0300
Message-Id: <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
In-Reply-To: <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>

On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > For example, a cheap NAS box with no internal storage (disks connected
> > externally via USB). We want:
> >   * disks to be encrypted and decryptable only by this NAS box
>
> So how this differs from LUKS2 style, which also systemd supports where
> the encryption key is anchored to PCR's? If I took hard drive out of my
> Linux box, I could not decrypt it in another machine because of this.

Maybe you could replace the real LUKS2 header with a dummy LUKS2
header, which would need to be able the describe "do not use this" and
e.g. SHA256 of the actual header. And then treat the looked up header as
the header when the drive is mounted.

LUKS2 would also need to be able to have pre-defined (e.g. kernel
command-line or bootconfig) small internal storage, which would be
also encrypted with TPM's PRCs containing an array of LUKS2 header
and then look up that with SHA256 as the key.

Without knowing LUKS2 implementation to me these do not sound reaching
the impossible engineer problems so maybe this would be worth of
investigating...

BR, Jarkko

