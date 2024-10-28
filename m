Return-Path: <linux-integrity+bounces-3916-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA09B2493
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 06:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209061F214BA
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7118C350;
	Mon, 28 Oct 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR5yDFzY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AA156960;
	Mon, 28 Oct 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094619; cv=none; b=TEeLFiXeCz0w6tHA+q1o3YUJ1Hculp+X7NnGYez4mZfxCQm8iXCQNJSgBJOedTFoS73d2ynUoJlSDPucZMAZ2PLaeglbO7UchleBRqDUTfjtkRptyH2VCLNcCZH6/tESQz2q1WvRH2swCv498AYPOvnYR0xTll/q8JpwPpW3tF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094619; c=relaxed/simple;
	bh=PfOZmwADW0D5PEbSXfxlI5rAAaT285DqXghI1CR6cbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWBKYaNeqbBIpcE3rRw4i+jBFYdOTFPFx3bHi8OEIqJgvZLInNBiI6d+NRZjo9TGOeBQpJhI1XXrGCHOedV8JztPfQLPeSa6oCUE8whAaJaXtZvouCw83fi1jNaqnSMNDT3xaH2I0fxqGP+ulnPKMYA+c/EVEAkjOxu43FD9gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR5yDFzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBE6C4CEC3;
	Mon, 28 Oct 2024 05:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730094618;
	bh=PfOZmwADW0D5PEbSXfxlI5rAAaT285DqXghI1CR6cbY=;
	h=From:To:Cc:Subject:Date:From;
	b=oR5yDFzY41FkOeGqSlUPsbj9QfyGx5p5qr6vPW5BI11UmL4oh0TC1OwP5LjkYtUO6
	 aJDAF1tAk774mfq80Rb+cXoDr5gHws2q+C+8sQsL1VElzc14Wjb3UISwZNeKRVDzKF
	 kkAwQY1hoZLPAgYUV6ai4ZywAeR1eC8UsH+1bvw8NMan4uu+5V5S4PvQA/h5xWe5Nf
	 1VKCaZq3zynoJHEsCWKlrcCwHSDUs3RASVtEd0LK3HApgjuPk8qZ18raw+Xw68Jub+
	 eqoh4DPnl4yUgf/TGj74vxFlwn153oVu8GUbCJG13oexghtzDsHOj5aiZWXEmqHPrN
	 dffy+eP4rwZdA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 0/3] Lazy flush for the auth session
Date: Mon, 28 Oct 2024 07:49:58 +0200
Message-ID: <20241028055007.1708971-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: David Howells <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229

v7:
https://lore.kernel.org/linux-integrity/20241021053921.33274-1-jarkko@kernel.org/
v6:
https://lore.kernel.org/linux-integrity/D501D1CY5SJ4.SUKXHV680B30@kernel.org/T/#t
v5:
https://lore.kernel.org/linux-integrity/D4WQ58T5O21X.CGFKGFKV630K@kernel.org/T/#m527d0466a02abaa448720999ff055de0540e7bb7
v4:
https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kernel.org/
v3:
https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
v2:
https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
v1:
https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (3):
  tpm: Return tpm2_sessions_init() when null key creation fails
  tpm: Rollback tpm2_load_null()
  tpm: Lazily flush the auth session

 drivers/char/tpm/tpm-chip.c       |  10 +++
 drivers/char/tpm/tpm-dev-common.c |   3 +
 drivers/char/tpm/tpm-interface.c  |   6 +-
 drivers/char/tpm/tpm2-sessions.c  | 100 ++++++++++++++++++------------
 4 files changed, 77 insertions(+), 42 deletions(-)

-- 
2.47.0


