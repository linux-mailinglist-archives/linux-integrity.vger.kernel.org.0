Return-Path: <linux-integrity+bounces-7536-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C8C12A27
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 03:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2458C462BD1
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 02:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2140855;
	Tue, 28 Oct 2025 02:09:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1352192B7D;
	Tue, 28 Oct 2025 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617378; cv=none; b=QGshW9vNiQJ1UnmuaH0PDjD5Ynj5HrLlvEXjEX9OSQ5RQ/dD4o0NllKQYZ+xsH3v+DHpWOXlRhhiONLztR6bH22N4D/XDTDnxtYzD4SRQoigDiMUuVd3mK6pq1Dz6FIH9OSa7YyRmFp7T6vquoOTNNTaVlnL9ZpSTI9sMPOVoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617378; c=relaxed/simple;
	bh=ynaihyXFtzTuHdEqhczTTlhBJVZmuleW1RFH0U7dwQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjKEdVxEvClyEfHoEicMTArU7LDoseh5ZRWUa4cWim4zgBH8fJswnE0hNDDHz0RdVyFgq0BcekRWQgQ/GBMnUp0UHPH2MBdfSdplFRCRxxaVXG32HEJUh6LrUB4gLvBLJ/sIChup4GP731XKbcR1xF5IUQlMTwzR9tgXkVyHAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9146B152B;
	Mon, 27 Oct 2025 19:09:22 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C3CA3F63F;
	Mon, 27 Oct 2025 19:09:30 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_crb: add missing loc parameter to kerneldoc
Date: Mon, 27 Oct 2025 21:09:21 -0500
Message-Id: <20251028020921.214189-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the kerneldoc parameter definitions for __crb_go_idle
and __crb_cmd_ready to include the loc parameter.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index c75a531cfb98..0eb48429f73d 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -179,6 +179,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
  *
  * @dev:  crb device
  * @priv: crb private data
+ * @loc:  locality
  *
  * Write CRB_CTRL_REQ_GO_IDLE to TPM_CRB_CTRL_REQ
  * The device should respond within TIMEOUT_C by clearing the bit.
@@ -233,6 +234,7 @@ static int crb_go_idle(struct tpm_chip *chip)
  *
  * @dev:  crb device
  * @priv: crb private data
+ * @loc:  locality
  *
  * Write CRB_CTRL_REQ_CMD_READY to TPM_CRB_CTRL_REQ
  * and poll till the device acknowledge it by clearing the bit.
-- 
2.34.1


