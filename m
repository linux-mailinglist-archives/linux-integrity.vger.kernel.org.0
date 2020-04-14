Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D721C1A7A10
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439601AbgDNLtP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 07:49:15 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50580 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728473AbgDNLtN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 07:49:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvWiAKX_1586864931;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvWiAKX_1586864931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 19:48:51 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH 0/2] Simplify the implementation of some functions in IMA
Date:   Tue, 14 Apr 2020 19:48:48 +0800
Message-Id: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify the implementation of some functions in IMA.

Tianjia Zhang (2):
  ima: simplify function ima_store_template
  ima: simplify function process_buffer_measurement

 security/integrity/ima/ima_api.c  |  3 +--
 security/integrity/ima/ima_main.c | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.17.1

