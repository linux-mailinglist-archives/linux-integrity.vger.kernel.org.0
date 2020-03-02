Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741AB175A87
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 13:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCBMbF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 07:31:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42528 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgCBMbF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 07:31:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C11D58EE17D;
        Mon,  2 Mar 2020 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583152264;
        bh=aUMaf7CZIzFL/1swa95BTdhBcSUkhpgWyCHxGRy3Gwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UV8wShEWYvSdsH/yfxg6qcgqJbzTAqgq/Dj3nga7zn93fT63gKTJ9XCvByVd6Oi96
         nLM6Uwn9w9ZnQ4V5BdcuaYvFqcQVAgf85zpKG6FMSu3cP5jPCFZSW9uQXkOsc958zX
         13XnqZsgIWLMZwP1Ydn8lLLVUK31ovjAqU2527xw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h6YqrzbKYd52; Mon,  2 Mar 2020 04:31:04 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 748338EE11D;
        Mon,  2 Mar 2020 04:31:01 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v6 2/6] oid_registry: Add TCG defined OIDS for TPM keys
Date:   Mon,  2 Mar 2020 07:27:55 -0500
Message-Id: <20200302122759.5204-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
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

---

v3: correct OID_TPMImportableKey name
---
 include/linux/oid_registry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 657d6bf2c064..f6e2276e5f30 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -107,6 +107,11 @@ enum OID {
 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
 
+	/* TCG defined OIDS for TPM based keys */
+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
+	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
+
 	OID__NR
 };
 
-- 
2.16.4

