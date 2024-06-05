Return-Path: <linux-integrity+bounces-2831-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EB8FC192
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3575B2537A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 02:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6660269;
	Wed,  5 Jun 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJA12w1F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FB5FB9A;
	Wed,  5 Jun 2024 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553661; cv=none; b=ijDAawlI6k8NdR7nHAhk31JJumYDVGqxaL/hNZPopUN/gsLjodBNefsYOgMAzLsFrMSFGgOjFNA/ECm5CW6XLCfrxE8H1mgRr4z1+ZM/bGm+HEEJtbM9obhf75fc24mMs0o264D82L242NEG37VDTD7GD60tP4LEG/aFHRpZ4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553661; c=relaxed/simple;
	bh=DfOmbOsoVpdt5DZ7XX2y5JZCI4+dggteYFy2x1p+b1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=QliaoPeYNihP5yLiuP1HaSJZ3V1vUAbCbCxy0HS3MZMf49jhIcrwQiTGiy2y5ps51UTaQos2Tenl9SacEguc0nyAgFP9KXk13gIYomZWfaGfotvLPCd2vIPmMPK7dOul0WSKw3hNaJ20dcc95Cj6OiXbk88qQ+BO+BHY7LOuhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJA12w1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB0C2BBFC;
	Wed,  5 Jun 2024 02:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717553661;
	bh=DfOmbOsoVpdt5DZ7XX2y5JZCI4+dggteYFy2x1p+b1o=;
	h=Date:Cc:Subject:From:To:From;
	b=AJA12w1FtdJ0hlABYJXJPA3ZyjjXULY8OADGY9Yk/mczKPMxjmgWWwP6YBM4KbP92
	 hwiFKOHDI0Y8ucAIwyj8r91bVtiPu3C7DRAf8xJwC0IWbxo62E6uU697HFmJ33wsir
	 ZBjjaFJcfD8J1SZq7VwDsB6zLOlR75Ew4jV5ulMtvYUj8bmha0b5i9hJI8Euh74MY/
	 aOu3ZpLsiRaAAJmpb4oh88H+XMgwiKVfHNWUzNziiaErP+hmnUyunIrVAfd7dy/irC
	 xJnC96KhOb+Uv5NwgQaqMrVJ8I4hQ0J5caUmgXTYEOX2perIlJQ9XrSSMMRW6/XlSk
	 7p98IUx6XOUEA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 05:14:17 +0300
Message-Id: <D1RPYHQDJIOG.2KAI4PDY90PD0@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Tony
 Luck" <tony.luck@intel.com>, "Jan Beulich" <jbeulich@suse.com>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc3
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 32f88d65f01bf6f45476d7edbe675e44fb9e1d58=
:

  Merge tag 'linux_kselftest-fixes-6.10-rc3' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/shuah/linux-kselftest (2024-06-04 10:34:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.10-rc3

for you to fetch changes up to f071d02ecad4cfbf3ab41807c90bd1fef1cbfd3f:

  tpm: Switch to new Intel CPU model defines (2024-06-05 04:55:04 +0300)

----------------------------------------------------------------
Hi,

The bug fix for tpm_tis_core_init() is not that critical but still makes
sense to get into release for the sake of better quality. I included the
Intel CPU model define change mainly to help Tony just a bit, as for this
subsystem it cannot realistically speaking cause any possible harm.

BR, Jarkko

----------------------------------------------------------------
Jan Beulich (1):
      tpm_tis: Do *not* flush uninitialized work

Tony Luck (1):
      tpm: Switch to new Intel CPU model defines

 drivers/char/tpm/tpm.h          | 2 +-
 drivers/char/tpm/tpm_tis_core.c | 3 ++-
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

