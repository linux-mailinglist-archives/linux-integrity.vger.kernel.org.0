Return-Path: <linux-integrity+bounces-5937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC20A93561
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9ED1B65DBA
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27276270EA2;
	Fri, 18 Apr 2025 09:34:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E2204F78;
	Fri, 18 Apr 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968862; cv=none; b=uMlYRNHy4dnk+hdBO/t25eWvwH9+K63PVBjZkk3mev0mcCF1oHqSmVogCq65mTY7FjS4BB2TUwKuCoiTr3oPDGmqGb8iPNijDGM8/HVv3gkvH8Sy8Ce1qlCeMxkpcnq2scOQVtv1qveHf8VwRbzw/UayicqmKAEV1BlCAXdRyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968862; c=relaxed/simple;
	bh=hrpcTytiLAurxxX1yrL4qNQ146cijwzFSzKIOnUFEqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1J5CZH6fb3rmxmafGuSfYkgKfg3btuZlt/MbHrV32rER4NclT5KBIGU20YBfJwhMx6yxzsm5iRnygBam2iYO5qCKwZ/9Kc3y7oN9uF7zUJXzRjIrrDoepX1KOmPQ/OgCrEv3ZqTCdUpnb6HI058PmqjE6onMIpHdbw9dtCdgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8CxieCZHAJo2KLBAA--.14626S3;
	Fri, 18 Apr 2025 17:34:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMDxPcWUHAJoyUKJAA--.11173S2;
	Fri, 18 Apr 2025 17:34:14 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v8 5/5] MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
Date: Fri, 18 Apr 2025 17:36:00 +0800
Message-ID: <20250418093600.1363-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPcWUHAJoyUKJAA--.11173S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFyftFyrAF48Jr1rCw1xJFc_yoW3ZFc_Ca
	y2g397Xr1kGr1I9asYvFZ3Zw4YvFWrJ3Wfu3Wqqw1fX34jyr9IyrnrAF4vk3W3urW5CFZx
	ua97GFs5Cr13ZosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7
	McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUUUUU

Changes to Loongson TPM driver would be best reviewed by the Loongson
crypto driver maintainers.

Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v8: None
v7: Added tag from Jarkko and Huacai
v6: "tpm_lsse.c" -> "tpm_loongson"
v4-v5: None

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a4726df8f..eb99b7a66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13916,6 +13916,7 @@ LOONGSON CRYPTO DRIVER
 M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
+F:	drivers/char/tpm/tpm_loongson.c
 F:	drivers/crypto/loongson/
 
 LOONGSON-2 SOC SERIES CLOCK DRIVER
-- 
2.45.2


