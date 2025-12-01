Return-Path: <linux-integrity+bounces-7753-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E1C996A2
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 23:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E8A3A2990
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03410245005;
	Mon,  1 Dec 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEZyLKtn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE28F5;
	Mon,  1 Dec 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629164; cv=none; b=mC//F04rBQTFEtmX/FPGFNB3cwtGoHmmi3Tl5TQYbT8DVflGIgitWhqIqk0YhLXdAC2EccpdMGyMn2IpdN+5CGy1QtlyYaYo3fVowALmc4XFk/LZ3FQXYr/YbdQfp5Iz5r4LIMbhf7g/ntENQIfPFkEO4JwIEoXX83+lSGduhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629164; c=relaxed/simple;
	bh=BplfthfVZBJifzGibrvU0QFx7UYQ6CE9kJk6ECBHvR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFEcJBYCzsKUyW4xAtgCUGh7Op4IlpI8Lgzx72EGLg6CnEo1yAhk+HOX5nVJhGqX/knIm1DHp7mIZ9zus6yu9/XDTAaKAQV3gbdDy/Q7v8vIir7KPwx/7Ww0W+JOYJIRbjEwNrNoUOJx7PEsAuXBCfLQaEHC1RRpT52dviFcQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEZyLKtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CA5C4CEF1;
	Mon,  1 Dec 2025 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629164;
	bh=BplfthfVZBJifzGibrvU0QFx7UYQ6CE9kJk6ECBHvR4=;
	h=From:To:Cc:Subject:Date:From;
	b=QEZyLKtnMdc3TKFFbcxspBCQIGs6GAbSVQBSfxYx43mH6cMahXg7/PrWVQ8klseW+
	 lbqIDA2Og8kF/YoqTKUZsk5l74MK0S9mH2paM5q5BcrKYye88DCeUBKCYbeo7IhsNa
	 9275umVIPfMXh0q8vePFYtqQilnEvT28vjLO1XTTRpBBPi2ODVltjTiB1rScrjnBoQ
	 kRuBnMleKq8WJDXnPbqXYdUF7vzlDa/EiCL7wR9Im6liTBw1nDey0cRPbGLgGP4pCZ
	 EJMvi7CmzynXmO8iUhmoX+maVE0ONETC/z/SFl248CM4HbpxmPSImUm+GOcL/Hlx5n
	 MS8t4oAGvBISQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] tpm2-sessions: Fixes for v6.19
Date: Tue,  2 Dec 2025 00:45:48 +0200
Message-ID: <20251201224554.1717104-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I collected the accumulated fixed for tpm2-sessions, given that I need
to still redo TPM driver pull request.

Jarkko Sakkinen (4):
  tpm2-sessions: address out-of-range indexing
  tpm2-sessions: Fix tpm2_read_public range checks
  tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
  tpm2-sessions: Open code tpm_buf_append_hmac_session()

 drivers/char/tpm/tpm2-cmd.c               |  42 ++++-
 drivers/char/tpm/tpm2-sessions.c          | 197 ++++++++++++++--------
 include/linux/tpm.h                       |  31 +---
 security/keys/trusted-keys/trusted_tpm2.c |  41 ++++-
 4 files changed, 197 insertions(+), 114 deletions(-)

-- 
2.52.0


