Return-Path: <linux-integrity+bounces-7840-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22333CAB84E
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4000301FC14
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0B2D4801;
	Sun,  7 Dec 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1M8ebG7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460803FBA7;
	Sun,  7 Dec 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765128741; cv=none; b=Ml8TWmSgTFhptsZ8xh2w0NT1ROWXz6NwhlVg6M4N6FtHywBPFZRd/Y68n7ILpezcNRCbfVf1oUE+sbo8kgPs1tTuR0oQkdy4A6ed/dqBKPs/SabKnH2ONpWeQ6IVO9YbsU58gaV8L+JYHhMVJBfWWE636qGygyMiHNbC8fJ4bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765128741; c=relaxed/simple;
	bh=ZhMaps32hoygg4D5ruYd+aVY7HvUwN93TzP+N2C6NZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXQSpDKOZ8zndrrrECGiJjh62jiSi7b3958S1z6zZmceKm3+qZL2k9RjcD05x58En+8Exph89XE0hhl87UTR1eXlpe1D0Udo+8KGg5CLc/e3g4IXXXDI7rEfO4twAesA6n6F1AR2Ua/A1vblWbefVI6S4mkAPOpPQGCC5k2KZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1M8ebG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B5C4CEFB;
	Sun,  7 Dec 2025 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765128740;
	bh=ZhMaps32hoygg4D5ruYd+aVY7HvUwN93TzP+N2C6NZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=S1M8ebG7wk4E7JDgQv6pPJ7DJXB3Wu0sv/1xcFTykolxQPsohlgODnmZFwnQemv0S
	 3OXd23QmPV3m5A0l03OBIlNh1UgfGsohjfsekY2FT75pPEMSHz8cISo3fa3oU13ZZb
	 K+JIGfL5pfl2SgEBi1EmvaqWh5nxLaUzafeQavhHAdLIfaT9IjEdIbrsVQhERuv5ly
	 I1sBq0pStVRQxUh2xjTZMI3q59wVoL32WZT83VANp8HxO3IF3oU+dTO0bLPkVjZcur
	 ePljxdIsZT3MkC6aH7DpODwe5K/P/dAkHksKVYQVEUVtX85mDP8syK+X+M4qdULXlQ
	 SoY+74mlp6hQw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 0/2] Optimize tpm2_read_public() calls
Date: Sun,  7 Dec 2025 19:32:08 +0200
Message-Id: <20251207173210.93765-1-jarkko@kernel.org>
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

 drivers/char/tpm/tpm2-cmd.c               |  86 ++++++++-
 drivers/char/tpm/tpm2-sessions.c          | 156 ++--------------
 include/linux/tpm.h                       |   3 +-
 security/keys/trusted-keys/tpm2key.asn1   |  17 +-
 security/keys/trusted-keys/trusted_tpm2.c | 207 +++++++++++++++-------
 5 files changed, 259 insertions(+), 210 deletions(-)

-- 
2.39.5


