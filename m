Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8367221720
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGOVjV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 17:39:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726736AbgGOVjU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 17:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594849159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0L3R6uEM0PMypzTypDqa6brvazZbp5wwZJ9AdtjT1wU=;
        b=TUdq+eo8GfN2bdDYLJwtsPJXeAZPEvk0S+humzYIlZSgFMdSSBAkMvc4lYPi+7mu/1EUCN
        AerNhQ3yitltRjP6Xn9pgTPDyJgtaBsyIpHNJiOufi51xuz4x4WwKYezuwLe3WFkJmHVci
        HmCgS8OarKH0m4NToJ5nRUtQpTzT3Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-QPMPFebNN-2zT6xsDyDxAQ-1; Wed, 15 Jul 2020 17:39:17 -0400
X-MC-Unique: QPMPFebNN-2zT6xsDyDxAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE1FD800400;
        Wed, 15 Jul 2020 21:39:16 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE981757A;
        Wed, 15 Jul 2020 21:39:13 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/3] ima-evm-utils: fix empty label at end of function.
Date:   Wed, 15 Jul 2020 18:39:04 -0300
Message-Id: <20200715213906.194041-2-bmeneg@redhat.com>
In-Reply-To: <20200715213906.194041-1-bmeneg@redhat.com>
References: <20200715213906.194041-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Distros running older OpenSSL versions (<= 1.1) fail to build due to the
empty label at the end of calc_bootaggr(). For these, that label is no-op.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 90a3eeb..d974ba6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2167,7 +2167,7 @@ out:
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
 	EVP_MD_CTX_free(pctx);
 #endif
-
+	return;
 }
 
 /*
-- 
2.26.2

