Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D649160EC6
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2020 10:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBQJhF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Feb 2020 04:37:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59769 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728889AbgBQJhF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Feb 2020 04:37:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Tq9PhSs_1581932216;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tq9PhSs_1581932216)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Feb 2020 17:36:56 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        ebiggers@kernel.org, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] IMA hash algorithm supports sm3
Date:   Mon, 17 Feb 2020 17:36:47 +0800
Message-Id: <20200217093649.97938-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixed an issue where the sm3 algorithm name mismatch in the crypto subsystem hash_algo_name.
Make IMA support sm3 hash algorithm, added support for sm3 in IMA algorithm Kconfig configuration.


