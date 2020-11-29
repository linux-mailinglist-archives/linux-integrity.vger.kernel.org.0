Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58732C7BAE
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Nov 2020 23:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgK2WX5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Nov 2020 17:23:57 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:42014 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgK2WX5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Nov 2020 17:23:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 66B451280A23;
        Sun, 29 Nov 2020 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606688597;
        bh=ck2ZIwBvUdlkG2aSWZp5Jzk7xWAy/yINKGxE2dUpmBo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=eUUKSdHweHuLJf2bjUMXnMMwaUcFO4tjCMnBzKc+3XaZ59LRdHV6sndDJKt7yS6Bf
         ZjhDgXLc3Dxp5CtktITjg7tX9afsPw0aC4MKC/aDT3gZHWcgTtpWQEzL7BVI0O5Qsr
         32KMnmFV68lY5QCZ2yKT8w4cTg8PfUHU/kjX9goI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ql8eIxMjb8jy; Sun, 29 Nov 2020 14:23:17 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ECB371280A21;
        Sun, 29 Nov 2020 14:23:16 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v14 2/5] oid_registry: Add TCG defined OIDS for TPM keys
Date:   Sun, 29 Nov 2020 14:20:01 -0800
Message-Id: <20201129222004.4428-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
References: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
key uses.  We've defined three of the available numbers:

2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
		RSA2048 or Elliptic Curve) which can be imported by a
		TPM2_Load() operation.

2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
		RSA2048 or Elliptic Curve) which can be imported by a
		TPM2_Import() operation.

Both loadable and importable keys are specific to a given TPM, the
difference is that a loadable key is wrapped with the symmetric
secret, so must have been created by the TPM itself.  An importable
key is wrapped with a DH shared secret, and may be created without
access to the TPM provided you know the public part of the parent key.

2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
		bytes) which is sealed by the TPM.  It usually
		represents a symmetric key and must be unsealed before
		use.

The ASN.1 binary key form starts of with this OID as the first element
of a sequence, giving the binary form a unique recognizable identity
marker regardless of encoding.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: David Howells <dhowells@redhat.com>

---

v3: correct OID_TPMImportableKey name
v7: add ack
v9: add review
---
 include/linux/oid_registry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 4462ed2c18cd..d06988d1565e 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -113,6 +113,11 @@ enum OID {
 	OID_SM2_with_SM3,		/* 1.2.156.10197.1.501 */
 	OID_sm3WithRSAEncryption,	/* 1.2.156.10197.1.504 */
 
+	/* TCG defined OIDS for TPM based keys */
+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
+	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
+
 	OID__NR
 };
 
-- 
2.26.2

