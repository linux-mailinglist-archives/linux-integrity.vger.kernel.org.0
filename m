Return-Path: <linux-integrity+bounces-3743-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8F993B2D
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2024 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F10D1C2311E
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08E18CBFD;
	Mon,  7 Oct 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZBuJGir"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB1143C6E;
	Mon,  7 Oct 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343712; cv=none; b=bxtlkFVR8RC45I4A2sTmvTNdFC/cRSQWMqs42EXb863+8f5a6mL2bpk5Rl1bPiBgCVhc10EaZhlGCn+b4IVbkCEMx7W40qYjlpbxWiqHKQDYJTKxF70bfGFC1zTYRpRTsWcKsrMLz+TIzNlVFu8eI4PEB0QNPIpDV/z2ahfBSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343712; c=relaxed/simple;
	bh=OYyXaazKvTv0jvhByYk/tw4TvzJy78FWvuxtnFj1VK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqYoMnc0ffKchSvJqj9043SbcP5s/7uobRId9ri0evB1b3e1B3VIem0A6cfZadxnJAceQeMcE/UezMu3O5oXqCbmcVZxWO32dlgTPqNJ9/AYek6mE6SJ0m24TqCsWIninFwSsmdhkdqXHvT7ZvgpDcmQWk8QwF5iR5anpYQTBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZBuJGir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F8FC4CEC6;
	Mon,  7 Oct 2024 23:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728343712;
	bh=OYyXaazKvTv0jvhByYk/tw4TvzJy78FWvuxtnFj1VK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AZBuJGirIN51PZPFLqT8zKOIqo9llVtkvVhnKiRbctdADqMn7OjYW047X4RTYjLrt
	 qGUzGNIvlayd/Ik59/A7+aAj6sXrQLkYlHmt0WVDESBsJxfwafoFMJ0CDmBTSeCX3A
	 bPtgGEKff9nhZQO6JeZmUcJ5t62S66lUMlynkibdD5hw/4bSkGGiKBOjwrRww0lE3P
	 +qc/d4aErBxJBwZc6rV0XKNRjCJD/BnAC7hgA9I36ovAFvhAXp/LzriiUsoR4UWwqa
	 1mcMSEroJwLvAdU2Hzt3cVL40bV4ICcXwMS11c3ML51unukJi4sd22uPJfwqyfzQFH
	 0D1063hILmWAg==
Message-ID: <58aa06044c8b570791a92a1a2a9062b9a477e246.camel@kernel.org>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Guangwu Zhang
	 <guazhang@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
	 <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, James Bottomley
	 <James.Bottomley@hansenpartnership.com>
Date: Tue, 08 Oct 2024 02:28:27 +0300
In-Reply-To: <ZvX_Zj8PAXcFJPLU@gondor.apana.org.au>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
	 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
	 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
	 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
	 <2024092340-renovate-cornflake-4b5e@gregkh>
	 <ZvHsh6by3omeYj9d@gondor.apana.org.au>
	 <D4EN54C1IK1R.11JD66L931PD8@kernel.org>
	 <D4EP817NLQY9.35RSWO8IFXRL0@kernel.org>
	 <ZvX_Zj8PAXcFJPLU@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 08:42 +0800, Herbert Xu wrote:
> On Tue, Sep 24, 2024 at 08:43:00PM +0300, Jarkko Sakkinen wrote:
> >=20
> > Without any traces that would provide more information I don't see
> > the smoking gun.
>=20
> I haven't confirmed that it's definitely the tpm2 driver, it's just
> based on the backtrace.=C2=A0 Hopefully my patch will confirm it one way
> or the other.=C2=A0 Here is the backtrace:

Agreed.

>=20
> [=C2=A0 100.784159] vmd 0000:c2:00.5: Bound to PCI domain 10002=20
> [=C2=A0 100.786209] Monitor-Mwait will be used to enter C-1 state=20
> [=C2=A0 100.786225] Monitor-Mwait will be used to enter C-2 state=20
> [=C2=A0 100.786244] ACPI: \_SB_.SCK0.C000: Found 2 idle states=20
> [=C2=A0 100.823093] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0=20
> [=C2=A0 100.823636] ACPI: button: Power Button [PWRF]=20
> [=C2=A0 100.905756] ERST: Error Record Serialization Table (ERST) support
> is initialized.=20
> [=C2=A0 100.905858] pstore: Using crash dump compression: deflate=20
> [=C2=A0 100.905861] pstore: Registered erst as persistent store backend=
=20
> [=C2=A0 100.907044] Serial: 8250/16550 driver, 4 ports, IRQ sharing
> enabled=20
> [=C2=A0 100.908305] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D
> 115200) is a 16550A=20
> [=C2=A0 100.926608] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D
> 115200) is a 16550A=20
> [=C2=A0 100.942953] Non-volatile memory driver v1.3=20
> [=C2=A0 100.947908] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> 22)=20
> [=C2=A0 101.226913] ACPI: bus type drm_connector registered=20
> [=C2=A0 101.229708] alg: ecdh-nist-p256 (ecdh-nist-p256-generic) is
> disabled due to FIPS=20
> [=C2=A0 101.229745] tpm tpm0: crypto ecdh allocation failed=20
> [=C2=A0 101.236311] tpm tpm0: A TPM error (708) occurred start auth

I guess it is TPM2_StartAuthSession returning TPM_RC_VALUE. Probably
James should look into this as the bus encryption code is clearly
tripping here.

I'm on second week on a new job so cannot promise any bandwidth
yet this week. Earliest next week...

BR, Jarkko

