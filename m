Return-Path: <linux-integrity+bounces-5229-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A0A5C233
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD16188EF19
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807D156880;
	Tue, 11 Mar 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Do0mxjPQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044C5680;
	Tue, 11 Mar 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698988; cv=none; b=cbIARI/EI6EQXytKBq1CyvRiox9DYeZjnMTpi5l7o1Si6u4t2B2AyctBTwmZAmsWyP3bfp2f2ZtWZhxE7aesFyrxCxmiHaasQe5RoA0/Unez2JLBA+ukcluj18az+PDRuw+1nROVV8uwRPo17s05ZAeh/hdJjVui2oCw6aO3YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698988; c=relaxed/simple;
	bh=UMlmsuVO6GEF8DdJQdsYePJLIYfHJRb0hZjOvxykXng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LamLNtMrl1ESS7lD1g6vvqcdeEB56UZgLEfGtS71Xj5fF05pxiFNlf/sJyLB3WpBPMQJbARGCFIxBLGpu3G/RQavEe8gaSzmfOQilYOySbUBIF6GrvC+Vwnovs9BFuAv0oCMuWk3SX+y2MO33jzB26LKbvbQMmGv4o6U4tAH7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Do0mxjPQ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741698896;
	bh=bqsJB7Ukp7U/upUJDVCAC/kv30cLNFALcWDC23R8Y8Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Do0mxjPQKX9O8nFHK5mNdG78DZDiKc3CRospvZmXZLh6OZKEXkgsVOO8o8AL5/OJy
	 VdE+xEjRS2a5F8C3KBc7J5qHFNC4TEOSVtbhl0n9VxpT622wxNdlqM6YSHEMMnMza3
	 NDqXVlOzBj7wnZog3c38rpgr1MYqBPaQt8flvc0s=
X-QQ-mid: bizesmtpip4t1741698889txnqiw4
X-QQ-Originating-IP: 38TNyXAdpG1cQvPev52XGYHqr0JmBM8kEIh2CHYNCYY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 21:14:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 952616671164402820
From: WangYuli <wangyuli@uniontech.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	stefanb@linux.ibm.com,
	ardb@kernel.org,
	roberto.sassu@huawei.com,
	viro@zeniv.linux.org.uk,
	gourry@gourry.net,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] MAINTAINERS: Add include/linux/tpm*.h to TPM maintainers
Date: Tue, 11 Mar 2025 21:14:40 +0800
Message-ID: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: McJfg7Aee/FZXzDXxt8QEVnoUM6dxLzdt0aSVPOgc8ZQ2DH9QYyMyfiQ
	wmywPojbpABIQ6PL/cr4gbr+ptnZbaUz4+mYbPez/XniOi10Aig+OjXfUSrXMrNOSkBqGGD
	GKr5fyEx2u/XVvDQPGXFWCQaAxFWv0Pd7pal6LpPqgZBQM2GX0+2a/eWx/DwyuJzdMqypuX
	jYsljs/nnK/d+d3gZMJTRl4q5d9gkPzlKjAHOGI/sO8Ctl0P9389nRYYioeJ7cxWJEgRP2I
	zNchFFGid7IH724JqqRs70iBVd/YdgybethcmoY6pF40DdHPe+lFMdlDXx2/vQhgK6Qp4qA
	IAFTUMr8fHPU6ud9j7LyGB3Ci1pck5Ufo+H+QUK5gAJeTWMHUNoKs0k+NIZ9KHXDgys5NJT
	wiAU4jmxxnDM6OYGpOyPewemzLyzuELYxTwMYBZwoXiiySmrBDlhCsvY813sqtt06IFMFSv
	3UjlalD6jLZeu8+IPGLRu0uUItUCkpuaVOu7IE1vX1byIvagZNG+bSE57HdOS4yLYDqu/CU
	S3SqpfLWv3xY/5vv01tTXcy1J7zunLZwheDXM3+/vXQBwBOfiAtxf2JnMtjl9y/jBvVnZAZ
	EdErxAVXh6nA4M+PgoEMkbLw2SPy0MbC55fqivq/QgFZIfhAsPdKtUyO3t4iPOwVkNSdf+m
	W3V9auFUlqBKJj0rV7A9GFmYkT/pkPdiSBT4+ginE583Soo0QER+KVH1sExPXlhZYP2bOVK
	QAirKo6+wcpTGWOdXHRLxVWEbFZmn6QKian/zmQGnHDBxQ41h5phPVkrVhFfxPCKFxNG/PX
	jhH9Tu7L9+WqPJ8FHH2JJAZOfg6uUbCMDbNoYeIXHqO8muEMKLI4A6nTAcePZ5sh3IDEZoG
	boL2ooc7QdESLfoND7V+jjWBgGoBnj6okZRM2JdrTeA1QnrJZKNmsu6q586Flhiiq6sCUGm
	VWgSp0DJccHTs1u7kmQisLcX2ZGkzgEQ6XjYTLr7SWeJZad4tpik/RAWB
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

As of now, within include/linux, there are three header files
pertaining to the TPM driver: tpm.h, tpm_eventlg.h and tpm_command.h.

Upon investigation when attempting code modifications, it has become
evident that these files are currently without a maintainer.

In light of their intrinsic relationship with the TPM driver itself,
stewardship of these files should fall under the TPM subsystem. So
that scripts/get_maintainer.pl can provide more accurate output

It should be noted that this change entails the omission of some
commit_signer and author entries from the scripts/get_maintainer.pl
output. A list is provided herein for future investigation:
 *tpm.h:
    Jarkko Sakkinen <jarkko@kernel.org> (commit_signer)
    James Bottomley <James.Bottomley@HansenPartnership.com> (commit_signer)
    Stefan Berger <stefanb@linux.ibm.com> (commit_signer)
    Ard Biesheuvel <ardb@kernel.org> (commit_signer)
    Roberto Sassu <roberto.sassu@huawei.com> (commit_signer)
    Al Viro <viro@zeniv.linux.org.uk> (author)
 *tpm_eventlog.h:
    Ard Biesheuvel <ardb@kernel.org> (commit_signer)
    Gregory Price <gourry@gourry.net> (commit_signer)

In passing, also include include/uapi/linux/vtpm_proxy.h for TPM
maintainers, as it is facing a comparable plight.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed7aa6867674..4a7b2e8b97de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24037,6 +24037,8 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	Documentation/devicetree/bindings/tpm/
 F:	drivers/char/tpm/
+F:	include/linux/tpm*.h
+F:	include/uapi/linux/vtpm_proxy.h
 F:	tools/testing/selftests/tpm2/
 
 TPS546D24 DRIVER
-- 
2.47.2


