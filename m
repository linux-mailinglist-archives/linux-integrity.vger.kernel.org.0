Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0D37BD39
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhELMxc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 08:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhELMxA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 08:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0898261554;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=Jyxa5b0wJDyAovUPme/k22k6PLvmyAwA/dwR9wmQyok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhao1Phh7hKgBdCV4xH59/Bcm+sV6c7r23FpdOth3Hrvsp3dUIB8seChyFazMlWpF
         Y59jxoNka6Lq80Mc7Ev0YT2aExqH1PEJzYX0wUVbOJqD0sz//JpV/yoi4MPH2a6zCL
         m+xbf0aWRRs8lePB2fDOCmh4b6NEfRakE5AGJQ9rWzXzLf3guyeYwjAarzyjb9J1yc
         CtlQ8ehObd7x1RvFuqoGVC96vQRXcK9Jbstn6SzKaZ5Z6T8IpVriCNvVzw3ZMiNpKD
         WLMJY0Ve6xZkb8R0nav/u8MbtxSjS/82EcXECCFJcOn3Rr65GZLNb42AeaRD3ETGQo
         fPslSipMau70w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018iI-2c; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/40] docs: security: keys: trusted-encrypted.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:27 +0200
Message-Id: <c727cd640cefea283213d89f524a4432779ed5dc.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

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

