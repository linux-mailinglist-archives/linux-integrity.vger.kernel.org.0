Return-Path: <linux-integrity+bounces-7765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59FC9CE5B
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 21:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA883A13CF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F82F12D4;
	Tue,  2 Dec 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1zURBHL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD802EBDF2;
	Tue,  2 Dec 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707210; cv=none; b=lI+jzqpoqBHBlmMfbQt8mNLTfqp1woLReaNJ27mXxi9NGj/d6T9uVVcQ46qR6UyVSxpTM6lGVue2yHy4OUYG28GciNRZP3bORSLRvfDsE7uOQPfCtsvhdQUV+ovAmFQAcGwRUwd3OVsW0RtiQXL6PODdPtcVT2pKyHUB3Ke5YFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707210; c=relaxed/simple;
	bh=pKOQzQHHRIg27uVLZjs7+e9ttWImLbk/jV/12YgkW58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3CHTDm0klEmh0hnOZBxb55p1rjfRHU3Asy/ZZa9lkYvi9Ev/1kgDqUBEOlcx+iCAorkurdqxBY2CxhlE0ONSSrVM9uAwDd/ZX98RQgdmAHKISP+QgCZCouLHqQPm2g/QDpFO0V38rcNhvcNNW3BZX6JKGsHNjB8UFnRjL5wmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1zURBHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E15C4CEF1;
	Tue,  2 Dec 2025 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764707210;
	bh=pKOQzQHHRIg27uVLZjs7+e9ttWImLbk/jV/12YgkW58=;
	h=From:To:Cc:Subject:Date:From;
	b=V1zURBHLovFlA5czKYrkDxfDqpJdMXS5TP9y4D0U9ynQz1pXq0cVRvkBOCVdx7rGJ
	 HWDV+ME1YTS7tHqkjgLcic/x71PksvCLfHDBvmducR5cDrI2DSkrg5FxsLMQAMuAdi
	 a1TVJjsnwe12PLdV/PV7V5hSlvUF1f66PvNEPWbxy0CqWQYyMT2NcbDu5/yrf2hDyl
	 BuDRzqaOMv29hZBvfefHzFm+Rr7GjPw1+lc4QPUhKYSojg0EFqtiDxy+dmhj3gz1EQ
	 RVI8KDQ1tvyJTQj4U69xJ2IsNNITQtUk8ofSrmU6APwJZW00tMoXd6AaNfLoImaAkI
	 3RFMWeoxQhsHg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/4] tpm2-sessions: Fixes aime for v6.19-rc2
Date: Tue,  2 Dec 2025 22:26:37 +0200
Message-ID: <20251202202643.107108-1-jarkko@kernel.org>
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

v2:
- Addressed issues reported by Jonathan McDowell:
  https://lore.kernel.org/linux-integrity/aS8TIeviaippVAha@earth.li/

Cc: Jonathan McDowell <noodles@earth.li>

Jarkko Sakkinen (4):
  tpm2-sessions: fix out of range indexing in name_size
  tpm2-sessions: Fix tpm2_read_public range checks
  tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
  tpm2-sessions: Open code tpm_buf_append_hmac_session()

 drivers/char/tpm/tpm2-cmd.c               |  42 ++++-
 drivers/char/tpm/tpm2-sessions.c          | 199 ++++++++++++++--------
 include/linux/tpm.h                       |  31 +---
 security/keys/trusted-keys/trusted_tpm2.c |  41 ++++-
 4 files changed, 199 insertions(+), 114 deletions(-)

-- 
2.52.0


