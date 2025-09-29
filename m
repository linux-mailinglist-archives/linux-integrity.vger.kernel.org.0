Return-Path: <linux-integrity+bounces-7292-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8518BAA803
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307491923242
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3BB2206BB;
	Mon, 29 Sep 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipzoyon1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B82AD3E;
	Mon, 29 Sep 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175324; cv=none; b=l8zFFz8f4RexKswGB0oxaI6c2Yj3tItBA+5TGnGdQHsx6eyqkyWfTkJE1eyx/J5qzYAOCl6rm/+q2ayMKrD7li6cbU82wTqD/ZN8QfGKYb1wND1DKr2JIFfyi4Dd/KVab7w88Au4Q5ExU72evlrp7GWGATeX8g8duBmv6Ggb5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175324; c=relaxed/simple;
	bh=KaZuLuXbKnLngYj5nT4SK1tdl2bfPrc+kNBvAQVqmwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KT5RnXg/QJBa+0yx4vILEiBefTIWeR4B/lGnuOA+wCVaQO5aRHvuBDjYclNzqGFHAUKpXv5H5iUD94U2sfOZV7lIOneW4OnrBBjnBOcCdOZf4mKh+8xQ1dgAQ09bzWQbDNFcITz3PaqQpl9GNGPFkD5cWc6FiAaUmPvAo2raPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipzoyon1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69CDC4CEF4;
	Mon, 29 Sep 2025 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175324;
	bh=KaZuLuXbKnLngYj5nT4SK1tdl2bfPrc+kNBvAQVqmwc=;
	h=From:To:Cc:Subject:Date:From;
	b=ipzoyon1RO3tVoc328MUec5mRuQKg+JSRYeb7eIfbwgXSiLUXZJ8OuzH4gPsNXhW7
	 q7QY+yTRjwUw29oR1jG7kv2TwsIl8xMO/lw4FeN5GpjctV4lqqRfPGUxVDpuFhjvTi
	 6xiPS4BaMI6C5zJY9Nv/mstyhf8lnyiv8PXqCMf1HGCe082Q6D3haAAbKRiwcGdzLz
	 gqQQDDfA2tAAdM0rLEB9/JZZZbiZakMLwyOf7EZbg6pGCwol9xE/psWcFLkp+gC9jW
	 NWvigNtgdcN7BU5b6eHw9uu58VafuhEo3pYT77BL3XbvPYJMlWMsZs990VLtKj3mcx
	 ti5CwNxN/bByw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
Date: Mon, 29 Sep 2025 22:48:22 +0300
Message-Id: <20250929194832.2913286-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========

Decouple TPM driver features relevant for Trenchboot and make tpm-buf
robust and decoupled entity from the rest of driver. By doing this, code
can be easily linked to the early boot code.

Backlog
=======

Parts of tpm_tis should separated and decouple from the driver code so that
the slices of code can be compiled into early boot code. Since by other
means the series already has most of the gaps filled it's better to resolve
this issue before landing the series.

v3:
- I think 6.19 is a better goal for this and thus expanded the series to
  be a generic Trenchboot enablers series. This version also consolidates
  my two separate ongoing series.
v2:
- While including fixes from v1, this patch set has a refocus in order to
  do minimal changes to make code base more compatible  Trenchboot.

Jarkko Sakkinen (10):
  tpm: Cap the number of PCR banks
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
  tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
  tpm2-sessions: Umask tpm_buf_append_hmac_session()
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: check for corruption in  tpm_buf_append_handle()
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Build PCR extend commands
  tpm-buf: Enable managed and stack allocations.

 drivers/char/tpm/tpm-buf.c                | 208 +++++++++++----
 drivers/char/tpm/tpm-chip.c               |  13 +-
 drivers/char/tpm/tpm-sysfs.c              |  20 +-
 drivers/char/tpm/tpm.h                    |   2 -
 drivers/char/tpm/tpm1-cmd.c               | 179 +++++--------
 drivers/char/tpm/tpm2-cmd.c               | 307 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 128 +++++----
 drivers/char/tpm/tpm2-space.c             |  44 ++--
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
 include/linux/tpm.h                       |  79 +++---
 include/linux/tpm_command.h               |   5 +-
 security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
 security/keys/trusted-keys/trusted_tpm2.c | 237 +++++++----------
 13 files changed, 621 insertions(+), 665 deletions(-)

-- 
2.39.5


