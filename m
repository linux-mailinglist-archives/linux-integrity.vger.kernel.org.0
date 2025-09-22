Return-Path: <linux-integrity+bounces-7223-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C41B9243B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECA11675FD
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779E311940;
	Mon, 22 Sep 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHHzVqge"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BFA3054E6;
	Mon, 22 Sep 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559409; cv=none; b=KuKEGGT5tV+rFgZPUlfoLE7psTcVQNb9yhQchJA+l/426Hg94dnw+2kwEUgo/xsgUHf//H/7lYIrU9TLYiNZouvYyNbKyHBucGng6xu8Msdmx6Y6PFqrMdcXDjPaGSlvBk6BM7cicER0WLcuMQTWf5sY3I6M5aodWk11kqBZjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559409; c=relaxed/simple;
	bh=sJzJdgQxOjNdQRb5nDHaDPoAIXYQDfFBB/Q8X33y7tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBpEfv/N8hp+TMe475afWsAuzoZyZO0UYMEzdx7D246JOalH+3gAqx3rKPrZ9TkyPQXW8Z63js/hI4lbFfTsi0a3wfdlsNeI6GgaJWhXxCwi8lSkBwpY5b/U2Pa7jf48zD6Kxvl8SW3hTeiM1UBFaZV/kVz/k6bX319VwRQbHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHHzVqge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B2C4CEF0;
	Mon, 22 Sep 2025 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559409;
	bh=sJzJdgQxOjNdQRb5nDHaDPoAIXYQDfFBB/Q8X33y7tw=;
	h=From:To:Cc:Subject:Date:From;
	b=jHHzVqgePVwqO+FxSez7KFt7GUTfwxU4+e91sEA+6//e7A2hJwbBE3S8157jTFlW/
	 HR81MvNJdl9HpL33pxtcVZftY16B1sd0gt1trHQmMqJdFy8eHJeIQ6XNBxrnBCiOqD
	 fW9e3nTbKhdPHjl/DoXcNjaELoOZAchqfuwSP3Ll5OdMf8ntFYz4klFdnAl17YxQvA
	 GeiJxBkpGBSUeVOeSkf/zZE3C1eDYHDygQTnj1IAqJIl5QcFcsrP/bBmGuYTmbELDZ
	 4CG32yxzXh9GhW9MsQC5kmGX0juoD8egOJ4IsCfFtTwTu9PUVesYRpSp56v5dHbwn9
	 e5zalheefRgEQ==
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
Subject: [PATCH 0/4] tpm2-session: correct disperancies
Date: Mon, 22 Sep 2025 19:43:13 +0300
Message-Id: <20250922164318.3540792-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct various disperancies in tpm2-session implementation that set knots
on improving the feature.

Jarkko Sakkinen (4):
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  tpm2-sessions: Remove unused parameter from tpm_buf_append_auth
  tpm2-sessions: Remove unnecessary wrapper
  keys, trusted: Remove redundant helper

 drivers/char/tpm/tpm2-cmd.c               | 16 +++-
 drivers/char/tpm/tpm2-sessions.c          |  5 +-
 include/linux/tpm.h                       | 34 ++-------
 security/keys/trusted-keys/trusted_tpm2.c | 89 +++++++----------------
 4 files changed, 47 insertions(+), 97 deletions(-)

-- 
2.39.5


