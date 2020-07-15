Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B20221721
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGOVjX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 17:39:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbgGOVjW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 17:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594849161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GrxYDQymSUTUExdcHo8UnPT4Tg+lIHrVDIxKR9A+1M=;
        b=FTF8iuEPh5sGLznbQriAjQ1lnYbwE8keMh4kZJii9jRanCQZPJRi9EQF0xR/2SUlPvahkc
        F2i8ieNE9KYsn/Zb9WUpv4OhZzyR7PIC/S+a3cQJIJ95hf/H2idNjv/k/kRDoGAIdvOfo/
        vqvLKeaLrQS4KHgWBtXgoq3TLpUD4oA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-3fMB8tkbPyuZ21w1LEUmHQ-1; Wed, 15 Jul 2020 17:39:19 -0400
X-MC-Unique: 3fMB8tkbPyuZ21w1LEUmHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9939E18FF662;
        Wed, 15 Jul 2020 21:39:18 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBC15FC38;
        Wed, 15 Jul 2020 21:39:17 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 2/3] ima-evm-utils: fix memory leak in case of error
Date:   Wed, 15 Jul 2020 18:39:05 -0300
Message-Id: <20200715213906.194041-3-bmeneg@redhat.com>
In-Reply-To: <20200715213906.194041-1-bmeneg@redhat.com>
References: <20200715213906.194041-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OpenSSL context should be freed in case of versions >= 1.1 before leaving
the function in case EVP_DigestUpdate() returns any error.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 src/evmctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index d974ba6..2f5bd52 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2143,7 +2143,7 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 		err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
-			return;
+			goto out;
 		}
 	}
 
@@ -2152,7 +2152,7 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 			err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
 			if (!err) {
 				log_err("EVP_DigestUpdate() failed\n");
-				return;
+				goto out;
 			}
 		}
 	}
-- 
2.26.2

