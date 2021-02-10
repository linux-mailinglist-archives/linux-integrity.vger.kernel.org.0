Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B4316069
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 08:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhBJHxh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 02:53:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12165 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhBJHxe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 02:53:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DbBlZ3D5szlGxD;
        Wed, 10 Feb 2021 15:51:06 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 15:52:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] IMA: Make function ima_mok_init() static
Date:   Wed, 10 Feb 2021 08:01:16 +0000
Message-ID: <20210210080116.1209789-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The sparse tool complains as follows:

security/integrity/ima/ima_mok.c:24:12: warning:
 symbol 'ima_mok_init' was not declared. Should it be static?

This function is not used outside of ima_mok.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 security/integrity/ima/ima_mok.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 1e5c01916173..95cc31525c57 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -21,7 +21,7 @@ struct key *ima_blacklist_keyring;
 /*
  * Allocate the IMA blacklist keyring
  */
-__init int ima_mok_init(void)
+static __init int ima_mok_init(void)
 {
 	struct key_restriction *restriction;
 

