Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5ED3ED9B0
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhHPPQw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 11:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231438AbhHPPQr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 11:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629126973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iQBKAzrNqORhg2zzXCJ4oGO4yWO1MUpZFcgPj3OCUa0=;
        b=N9NSqxaVmfPCKRMdyDdlXYkkb6waKZ7aExX6IRZG1H972cxL+uwq6b7Jt9mZUDtSf1aPE2
        TcBWC4hGsKPpPVb8jnrbnZwslQEWE/yh21ggv+B4sK2FxEMrkQFAc2TeyaCWhw0EE36J9Y
        nVRzp4T7P05WpQdbDRLvzTKgi3leTMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-u-J0c4wnMKS7v58T5wF-Uw-1; Mon, 16 Aug 2021 11:16:12 -0400
X-MC-Unique: u-J0c4wnMKS7v58T5wF-Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E4F87D551;
        Mon, 16 Aug 2021 15:16:10 +0000 (UTC)
Received: from localhost (unknown [10.22.8.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFA1260FB8;
        Mon, 16 Aug 2021 15:16:02 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     vt@altlinux.org, zohar@linux.ibm.com, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 ima-evm-utils] evmctl: fix memory leak in get_password
Date:   Mon, 16 Aug 2021 12:15:59 -0300
Message-Id: <20210816151600.24850-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The variable "password" is not freed nor returned in case get_password()
succeeds. Return it instead of the intermediary variable "pwd". Issue found
by Coverity scan tool.

src/evmctl.c:2565: leaked_storage: Variable "password" going out of scope
    leaks the storage it points to.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
  v1: instead of removing the 'pwd' var, return 'password' (Mimi)

 src/evmctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a8065bbe124a..ab7173723095 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2625,7 +2625,12 @@ static char *get_password(void)
 		return NULL;
 	}
 
-	return pwd;
+	if (pwd == NULL) {
+		free(password);
+		return NULL;
+	}
+
+	return password;
 }
 
 int main(int argc, char *argv[])
-- 
2.31.1

