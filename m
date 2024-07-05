Return-Path: <linux-integrity+bounces-3017-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF179287D5
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B1286CDC
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1314A4E9;
	Fri,  5 Jul 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2KaoXGU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AE1465B3;
	Fri,  5 Jul 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178525; cv=none; b=BfeuIB5XFU6Oi6Igms3GpsZofXmApjHkyDSz9monwQcU4bJw1pF5Jqb2VsbcFmw3Nl+bqMGTBA/C6rEJU/OWWeSck8gJVjCZkVZntrhUCayhI1quQ3VngfLiN6jDIUKE/wnYSGaCltzZq2v+MHPcRqwj7PYzdkkd7ETePuaiFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178525; c=relaxed/simple;
	bh=b6EsCXCAUPVZ6fUS4BEAH9hZNBzB1OJF44oM3EXRitk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=FHlrMQA/YGZWPYvj4WzImMMxWMbU592PuR1KqsmxXRfbNGTdnGccE81c6OZiBFUBmIRI0d/bHiD99u0v2hkX+4SISM6SsWrY11fOQb9K3O+TchubATzOjty397a9dmpOU8LxLKQqEuxPbJ3ifvNkMZ5NjKVmlIX60aSN8ToTx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2KaoXGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713FDC116B1;
	Fri,  5 Jul 2024 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178524;
	bh=b6EsCXCAUPVZ6fUS4BEAH9hZNBzB1OJF44oM3EXRitk=;
	h=Date:Cc:Subject:From:To:From;
	b=G2KaoXGUqY2s194Fx6JCDC7egcc+QUc1Gb/iCNxbA0pY1QS+RJtNXYDKBU7o/eWhu
	 tvHz3p6Ph247ksAxYN/r2gRz5idJ2ArSlsZE4IiYQJFhT9V4kyoL7W5oF1FQUSHIVR
	 LKjrSnbDVzVRdk/oTNu5rcKqZ3SSclRIDYqXGg8uAq2i0Iuw84fbnEg/sssCAeCgN3
	 NRn276bGQHA7RgFxNSmJxHTh873BUbBHFZJMX8AIjbKsCRw+Dygm2ESDtoR7DLPtT5
	 KWTctc+7ZXkWH9/Gt8/H49+4b4LxAKnpdYsc2/f8O8xh4QBxtVN506qsDwNzVrbiJP
	 NPiHtve+Ksetg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 14:22:00 +0300
Message-Id: <D2HKE740MWCK.2O7S4KF56L929@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Stefan Berger" <stefanb@linux.ibm.com>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc7
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 661e504db04c6b7278737ee3a9116738536b4ed4=
:

  Merge tag 'for-6.10-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel=
/git/kdave/linux (2024-07-04 10:27:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.10-rc7

for you to fetch changes up to 7ca110f2679b7d1f3ac1afc90e6ffbf0af3edf0d:

  tpm: Address !chip->auth in tpm_buf_append_hmac_session*() (2024-07-05 02=
:12:27 +0300)

----------------------------------------------------------------
Hi

Contains the fixes for !chip->auth condition, preventing the breakage
of:

* tpm_ftpm_tee.c
* tpm_i2c_nuvoton.c
* tpm_ibmvtpm.c
* tpm_tis_i2c_cr50.c
* tpm_vtpm_proxy.c

All drivers will continue to work as they did in 6.9, except a single
warning (dev_warn() not WARN()) is printed to klog only to inform that
authenticated sessions are not enabled.

BR, Jarkko

Link: https://lore.kernel.org/linux-integrity/20240704185313.224318-1-jarkk=
o@kernel.org/

----------------------------------------------------------------
Jarkko Sakkinen (3):
      tpm: Address !chip->auth in tpm2_*_auth_session()
      tpm: Address !chip->auth in tpm_buf_append_name()
      tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 419 ++++++++++++++++++++++-------------=
----
 include/linux/tpm.h              |  81 +++-----
 3 files changed, 269 insertions(+), 233 deletions(-)

