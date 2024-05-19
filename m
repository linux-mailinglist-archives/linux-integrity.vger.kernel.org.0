Return-Path: <linux-integrity+bounces-2466-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4578C976D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 01:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA26F28115D
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6151DDF8;
	Sun, 19 May 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbQFl7s3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC338F4A;
	Sun, 19 May 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716162688; cv=none; b=aSfgDOTnGV9pWNGn/qS1tw/a4uC75OUe16gjaSJFDalsyOC1dpyV3D1iLvIjFa83efZmGZgsuoKumppPiwZfqr9z12hcpSw7oqDI1b3QpEWFeHhmga+o/RUBpZQtr112WNYgQG0n3rEnmGfL5geFqIsyWubMxipt2c+kDTYok1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716162688; c=relaxed/simple;
	bh=sFF+7igQBl2ESdcO2thGcwttU4waX/G2ehZzAJURP0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJVfARbJ5X/XOhBGJPD0TvK40hCBveoiPUL0Rdubsvl8EZDVpVfnLSCpXrQhcuJnBLY6rf1UK0K0NEWVqt+R/NpA3TuyCTSVPyVLtFGX4tFeCZ8m85OD2+Q9ffTa/4IKynnotK1GO/FqWe2/prpUl8EzinhSe4sM5gGjkPGp6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbQFl7s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE9CC32781;
	Sun, 19 May 2024 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716162687;
	bh=sFF+7igQBl2ESdcO2thGcwttU4waX/G2ehZzAJURP0I=;
	h=From:To:Cc:Subject:Date:From;
	b=GbQFl7s3spqTkn7xfq3hNeqkAE8gh6hjmnA1j0Y/+pudvJV/wg2Pg7bLydSfLjr1Y
	 gXXzP676BsvfO4+haxJrn2zlF9iVGsfJjvegbqk9V43UgEhOyCWot7SGlMOWaKoH27
	 Zhp42JxAVqA64f236VKNPwmY8If2qqRcSdDWL28y2o51Qs0djXlDYZSoe8LnOtR+QC
	 Vp3gaohiuJ2usHqXxS7K/G1YUhN5L0AvrmlQkBKL3wlmwGMDCtl2jB8tm3lZA4Ql++
	 0cnPHxp4Y0Kzvw4j3/bDxfs93XW3BTj8RryLLCIzJafmH+SLU1xZKYIL/1IaDR2Ihx
	 SpJy5kItC4yzQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KEYS: trusted: bug fixes
Date: Mon, 20 May 2024 02:51:18 +0300
Message-ID: <20240519235122.3380-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accumulated bug fixes for trusted keys.

Jarkko Sakkinen (3):
  tpm: Disable TCG_TPM2_HMAC by default
  KEYS: trusted: Fix memory leak in tpm2_key_encode()
  KEYS: trusted: Do not use WARN when encode fails

 drivers/char/tpm/Kconfig                  |  2 +-
 security/keys/trusted-keys/trusted_tpm2.c | 25 +++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.45.1


