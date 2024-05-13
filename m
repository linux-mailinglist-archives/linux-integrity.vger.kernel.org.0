Return-Path: <linux-integrity+bounces-2371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017048C4186
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928F71F22BC2
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022F1514C8;
	Mon, 13 May 2024 13:11:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A81509BA;
	Mon, 13 May 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605911; cv=none; b=pVNXQP1pydHIA/DYo7rbDGL8Mp0qE9iuvOx1xv4ZyQhLwPnv4xbq2TcfYFjTq4Qaq7NSiW/g1POP/aVBmrYxUDQx51tEa3iFIbP8qGiKW4JQXLWiyjt9yyKicH+PPt6n9uC4GDBuWno6YhZIYUtKqqeSXVNsJqYKt7vl78vIhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605911; c=relaxed/simple;
	bh=X65G6pvRWIYGrSvOefH5o342aNX3aFIt2fxYbtFpp9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJcjONIEvss1fdyoIkDLdovPJbwOno5KIW8pCqKZk6GNUcvBxulz2srScEm+4uafH7qMmDFU5UJ68Trcc+s/+2QPcC7JE5Q+QumH/dRkukUc4FSrww9jlYMrIFtlMpAbddXNMA2lNl2NWbfOnuA+zNtXDQIphujHlNvQRCK/OoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdK8D3GkWz9v7JW;
	Mon, 13 May 2024 20:50:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CC88B140428;
	Mon, 13 May 2024 21:11:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC38SV9EUJmnBMTCA--.48417S2;
	Mon, 13 May 2024 14:11:37 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: x86@kernel.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	keescook@chromium.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] x86: um: vdso: Disable UBSAN instrumentation
Date: Mon, 13 May 2024 15:10:24 +0200
Message-Id: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC38SV9EUJmnBMTCA--.48417S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5AF45XFykAF13ArWxtFb_yoWDZrbEkF
	WIqFZ3G34a9397A3y5GFWYvF97Cwn7Arn3u3y3uF13tay5Xas7GFsrG343Xw4rJF9F9FWU
	WF93ZFWUXw4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5lAMQADse

From: Roberto Sassu <roberto.sassu@huawei.com>

The UBSAN instrumentation cannot work in the vDSO since it is executing in
userspace, so disable it in the Makefile. Fixes the build failures such as:

  CALL    scripts/checksyscalls.sh
  VDSO    arch/x86/um/vdso/vdso.so.dbg
arch/x86/um/vdso/vdso.so.dbg: undefined symbols found

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 arch/x86/um/vdso/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b86d634730b2..ca79c0de582e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,8 +3,10 @@
 # Building vDSO images for x86.
 #
 
-# do not instrument on vdso because KASAN is not compatible with user mode
+# do not instrument on vdso because KASAN/UBSAN are not compatible with user
+# mode
 KASAN_SANITIZE			:= n
+UBSAN_SANITIZE			:= n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT                := n
-- 
2.34.1


