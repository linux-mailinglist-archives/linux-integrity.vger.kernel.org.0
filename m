Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A1221724
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGOVj1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 17:39:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29770 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbgGOVj0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 17:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594849165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYV4+3cWAQVPGT7D9RrqoWjj3dpFkmnc31u6srYm/pI=;
        b=IDrw5a8Hsks5Exjzj4nRzcXsIJrMgr7pQsK0qUjodTWlWZyhf6FtO1lVX7TbLhqelURvUo
        wn5j4oSQPirsF80JBagMKz6GdJxgQ/SPudWR3jpiBuCz7m1t2NwU5Wd0loCBucgNfdQlWi
        bioUb7y8Tr9aFQrsc/vkzc8OqwI14ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-XfEArMf8MfO3kx9rYGzxyw-1; Wed, 15 Jul 2020 17:39:24 -0400
X-MC-Unique: XfEArMf8MfO3kx9rYGzxyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1C01083;
        Wed, 15 Jul 2020 21:39:23 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8536FDD1;
        Wed, 15 Jul 2020 21:39:19 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 3/3] ima-evm-utils: fix overflow on printing boot_aggregate
Date:   Wed, 15 Jul 2020 18:39:06 -0300
Message-Id: <20200715213906.194041-4-bmeneg@redhat.com>
In-Reply-To: <20200715213906.194041-1-bmeneg@redhat.com>
References: <20200715213906.194041-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There was no room for placing the '\0' at the end of boot_aggregate value,
thus printf() was reading 1 byte beyond the array limit.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 src/evmctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2f5bd52..2bd37c2 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2252,7 +2252,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
 		bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
 		bootaggr_len += (tpm_banks[i].digest_size * 2) + 1;
 	}
-	bootaggr = malloc(bootaggr_len);
+	/* Make room for the leading \0 */
+	bootaggr = malloc(bootaggr_len + 1);
 
 	/*
 	 * Calculate and convert the per TPM 2.0 PCR bank algorithm
@@ -2266,6 +2267,7 @@ static int cmd_ima_bootaggr(struct command *cmd)
 		calc_bootaggr(&tpm_banks[i]);
 		offset += append_bootaggr(bootaggr + offset, tpm_banks + i);
 	}
+	bootaggr[bootaggr_len] = '\0';
 	printf("%s", bootaggr);
 	free(bootaggr);
 	return 0;
-- 
2.26.2

