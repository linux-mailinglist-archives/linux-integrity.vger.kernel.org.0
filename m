Return-Path: <linux-integrity+bounces-6477-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3622ADFB84
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 04:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C1C3BAA0D
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 02:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7C237713;
	Thu, 19 Jun 2025 02:53:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69A2367D1;
	Thu, 19 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301585; cv=none; b=NqpDnU1L4UAhs1tfjVnMWiI1tHZEO0y6anwXKVATM0ISFfeQ5B85KIEO8U4XeSTUPSUyYa0b8aIzTzcDX0mq/g3uH0G5XyRlrsf4uOxrGBqTi41yKnOxgDQAfioSc10+hrt0NNZZsjiagaeK/AIb73bX+SaFY0rV25whogfN1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301585; c=relaxed/simple;
	bh=MEl+ZIwp0FazqpAfcXcXD6/juBeDei3hND4ow+STUIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2JUa0khp7bdbGZdLMdjcBfUH/+MJZSkvMx2RPQM28luie8p4apNQHP384ZAEp7hYUx7X9RgEtlr3Y2djloiAuELBwnDiHWoqgEBZKUAKz672a2c0Hhe7XCGa7hSF/tlRQ/WBgL8zGb6v7ATr+e0jWmJZSWdysdsckMXXcnk8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8Axx2mGe1No0o0ZAQ--.24246S3;
	Thu, 19 Jun 2025 10:52:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMAxj8VPe1NoOXYgAQ--.34847S6;
	Thu, 19 Jun 2025 10:52:44 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH v11 4/4] MAINTAINERS: Add entry for Loongson Security Engine drivers
Date: Thu, 19 Jun 2025 10:51:38 +0800
Message-ID: <20250619025138.2854-5-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxj8VPe1NoOXYgAQ--.34847S6
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurykWw48uF1rJF18JFW3XFc_yoWfWrX_C3
	yIq397Wr18JF1xKay8ZFWxAryaqrWfXF18C3ZFqw15Zayqy343ArykAF1xW3W3urW5uFsI
	qayxGrn7Cr1xZosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWrXDUUUU

This patch adds an entry for Loongson Security Engine drivers in the
list of maintainers.

Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ecb44458..23d889bca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14152,6 +14152,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 F:	drivers/pwm/pwm-loongson.c
 
+LOONGSON SECURITY ENGINE DRIVERS
+M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm_loongson.c
+F:	drivers/crypto/loongson/
+F:	drivers/mfd/loongson-se.c
+F:	include/linux/mfd/loongson-se.h
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
-- 
2.45.2


