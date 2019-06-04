Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BB34A1C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfFDOTB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 10:19:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfFDOSD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mN9SlMwFezZ1ZPB+c4+XXB+0uQsuZLbIqjOavdIdlqw=; b=QpCiAFfqH9xfvJHkdueb+lqM+O
        QuJI6/GoxfZFHIF+U6YrRnFcJ0audVi2ntWjxj0QSqDFvIdaqC+PVtPlGdbJtOr/dyO74+0TsyC9j
        kKuH+wV7Q3euRKGxUk+SC6pvVZvVi+3ScveTGuUEhX7VISIwNQZTmuih2CBmdx4WegnPB+DpSNsmk
        Fuc/dkxbfjh9HZ6yKlMiUWhUOdDQAGVYkEcDKgDwhZR0RWVNavbNeH4lcqIX3BvNJEVPE7F06piej
        FztI/3sXqJRJQlUJ62kHGeKFehUT5P4tpx134x+wR1/AwRSOnX46DkawaK4P0UkCKdnORcXE729eB
        MWg6CfAg==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rt-Tg; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002lV-Ri; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>
Subject: [PATCH v2 14/22] docs: security: trusted-encrypted.rst: fix code-block tag
Date:   Tue,  4 Jun 2019 11:17:48 -0300
Message-Id: <3f540bedea5771489750cbcba540e9b27b21225b.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The code-block tag is at the wrong place, causing those
warnings:

    Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
    Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
    Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 7b35fcb58933..50ac8bcd6970 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -107,12 +107,14 @@ Where::
 
 Examples of trusted and encrypted key usage:
 
-Create and save a trusted key named "kmk" of length 32 bytes::
+Create and save a trusted key named "kmk" of length 32 bytes.
 
 Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
 append 'keyhandle=0x81000001' to statements between quotes, such as
 "new 32 keyhandle=0x81000001".
 
+::
+
     $ keyctl add trusted kmk "new 32" @u
     440502848
 
-- 
2.21.0

