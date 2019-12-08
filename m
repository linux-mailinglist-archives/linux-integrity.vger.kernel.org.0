Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2319116074
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Dec 2019 06:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfLHFJH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Dec 2019 00:09:07 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57964 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLHFJH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Dec 2019 00:09:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 24A818EE111;
        Sat,  7 Dec 2019 21:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781747;
        bh=4FmAxKQz7ECJGSh7N2RP7M0+Pg0ss+HhRBx0TU9I6GY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bm9pjvmmz6wg/E0iezCLlx9qk21tRiYnMImnW8ayUTbmk8eVshsX+EHJMYP1LPREo
         /yfhHx0npoUUeUTLSqVDXH+3caTtBnyA8do56gOUmivSkReIXBWW8OrSLuoZo6dKdz
         q3U3VYrHtvs7KTr2asfPZ1DrI6IAXbT5+8o5ukIU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WpH-3atotCnY; Sat,  7 Dec 2019 21:09:06 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A73B28EE109;
        Sat,  7 Dec 2019 21:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781746;
        bh=4FmAxKQz7ECJGSh7N2RP7M0+Pg0ss+HhRBx0TU9I6GY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sfkT7AZr+OVB3Oh9mDKNAbv3N0g+cVMx1oviyc2OjWAw1/fo1c4mgAmgvGLlVseV3
         +d/KdFflHLHY9zrmScYEo0qjhMRfiYobM+1nflU1kBzLlDEaKggrTBNVUwyaR26qpR
         1OgVvRUZn+tUJ1Cp4jAkFnOrbUQJywJdDYidZplg=
Message-ID: <1575781746.14069.11.camel@HansenPartnership.com>
Subject: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 07 Dec 2019 21:09:06 -0800
In-Reply-To: <1575781600.14069.8.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/oid_registry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 657d6bf2c064..a4cee888f9b0 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -107,6 +107,11 @@ enum OID {
 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
 
+	/* TCG defined OIDS for TPM based keys */
+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
+	OID_TPMImporableKey,		/* 2.23.133.10.1.4 */
+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
+
 	OID__NR
 };
 
-- 
2.16.4

