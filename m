Return-Path: <linux-integrity+bounces-8059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A51CC1C09
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 581923025715
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633983346AA;
	Tue, 16 Dec 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7vkOCHD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCB330B02;
	Tue, 16 Dec 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876915; cv=none; b=CXqbn6GUPoA6IppjWuNiJOP8C1p3LeqzSJC1JGaqpcSmS+WrGkoFoIubzMWOSjA4lSfptzBzcKsxYKW170r1xA3FqEdf7NivHkSWI4Q31Xlta6pG4mfYz0I9b6xCTj5YtbHmMiehIyZ1V0JFDmpv4b5kcOXGmx6dEE3OtzGIfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876915; c=relaxed/simple;
	bh=u6HWC/nUh3OKQvYFMbBVlQmz7mIz9B4bfR7y1Ey4mmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Biytp4dDTGr2RQZW+bt+KwK9csiufTayz2vJ/EYh1hOYDXfYVTgDjfA4u2o56wVJ6ClXOj/n2/3JVfCxYq1AGvZb6RwrjtRau5+/zMZqtuBWcSkkZvF45QzdMhaMuQDHJCsNi5CS7ftY7roexu7aOI9qfP2PyHOOUlGEixeoFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7vkOCHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F3EC4CEF1;
	Tue, 16 Dec 2025 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876914;
	bh=u6HWC/nUh3OKQvYFMbBVlQmz7mIz9B4bfR7y1Ey4mmg=;
	h=From:To:Cc:Subject:Date:From;
	b=f7vkOCHDLvhcOIBrjYT0KYltf2Snezc+3YiKEGf/yiS+VwNrJxP/Uoy6C2vDp+d+J
	 fGYk4umUvA7Su0hOf97mxwODOcCUGjiPueDy/1l0t9A8nHvLK71B6Lysyec5L84nRm
	 3ZW7B48vQeowQhpWT56x+iW2ypxK0oh3W7ME4g2eNg8dyJZCZgQ4owun33SSIccUz0
	 jjkLzL1IYkE6EnutwiHO6L0LzwMrAifgcvt0SV2fJusSUDh5oBELiYgCr3CvLrHZDF
	 nHIcsjgAeGVS9Ihlp2VEf+22DbPITzz2shzN+42g226OncKjWpUYP1MOw59Cjdlw3+
	 SEoc8vxH+p/Ig==
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
Subject: [PATCH v8 00/12] Streamline TPM2 HMAC sessions
Date: Tue, 16 Dec 2025 11:21:34 +0200
Message-Id: <20251216092147.2326606-1-jarkko@kernel.org>
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

Jarkko Sakkinen (12):
  KEYS: trusted: Use get_random-fallback for TPM
  KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
  tpm: Orchestrate TPM commands in tpm_get_random()
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
 drivers/char/tpm/tpm-interface.c          | 145 ++++++++-
 drivers/char/tpm/tpm-sysfs.c              |  23 +-
 drivers/char/tpm/tpm.h                    |   3 -
 drivers/char/tpm/tpm1-cmd.c               | 198 ++++--------
 drivers/char/tpm/tpm2-cmd.c               | 371 +++++++---------------
 drivers/char/tpm/tpm2-sessions.c          | 281 +++++++---------
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  77 +++--
 security/keys/trusted-keys/trusted_tpm1.c |  70 ++--
 security/keys/trusted-keys/trusted_tpm2.c | 329 ++++++++++---------
 12 files changed, 783 insertions(+), 944 deletions(-)

-- 
2.39.5


