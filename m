Return-Path: <linux-integrity+bounces-7483-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03042BECE1B
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E834E985
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C0155C88;
	Sat, 18 Oct 2025 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2suU20i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FCCA6F
	for <linux-integrity@vger.kernel.org>; Sat, 18 Oct 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786255; cv=none; b=g6V/6li279X8Gm8dMaKyWJ5KJxdjYtjx2XkS8hZ6hsC7d7tdqiRTdun4XyRX35RR2sKi6WoIFJ5I6iIAHa8hwuKT40elHVsRQIvVq98clZAPBZjj0wp2yvCeiR2leWWW6eOPxe+EIShUPADNkd9W8rnz9XJMQUq6cTfTMe/1ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786255; c=relaxed/simple;
	bh=IJcDfxKvQ634pBGoHrm7xYPk1ZNLEcW0u9COeLKNNuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHYh+dOp2dQpQGcRRa9Zpk1SrmhlJmAHnDF3Cfbtfy3By7zqqgRxyMh/XrSJvPcOVWfXRm04hrdBnHKus3agpwiR9JeeXc/ZuDnDeFFykxWhSeYh74AlfUD80UNl6677cR661c2GoEGyp4xE51O+6QUhLgv59CK3ckjco7DCoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2suU20i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D254C4CEF8;
	Sat, 18 Oct 2025 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786254;
	bh=IJcDfxKvQ634pBGoHrm7xYPk1ZNLEcW0u9COeLKNNuA=;
	h=From:To:Cc:Subject:Date:From;
	b=C2suU20iPZuA38k7Pa29HxZ4RC/mwsGAMgR1ojPa7yFWAEZQj3L+GKUII0gae2sJR
	 wl9FQhicAxblS+s7YgDfcr/a7xRMSnX9YBSMJt0kk/nMqrPHSLd1Ug24iMw7CQh5U4
	 RvZLLiI6aT94mDOXM+tXoH4MNT3hxQMvQKQ3k9fwyxjYKntUs5tOz4EyqnIs70220J
	 yOFZTwkd4AyRgWzHOSWBpPwO+fgNifehDppOIizFLrMMt6UMDGKt0Qjvp51gq1jxwe
	 N1YLPafX31xNaO4bWsayAsICaBdhiKGeusbjebx9hCwwxT1wvEs9PIAnzELkVWTj7d
	 z3vszbZHdaLlw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyring@vger.kernel.org,
	dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v6 00/10] Prepare TPM driver for Trenchboot
Date: Sat, 18 Oct 2025 14:17:15 +0300
Message-Id: <20251018111725.3116386-1-jarkko@kernel.org>
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

Backlog (of stuff that will end up to a follow-up patch sets):

1. Static flat duration table for TPM 1.2. Such feature already landed
   in v6.17 for TPM 2.0. We probably can figure out some sane roof
   values for the legacy standard, right? This allows to share more
   code "via data".
2. Not a blocker for sending subsequent versions of Trenchboot patch set
   but we could look at slicing tpm_tis code at some point of future.
   It could be even that redundant parts could be "merged" after the
   feature lands but this is neither a promise (depends on how things
   look overall).

This patch set does not do a lot heavy-lifting but is beefed enough that
it is better not fatten it up too much anymore. Sane buffering is a
great starting point.

v6:
- Fixed a memory leak that I found trom trusted keys.
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

Jarkko Sakkinen (10):
  tpm: Cap the number of PCR banks
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  KEYS: trusted: Fix memory leak in tpm2_load()
  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
  tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
  tpm2-sessions: Unmask tpm_buf_append_hmac_session()
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: unify TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
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
 security/keys/trusted-keys/trusted_tpm2.c | 267 ++++++++----------
 12 files changed, 554 insertions(+), 690 deletions(-)

-- 
2.39.5


