Return-Path: <linux-integrity+bounces-5838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37771A85AAB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7B87B56EE
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3780221261;
	Fri, 11 Apr 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="S7SW79Q9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F057278E41;
	Fri, 11 Apr 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368999; cv=none; b=RlUMbqEgoEArDh59s7u7BOwxmv7pVuFCUEOb1C4xG2lgaxaq/cYQ9DYj+/obCsB6QJmjsfPlKedhk2i0OcLgiWz1Yhd+LYKXfI10blvU6IoQs3kctBgvCDh78KVNv8BU4hTi2D0d9Gd8pRqGqeX4SbRcM2qAyY7doSedB5+ohPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368999; c=relaxed/simple;
	bh=hS8tQiKEMB/su+TOXT4QOpwnxLxBDvzzTd0CgutPTBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbTBxIoEvx4mSjBlHjocBZUS/mk4RwXIlj0mwDNXHGwhWt4gKsroHjMULxHJCLIhwWhmGskAL/BpysHgnT6westYHp+tpC13qXYWV4dnIjOfKFmWFuZz3PafURNFBHGJXr9li1ATwB7+awkmdrLB9E3p35seT1bpAa2VwWpvpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=S7SW79Q9; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744368977;
	bh=V4V3m9D93m7/64N9/8MnQi5QwU2s8DrpyNkKMdC8oU0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=S7SW79Q922ONMYBYEHZcqAn99Os4GQ3bcLbLLOF9Rfn2qPnoRI7hywnBI/wf2EhO3
	 8/Csbx8LFjzxd3mg93106uwmR25dXt7I+0P/F7PjityyV/ImAp9/kTbYqMgTCln+Mf
	 D5LysnNbQxCSxXPrI8qI+guFV8jlT9xqwM5bF+qg=
X-QQ-mid: bizesmtp23t1744368970t8864be8
X-QQ-Originating-IP: ew478SCyhKNuqsmH0zRg5i87XBYdfzy7c67CdcI4cqs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:56:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 915609387296721397
EX-QQ-RecipientCnt: 7
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Winston Wen <wentao@uniontech.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] tpm: add __always_inline for tpm_is_hwrng_enabled
Date: Fri, 11 Apr 2025 18:54:54 +0800
Message-ID: <D513EE4F40467A51+20250411105459.90782-6-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250411105459.90782-1-chenlinxuan@uniontech.com>
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
 <20250411105459.90782-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OC3CwsoFpuZ9mh1INc04VqNc/1WQudc/cfiBvNnFXQQudRui56PDnGdU
	Gw9835E7gqTzQA6KPmkOOVphCRkuLUvO8NfUmrsgtLFeRWB52QukI0QvFs/5Xx8somIsBpF
	sA9hpYNVVrYNrZ3izgO0DezxkeUgdu1tfnVzAWYOdX984jijZeDCJBiM7OftZQm4hU3Xgk2
	STiv559k79y1CYMMz5n90mjXn/5lVpbpSen1hVNttwgN9JKkYMPXr9BPtbDGmOPSaTBC84s
	QzzdIOxck7B0X8YXOVVDy1jvlIw0n817RG1huguhft7clJTJMw6fFEmTd1qjsAHKGLUIXCm
	2XYzFUh1zo3RGj7IBLylwp7cpIezugtD+x1GiF0Tz9dv+HXxeK702+3XKlWl5wpMt8ZWdGM
	IfjXRCwr5/zI18d1Wfvliri2mz0vorz6ni7vA8r+6IpR40UggiIlhx2FFoMEA+lISdqmRtd
	0aX+OravoFkC5dKQH68jJYAhnXi3vfpNay+gQOm6Sn/lGD/zvC8ydIEvqYWbr7Ceg2yuM89
	MDhCeVkGT9uYWAVy/SYhZ/qMI7JLfQnl0JIEcSADUtY/VpM3YnitO5skGR7nWcTstkjcd9Q
	h6AGWolYTNXtVIZo/GZ5aV8lNyx5k1Jb8uzu0zcuxz9TlFbc8DF/S/aVjkIdj/GaQUy2lcY
	2bpcnLkV/q3EbwlHSBHz4jQizZmw0PbQzXJsFLuMAE8WTDwbz/HIUnVl72yQ3Lh/+K4T6y6
	rEvpPDxKNC8s0e6Js53C8d2RX6epeKJgUBIwBd6pPQeid6eWkNJ6lj3RyutcXohBnuygqJh
	h5SykPsMGiqt55T+PW0NGZ8SRz3viTY8Shi3WkAOJSLY/RC/4XUuRaXgfnKfopFaodtIsrC
	kf/bTpKJIl/u9LUTe1xY8Jpv5PX/poTGrSiKuFI4m3/rl4aktr9YAF+ky44RqKeUgskGtAg
	tjnkT9+zRuYTrLwbYWna/ie22vunEzXQx5DOlS28VenloAqnYRWv3K0Zb1KX9X3ZCF28mHs
	iuhV5LMtdQ/oSvs5Q485fKlOn4M8B/5rhYOmBYrg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

From: Winston Wen <wentao@uniontech.com>

On x86_64 with gcc version 13.3.0, I compile kernel with:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_TCG_TPM=y
    echo CONFIG_HW_RANDOM=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"

Then I get a link error:

  ld: vmlinux.o: in function `tpm_add_hwrng':
  tpm-chip.c:(.text+0x6c5924): undefined reference to `hwrng_register'
  ld: vmlinux.o: in function `tpm_chip_unregister':
  (.text+0x6c5bc9): undefined reference to `hwrng_unregister'
  ld: vmlinux.o: in function `tpm_chip_register':
  (.text+0x6c5c9b): undefined reference to `hwrng_unregister'

Signed-off-by: Winston Wen <wentao@uniontech.com>
Co-Developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e25daf2396d3..48cc74d84247 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -534,7 +534,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	return tpm_get_random(chip, data, max);
 }
 
-static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
+static __always_inline bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
 {
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
 		return false;
-- 
2.48.1


