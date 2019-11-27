Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4093E10BEBF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfK0ViY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:24 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34594
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfK0ViY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890703; bh=ZjuBNInN/g4FMmABgmB15RDd9FJ/VNmRPUEUXkskYc0=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=O2tStxrpXemu0yOG2c+oIxP88hAXxAsKl6HTyrMjPMutE9VSb5wwD4j5LjOhA2nVLoFrV9KN9n4NuAUsisxeZ7plfUb9GQnH6U4/XoMoERcv/yPJ1qo5+melSNHDPpiNmliwBxiIVNe1AznbKCQWdz/rVqba5am/lRQYcc1lVY9L/Xw7wo77SnWmPQeDBBKEasE1d9XwmodA9Zht/bBHNPkc/aIDNPYfy7ZyxAm1d0aFxxY6MCH3eUXNTPzYXdw1yEaeq7hIpxusoIxTitCRz1PY0AYCokKgu35NVKY8J7grCJJOquR5oJeaM0OAjQfmQVrHo5PYaKR+9JRW+RoDqQ==
X-YMail-OSG: x7fRHd8VM1nBwKU_5B4m.vNbd5VecT_VPbhikyMJ2pk8fazCXgPqRYP3CX1z1mg
 uDszajVW2OE56QE5npX80HLS1mthOzv6d.d2I1lxG3Du4UeUtJ18NCRzNYE.t1ukVDVHvBj6Xg_p
 NwqYoKGl0jYAYiRBeLxhAr7ApEP7ep_W5xYE5OO3T2qUXt.bpCaMa3BbN5.bHlPIvbfMvgWIsF8j
 lITPBnb42haFKtw8XrT7ALKUd9MXydoI0HCPUTtb4TDu9pYSetUXlzkSE4tPPVovzgSG2bRNdzm6
 7Mhjy6HAVpVWIfeHX18irc5AVVf1nIcPkXbdzGaGiLi7qX4an_XO9rrLjbFFTeh6BAsFXD4wiJKu
 cKfsym2Dx4mLckXqW.AbZkIwgrY5LjBmdWc6SKQOdsIdjhvCcHQ4ojfQ8E_zj8JRQ_gXhKxp3PUq
 P2XS8OOmraucaQDGEVo1K54MHOJ1JaKxC6gWKe6ttY7_ncOJpOU.KkXxqvOfbb7isVK3x6uAAdrh
 X6UK5HUnZHHQv.i1cPhMEclgzimDcKexCJRiySsWTaqpwlnYOBwQrhnZqH8lI2YurwizBWxmdLzs
 LtPaCe05lfrBSEwETbA97sBu4DCx6rCxT8MH2Ie9Z8O.hWxk0FO4HUr81Z3BO22458frBN22n.lC
 ajUul5oygXowzx2NKRwFxKoHUiSpjWKI0kgD23YaSFUZktOXlxvCobJXGBmLpkSGXxnjyufuD0gg
 ria9ziOg2sXGwa94Z9XB__dUKgmDcMnhs92qnqxtQ9GVLCEglJsGoEguYctUBZYBVsp50CIa6Ok6
 SXjaSMU7PcQ07lQipNlnc8b4O4HJOleWNnMt7MoAld9i3g.lrDYvDi4bCLqtTwIGVEk5uh10r.lA
 EcRzw3vYKADVzMmPnKj50341LC1drtap5WF8N0OsKdenj860kPUM2RnTsvYnCOGj0Zvyf3RGfcw6
 ADMx6JZh.oT7tBGXmC2trn_lSzUDlyV2HzhxwqcTQ74n37FYMcnh3erqdvcpZ4kcBsRPBtKl86xB
 mrj.1zY_LRB6KfidnBVD_3N7A56xJTILzloMTVEV2E5_XGeBNMPkBpYGggZQD4tjEIBz7DV6ovKz
 fCUlEQ889btK9fBJze_NiCVh3teHAjjAUqqo7.xtcFHN_67886BueSxsHXABkUAdw3qprq2bJebF
 LWDg.r5mTcPr7mFOBSeSfnw3q.HRAl7sjfqfoCGBIq2DqHfPWAjpAZtro7GirH46qxDOO_hHuM19
 hNtszdveEGqxAQFiYlV.nUZlz18NTWkCbX6IHpjxwFoW3xkIisX5BprMBhZQR_cODjRpcwYPfOfE
 ..cwK_OsMi3Dui3UE.Jg6COVIms6493ao8ceZUPMN8DZAmz6BfCK7uHWmM5_np443j6LFdBwpDm.
 SYRh0FABysxt3b5KUTW4L9lXKjy.06mRcWBdaMC4t3Kvm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:23 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 850c88567681b8abbaba4b57aaf8e962;
          Wed, 27 Nov 2019 21:38:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 20/25] LSM: Verify LSM display sanity in binder
Date:   Wed, 27 Nov 2019 13:37:13 -0800
Message-Id: <20191127213718.18267-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 101063b00aeb..0e8c61cceecd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -738,9 +738,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction - Binder driver transacton check
+ * @from: source of the transaction
+ * @to: destination of the transaction
+ *
+ * Verify that the tasks have the same LSM "display", then
+ * call the security module hooks.
+ *
+ * Returns -EINVAL if the displays don't match, or the
+ * result of the security module checks.
+ */
 int security_binder_transaction(struct task_struct *from,
 				struct task_struct *to)
 {
+	int from_display = lsm_task_display(from);
+	int to_display = lsm_task_display(to);
+
+	/*
+	 * If the display is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_display == LSMBLOB_INVALID)
+		from_display = 0;
+	if (to_display == LSMBLOB_INVALID)
+		to_display = 0;
+	if (from_display != to_display)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.20.1

