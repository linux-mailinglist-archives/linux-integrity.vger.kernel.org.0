Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A91A328F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIKer (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Apr 2020 06:34:47 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50441 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDIKer (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Apr 2020 06:34:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tv2Jng._1586428480;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tv2Jng._1586428480)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 18:34:41 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH v2 0/2] support to read and tune appraise mode in runtime
Date:   Thu,  9 Apr 2020 18:34:38 +0800
Message-Id: <20200409103440.47946-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Support the read and write operations of ima_appraise by adding a
securifyfs file 'appraise_mode'.

In order to tune appraise mode in runtime, writing a PKCS#7 signature
corresponding the signed content is required. The content should be off,
enforce, log or fix. Given a simple way to archive this:

$ echo -n off > mode
$ openssl smime -sign -nocerts -noattr -binary \
    -in mode -inkey <system_trusted_key> \
    -signer <cert> -outform der -out mode.p7s
$ sudo cat mode.p7s \
    > /sys/kernel/security/ima/appraise_mode

Note that the signing key must be a trust key located in
system trusted keyring. So even the root privilege cannot
simply disable the enforcement.

---
v2 change: fix build error.

Tianjia Zhang (2):
  ima: support to read appraise mode
  ima: support to tune appraise mode in runtime

 security/integrity/ima/ima_fs.c | 140 +++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

-- 
2.17.1

