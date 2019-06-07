Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62D394E2
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfFGSyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 14:54:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbfFGSyk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mN9SlMwFezZ1ZPB+c4+XXB+0uQsuZLbIqjOavdIdlqw=; b=HTM+//NTshmY11VPp3W2zCC0AV
        AnxnJl/5QTXQPkKrFfbo5L9QXQ+NWhQXx55Bzov9saX3KqjAdGWO5e9rYIJj+km9BAG0LXoJj0bap
        q1I+rt94/+kmxxLnj2fVapCr8TgoRYqK/dxt0UrHQAIQcESZ2UnEA/WxAiDB5UMaYTYAgxAWYgQCB
        Vm3QYFxZNeS4ooSrsMJqSGEl3lsWf6/E4fGKje0zAmxn2wJaGnYVVFjT3o+oeayKdH1SYHQUxPh6a
        I+x+Tv3yFEYYuZItw1vXMeLhh3KzKn8fLI0a4cU45VsOQDmju23QkXlJrpu7dSWxgJVfYKUJk1Bw3
        S69+bYTg==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sj-LB; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007F6-Fo; Fri, 07 Jun 2019 15:54:37 -0300
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
Subject: [PATCH v3 11/20] docs: security: trusted-encrypted.rst: fix code-block tag
Date:   Fri,  7 Jun 2019 15:54:27 -0300
Message-Id: <d9063d11a7690c91a61938d0bb1f92e8669be95a.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
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

