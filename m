Return-Path: <linux-integrity+bounces-346-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A1803E4F
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E0C1C20987
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CE2315A3;
	Mon,  4 Dec 2023 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LAQLF4nJ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LAQLF4nJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA57BAC;
	Mon,  4 Dec 2023 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701717889;
	bh=0wUiunP6iswEoONyGrxPMS7DFeyyggOfe26ePfsI2pk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LAQLF4nJQayCFapLYg8n4BQIeHtJz/Seitt/Ijw3iGK0zCTvK9OD3Pgd2gTYAi/6R
	 xReyYcQ9Me9KyvH692F1C0+Ptap1OKMnjCRrIAw4GCVSF5x3r/ZZi1KLgl4SMQlHGO
	 JLhxwVb5FzrOVHOkWtapHtB6IYHuBYdHOMbOz0V0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 707A21281835;
	Mon,  4 Dec 2023 14:24:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id y9Qows9Ey-KE; Mon,  4 Dec 2023 14:24:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701717889;
	bh=0wUiunP6iswEoONyGrxPMS7DFeyyggOfe26ePfsI2pk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LAQLF4nJQayCFapLYg8n4BQIeHtJz/Seitt/Ijw3iGK0zCTvK9OD3Pgd2gTYAi/6R
	 xReyYcQ9Me9KyvH692F1C0+Ptap1OKMnjCRrIAw4GCVSF5x3r/ZZi1KLgl4SMQlHGO
	 JLhxwVb5FzrOVHOkWtapHtB6IYHuBYdHOMbOz0V0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B56DD12817E7;
	Mon,  4 Dec 2023 14:24:48 -0500 (EST)
Message-ID: <a56dfd99262b31db06713f6f0b6ff2ba58c2fa4b.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, Ard
	Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 14:24:46 -0500
In-Reply-To: <1d8de077-9dd3-432e-90de-0a5b7dafcd75@linux.ibm.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <1d8de077-9dd3-432e-90de-0a5b7dafcd75@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 13:56 -0500, Stefan Berger wrote:
> 
> 
> On 4/3/23 17:39, James Bottomley wrote:
> > The interest in securing the TPM against interposers, both active
> > and
> > passive has risen to fever pitch with the demonstration of key
> > recovery against windows bitlocker:
> > 
> > https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network
> > 
> > And subsequently the same attack being successful against all the
> > Linux TPM based security solutions:
> > 
> > https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-targets
> > 
> > The attacks fall into two categories:
> > 
> > 1. Passive Interposers, which sit on the bus and merely observe
> > 2. Active Interposers, which try to manipulate TPM transactions on
> > the
> >     bus using man in the middle and packet stealing to create TPM
> > state the interposer owner desires.
> 
> I think this is another capability of an interposer that should be 
> mentioned here, unless technically not possible but I would not know
> why:
> 
> 3. Active Interposers that send their own commands to the TPM to for 
> example cause DoS attacks.
> 
> If we protect PCR extensions now and the interposer can send his own
> PCR extensions and the TPM 2 accepts them (TPM doesn't have a mode to
> reject unprotected commands in general), why protect the PCR
> extensions from IMA then?

Well the PCRs are world writable in a standard system, so anyone with
access, i.e. anyone in the tpm group, can arbitrarily extend them and
destroy the replay.  So I ignored this because while an interposer can
do this, you don't have to be an interposer to cause log replay
disruption like this.

The actual threat to PCR extends from an interposer is silent discards
where the attacker seeks to fake the log after the fact to match a
quote they've discarded a suspicious event from.  Thus the HMAC check
is actually the return one, which allows the kernel to know the write
succeeded.

James


