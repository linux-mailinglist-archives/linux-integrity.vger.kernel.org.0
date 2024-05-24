Return-Path: <linux-integrity+bounces-2606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124048CE5A6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437201C2183E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3286263;
	Fri, 24 May 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="csRCWOOG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89285639;
	Fri, 24 May 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555908; cv=none; b=W1fuEpOS01nH2ViE2qm0ckF0cysk15f6SnslziN2bjGn8bZdnMSg2Opa1ZVHD4kXkqH0b6jDOufcGdULzpNHfdiZ+ulMTlebklCLW4qThaH+L7b4kA5YH6hGn2J6PZylsOym6HUaYBs/VCKs3a0ck8/n1fcGxHLzsSZYPD3MrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555908; c=relaxed/simple;
	bh=0DJry9fmYCDLVlCL+vS+MoUCKZnBxo96/vmJdwMAdMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFygYVhFKmDxpz+rSS8BjymIeE7tVLrpwQUurwZGOjSfQYmDDbBLctqGN54Ss0tvaopGpubBBBd9QpCmo1ZduawTQm3V7KqRiatgSpz7fFl0gDhVrDem5og6ZlHUKT41CyR+mYyclVjU3yK5Y4nW87F1pvtU0NnXjq7OWMHvgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=csRCWOOG; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555906;
	bh=0DJry9fmYCDLVlCL+vS+MoUCKZnBxo96/vmJdwMAdMw=;
	h=From:To:Subject:Date:Message-Id:From;
	b=csRCWOOGgN2bq1msd5v4vByI7NLzx/Wj5IcLrKSODXsZFZV55Ex1c8ZAlgTEtrVSL
	 p6VmHg91hTuF3v7dq2wGsoD6jo1vS/S1bIaq4a9ej4jo8TqczFZ4fB9g5dyTcj+AYU
	 pzEFYERwbI6S1QqbLbvQNTEZ97Lhb6bIbGtp/rt4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 89BEE12817CC;
	Fri, 24 May 2024 09:05:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id EIUnWhuE2HgG; Fri, 24 May 2024 09:05:06 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 028071280355;
	Fri, 24 May 2024 09:05:05 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [PATCH 0/6] Add policy to sealed keys
Date: Fri, 24 May 2024 09:04:53 -0400
Message-Id: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPM2 policy is much more complicated than the original TPM 1.2 which
only supported PCR value binding.  TPM2 policy may be a sequence of
policy statements each of which must be correctly executed and may
include choices in which set of policy statements will execute
correctly.  The actual policy is identified in the key by a single
hash, which is the end result of extending all the policy statements.
However, since it is impossible to reverse engineer the policy
statements from the hash value, the ASN.1 key format is extended to
give a broken out list of statements the kernel must execute to get
the correct policy hash value.

In order to create policy sessions (which are usable as HMAC sessions,
but also respond to policy statements), the TPM HMAC code is reused to
create the required policy sessions (while preserving bus security).
However, because the session hash algorithm must match the name
algorithm of the sealed data (which is used for the policy hash), the
TPM session code is changed to use a variable hash algorithm.

The first patch consolidates the hash definitions and conversion
routines, the second adds both variable hash type and policy support
and the remaining patches add specific policy statement
implementations.

James

---

James Bottomley (6):
  tpm: consolidate TPM to crypto hash algorithm conversion
  tpm: add policy sessions
  KEYS: trusted: add PCR policy to TPM2 keys
  KEYS: trusted: add ability to specify arbitrary policy
  KEYS: trusted: implement counter/timer policy
  KEYS: trusted: add support for TPM keys with signed policy

 .../security/keys/trusted-encrypted.rst       |  99 ++-
 drivers/char/tpm/tpm2-cmd.c                   |   8 -
 drivers/char/tpm/tpm2-sessions.c              | 313 ++++++---
 include/keys/trusted-type.h                   |   8 +-
 include/linux/tpm.h                           |  81 ++-
 security/keys/trusted-keys/Kconfig            |   2 +
 security/keys/trusted-keys/Makefile           |   3 +
 security/keys/trusted-keys/tpm2-policy.c      | 662 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  61 ++
 security/keys/trusted-keys/tpm2key.asn1       |  21 +
 security/keys/trusted-keys/trusted_core.c     |   7 +-
 security/keys/trusted-keys/trusted_tpm1.c     |  15 +
 security/keys/trusted-keys/trusted_tpm2.c     | 206 ++++--
 13 files changed, 1314 insertions(+), 172 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

-- 
2.35.3


