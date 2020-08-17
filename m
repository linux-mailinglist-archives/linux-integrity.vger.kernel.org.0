Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7162A247929
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHQVws (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:52:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbgHQVwr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMKjbUdhIVST6o3H3+0+skCoVkiZxquiNwTivuQ2ZEc=;
        b=fCMGloIKHnA15/7kBnnUfiUKNfrFck7A7XzGMNFcTBZSqZN1A7NzX48YDNnb+ITdzcRK6l
        pWNfiYIM8mT4WbOeydE8KRcrUvI8G32f7yaSMoUu31blgpMn8dNfhXamWdtKoIXC5IJe7+
        wIkvK76CBZwExEloOX9yYI6tqnfjQpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ioYGrboyOSeNDdyxtvOnyw-1; Mon, 17 Aug 2020 17:52:44 -0400
X-MC-Unique: ioYGrboyOSeNDdyxtvOnyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03927801AC9;
        Mon, 17 Aug 2020 21:52:44 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D7E5D9DC;
        Mon, 17 Aug 2020 21:52:40 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/4] ima: add check for enforced appraise option
Date:   Mon, 17 Aug 2020 18:52:30 -0300
Message-Id: <20200817215233.95319-2-bmeneg@redhat.com>
In-Reply-To: <20200817215233.95319-1-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "enforce" string is allowed as an option for ima_appraise= kernel
paramenter per kernel-paramenters.txt and should be considered on the
parameter setup checking as a matter of completeness. Also it allows futher
checking on the options being passed by the user.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 372d16382960..580b771e3458 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -31,6 +31,8 @@ static int __init default_appraise_setup(char *str)
 		ima_appraise = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
 		ima_appraise = IMA_APPRAISE_FIX;
+	else if (strncmp(str, "enforce", 7) == 0)
+		ima_appraise = IMA_APPRAISE_ENFORCE;
 #endif
 	return 1;
 }
-- 
2.26.2

