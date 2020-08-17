Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8765624792D
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgHQVxE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33546 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727931AbgHQVxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LfMo0bPH1qwF7NhkKROPvBHvn6aBWYvqMe0We0V1A0=;
        b=PAKUPSB7LsbSIENi/GNdkzCJDKJJ1HYZyEblTdwTV4opzaEZmzHmghLibCP64KQYZbgeDn
        lzPCvXm9Q/Mhd//b18sjVwd8dDiVROITkZyIHzzvlA/wz1yeuNE7fKFE8NZxJ1HCH53pAU
        Hlj0cja8TkcRoBudwz7n1DctXE+22oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-BeejGxuAM8mGM84ziVKYKw-1; Mon, 17 Aug 2020 17:52:58 -0400
X-MC-Unique: BeejGxuAM8mGM84ziVKYKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E080181F00B;
        Mon, 17 Aug 2020 21:52:57 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7988210021AA;
        Mon, 17 Aug 2020 21:52:54 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 4/4] integrity: prompt keyring name for unknown key request
Date:   Mon, 17 Aug 2020 18:52:33 -0300
Message-Id: <20200817215233.95319-5-bmeneg@redhat.com>
In-Reply-To: <20200817215233.95319-1-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

