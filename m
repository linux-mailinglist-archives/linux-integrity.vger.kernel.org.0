Return-Path: <linux-integrity+bounces-8308-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN6mMzdudmneQgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8308-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:25:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF78210F
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DDD300460F
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EEF2F3624;
	Sun, 25 Jan 2026 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGDLRuZS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2172F3612;
	Sun, 25 Jan 2026 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369139; cv=none; b=iMRK+z/h1xGF6GWB20bvH7ubQLYfNH79+aqjudE741AruWkvkSFWuWBoUTeIlGI5mfAWousQsMRxgGGGwwGBNJ8ZR5hMs8tURuwQ0mwCzTzSqtblnR1/cpR0gfIydZ0N6kZFyGmQ2xX0q94kmBLEKDJ7lmDdfdtSmWXAWz+tKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369139; c=relaxed/simple;
	bh=jE/8iQliFtyGfixgzL56E+plscnQ7JagHSVwqmSfIqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDTScSQVINRc6vJIyRH9crxS/BGmyiQnPsgGsDxjdMjwPCvoyMTDBcevqhM1e1LF+H9oJfNeUP0XRhelRAfnsf6ZbWkCUet8p6KOQxCJsaxVw5mgJw7KyzIDdejMHtbiaNY7r0mXivTBOnVNkhzOJ2I3HBSQtoK9GBKOS/SyD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGDLRuZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762BC4CEF1;
	Sun, 25 Jan 2026 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369138;
	bh=jE/8iQliFtyGfixgzL56E+plscnQ7JagHSVwqmSfIqs=;
	h=From:To:Cc:Subject:Date:From;
	b=iGDLRuZScIVzZlqKSJHYJ2nBihsMgQ3DTsd9B7lAVrtpzsM1eQ+QKaAHQb3LQDSin
	 0Lcg60si+Zl3xdoSo5HIce7arT5Q7G2r2nXp75YjuMKGrL0a2T5kM8CkyBsMsy1pHH
	 b+BPauoQWu1iX46vrSHYsVYt3zLvWNrgxBIItpD4F+Fg6dzznlRK02E+w958HlQd84
	 oNb5oIXkBlooAjCGd/bLoLFylaEHXZHDxhtnopF+n4PVhiYgjCJ8Zm46HodgFlH7gD
	 eDrNHHEQfddlgSWLK91i45Bhy65Fk7/whKwI9R/QEW1/IzNNzXgdYH4LpI4USK+V7o
	 WVQEnPJP7gpwA==
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
Subject: [PATCH v9 00/11] Streamline TPM2 HMAC sessions
Date: Sun, 25 Jan 2026 21:25:10 +0200
Message-ID: <20260125192526.782202-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8308-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AAF78210F
X-Rspamd-Action: no action

This patch set contains accumulated patches, which gradually improve 
TPM2 HMAC session management and TPM driver memory management.

RNG test
========

I run this test both TPM1 and TPM2 chips using QEMU and swtpm:

#!/bin/sh

ctrl_c() {
  set +e
  echo 0 > tracing_on
  echo nop > current_tracer
  echo BYE
  exit
}

trap ctrl_c EXIT INT
mount -t tracefs none /sys/kernel/tracing

set -e
cd /sys/kernel/tracing
echo function > current_tracer
echo p:tpm_get_random tpm_get_random > kprobe_events
echo tpm_get_random > set_ftrace_filter
echo 1 > tracing_on
cat /dev/hwrng > /dev/null &
echo > trace
cat trace_pipe &
sleep 10

Change Log
==========

v9:
- Simplified hwrng patches.
- Minor tweaks.
v8:
- Patch was a bit out-of-sync after piling new stuff. Now it is somewhat
  sane: RNG patches first, then tpm2-sessions and finally managed
  tpm_buf allocations.
- I added inline comment on explaining why unconditional sha256_update()
  call is safe to do when managing only single authorization handle. 
v7:
- Updated cover letter to match better the current state of the patch
  set.
v6:
- OK, so I decided to send one more update with managed allocations
  moved to the tail so that it does not block reviewing more trivial
  patches.
- Trimmed some of the patches and improved commit messages.
v5:
- I decided to add the managed allocation patch to this and take it from
  the master branch for the time being, as it needs more eyes despite
  having already one reviewed-by tag (especially tested-by tags).

Jarkko Sakkinen (11):
  KEYS: trusted: Use get_random-fallback for TPM
  KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
  tpm: Change tpm_get_random() opportunistic
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Open code tpm2_buf_append()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove the support for more than one authorization
  tpm-buf: Remove tpm_buf_append_handle
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Implement managed allocations

 drivers/char/tpm/tpm-buf.c                | 156 ++++-----
 drivers/char/tpm/tpm-interface.c          |  20 +-
 drivers/char/tpm/tpm-sysfs.c              |  23 +-
 drivers/char/tpm/tpm.h                    |   1 -
 drivers/char/tpm/tpm1-cmd.c               | 201 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 386 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 281 ++++++----------
 drivers/char/tpm/tpm2-space.c             |  44 +--
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  77 +++--
 security/keys/trusted-keys/trusted_tpm1.c |  70 ++--
 security/keys/trusted-keys/trusted_tpm2.c | 327 +++++++++---------
 12 files changed, 735 insertions(+), 881 deletions(-)

-- 
2.52.0


