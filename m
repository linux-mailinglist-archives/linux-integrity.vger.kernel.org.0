Return-Path: <linux-integrity+bounces-8045-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E068CC1672
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE3030A0E74
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC033A71B;
	Tue, 16 Dec 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfOQoKXQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9933A701;
	Tue, 16 Dec 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871103; cv=none; b=cPb7ZZunYkplPYmkJ02Ib4s1kZdsXEAn2wTtlyW7twTsyWUDO5NOZXO/C20Qw8aiQwQrzyEwhVJjrpbH3QNO7MwXN7RDaXcjTQwYzSW69tfNMvbE9su25QADFiK9f3lQ0KJgCd6T1INhgHR3/JuokuYXHBaxNuQbHenx1b2/RBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871103; c=relaxed/simple;
	bh=wYxzWVbHlAsYeHK0+0jFgYjxvgSyTHgq6l6w12CPskc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QMQksnRL9ROp1Qkkcg0zbtMkXTDq1VO1BYdYyVAaciejyq9doCbi9y1/92MuJ/8lY6EAbyF9QWtc77wTDYR7hbWAoxOe4QuMmLkWwNZKUMfAwGLEY5iZqX3p1feSj4PmcXhXX5wCMT2nMON26v/tZ8/NwumrGLxprlLVVoycHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfOQoKXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B593C4CEF1;
	Tue, 16 Dec 2025 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871102;
	bh=wYxzWVbHlAsYeHK0+0jFgYjxvgSyTHgq6l6w12CPskc=;
	h=From:To:Cc:Subject:Date:From;
	b=jfOQoKXQr3kb3Os1voFDWTkGPHalCUaU6nkty/r+rCINdOSqDTWKSK771D6bTA9iG
	 kMlbm/diP2his+vvDB1yYqBQIKLUDPmrZI/9qGCo+nWp3EtoByAGQ6x//msQn3X9Z7
	 zdc2ZrmkutGBAeH3gdgypG71lHZ2HNiEGgPYu0vTFEyki1MMLc99BbEK+30V3w/GPG
	 fMBfgm8gLw4QfAAldrU5ucnt+m1eDJ2MXM3L/7FwK3QD3/Rer/qlWgz68LB3kJkqy3
	 1R4Pl70HwlB0Gh5Z3geVJ5MwixTsxU2zf1Lx7+bHA62e806A/3IYnOT73L7mOY/N0q
	 oemzL6RanZxGQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 00/12] Streamline TPM2 HMAC sessions
Date: Tue, 16 Dec 2025 09:44:41 +0200
Message-Id: <20251216074454.2192499-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set contains accumulated patches, which gradually improve 
TPM2 HMAC session management and TPM driver memory management.

RNG test
========

I run this test both TPM1 and TPM2 chips using QEMU and swtpm:

#!/bin/sh

ctrl_c() {
  kill -15 $TEST_PID
  echo 0 > tracing_on
  echo nop > current_tracer
  echo > kprobe_events
  echo > set_ftrace_filter
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
TEST_PID=$(cat /dev/hwrng > /dev/null &)
echo > trace
cat trace_pipe &
sleep 10

Change Log
==========

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

Jarkko Sakkinen (12):
  KEYS: trusted: Use get_random-fallback for TPM
  KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Open code tpm2_buf_append()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm: Orchestrate TPM commands in tpm_get_random()
  tpm: Change tpm_get_random() opportunistic
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Implement managed allocations
  tpm-buf: Remove tpm_buf_append_handle

 drivers/char/tpm/tpm-buf.c                | 154 ++++-----
 drivers/char/tpm/tpm-interface.c          | 145 ++++++++-
 drivers/char/tpm/tpm-sysfs.c              |  23 +-
 drivers/char/tpm/tpm.h                    |   3 -
 drivers/char/tpm/tpm1-cmd.c               | 198 ++++--------
 drivers/char/tpm/tpm2-cmd.c               | 371 +++++++---------------
 drivers/char/tpm/tpm2-sessions.c          | 272 ++++++----------
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  77 +++--
 security/keys/trusted-keys/trusted_tpm1.c |  70 ++--
 security/keys/trusted-keys/trusted_tpm2.c | 329 ++++++++++---------
 12 files changed, 776 insertions(+), 940 deletions(-)

-- 
2.39.5


