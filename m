Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919DC2E948
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE2XZw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 May 2019 19:25:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfE2XYA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=grIpI6sxpoTAJV0Ncwe3KE3Pkp6elLo09FG9+ha8eR4=; b=HLp+W6HDYkZ5BG3pl/MVxdnwMl
        Qsyp6pfk8TrwCFQMXmy5KjlbYNXb/HkmyrqRM1+XLtrvCwN8l1bRlaO/ROsYGa6WYqPuYLbyvtDLY
        IYXq6aDUMNjOH1KjrS4A2bjbpkA4HItDYZRalS8ZgwenJhceREiJZQ/YesUSPo9VH8uzQzzjQSlKC
        rqekLYgF8KyZwu7cayzFE5H8DDA3im/F5JbNyB7gpX1X7uREfbhb3JGterJ2pWbisXboGM9RI/oUL
        2H0myDUyJXOQEoehlkLawqapDSjTByDXVnTbQaTlK7vhezMmW7g2owyPChj7R3xy4l1nL2VyXpvYg
        5gBKpV5Q==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rs-Dp; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xu-Um; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH 18/22] docs: security: trusted-encrypted.rst: fix code-block tag
Date:   Wed, 29 May 2019 20:23:49 -0300
Message-Id: <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
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

