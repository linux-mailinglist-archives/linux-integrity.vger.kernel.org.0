Return-Path: <linux-integrity+bounces-5884-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD94A8A726
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 20:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06033B2BDA
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAEC230BDC;
	Tue, 15 Apr 2025 18:50:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EC1F09AF;
	Tue, 15 Apr 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743020; cv=none; b=YMvNaCaIECQ+Rsyd/+jfzgbAWjcY+37Ttq1T4r5HjaUrVVASAbCRj445NTQ+PkUClBq/EQTej/fcjevQbvtP3My6JoJYV2rSymLkk7adhcy01/yugpuYyjPzeJ0Evn2Rhl02uG/BtfhzYYc7OCjnG969ZM4hxusUuQuIAFznsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743020; c=relaxed/simple;
	bh=a7I+68q4zrbtrqijgaqWDnQ51rlUQ/jQ0xoqtmi8Itw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dT+LLQblimHP1de5D7/dJwtY9PdR/DMOD9wHF6KSBAWd4cXTpOov86skwAyaU8ixHKqzs8FOKsovoRrFAxAIJDkzoL1JvdFpvwXqK1Mjuwhz9rxZDZ06ppVX5uZ6pNRpC1KlCi3ANc9bXvnnzNwrgjg9xUfq2g0GRZ3m/iytCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C584F15A1;
	Tue, 15 Apr 2025 11:50:14 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 350F03F694;
	Tue, 15 Apr 2025 11:50:15 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com,
	sgarzare@redhat.com
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 0/2] tpm_ffa_crb: add support direct message request v2
Date: Tue, 15 Apr 2025 19:50:11 +0100
Message-Id: <20250415185013.2387369-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports to access TPM crb buffer accsess over FF-A via
direct message request v2 ABI and include small fix.

Since v4:
   - rewokring with commit message.
   - https://lore.kernel.org/all/20250415075712.2157073-1-yeoreum.yun@arm.com/

Since v3:
   - replace pr_xxx() usage to dev_xx() to print log.
   - https://lore.kernel.org/all/20250412054721.1647439-1-yeoreum.yun@arm.com/

Since v2:
    - rewokring commit message
    - https://lore.kernel.org/all/20250411090856.1417021-1-yeoreum.yun@arm.com/

Since v1:
    - Fix indentation.
    - https://lore.kernel.org/all/20250410110701.1244965-1-yeoreum.yun@arm.com/


Yeoreum Yun (2):
  tpm_ffa_crb: access tpm service over FF-A direct message request v2
  tpm_crb_ffa: use dev_xx() macro to print log

 drivers/char/tpm/tpm_crb_ffa.c | 63 ++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


