Return-Path: <linux-integrity+bounces-5933-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C1A93554
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFA54A0A37
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A86270ED2;
	Fri, 18 Apr 2025 09:32:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010C204F78;
	Fri, 18 Apr 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968769; cv=none; b=a9R3CJUU2xPG5TwjufVRsvdm7qi7ph0pvm+knAf6Q0E8g5WO7kEgyaE8qW+AXtRI42iyEqtldZPLnv+KTsak6lCJOyQS2BHBPwUT2hdQe0PB0AB0bffxXJNeZSOLi4XmHfraI1yx4RJiDCKX73jC4nRgUWaJYqZMJh1DUpZ1KU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968769; c=relaxed/simple;
	bh=fQjE9WiFTrVqd184wm4Say81OBGlALD7UvJAJwESn+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEEkH24DQ9bTbOdcmkeeeUitZa5RPYAK+YWqhhmsdOem5h9tsyrbadSRfkc2r4FRHz/T8hwtQmmbLlypwZDDKJIb3iiucD2UZypSA2Ge6994jD4LF71SE1EJPXv7ohbCT3QFcx+Nn+7dvg4HyU8EwDXhfgXLGN3DrfVFazoUY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8AxbeI5HAJoQaLBAA--.20630S3;
	Fri, 18 Apr 2025 17:32:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCx_cYsHAJoGUKJAA--.15831S5;
	Fri, 18 Apr 2025 17:32:36 +0800 (CST)
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
Subject: [PATCH v8 3/5] MAINTAINERS: Add entry for Loongson crypto driver
Date: Fri, 18 Apr 2025 17:34:05 +0800
Message-ID: <20250418093407.1335-4-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
References: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cYsHAJoGUKJAA--.15831S5
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFy7urWfGryxCFyUtw4kZrc_yoWftFX_A3
	y2g3y8Xr1kJF1vk3yv9F97ArWavw4fX3W8C3Zrtw1Sv34qy3s8AFyDAFyxGw15urW7uF4a
	9an7Grs7ur17ZosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU

This patch adds an entry for Loongson crypto driver in the list of
maintainers.

Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v8: "RNG" --> "crypto"
v7: Added Huacai's tag
v5-v6: None
v4: Changed tile to "Add entry for ...".
    Lowcased "Maintainers" in commit message.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c59316109..a4726df8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13912,6 +13912,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
 
+LOONGSON CRYPTO DRIVER
+M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/loongson/
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
-- 
2.45.2


