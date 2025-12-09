Return-Path: <linux-integrity+bounces-7860-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C57CAF2CB
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 08:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6133D3012248
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B41256C70;
	Tue,  9 Dec 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of2xM9+X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC37226D02;
	Tue,  9 Dec 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265951; cv=none; b=O8JEBzxjY1x8NoekgCOeeA7WTRJQCNFHA7bkD805XtPYC3g+nlZbQJc4nx3sV1Xqge8wiLNnDEy4+Xw1ugh9BG8cq/8NCt4WPbcdSEhQfXSrgA5/onqyW5XZU/H2O924b5ymRTZZ/iVnovfCfIPlHLrlj15bnGNmM6AZ2FtfWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265951; c=relaxed/simple;
	bh=fRwbGA03g/53T76h+WSxb7/SQGQJpScmKz94gfWdyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIBAV5xtpqAEDtBzD/HAnHK0lu13HOHSVOXTkbTBIJccg6RED4Nk8unYRidskyva03dZIr7MfIt9Zrn4TMp4iZGwJgcAUjdft5EcGl/D9H4O8N/ZY6ERcF4Y7+7UlLx1acFOGRKrQ+orAlmRdjIuBUNHOILi+knxUfaM0k56CMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of2xM9+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE39C4CEF5;
	Tue,  9 Dec 2025 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265950;
	bh=fRwbGA03g/53T76h+WSxb7/SQGQJpScmKz94gfWdyTI=;
	h=From:To:Cc:Subject:Date:From;
	b=Of2xM9+XIyZWWeEyxapquVh3G+Zza1DlpVZ9W3KUMqXxtmbezvwqjvdj8r3+8+Q2P
	 RSsLBxL+v4vr3SAH1RW+f/Hh0iH7YCjp/2rvOLMQSqAJDB2f6ei/eITmcXvE6jfWUA
	 67XyvprKmlRnke1xh6JYOLpxHlQHQG4e4Kz9tBXsZvPZitG2g/KI8SS+q2s+7UhvZB
	 /0FVDYDxKZqbLurnKhgrcxaKVRozaxLl/Gdt9XHvNi4YiFFbQ09EzpxpmfTL8DdjLa
	 ErnCO1L9Ps+gVZB+Yf+m3lGp/Fvj5Ph69Egivyjn+gVwlgCTrvc5GhS6JHXv870OFy
	 UnQLg2zSWm7bg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] Streamline TPM2 HMAC sessions
Date: Tue,  9 Dec 2025 09:38:58 +0200
Message-ID: <20251209073903.767518-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we cannot at this point cache names of the keys given limitations
of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
we can right now.

This patch set addresses two major issues in the feature:

1. Dynamic resolution without gain. All kernel sites have at most single
   handle to authorize. Even if this changes some day this is how it is
   as of today and we definitely do not want to dictate the future but
   instead downscale code to the metrics that we have as of today.
2. Eliminate at least one unnnecessary tpm2_read_public() call.

Jarkko Sakkinen (4):
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm-buf: Remove tpm_buf_append_handle

 drivers/char/tpm/tpm-buf.c                |  25 -----
 drivers/char/tpm/tpm2-cmd.c               |   7 +-
 drivers/char/tpm/tpm2-sessions.c          | 120 +++++++--------------
 include/linux/tpm.h                       |  20 +++-
 security/keys/trusted-keys/trusted_tpm2.c | 126 ++++++++++++++--------
 5 files changed, 138 insertions(+), 160 deletions(-)

-- 
2.52.0


