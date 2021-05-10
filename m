Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D637823E
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhEJKd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 06:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231653AbhEJKbZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 06:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD476192C;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=4kiApqtEgxHXQ5lpCKw+lSX7463eojql3r+0QIGTBk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzfm3KUMVGsQoNL9uzhEOfxioVlpznVAu9YybNV7Uhz/YBB/0PhMl4MmULooDGh6N
         J9Fd4YLOXJ8/7lTT9MsJ7kB2oM4zS42lMvaCwEjNBLKbyJByzI8pu0dUE+KcF/oYUY
         VSw9pQ/UHkwLBPyMhejovxL/5AMOAbGxjVhkFp22qo8RO8cnDv/6q94+xP95fhXczr
         HRMT7d0lzl+lA7N+M3LBREUxoW6sWkWJ9BXmsQVDj98tCSRpCl0Aa4NqJLhKpxCShP
         DzAoD+DM2IFeD7peg/taNH2DViyZmw8SdlP5YjaSv/s1DfrkJeDuh2oZ3qaRJ2YoiR
         6TlKgvAPtF9/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQO-Sw; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/53] docs: security: keys: trusted-encrypted.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:44 +0200
Message-Id: <6dd7b47b3d18e201e5552c62f8186d28f787840f.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/security/keys/trusted-encrypted.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..3697cbb4fc2c 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -108,8 +108,8 @@ Encrypted Keys
 
 Encrypted keys do not depend on a trust source, and are faster, as they use AES
 for encryption/decryption. New keys are created from kernel-generated random
-numbers, and are encrypted/decrypted using a specified ‘master’ key. The
-‘master’ key can either be a trusted-key or user-key type. The main disadvantage
+numbers, and are encrypted/decrypted using a specified 'master' key. The
+'master' key can either be a trusted-key or user-key type. The main disadvantage
 of encrypted keys is that if they are not rooted in a trusted key, they are only
 as secure as the user key encrypting them. The master user key should therefore
 be loaded in as secure a way as possible, preferably early in boot.
-- 
2.30.2

