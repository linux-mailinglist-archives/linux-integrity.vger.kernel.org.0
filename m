Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7025E215
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIDTlf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 15:41:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728057AbgIDTle (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LfMo0bPH1qwF7NhkKROPvBHvn6aBWYvqMe0We0V1A0=;
        b=Vmr0wn0bbUI/+XmiK19sWEZZKfFyj6oQeerQ4w5Ff9S79jbr5UQ8M0oQ622e3CZIopyoxG
        9DApe9fdxUiiLr/vOWPiW/qogr/FMErTO2NQ6UcOONFgdw8q5cenFSKldwpQjqEKTPWxiG
        EMZ529aMn/sEWWkl/nMEqkvBPGgz5is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-6gBDPg3gMXel9fFtSjWU5g-1; Fri, 04 Sep 2020 15:41:29 -0400
X-MC-Unique: 6gBDPg3gMXel9fFtSjWU5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968D71DE13;
        Fri,  4 Sep 2020 19:41:28 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74735C1D0;
        Fri,  4 Sep 2020 19:41:24 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 4/4] integrity: prompt keyring name for unknown key request
Date:   Fri,  4 Sep 2020 16:41:00 -0300
Message-Id: <20200904194100.761848-5-bmeneg@redhat.com>
In-Reply-To: <20200904194100.761848-1-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Depending on the IMA policy a key can be searched in multiple keyrings (e.g.
.ima and .platform) and possibly failing for both. However, for the user not
aware of the searching order it's not clear what's the keyring the kernel
didn't find the key. With this patch we improve this feedback by printing
the keyring "description" (name).

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/digsig_asymmetric.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index cfa4127d0518..14de98ef67f6 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -55,8 +55,14 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 	}
 
 	if (IS_ERR(key)) {
-		pr_err_ratelimited("Request for unknown key '%s' err %ld\n",
-				   name, PTR_ERR(key));
+		if (keyring)
+			pr_err_ratelimited("Request for unknown key '%s' in '%s' keyring. err %ld\n",
+					   name, keyring->description,
+					   PTR_ERR(key));
+		else
+			pr_err_ratelimited("Request for unknown key '%s' err %ld\n",
+					   name, PTR_ERR(key));
+
 		switch (PTR_ERR(key)) {
 			/* Hide some search errors */
 		case -EACCES:
-- 
2.26.2

