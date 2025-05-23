Return-Path: <linux-integrity+bounces-6305-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB1AC2A73
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BC4168A0A
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13929B208;
	Fri, 23 May 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV8EVC2c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E01D6DB4;
	Fri, 23 May 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028865; cv=none; b=JUiDjQjNtguGCIgW8mXueSoTTzktKg9MIurz1AkOK9e8K0wn4U6lNMJHfogZgBqNalWQ3vY7tvWnqndJEKWavfTmR78Qql0FvU1yf71TJRwC1pW+JEFUue1w2lxEtdFCRcQSz2VMvglr+cyv3NFluWA7ExT9J95O4WI8TdmgUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028865; c=relaxed/simple;
	bh=0UqZX81/yv/x/h+gFpsviYXaq+oaQj7FYRpkQJR7Vi4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=h4EYYAZa572XhqZ6lIlLZLs6TOlEO7mJAzErOPLnZvvXA+cp/qA/l3a4fHGbQEAI+oCmglTILM8t2Kd9VpQcMDtqHuU+XgFw7lkItKUP82hug47rH3EEa0oCCy4rS5Uju1NS8kRLPXMQsQAyiLy3HlsV6phF+AyaQHNZ7Ed6JYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV8EVC2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB3C4CEE9;
	Fri, 23 May 2025 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028864;
	bh=0UqZX81/yv/x/h+gFpsviYXaq+oaQj7FYRpkQJR7Vi4=;
	h=Date:Cc:Subject:From:To:From;
	b=JV8EVC2chRFswuMnoG+N3m7qnKEr6qT7zoMVt0N4byBDxKQsKnuoMF69/kUqLq9C4
	 ZpWYxB/5jzzNs63RETRkmLiGiS2EyqIDyqvuZjdMZRAF0sy17w+jd0vIjx9ZvnX94e
	 xK1woqWohSZi5HhYz5Qc97dFEKTXUL0p4rV5JBz34JwfcMc5xrN3tjIPGQRLxRNUoQ
	 stqvQmsyC5hypVGmmRy1vfH3qSi5OVeVe0ENqUmueNRIY4OPbjhTP0Y91hOclB8XZ8
	 7wIgDmJKKy/W+sAutmx59jy812C5OF9JagG9pqVwoHIAOPStSexqnBXd3gwk/E2g9n
	 v7QqeZ6N0UptQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 May 2025 22:34:19 +0300
Message-Id: <DA3SIK592YXY.LG3BS9A4XH6K@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.16
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.20.0

The following changes since commit 3d0ebc36b0b3e8486ceb6e08e8ae173aaa6d1221=
:

  Merge tag 'soc-fixes-6.15-3' of git://git.kernel.org/pub/scm/linux/kernel=
/git/soc/soc (2025-05-23 08:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.16

for you to fetch changes up to ecc1ca9185c377822c66cbf61ecfed914455d884:

  tpm_crb: ffa_tpm: fix/update comments describing the CRB over FFA ABI (20=
25-05-23 19:05:51 +0300)

----------------------------------------------------------------
Hi,

This is only a small pull request with fixes, as possible features moved
to +1 release.

BR, Jarkko

----------------------------------------------------------------
Colin Ian King (1):
      tpm: remove kmalloc failure error message

Stuart Yoder (1):
      tpm_crb: ffa_tpm: fix/update comments describing the CRB over FFA ABI

Yeoreum Yun (2):
      tpm_ffa_crb: access tpm service over FF-A direct message request v2
      tpm_crb_ffa: use dev_xx() macro to print log

 drivers/char/tpm/eventlog/tpm1.c |  7 ++--
 drivers/char/tpm/tpm_crb_ffa.c   | 74 +++++++++++++++++++++++++++---------=
----
 2 files changed, 53 insertions(+), 28 deletions(-)

