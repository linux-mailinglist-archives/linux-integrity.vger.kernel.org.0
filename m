Return-Path: <linux-integrity+bounces-2395-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D951C8C5896
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F4E1F22880
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97017EB8B;
	Tue, 14 May 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1+G9nnn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD917BB3E;
	Tue, 14 May 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700071; cv=none; b=sn38KgCO8R0xSSHH2C0jmNHzHvSShD5+iBq2nnn+1x8UZX5cZLltRDG1jBXN7BUbnlk5fv+GM1pbWhS760Auoe7I86x7fp5YFQNY63RLw8QeKCgF74TDHBxnvrxl2C7CqZttiohy9l3bt2/oUwJy0bEsoCWxGeZUAb1hbhoejmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700071; c=relaxed/simple;
	bh=dt6KEmyr9WRZ3KLJyEpAgM2p7Pm++GEzc+zDaBvA6zQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iiL50xiCQtunagbXf3juYp2zhBc1wXXNYrOKFlkHSfE7j054zxgDlewhK9LLMRjI3SmIMqDVcvwPqnHZbHLI4H+y1mZZwzrvhihXGPwjTKiqI3gwsXlqiyYT7aBwG41LLTrXPZgR6AbWc5ssAoQC41qWqBwQzO5/G1TjqeaenTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1+G9nnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E7C2BD10;
	Tue, 14 May 2024 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715700070;
	bh=dt6KEmyr9WRZ3KLJyEpAgM2p7Pm++GEzc+zDaBvA6zQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=f1+G9nnnE8FAgaxfw8WydJ+Y7C7L37+Bd1CM7qPsgqRfl70d4tJqauhYT6eHp1aLx
	 56iT8WXsRM/esL2uSR6g9Gtgje1guV1y1hy6jKTTt6ckodDZUreWijv/2KsM/NAW/k
	 4Pwxc/qqIOLdSAy6dZ6iemzPQfP0aaYZqtQCBqe0Lcz3brc63KgqOnQn18kkkStME6
	 2CWgqxfAxH7twA1OMS8Ok3+wZcoc0Rtw1DWtW2heEJihz7w1P1MbW+O9pUxWQ+ljXJ
	 /p9ni7DpHzxO3FkSRlaCGgz9BlrIiMyuPvvnT/dQJs+9R9UyRX4ktkHKVeVw6A9bo7
	 vueoEP0E33wfQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 18:21:06 +0300
Message-Id: <D19GWXHYP2VC.1OY7BOW5LNXVF@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
 <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>
In-Reply-To: <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>

On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > For example, a cheap NAS box with no internal storage (disks connecte=
d
> > > externally via USB). We want:
> > >   * disks to be encrypted and decryptable only by this NAS box
> >
> > So how this differs from LUKS2 style, which also systemd supports where
> > the encryption key is anchored to PCR's? If I took hard drive out of my
> > Linux box, I could not decrypt it in another machine because of this.
>
> Maybe you could replace the real LUKS2 header with a dummy LUKS2
> header, which would need to be able the describe "do not use this" and
> e.g. SHA256 of the actual header. And then treat the looked up header as
> the header when the drive is mounted.
>
> LUKS2 would also need to be able to have pre-defined (e.g. kernel
> command-line or bootconfig) small internal storage, which would be
> also encrypted with TPM's PRCs containing an array of LUKS2 header
> and then look up that with SHA256 as the key.
>
> Without knowing LUKS2 implementation to me these do not sound reaching
> the impossible engineer problems so maybe this would be worth of
> investigating...

Or why you could not just encrypt the whole header with another key
that is only in that device? Then it would appear as random full
length.

I.e. unsealing

1. Decrypt LUKS2 header with TPM2 key
2. Use the new resulting header as it was in the place of encrypted
   stored to the external drive.
3. Decrypt key from the LUK2S header etc.

?

BR, Jarkko

