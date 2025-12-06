Return-Path: <linux-integrity+bounces-7833-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76C7CAA9E3
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 17:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB79302C8F8
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FA2FFDD9;
	Sat,  6 Dec 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDW+VyOS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA92ED17C;
	Sat,  6 Dec 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765037636; cv=none; b=vDFUrSdm9EjwfPfnvA8IzmpcPgG4xOBufhn3VObk5cgHGOipmx21dBI4jA95QC3feZA0c6MAJiYGDkUU0/0ZFq6sX0zkbwQmw+D+8bXxqZTR9VeZtmMUWVg6zMdNxkIz47KFpuZH7nLSC1lDGrb5MAVoWOIILx814iRmGt1wLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765037636; c=relaxed/simple;
	bh=q1kiBNhAfJoQw/DVM3Crq+Yw2cbwrqS+LKmJtD/kF28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q47XnStopkUv2z7mqWz2cUCWLz/e9zd3EW2fhKfefrgEK7yy5J5GgOi2KaGXGH7k3/88DMikYH/K0VJzdpooH0JZC3f8SosfnuiL7W69LsvrX6QnoOl6UDOB+S12oWZDT8SgdOTmToZYsZ5rDRBTu5SssWzRvhUA/INktRFM1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDW+VyOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72619C4CEF5;
	Sat,  6 Dec 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765037635;
	bh=q1kiBNhAfJoQw/DVM3Crq+Yw2cbwrqS+LKmJtD/kF28=;
	h=From:To:Cc:Subject:Date:From;
	b=kDW+VyOSPpDqhMcUksJjqfW+TpoF27lx7QsdzYbrV0GkFIgsV1ynyHz6tIDpDDeQt
	 GocJVzsCJYX8F6v9SInhNgix6LvFiOCWSY2BwyOu4hdU4LrjYlj8U0EnVyLqfGT8KW
	 F4DBtsUkpBrCXgwKRFvt4u+0kRptv9T9twoJvHoFpUgmn589DX6YXTuhOXfvnUd3ET
	 yXDE5BL/HwPntgpOdC4gU3AFqp8v+aobXmwghM98lguiEAt/peeS6ZnmreCgtasVQq
	 pLEVf+h+RVlpPwajJXOnjohtVD9m0KgJZkujUZb54W7V9APCcvFc4I1WmDwrf+pSjw
	 8M5SUbuiV0+LQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 0/2] Optimize tpm2_read_public() calls
Date: Sat,  6 Dec 2025 18:13:43 +0200
Message-Id: <20251206161345.2038730-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal is fairly straight-forwrd here.

The aim of these patches is optimize the number of tpm2_read_public()
calls to the bare minimum. The last patch is a bit out of scope but
I included because it builds on top of this work.

Jarkko Sakkinen (2):
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  KEYS: trusted: Store parent's name to the encoded keys

 drivers/char/tpm/tpm2-cmd.c               |  93 +++++++++-
 drivers/char/tpm/tpm2-sessions.c          | 163 ++---------------
 include/linux/tpm.h                       |   3 +-
 security/keys/trusted-keys/tpm2key.asn1   |  17 +-
 security/keys/trusted-keys/trusted_tpm2.c | 207 +++++++++++++++-------
 5 files changed, 266 insertions(+), 217 deletions(-)

-- 
2.39.5


