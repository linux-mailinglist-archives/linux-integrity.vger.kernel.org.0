Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3A43331B
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Oct 2021 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhJSKGn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Oct 2021 06:06:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57571 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhJSKGk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Oct 2021 06:06:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UsuI4X._1634637863;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UsuI4X._1634637863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 18:04:24 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 0/2] use SM3 instead of SM3_256
Date:   Tue, 19 Oct 2021 18:04:21 +0800
Message-Id: <20211019100423.43615-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
SM3 always produces a 256-bit hash value and there are no plans for
other length development, so there is no ambiguity in the name of sm3.

---
v2 changes:
 - an additional macro with the same value is defined for uapi instead
   of renaming directly

Tianjia Zhang (2):
  crypto: use SM3 instead of SM3_256
  tpm: use SM3 instead of SM3_256

 Documentation/security/keys/trusted-encrypted.rst | 2 +-
 crypto/hash_info.c                                | 4 ++--
 drivers/char/tpm/tpm-sysfs.c                      | 4 ++--
 drivers/char/tpm/tpm2-cmd.c                       | 2 +-
 include/crypto/hash_info.h                        | 2 +-
 include/linux/tpm.h                               | 2 +-
 include/uapi/linux/hash_info.h                    | 3 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
 8 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.19.1.3.ge56e4f7

