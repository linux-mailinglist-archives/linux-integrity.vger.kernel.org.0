Return-Path: <linux-integrity+bounces-3000-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21509276B6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD4D1F2566D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A031ABC25;
	Thu,  4 Jul 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qy7tJxS3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A113BADF;
	Thu,  4 Jul 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098230; cv=none; b=Xu3DL9VfZrkVJpSQVuX1gCars5DPSJNESwdGKPcRkPHhpOgoUhlV7krKF2v1WbSUzsSe9If/lwzvQ8IoNgfRl9Y1iWiDYNnW3CluZZTC51Jndo5blyr41HsZqBSdJy3XIwGkln+hvFR5W7Q/CHcF/0e2mPkwM75jKBpSZOAHzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098230; c=relaxed/simple;
	bh=klDO4/0U/vbGsv3gt7DQ6MnOPmWNXXpzrcflYCa9vB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYXQc4ndTp5lF/yCOhAAsPfFHxbuqaIkVpi9zDLsGNCoMUQVIOBPU4RRE405rcsTYSrvQdaMjtsxcwGR0Ou95oezNCpcpr9Ueepu7vDaBm9zTTHntPvaCdCfBiHNvk8GJe6OI4JBP1mqSRtmwbi/L/w/cfnFMMtBIIEBYVeZxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qy7tJxS3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720098224;
	bh=0wJ0thRf7utBZ6y1Ms5sJbvCz7hTW8OVR6SsUnnt3kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qy7tJxS3ZX6A0h77MmM8sUm0/3VYqXFsEQraTYZHkt7bZj6nqly9q0kyO0tZozxKy
	 3xgfnqi0OL+DOsRT9IyYfbqVSXICMaGrVFRxWXe4OrU3aDAfb3eGNKvwtKiemvP0Uv
	 9U6I/lzS/iTqu98mNw6A+XATmnh5NqnI3agh1DmCKW80zIMJ1HTVdVbp6yTlYnPqJ7
	 jg2k2RVo6XFSliMsMXO1bTshBiB/6cyywB6qB39P2kqRj1EuAGoP8OpT38nOr585H3
	 XDc7yb7M8U5T1by/MQP2Yki1HZ+wJzpzEhbuApKrGTJF+VIBcZcrcbbNAjFCqGOTWs
	 ILQcyoI5LRlpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFGzy6ypwz4wbp;
	Thu,  4 Jul 2024 23:03:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jarkko Sakkinen
 <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Mimi Zohar
 <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Address !chip->auth
In-Reply-To: <D2G2QR0DMG8B.R0B95Z5T5YAF@kernel.org>
References: <20240703170815.1494625-1-jarkko@kernel.org>
 <D2G2QR0DMG8B.R0B95Z5T5YAF@kernel.org>
Date: Thu, 04 Jul 2024 23:03:42 +1000
Message-ID: <87v81lia1d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jarkko Sakkinen" <jarkko@kernel.org> writes:
> On Wed Jul 3, 2024 at 8:08 PM EEST, Jarkko Sakkinen wrote:
>> Tested on x86-64 with:
>>
>> - TCG_TPM2_HMAC disabled.
>> - TCG_TPM2_HMAC enabled.
>> - TCG_TPM2_HMAC enabled, and "/* rc = tpm2_sessions_init(chip); */".
>>
>> Jarkko Sakkinen (3):
>>   tpm: Address !chip->auth in tpm2_*_auth_session()
>>   tpm: Address !chip->auth in tpm_buf_append_name()
>>   tpm: Address !chip->auth in tpm_buf_append_hmac_session*()
>>
>>  drivers/char/tpm/Makefile        |   2 +-
>>  drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++--------------
>>  include/linux/tpm.h              |  75 ++----
>>  3 files changed, 245 insertions(+), 232 deletions(-)
>
> Aiming these still to 6.10 so that there would not be known regressions
> in hmac authenticated sessions. Note that issue is wider than "just"
> tpm_ibmvtpm.

This seems OK on my PowerVM box using tpm_ibmvtpm and TCG_TPM2_HMAC=y.
I do see one new message:

  [    2.475208] tpm2_start_auth_session: encryption is not active

But no error messages like on mainline.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

