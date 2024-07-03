Return-Path: <linux-integrity+bounces-2981-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F49266BF
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594512831BB
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374618412F;
	Wed,  3 Jul 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQn+WKBb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89011836EC;
	Wed,  3 Jul 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026507; cv=none; b=TonkLJa7B561EF5S7YpnAx05mRNJbC3vLlwwN4ddHWm/Hz3P79fLelreTXe2EpT07SxMNJgtZ1KHuRnNzidMkNJHLD+n6ftjKupe++BqMqdaRL66bGp5P1ALpds4eJQ1PcRj8xmz2xtp6QxuBx8OzWhj3HViBeC7BVFWHK6CmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026507; c=relaxed/simple;
	bh=53a+yutO6MlJaOnWEaLCV/tROnZ8aefLb6PyRJjpgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vof9lPq/u29PhoIB45xVN8Qbu6WtdateJ4Nm5A38sKeiC1Z1Prm21MJAamB8PiCNZgs3H09/LwaKuELhGi8ugjteSSQis6xQR9//SVQrmyKJUtT9BqSW75YkWXltlh4MMp5RaaKPjDK2pz74hZ9uTB55OTvEvXh69vvzBgJDP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQn+WKBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA9EC2BD10;
	Wed,  3 Jul 2024 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026506;
	bh=53a+yutO6MlJaOnWEaLCV/tROnZ8aefLb6PyRJjpgDM=;
	h=From:To:Cc:Subject:Date:From;
	b=pQn+WKBb+w2ZnqKl4dsMayP4kwLGLGf1BfM0Jwuim07WuhSrihND8D64/uhpP6+jg
	 HX5dsqyf02OIrJ8MSX7R3XSu/omJSH3i1bUOL39S1KVT7J6hV8p0myaArtZMZ5EpdL
	 wmU/rG7bVmLvyYVaGdHuhkt9a0v6RyWV1s2a1TILY22I5mr+J2fdJrAupJdmD/Ziw4
	 8BPib7VafTwCp2d912If+yWAoq2U99QDANIgCfYLpiuFYEC10ElFhIRY7DBE7gcf0x
	 ZbtnnMC29JwzTnGb8sKl6lx9q2gaAml0lgxlAKryTXtDAlKd8pNB+QYaC872Rgdlsn
	 GI/krsjmPhpFA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Address !chip->auth
Date: Wed,  3 Jul 2024 20:08:10 +0300
Message-ID: <20240703170815.1494625-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on x86-64 with:

- TCG_TPM2_HMAC disabled.
- TCG_TPM2_HMAC enabled.
- TCG_TPM2_HMAC enabled, and "/* rc = tpm2_sessions_init(chip); */".

Jarkko Sakkinen (3):
  tpm: Address !chip->auth in tpm2_*_auth_session()
  tpm: Address !chip->auth in tpm_buf_append_name()
  tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++--------------
 include/linux/tpm.h              |  75 ++----
 3 files changed, 245 insertions(+), 232 deletions(-)

-- 
2.45.2


