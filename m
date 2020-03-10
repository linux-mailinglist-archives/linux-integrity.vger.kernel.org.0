Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6650117EFEB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2020 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgCJFRl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Mar 2020 01:17:41 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35478 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgCJFRl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Mar 2020 01:17:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 222338EE130;
        Mon,  9 Mar 2020 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583817461;
        bh=utjcIpzB5cKz3QfoZk7p4oF7i25SrMb648uT7GA0lew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSP+Lr+AlQaQ6p3gi4yK4JHYhG+A6yIEAMe8Szz9mbNUZEMHxKPSRIx1KxjM46UOH
         k0G5If49Cd8feuu2GRmSxOgsRu7Q+/7IAZfuuvY9A7nWuefHPlZSkC+jletEdEkMi0
         IlK4lQltC/fmTdRSOGRaH0RMFf8SWLF1LR127YKA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id buryEUtGm66E; Mon,  9 Mar 2020 22:17:41 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA8E28EE121;
        Mon,  9 Mar 2020 22:17:40 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v8 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Date:   Mon,  9 Mar 2020 22:16:01 -0700
Message-Id: <20200310051607.30334-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
References: <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
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
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

v3: correct OID_TPMImportableKey name
v7: add ack
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

