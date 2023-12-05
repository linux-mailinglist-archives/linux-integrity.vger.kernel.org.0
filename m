Return-Path: <linux-integrity+bounces-351-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FF806284
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 00:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D7E1C21108
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Dec 2023 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3E405D7;
	Tue,  5 Dec 2023 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ixct9+YK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EDB5;
	Tue,  5 Dec 2023 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=veuA5jcJpJK6ZOBUYJpEl5tEQ5a6kyp2AU4+606vnO0=; b=Ixct9+YK621xO+NHLV3Bl7IpTW
	RD2TXwUyTf9T5SoFN4RP5+r0GpMXDSzhPaiPhIaMQj/bPyZY8YgfAj1La7E6qd2VvqGY0S1ut3BY+
	3o1iMIK9VRhWQqZUrMYqplKosgXALBP0NTTenE1BPFmFdyHsHZGbh/MXk1MOx12278cmx7N8ClhF4
	bZY55cHSyq+XQXIF4l9R2k3DUe0eZLlPMk2ROb8SYuBtIdFl9vXufyEdK4sfSwx1MdpLvFxUxbYAn
	DD6VqLrOYtaiaSw0uRZO9M4kXFcoDqWhoVUv8PmxJDdFpac5mPf0eznPqzMatOW9cDEM3hpXdGN0o
	dQ14unRA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAePZ-008ZJ8-0v;
	Tue, 05 Dec 2023 23:01:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: cr50: fix a kernel-doc warning
Date: Tue,  5 Dec 2023 15:01:04 -0800
Message-ID: <20231205230104.414-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropn one function parameter line to prevent kernel-doc warnings.

tpm_tis_i2c_cr50.c:681: warning: Excess function parameter 'id' description in 'tpm_cr50_i2c_probe'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -671,7 +671,6 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_matc
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
- * @id:		I2C device id.
  *
  * Return:
  * - 0:		Success.

