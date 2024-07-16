Return-Path: <linux-integrity+bounces-3125-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDB932611
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF32810F7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32A143891;
	Tue, 16 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsUT1zJP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EB1CA9F;
	Tue, 16 Jul 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131269; cv=none; b=EhDoNL9wgReRkK6D0zi/wLis0ijxuJ49JEme5buQxKj4kZfmgV3g51LI724mkBAtzUAFpz5/Em/cC/ULQ/bjJwqw6ia1kwVVnnfTYxzmn8O/NdvyaWnWnWhEkxDmH4jp1L9IzZjkNSnzIKVQTd6mjZLEJ8fbnKhn29hqk5RkKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131269; c=relaxed/simple;
	bh=bTWOA6cn5RyYT9EBZdWupkElF7jAkif+/TErSzGRF+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pirlER5GNbzvx2BDtkhzc4FPyP2eIwqPi6WfDgMppE1pDbqWrfNl0EXYp0svjz7kvxyqyAqs7nH+4a+NlwwnBE23pK95fzLyqCWyzFwIbbIzAvAzcr6i3oP688EX8bwrf7RCAgoaulNt2N+PgPwYp3RyMscyROLELrMBF89F6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsUT1zJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3B8C116B1;
	Tue, 16 Jul 2024 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721131268;
	bh=bTWOA6cn5RyYT9EBZdWupkElF7jAkif+/TErSzGRF+8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dsUT1zJPiBEicMm/aELcc5UQaSkrJVxOOIXWIceWI4MWxbn1FWrs6v1sivUXcCBlH
	 yBAKpjaMuqmiHugb6WUB4590oPMAqZq2RaCOQLU78NXk4QyeDsO5UR5Zi1yAlxKhX/
	 0PGIm3EvYp3VOZAnT0Keq4Y4N+AGVkmsKgHG4rRMewOMxL3hdUNNLsABmZt8d4C+wc
	 Sw3AiOh0x5JfTF6LPAc/OmQGxmFCnW9SZjj5Aw/BTRy2L3WZ41RNoGm2UVr/Z1DcSV
	 neFcvQoE4+BqQ3Z0PDq6vgtIfFVNIECoiIzPEAOmUMgu1WGyAf8zUjWIfgVyYcizEq
	 kxGKaCJAgOK9Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 15:01:06 +0300
Message-Id: <D2QY44AS2NS4.3H7KQPHGYH8QW@kernel.org>
Subject: Re: [PATCH 3/6] KEYS: trusted: add PCR policy to TPM2 keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-4-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> This commit adds the ability to specify a PCR lock policy to TPM2
> keys.  There is a complexity in that keys that contain both a password
> (blobauth) and a PCR lock have to have two policy statements
> (POLICY_PCR and POLICY_AUTHVALUE).  The way to construct a pcrinfo
> statement for a key is simply to use the TPMS_PCR_SELECT structure to
> specify the PCRs and follow this by a hash of all their values in
> order of ascending PCR number.
>
> To construct a policy around the value of the resettable PCR 16 using
> the sha256 bank, first reset the pcr to zero giving a hash of all
      SHA-256                      PCR

> zeros as:
>
> 66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925

Please also provide example how this kind of hash is constructed, and
no mention about trial and policy modes, which are essential in order
to understand what is going on here.

>
> Then the TPMS_PCR_SELECT value for sha256 bank PCR 16 is
>
> 000b03000001
>
> So create a new 32 byte key with a policy locking the key to this
> value of PCR 16 with a parent key of 81000001 would be:
>
> keyctl add trusted kmk "new 32 keyhandle=3D0x81000001 pcrinfo=3D000b03000=
00166687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925" @u

PCINFO=3D0x66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925
HANDLE=3D0x81000001=20
keyctl add trusted kmk "new 32 keyhandle=3D$HANDLE pcrinfo=3D$KEYINFO" @u

I won't look at the code this round because commit message is lacking
explanation what it does.

606 is a huge addition for single patch and requires belieable story
why it can't be smaller. I won't even try to understand all the changes
just looking at the code.

BR, Jarkko

