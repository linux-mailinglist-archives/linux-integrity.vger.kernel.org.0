Return-Path: <linux-integrity+bounces-3646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D283397DD0C
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B70282ACC
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2E156C7B;
	Sat, 21 Sep 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwApDNk8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2F38FAD;
	Sat, 21 Sep 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920497; cv=none; b=mj9pTcZB7xnq9gfhxWEMF+66GIci+2j/L0GVgoudI08zc1fgzn4bYeSlWmjoDdIwwjKeJ2JCP+9SG2ZdkoPGTFzI72GzFb5jbrX7SjZppPwjtAfdcZxm3wBk0PmxbBxGvaNN+IPjldJihHSZNaGpdpA7aAK2m9j27nUsi+41Ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920497; c=relaxed/simple;
	bh=eyoBx/NKFE6Fmta/q0MPQKQBRElp6C0qlTcA5X+Tsz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/0LouEHcxmrfp9r+w8uTDrQkN5hqB6GniWmWB66izMopHiBfqr2Ss1LHfXvJtaGpIX2lI6oJ485vLuAEYUIOeL8zzb5NjLbhYtneJEnktGZ8X2mjrwXH+I49yXuzuzUhncivTRYHrQjSfqRV5wHvocGu9GVh1U6MBBjA24jX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwApDNk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E6BC4CEC2;
	Sat, 21 Sep 2024 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726920496;
	bh=eyoBx/NKFE6Fmta/q0MPQKQBRElp6C0qlTcA5X+Tsz4=;
	h=From:To:Cc:Subject:Date:From;
	b=PwApDNk8l9S/mr35QNpD3zMOsO/Yp4ZsPb+iuZuMvhmvmsdxpNsU7TjOvFBn9pHTJ
	 5b06dhTwlComs9GHlWgF51q5JBtsJR3K97+O3JHGFLbpGFZKNQQoKTpxJ39uuOESP9
	 1blhmPIiJXOlFwNt4i7dYnvtS0Q0DkV3eNSDtePbatljyMEx0MO131E5KUlVcUZDPr
	 C4C1AM1rCXRqywO3/pIB+Ml2C1Ms2IVurEVPLxqfKE/wgHmdvmR+OxYjb4Mi4HLsUZ
	 fOOAy1j8DqYpmAICQj9gCW4NzEtuJ7IFpMZselIZPZ0atf8DlLbY5xFuruEWTF3i/r
	 vyqff5zq+dQhg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Lazy flush for the auth session
Date: Sat, 21 Sep 2024 15:08:00 +0300
Message-ID: <20240921120811.1264985-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to fix:
https://bugzilla.kernel.org/show_bug.cgi?id=219229.

The baseline for the series is the v6.11 tag.

v4:
https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kernel.org/
v3:
https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
v2:
https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
v1:
https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (5):
  tpm: Return on tpm2_create_null_primary() failure
  tpm: Implement tpm2_load_null() rollback
  tpm: flush the null key only when /dev/tpm0 is accessed
  tpm: Allocate chip->auth in tpm2_start_auth_session()
  tpm: flush the auth session only when /dev/tpm0 is open

 drivers/char/tpm/tpm-chip.c       |  14 ++++
 drivers/char/tpm/tpm-dev-common.c |   8 +++
 drivers/char/tpm/tpm-interface.c  |  10 ++-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 109 ++++++++++++++++++------------
 include/linux/tpm.h               |   2 +
 6 files changed, 102 insertions(+), 44 deletions(-)

-- 
2.46.1


