Return-Path: <linux-integrity+bounces-2382-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D78C4A76
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 02:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578FD2825B7
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 00:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622879E0;
	Tue, 14 May 2024 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USk9NWby"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EB7470;
	Tue, 14 May 2024 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646516; cv=none; b=P4hFjl+zAXJDQkSR/ty2CbDeOyrOPToRwRj1rKUxhA8X4kr621lxSxAcvL90AWCXvz0GwjyrQqPcYiQ0u9+1CMTHNhA9XXdSTs94IQgKbZQiD7SEdz9okYLDFGRV+YoNBOmPJweFFYiVoPSHJpISRKUPe6vUcyOkYgz9lh7y3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646516; c=relaxed/simple;
	bh=vrfVCwMNSrpMBHio2ZoX7aks/0UpGwwNm55xOZdIHRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BjME783Rgo8cUR6x9bDdu6MXBhR859AWPaBvN/zpby8mxJrF9rq2DHfRPiZdQOZeeIvDmm61vCDpzrMFJW5SFZiWdol/Y1ppXThW1kUBHko1jGa8YR90yClYrp5GWr17tShrK7u8n4BBEEThb8WIiNyT27RoIWVusn+sg6LH+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USk9NWby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0449EC4AF08;
	Tue, 14 May 2024 00:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715646516;
	bh=vrfVCwMNSrpMBHio2ZoX7aks/0UpGwwNm55xOZdIHRQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=USk9NWby9tjJ5bBcEQmIuIX2jOwXCQAnfWz9FHYcjMu0Mnwho1TcA2DL2dqLEsmId
	 3X6a3lsA/RPP/50vwF5Y7SHlkX7HVagQoafzbHiD0kuDbRC0taTHpgAljkl0KK43dt
	 6bvot2MDn0wylzm+EuhFm7S8R60grgRX2NrzjM1oBWxmTKMqqzN/x9661QPbZviBWK
	 I9mSXhs1hg0CVwSTqEC8t1zrfF01C7F7w9RPo2eCE1NvDJca5w6rwQKO4ya1iQ7JDK
	 MoCC3sz1yBhsyf0FZTuudauAiVhs11lS5IEB0rakg7ay1I7jAm018sSHtQ432myZDD
	 spm7mIRvheH7A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 03:28:32 +0300
Message-Id: <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
In-Reply-To: <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>

On Mon May 13, 2024 at 8:11 PM EEST, Ignat Korchagin wrote:
> On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudflare=
.com> wrote:
> I would like to point out to myself I was wrong: it is possible to ask
> the kernel to generate a trusted key inside the kernel locally with
> "keyctl add trusted kmk "new 32" @u"

Not in a full-time kernel position ATM as I'm working as contract
researcher up until beginning of Oct (took some industry break after
a startup went down of business), so please, politely asking, write
a bit more compact descriptions ;-) I'm trying to find a new position by
the beginning of Oct but right now I'd appreciate a bit more thought out
text descriptions.

I'm working out a small patch set with James Prestwood to add asymmetric
TPM2 keys based on his old patch set [1] but laid out on top of the
existing baseline.

I did already the key type shenanigans etc. for it and James P is laying
his pre-existing RSA code and new ECDSA on top of that. So this will
give x.509 compatibility [2]. This patch set will be out soon and likely
part of 6.11 (or almost guaranteed as most of it is done).

So by plain guess this might be along the lines what you might want?

[1] https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
[2] https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/

BR, Jarkko

