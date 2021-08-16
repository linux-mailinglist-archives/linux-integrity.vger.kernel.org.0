Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2375F3ED9B1
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhHPPQw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 11:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhHPPQt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 11:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629126977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQBKAzrNqORhg2zzXCJ4oGO4yWO1MUpZFcgPj3OCUa0=;
        b=UBfu7VyhX/KfetlHVA8VkkrfvLCxcJOHDs+USB/TW5NeMUH9cyv4OkN46Zmeg0yjIDCfV/
        c33ePuJc6F5weAXgIrOYFeK/Cl8en0lkM0mcBZcnRqxwQ96380bVX7fHmclZzrj0cnxgJO
        s/OsGHGkwqO3UeaQ6s7xRp4WhUz11ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-cNB8QwZ2Og6Wp_-n0WwbQA-1; Mon, 16 Aug 2021 11:16:14 -0400
X-MC-Unique: cNB8QwZ2Og6Wp_-n0WwbQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C89E487D541;
        Mon, 16 Aug 2021 15:16:12 +0000 (UTC)
Received: from localhost (unknown [10.22.8.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56AA55D6A1;
        Mon, 16 Aug 2021 15:16:12 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     vt@altlinux.org, zohar@linux.ibm.com, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 ima-evm-utils] evmctl: fix memory leak in get_password
Date:   Mon, 16 Aug 2021 12:16:00 -0300
Message-Id: <20210816151600.24850-2-bmeneg@redhat.com>
In-Reply-To: <20210816151600.24850-1-bmeneg@redhat.com>
References: <20210816151600.24850-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

