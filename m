Return-Path: <linux-integrity+bounces-4593-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4410A17A5D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E21887876
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC61C243D;
	Tue, 21 Jan 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVCaJxBI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AF1BF7E8;
	Tue, 21 Jan 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452362; cv=none; b=Nk0DmxZfG/5A4WqiaAYlfzKubhlzXDfDAuH3RLM76KW2HjzC4/tGvIJddlLw8RkKQdKCPJXOAw086meh4FNDPvNsFOztC7/YfAB1vUIq8bWtPOkETC5v1OwhMQWdXuCvD7KLkhziItnfNyGBthcNkKgUJPnVWYPlrbE2ziGxTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452362; c=relaxed/simple;
	bh=y5PRdam68rWeAIOQplp0XYwlkEat17e5msRWIF6Hwq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fwFOfgi6Kz1XSns31JLExrM4JkH/f4CH8E2Cxy/hkovADVI9VF5MO33Cpx9cAGZ6psDn/VB6wTGfvmu43+DUqmvBx4PRqnPABF5dVYGPdPBjSutlb89GQ+UWi/7M290445tlgATSG7P05Eldtyi0F2hZZ5Flb7k6QxHt22KWAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVCaJxBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B99C4CEE1;
	Tue, 21 Jan 2025 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452361;
	bh=y5PRdam68rWeAIOQplp0XYwlkEat17e5msRWIF6Hwq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVCaJxBIMv2rwWdnLAQEh40gt+88as1Uk19hf5MMevlCs+K6oLfLBhfPXbYfvLCYN
	 sUCVrEeLnLSOxDXXCk4dSSzubE2hik9apCp2Eh+DeU2eC2tAfp3MvAQgH/0C3Vos9/
	 95e16hiBDxqdrU4NpoY/Ma5CeAF3RGGMnj63Z1pQPF5FKhwpcgNRUVhe0ouYQWvpv6
	 oWF85GQ25eS7y8hIEjfNE4YeSHaJKQOMLPv2ffVVwqhnhxA74uY6qJ87jnJZbIUayg
	 kFaT8TW4zukr87gUhildlMjXjxTHv/1G/fND7yRhH4Et3yA/RrDkP8oYzsS1dS2VSm
	 nxgOROTd/ui7w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 11:39:18 +0200
Message-Id: <D77NGIDQ3JD7.WN0T76KO6XPE@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] KEYS: keys-next-6.13-rc1
X-Mailer: aerc 0.18.2
References: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>
In-Reply-To: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>

On Tue Jan 21, 2025 at 11:36 AM EET, Jarkko Sakkinen wrote:
> The following changes since commit 95ec54a420b8f445e04a7ca0ea8deb72c51fe1=
d3:
>
>   Merge tag 'powerpc-6.14-1' of git://git.kernel.org/pub/scm/linux/kernel=
/git/powerpc/linux (2025-01-20 21:40:19 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git ta=
gs/keys-next-6.13-rc1
>
> for you to fetch changes up to e8d9fab39d1f87b52932646b2f1e7877aa3fc0f4:
>
>   KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=3Dy (202=
5-01-21 11:25:23 +0200)
>
> ----------------------------------------------------------------
> Hi,
>
> Here's the changes for 6.13-rc1.
>
> BR, Jarkko

Oopsie, should not do PR's before the morning coffee. I'll re-create
this, please skip and ignore.

BR, Jarkko

