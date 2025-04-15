Return-Path: <linux-integrity+bounces-5878-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68398A895C2
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 09:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0E018957D5
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1115274671;
	Tue, 15 Apr 2025 07:57:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443C2741D6;
	Tue, 15 Apr 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703839; cv=none; b=sJoE+MYMsa7vWqgzqBq8yydUOPmHSPrbI7/QLwZkEhalwM+QTjoCRgwc9AmnqjY1JpdLoYN0Kko9nKGKOcuPouoWMRZYEvKppfEoDV3zRDHU+vNOwnul6zKt/rHmlYLbugjHUGcYLgUPiCQytW1IAFpe/U2haut/eeH/5++H8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703839; c=relaxed/simple;
	bh=18lRI/Jc+UaPMYFTV9F8ZB92h/nnBnkg0XHxkTcKNK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDntzeaTcqcZbqKVB8/R3WumxnYl4y5ykKLME3szglMIuIGOK5TSH61Ip6Mw/+Muq05kEmESpHxsjfE/D5HmjFOm19t8GSH4iwo0moWRDSGqe1sdRlP0YX88MXkLOeZ/he7fOwqkzMXJ2YEhIHBJTGZIXO+i66ROkcZM7D2epnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8A72F;
	Tue, 15 Apr 2025 00:57:15 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3E343F694;
	Tue, 15 Apr 2025 00:57:15 -0700 (PDT)
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
Subject: [PATCH v4 0/2] tpm_ffa_crb: add support direct message request v2
Date: Tue, 15 Apr 2025 08:57:10 +0100
Message-Id: <20250415075712.2157073-1-yeoreum.yun@arm.com>
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


