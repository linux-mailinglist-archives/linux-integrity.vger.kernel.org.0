Return-Path: <linux-integrity+bounces-7341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57822BAEBDA
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E11890811
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1D264F9F;
	Tue, 30 Sep 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/3Ad7NA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C41A2C0B;
	Tue, 30 Sep 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274406; cv=none; b=jfEsQnF2O5ofWY1Wwj2OC54LprPnjdwM5cYxXSdhQDd588PsBoXxcx28eGZJi3aPJz1pmbzOCTDsQaPPVUWckDXjeOf/OdqC3YGHEIWc1YyWIpf5aLJ60+8tQa47MH2EMfWo5/zySig9/jRAscmhx6t0QsPqpa/kkzNuduHM9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274406; c=relaxed/simple;
	bh=+wWTrE4ITvFS8g2AqNmb6ksKLW9/5I4wm5HcledP4dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ii3+oKnZE93JWFYjCh49m5Vz7AQpKHUnhzHspHzTZ2fU3JpsiwSKilUQdSqdD+un0jn7An41hPwG+JLqjTV0/3p3ZXhwso5/bFsK33vfTDYs1C1GHv2RpIpCzjPcTHwh+Iq0CFVwLot7jqOU98NG6oIyTwACZavkaZxcnjlnky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/3Ad7NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC6C4CEF0;
	Tue, 30 Sep 2025 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274405;
	bh=+wWTrE4ITvFS8g2AqNmb6ksKLW9/5I4wm5HcledP4dU=;
	h=From:To:Cc:Subject:Date:From;
	b=p/3Ad7NA8hJygSDTMQy9ygj743we6+3oG3kOTOCsNbN/NFSspYnNCGw32Yq5JdJVF
	 CCqGVjR1+egrGRmAUuaiEkXfcWBhAp5egrbjFUY0VlJizIwDc8wFIpouvu1N6poE6R
	 jExV+q0x8cY2T7LefTZVROKOW3BBP94drDs/414eVNASIyU9UBaJoFFQRylbcUDGJK
	 nZTRIZ6uG+zPXFjyTw7CCEchRjMAhFpBsffJ0p7jYU8fh4WYYxKtDVc/2E12mzXRYW
	 t87zYJwve+5BeYkPReYpdv7d4Wpq/zvgxOmJmgYJo1sX3k1mEZUmkElaRLjbrc4q17
	 yke3NSEjBMRTQ==
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
Subject: [PATCH v5 0/9] Prepare TPM driver for Trenchboot
Date: Wed,  1 Oct 2025 02:19:49 +0300
Message-Id: <20250930231958.1437783-1-jarkko@kernel.org>
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

Prepare TPM driver for Trenchboot by making tpm-buf easy to compile as an
independent compilation unit, and generally be IO and memory agnostic.
This allows Trenchboot easily use this code to build and parse TPM 1.2 and
TPM 2.0 commands.

Goals and scope
===============

This patch set contains only changes, which are acceptable to the mainline
driver without existence of Trenchboot feature.

v5:
- Order sobs correctly.
- Fixed a minor glitch in 9/9.
v4:
- PCR patch has been removed because it does not fly without Trenchboot
  context.
v3:
- I think 6.19 is a better goal for this and thus expanded the series to
  be a generic Trenchboot enablers series. This version also consolidates
  my two separate ongoing series.
v2:
- While including fixes from v1, this patch set has a refocus in order to
  do minimal changes to make code base more compatible  Trenchboot.

Jarkko Sakkinen (9):
  tpm: Cap the number of PCR banks
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
  tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
  tpm2-sessions: Unmask tpm_buf_append_hmac_session()
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: check for corruption in tpm_buf_append_handle()
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Enable managed and stack allocations.

 drivers/char/tpm/tpm-buf.c                | 141 ++++++----
 drivers/char/tpm/tpm-chip.c               |  13 +-
 drivers/char/tpm/tpm-sysfs.c              |  21 +-
 drivers/char/tpm/tpm.h                    |   2 -
 drivers/char/tpm/tpm1-cmd.c               | 185 +++++--------
 drivers/char/tpm/tpm2-cmd.c               | 313 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 129 +++++----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
 include/linux/tpm.h                       |  65 ++---
 security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
 security/keys/trusted-keys/trusted_tpm2.c | 241 +++++++----------
 12 files changed, 544 insertions(+), 674 deletions(-)

-- 
2.39.5


