Return-Path: <linux-integrity+bounces-3632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD997C0C5
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DBE1F21558
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 20:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C321CA69A;
	Wed, 18 Sep 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLiiRii3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036D17E019;
	Wed, 18 Sep 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691767; cv=none; b=tPWjCmGTO6y1c1uebcTL/d7RFm/JRoYYvc/0M/rH2aYSPKG0z7QM6WgbZCUlm6ylWKUxfAj2ED9qyYgw9ArIVbr016nnRVFvLVlj2un6NGpouW0/gIaL0tdNWqkkK3UKFEHcQxMu1VN44NhzRKZWrG0Wsir29gdSkCApYjSIi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691767; c=relaxed/simple;
	bh=bZjsGt2Pe4l16jCjFZuojXhJsBQT5BkyvpLMlnl2ZRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiQuPj4yK1Xm4VZNgXP2cP3xShY3Q8wY2gEjzYRA02GaP9NMk313VzEN67NCUyFYB4eKwVBthikk2RFIvoenA1hTYtPM7nag7xzvH8ioj/b2AdpZx6+t0umJdKzo2QokSgFBBoBbyrgfaQPDPMyX8quc5YyVUQln7XnijPmTPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLiiRii3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DEC4CEC2;
	Wed, 18 Sep 2024 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691767;
	bh=bZjsGt2Pe4l16jCjFZuojXhJsBQT5BkyvpLMlnl2ZRc=;
	h=From:To:Cc:Subject:Date:From;
	b=HLiiRii3N5eUiY8A10VZp1df1SjzgZnJNsmCnN4pYIvOo3U0kRWg8jjq/7JSAu1sA
	 0oPnS05GARDUMyQTAI7KlfF4dkNv424DsMNe2ZSugOCTMxVa1LEmiKZUPRWoN8iTEk
	 g9VfDu5/lW1NYyW74K9uBKI9gmL1mVTja791AtcCV4iWM1ll/OvuVYWT+CHQfjKX6Y
	 GPnUtqsmcqu9WpMSxmd4Sq6X0SxFJxdSwmwYjNzg+lkcbzr7aLxhH7DnSokAjxGK9a
	 xw6KHVbQW1acU0kL+s2gn14R7hnaYpfV8Wz8OHLUINqo9SDLQLHNMGjsvV8SLv9dFN
	 ydVBH2LU5jNVA==
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
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Lazy flush for the auth session
Date: Wed, 18 Sep 2024 23:35:44 +0300
Message-ID: <20240918203559.192605-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of:
https://bugzilla.kernel.org/show_bug.cgi?id=219229

The baseline for the series is v6.11 tag.

v3: 
https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
v2:
https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
v1:
https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (5):
  tpm: Return on tpm2_create_null_primary() failure
  tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
  tpm: flush the null key only when /dev/tpm0 is accessed
  tpm: Allocate chip->auth in tpm2_start_auth_session()
  tpm: flush the auth session only when /dev/tpm0 is open

 drivers/char/tpm/tpm-chip.c       |  14 ++++
 drivers/char/tpm/tpm-dev-common.c |   8 +++
 drivers/char/tpm/tpm-interface.c  |  10 ++-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 109 +++++++++++++++++++-----------
 include/linux/tpm.h               |   2 +
 6 files changed, 104 insertions(+), 42 deletions(-)

-- 
2.46.0


