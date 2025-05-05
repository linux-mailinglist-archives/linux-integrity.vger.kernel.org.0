Return-Path: <linux-integrity+bounces-6130-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B26AAA85E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 02:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC09163565
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006E34D643;
	Mon,  5 May 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1KNwV/L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641C29B8E6;
	Mon,  5 May 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484794; cv=none; b=DqzFUykugImLyTVv7pyFOUgdvx/RTL0BJhgO/nrkSjE7xKe/j7/ZmxxVGR/Jn5wkmrmm5G0HrENg0OkDIP867gnGJ6k2Lye0DAsITnTKtWE7sBYFJQYTFD282UZ7DtqKQHoVBAcDSCtpBqxe4R2zaeDzvgeVQMhiL81BbfoWPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484794; c=relaxed/simple;
	bh=Pzar7iFHGx0C1ukBGapZnxhXD7NXDJvM+1AU/LbBr24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3sNtsrhW1Y5TszXfefMc9ikNLQD2EZP3b7SSpzLFRM41jMqpG16aSAlr8vWYpSZnqBmqMTJjpFmazRJGSKBx7zGN4yYDZTH84/BfBw3y9XrfnMxNAogdbrQjLlK6J1IwALpxhviCoRVUY+ISbR7D1BViGwYo+dS1mMqD6zoPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1KNwV/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AF3C4CEEE;
	Mon,  5 May 2025 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484794;
	bh=Pzar7iFHGx0C1ukBGapZnxhXD7NXDJvM+1AU/LbBr24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1KNwV/LGfZbKjTs0ZfHFnSfax3cqLEnhM9PuEWh4xrmBAPsaDsB9RuWwKt3Ydy1h
	 4Md2HanoW9ibCKVM/wu7LFo7e1zH1gpTLmHQJDSnur212UTYh9NA00G+Z56WLGehK+
	 I1cM05B+iC+dX/BYmJ4Qek8X2qyKr38HIPxjz+JUJy5IA0HF1LQ5AxVPkQQkwYfsLX
	 66dcPaIHM1FU9y7JlX4aDeS5PBkFscrY/Bj5YKF345ueAye9Wh5r/XHqAIKXM0hCXC
	 plkiNPn1voDfkLixjSmSOR5k+jXn4D7pCkJoIOx3KuReFWSPTE4bK+flh1t8Bx7dyQ
	 iq74XAMYPPOjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 018/486] tpm: Convert warn to dbg in tpm2_start_auth_session()
Date: Mon,  5 May 2025 18:31:34 -0400
Message-Id: <20250505223922.2682012-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit 6359691b4fbcaf3ed86f53043a1f7c6cc54c09be ]

TPM2 sessions have been flushed lazily since commit df745e25098dc ("tpm:
Lazily flush the auth session").  If /dev/tpm{rm}0 is not accessed
in-between two in-kernel calls, it is possible that a TPM2 session is
re-started before the previous one has been completed.

This causes a spurios warning in a legit run-time condition, which is also
correctly addressed with a fast return path:

[    2.944047] tpm tpm0: auth session is active

Address the issue by changing dev_warn_once() call to a dev_dbg_once()
call.

[jarkko: Rewrote the commit message, and instead of dropping converted
 to a debug message.]
Signed-off-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b0f13c8ea79c7..7c829de09afb0 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -982,7 +982,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 
 	if (chip->auth) {
-		dev_warn_once(&chip->dev, "auth session is active\n");
+		dev_dbg_once(&chip->dev, "auth session is active\n");
 		return 0;
 	}
 
-- 
2.39.5


