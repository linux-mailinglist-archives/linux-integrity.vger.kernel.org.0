Return-Path: <linux-integrity+bounces-7801-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B6CA528E
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D733046EF6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF032DCC1B;
	Thu,  4 Dec 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoCxsAge"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246171FBC92;
	Thu,  4 Dec 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877684; cv=none; b=C4+R4apg5cgq5WQoF9ULlRCjSpHMQ6i7+e9/cHwyk2K//D4SRA4IV6yR681ABBphFPaJpESdz3JGPYZQDr9eJcew0VQ+j2GlZ2OpBWb1cMbb6NjysReoa8G7LfGlnkuvM8ECAg0DIVU+5dsGrPgnmV1jaecPwei5fQG02fX1th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877684; c=relaxed/simple;
	bh=ly3de6K4sc5L0JskNHVa0dAv3ZtpSvjHRFx8BB54r5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8OiVljJvsqwyTe0OQDLUSw/IgrsFhjD5DgAwm/kg7zx3A9rm4AL02lLF04CJChCbw0/5QGGkan9Z0pQ07fW22XKXAB9622K4/XOwH+ovJ2oUmskMuW+RMtBKJA9bPi3YWRJSqNwjTyH6nW3+tSZZ36gkqcH+lcQe8ojecRV7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoCxsAge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2915C4CEFB;
	Thu,  4 Dec 2025 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877682;
	bh=ly3de6K4sc5L0JskNHVa0dAv3ZtpSvjHRFx8BB54r5w=;
	h=From:To:Cc:Subject:Date:From;
	b=HoCxsAgehsDzWZmNCt8pUi66ym2UWb+VwE6vf5sGjOho0H0eMK3KYnAwpX+5fUuBK
	 NM3qxCv2L0jgrNIlAvjuXH3tFc5bcBfvt55LcF5jFrVA4wioE8D1IU9eYhHdh7eteT
	 W3GE/JTjz35rP+QoFWQoEyalkbZ/GZ5K4/K0eTpfQwPR+HNsAaY9D6lQhHrQDx+Dsw
	 MGFlkJ8d2o6sTCJ1NtcIVv8v8biqaDZ0kfSy7Uu6xTO8GefwCRLOcy6F/UxO7Ppu3R
	 QDop39j6GJHmEDmg0t4exJbtqYJEZ/yDkQMOAi/cfeJWDPr3D+Sut+DbPFHIDvnSYo
	 2x8xhoCzM3eNA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/4] tpm2-sessions: Fixes for v6.19-rc2
Date: Thu,  4 Dec 2025 21:47:38 +0200
Message-ID: <20251204194743.69035-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I collected the accumulated fixed for tpm2-sessions, geared towards
v6.19-rc2.

v4:
- Removed spurious newline and renamed 'rc' as 'name_size_alg'.
- Return name size from tpm2_read_public() back to caller.
v3:
- Fixed two issues in 1/4.
v2:
- Addressed issues reported by Jonathan McDowell:
  https://lore.kernel.org/linux-integrity/aS8TIeviaippVAha@earth.li/

Jarkko Sakkinen (4):
  tpm2-sessions: Fix out of range indexing in name_size
  tpm2-sessions: Fix tpm2_read_public range checks
  tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
  tpm2-sessions: Open code tpm_buf_append_hmac_session()

 drivers/char/tpm/tpm2-cmd.c               |  42 ++++-
 drivers/char/tpm/tpm2-sessions.c          | 199 ++++++++++++++--------
 include/linux/tpm.h                       |  38 +----
 security/keys/trusted-keys/trusted_tpm2.c |  41 ++++-
 4 files changed, 204 insertions(+), 116 deletions(-)

-- 
2.52.0


