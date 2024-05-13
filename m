Return-Path: <linux-integrity+bounces-2365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6508C40BD
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCF1C2128C
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A614F9C6;
	Mon, 13 May 2024 12:28:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D514F103;
	Mon, 13 May 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603318; cv=none; b=D+6wZJ9+NNQFrdIzA3SutNmkHxcbbTDIDabNJFhF3NRG+9BW3/Co3gTWD/af+b/0xawkvNYBwu1YTta7FPpf5eP3xyBaMFl9yGJMD4QZ80k61K8knP8Hs2/w+Wpg2fXh56JD+RYWOl/TUbBA99aI7QykT2amNbx592QVOphtzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603318; c=relaxed/simple;
	bh=efjpt6jyTPgyfXiPmrHxNy4PR/jcYioYANo2ECrW7Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t2OFRr7dn4RXivf/thHlqeUspwic43i6ym+1DNF1LFb1SFC+xJ+yirWPTFByq+wsq5Wg/d3C9MUHxOqJtAdZDxukCWz6KD/9DtKNkhkjRuuYdClJ4h46jR++fvokU8kw4YeRowkEDfnc9Ae3/GzucmdFUZNlaiL3w6kyDmziYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VdJHf1KQxz9v7Hv;
	Mon, 13 May 2024 20:11:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 547F5140381;
	Mon, 13 May 2024 20:28:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3LyRfB0JmiJMSCA--.46264S2;
	Mon, 13 May 2024 13:28:25 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] arch/x86/um: Disable UBSAN sanitization
Date: Mon, 13 May 2024 14:27:54 +0200
Message-Id: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3LyRfB0JmiJMSCA--.46264S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW5Gr4fZw4fur4kuw4xXrb_yoWDWFgE9F
	WIqFZxJ34fZ3ykJ348KF4YvF93Cwn5AryS9w43WF13ta15XF97GF4xG343Xr45J3ZFvFWU
	GF93ZFWUXr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5k-yAAAsb

From: Roberto Sassu <roberto.sassu@huawei.com>

Disable UBSAN sanitization on UML, since UML does not support it.

This fixes the error message when building the kernel:

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


