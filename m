Return-Path: <linux-integrity+bounces-7330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E26BAEABC
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13BA4A56DE
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618B22A4FE;
	Tue, 30 Sep 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErIDrCz0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B05FC1D;
	Tue, 30 Sep 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270636; cv=none; b=AQHoWwiBNAn/ILJvOl4Qx9Lhgcsq5BvmdIrFhXvpQhuZ9TgW5GdzgIrP70yYoJ1KaZM50ZEF4iYy+Oc56SMWjyuSUZ6deFJ3I+iqK7ctNaU2E2hGB1I0QHx1BAVdNxvCICttVBQGXUqvfEyH4X4u5JnHBgRxtCXBFvr++uEzoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270636; c=relaxed/simple;
	bh=d+JYANOeZ+9GlZcNiN33I9hBdQl0AHlGwLK80LGLXa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqW6UyOJ3nmxsKD+0vsOdQ49YzoJHyv4YHhWcvyQlt9vTbTcFfySrTi/V4/4yMCcCutVioALmjZwLZvULhWOd4cYSVYLg917qPdl8clEiQMpwlfgNaeqfvpSllW8fzlcG5qlbC0vKGir6FV3iMyunShifyABuuEKQtIvsrolSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErIDrCz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD9DC4CEF0;
	Tue, 30 Sep 2025 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270635;
	bh=d+JYANOeZ+9GlZcNiN33I9hBdQl0AHlGwLK80LGLXa0=;
	h=From:To:Cc:Subject:Date:From;
	b=ErIDrCz0wIvjIygTTjYc39ufDMFQApecjBJwBtT5/k+K638HWXimeDSOZcK/dq/YK
	 zUDTqYeYPeDyYqXLtGvjcA8aeQpZvOvCnszZdZKpUzOUVGG0wGiSA2UD7ONLTogYYQ
	 0EWhcB12hsMa/wvgoOw1RX6iSNWMgeAhMwNO4eivK4CK5VASVDYSwhCNzsLbDoOt8A
	 8l/LXGBL2McupXxgb7vin9BlawXp10EiSECxoJvt4lxqr1CV0MZj+kN9EgfHy2j9PF
	 QQng+yhskgII8F6R6+cup40dm5JPQCz8hlbRr4Htpm68Q/8CwTSNVOmg68QsgH/t1a
	 o/n7Bjb2dIjkQ==
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
Subject: [PATCH v4 0/9] tpm: Decouple Trenchboot dependencies
Date: Wed,  1 Oct 2025 01:16:58 +0300
Message-Id: <20250930221707.1373912-1-jarkko@kernel.org>
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

Goals and scope
===============

This patch set contains only changes, which are acceptable to mainline
driver without existence Trenchboot feature.

At the same the primary goal of the included is to make driver code 
robust enough to meet Trenchboot's requirements.

These constraints should define a meaningful DoD for this patch set.

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
 security/keys/trusted-keys/trusted_tpm2.c | 237 +++++++---------
 12 files changed, 542 insertions(+), 672 deletions(-)

-- 
2.39.5


