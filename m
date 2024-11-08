Return-Path: <linux-integrity+bounces-4078-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B451F9C264E
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733E01F2292C
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B21C1F33;
	Fri,  8 Nov 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iczxifXy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335271A9B42;
	Fri,  8 Nov 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096772; cv=none; b=OStculIMUqTqhGi+l5zdPwiR8IETdSvabtIZHx1Hk/UWlgZJt/W8uY/HoYRWh0aNLYogtIptT+XTY4ulhBmz+iABjSUeam+lhETat3r8dgnV93ujBKHJIY08E0nZlkqqDJphSwtpqT42SmyFoXPeNvy1BlVHg8rJYGAjjjArbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096772; c=relaxed/simple;
	bh=3bkHAnBjuBpsLMeFb5CLXpgUzYXRlFOHrjbNA7OcNJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ug0Gw8ovuEY9EdWaK2mkTMVT8F2QwvXUbgWiCAp03tJIoavnVadDHibgcFSG7sTT6Ku9vAyvwqpC4KwMbT48d5a5ztbSOMBaI3iFf+kHuGv3TpIpojIxIGV82DGgYqcKSanf6n6TyK3dHB/MayldUMnYC6mXF7vh5xwdDHbZVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iczxifXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B11C4CED0;
	Fri,  8 Nov 2024 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096771;
	bh=3bkHAnBjuBpsLMeFb5CLXpgUzYXRlFOHrjbNA7OcNJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iczxifXyiav96cxBvG0UBCXE7DU+BBbmHp6lEGnPFjuOtR2+NPory2JQ+o02xnZwX
	 W30+0P1+hXbZTC/BipvJIHjKflxrSFG46e4f4tdXNQ58OvVdmdVC/3w7b4ApPNHCZV
	 9H1o7oB4Y32KJYs50m8bm6Sg2X8f7Ty6amNESY20ATLLQeXsgM1qDU8P/bvAYiFBVK
	 /7n797qEB2fyxINlMiARRi+jbnSZE0RNJaEdNU46nmPniQ/ovYdU9H1hGNTXv4cBUZ
	 IKSpwUi0XYf9dTVpMU9MQ2SSdjPXXxVjzJEc+37TmihdTd/bOuSQaFGHKYoA+51BtH
	 e3YQ+aUW5lvNg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Nov 2024 22:12:47 +0200
Message-Id: <D5H2L8I47L68.1GJPPIBLOD0LX@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Prestwood"
 <prestwoj@gmail.com>, <keyrings@vger.kernel.org>
Cc: <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
 <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <davem@davemloft.net>
Subject: Re: Reading public key portion of asymmetric keys
X-Mailer: aerc 0.18.2
References: <eb52cc47-0e42-4f1a-984d-27d3470da92e@gmail.com>
 <D5H1ZB95VC60.1XLLYFS3CLRIZ@kernel.org>
In-Reply-To: <D5H1ZB95VC60.1XLLYFS3CLRIZ@kernel.org>

On Fri Nov 8, 2024 at 9:44 PM EET, Jarkko Sakkinen wrote:
> On Mon Sep 30, 2024 at 9:40 PM EEST, James Prestwood wrote:
> > Hi,
> >
> > Unless I'm missing something it does not seem possible to read back the=
=20
> > public key portion of an asymmetric key to userspace once added to the=
=20
> > kernel. I have a use case where two separate applications need to=20
> > perform crypto operations using the same private/public key pair and fo=
r=20
> > added security it would be convenient to add the key (or load from TPM)=
=20
> > once and pass around a key ID rather than the keys themselves.
> >
> > One of the things I need is to create and sign a CSR. To create the CSR=
=20
> > I need the public key contents which can't be obtained from the key ID.
> >
> > To solve this problem I would propose adding a "read" operation to the=
=20
> > asymmetric key type, but limiting it to only reading the public key=20
> > portion of the key (if it exists). Alternatively a entirely new=20
> > "read_public" keyctl API could be added as well, but re-using the=20
> > existing read seemed more straight forward. Adding this seems easy=20
> > enough, but I wanted to get an idea if this is something that would be=
=20
> > accepted upstream or if others had better suggestions.
> >
> > Thanks,
> >
> > James
>
> Missed earlier (CC to dhowells).

Right *obviously* to linux-crypto and Herbert! And people/lists relevant
(at least according to MAINTAINERS file).

BR, Jarkko

