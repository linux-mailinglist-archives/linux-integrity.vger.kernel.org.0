Return-Path: <linux-integrity+bounces-2487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A58CA530
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42EA1F233AA
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E44C3D0;
	Mon, 20 May 2024 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZPV7Uc8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AF1847;
	Mon, 20 May 2024 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248832; cv=none; b=LPVDHm+QJzd6hCIA1SNe7NV4iQZa6mqfvDvGbVBtCANVIJI2us3gqbIKbSD6/W1hOKZ4mSSn89tKAsQTSY3D9mixo+lI5RP9mdFFb7W6E33emD/5ToMUOTfDa4Fa2j0/ub7MCWX4CboNT/pI0nNQeOOVrqhFYEfPfHGWtlqCzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248832; c=relaxed/simple;
	bh=0wjefISUoN96mAPBLJ0rNJILfk9c7am3GfkpyKaDm+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=EFF4RzVk+DfCB+duGg4QgsIhJTmCDwG4XRJM1pV1qF8JvzatHH9UdsBhxIh1J8KIDnOVOnrjl/7sc2tedtEVBJjoUyzkzIuq/lXlAVIEJzoWTJkzf2LgbAwlt0XOF9QqmraKKj0PsKiamZ0fXr4h/qsUAfpapz8g+IpGDUvdh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZPV7Uc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31227C2BD10;
	Mon, 20 May 2024 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248831;
	bh=0wjefISUoN96mAPBLJ0rNJILfk9c7am3GfkpyKaDm+M=;
	h=Date:Cc:Subject:From:To:From;
	b=uZPV7Uc8vj1Ur/v/dph3TgINjob4sC3XuILj8TppLdP7C3/YuhLBmDNZBSpb9aSWS
	 dx1cUF1O9JMCBECBGl0L4og9DbCMITI4eFtm4LcSyGaUqBXQYDVdDBGZutRnfVmMo1
	 LrzX2arzOnh0ba2JKOAWj72jA2NsTrEhcOdyZtXyvK+wOw4zJ+kyuL9Dj9+DQSta1o
	 m8gvLrwDDoW+bzupm6J4bHMSyDiQPiFLA5C5BfG2Z0rnmIlWYKLIugY6l1bEifAiSI
	 ooDAWgRxFiM8zJI6fwr+ARvE2U1vVq2btWc77mNF7W5L2Rh3xoHTWcYb3ZyKPo2iNO
	 1eKqag9JModHA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 02:47:08 +0300
Message-Id: <D1EVFNB6HJZ8.2ZRZB8Y0K3TV5@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "David Howells" <dhowells@redhat.com>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <keyrings@vger.kernel.org>
Subject: [GIT PULL] KEYS-TRUSTED: keys-trusted-next-6.10-rc1-part2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6=
:

  Merge tag 'cocci-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/jlawall/linux (2024-05-20 16:00:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-trusted-next-6.10-rc1-part2

for you to fetch changes up to 050bf3c793a07f96bd1e2fd62e1447f731ed733b:

  KEYS: trusted: Do not use WARN when encode fails (2024-05-21 02:35:10 +03=
00)

----------------------------------------------------------------
Hi,

These are couple of bugs I found from trusted keys while working on a new
asymmetric key type for TPM2 [1]. Both originate form v5.13. Memory leak is
more crucial but I don't think it is either good idea if kernel throws WARN
when ASN.1 parser fails, even if it is related to programming error, as it
is not that mature code yet.

There's at least two WARN's in that code but I picked just the one more
likely to trigger. Planning to fix the other one too over time.

BR, Jarkko

[1] https://lore.kernel.org/linux-integrity/D1ERDC16XLUO.578U4ZE7VXW@kernel=
.org/T/#t

----------------------------------------------------------------
Jarkko Sakkinen (2):
      KEYS: trusted: Fix memory leak in tpm2_key_encode()
      KEYS: trusted: Do not use WARN when encode fails

 security/keys/trusted-keys/trusted_tpm2.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

