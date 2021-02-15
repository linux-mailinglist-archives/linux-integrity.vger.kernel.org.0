Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00831B707
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBOKY1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 05:24:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBOKY0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 05:24:26 -0500
Received: from weisslap.aisec.fraunhofer.de ([146.52.20.127]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhlCa-1lpLfJ1vyi-00doH6; Mon, 15 Feb 2021 11:21:17 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ABI: testing: ima_policy: Fixed missing bracket
Date:   Mon, 15 Feb 2021 11:20:29 +0100
Message-Id: <20210215102031.10622-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sV9ASGHGqk2dLjVSZn2f7NG6tXo64D/g8/2vIEtGItfqCwuLF/z
 a8FToVNrj/UCEEuA9WF+pIJO+vWnlen0AbQENd49oGIG3Vgo5/S1QvsQxGdJfKXh5sgkVkb
 3tnKgZzMuQR7ahZOdujgHgoRkRlNFZNrMw3EcyiNP3srI/Mcrzv4GZMlgqLBG+10HDdOvQq
 xBy18SMXJlYTuigOHojGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6lAVGVWW4xI=:fwrKdCzi1moqoOgEvVFfer
 t+b231Nxhx5PRx3YqWJZWleuq15/ek2TCxpK8nqZ2eabzRUr03hJ84hRRmF+FWan8PRVNCFVH
 G8tVfgIWza6I4dbmGwQiaQZyzec3Vp4NYUr/NeExuD0OwahJqQDP5tYA0nyxQp7PrRw0uXPcI
 s/PnBmxC7CXL8s4DT+Vje3RHPsZkB6+yjwxz3NtI7IWhJquar45x4eWMFNFW4SzIjoLOnHP6u
 JE9IJZ00b55NyjCpYX3zMOs3pKkGP5QG3oDHMVq6XTFyEcwgHdQ/UYdxhAyVVs4ldnxM4pRzS
 Lty6kpk9+43a+KeOEP8iSfGaNgYE8CWlk+H4o7AZFdEEl2MDOKhZL9eq6mYPNdPhztZ9gmmSN
 I03bsSAFCRYnpkQo3lwA0tQarxY3gbK7VsT/FxdgRZ/PNBt3V/VhdW20bX7U/kp7n+VLV0601
 3lyg2zXWYelnbm2KLYOMUXGZCOooPR5CmdvIsgw6T2AxO6P8caYQKDB/CiKqPybjX9igz5bNu
 w==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes a minor typo introduced by commit 34433332841d:
"docs: ABI: testing: make the files compatible with ReST output"

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 Documentation/ABI/testing/ima_policy | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e35263f97fc1..2617c21ab843 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 			option:	[[appraise_type=]] [template=] [permit_directio]
 				[appraise_flag=] [keyrings=]
 		  base:
-			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
+			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 			        [FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK]
-- 
2.20.1

