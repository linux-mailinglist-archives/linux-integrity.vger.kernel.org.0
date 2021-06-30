Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF45A3B84DC
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhF3OTV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 10:19:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3332 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OTU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 10:19:20 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GFNW35R5Fz6H6nB;
        Wed, 30 Jun 2021 22:09:03 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:16:49 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/3] ima: Provide more info about buffer measurement
Date:   Wed, 30 Jun 2021 16:16:32 +0200
Message-ID: <20210630141635.2862222-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set provides more information about buffer measurement.

First, it introduces the new function ima_get_current_hash_algo(), to
obtain the algorithm used to calculate the buffer digest (patch 1).

Second, it changes the type of return value of ima_measure_critical_data()
and process_buffer_measurement() from void to int, to signal to the callers
whether or not the buffer has been measured, or just the digest has been
calculated and written to the supplied location (patch 2).

Lastly, it adds a new parameter to the functions above, so that those
functions can write the buffer digest to the location supplied by the
callers (patch 3).

This patch set replaces the patch 'ima: Add digest, algo, measured
parameters to ima_measure_critical_data()' in:

https://lore.kernel.org/linux-integrity/20210625165614.2284243-1-roberto.sassu@huawei.com/

Changelog

Huawei Digest Lists patch set:
- introduce ima_get_current_hash_algo() (suggested by Mimi)
- remove algo and measured parameters from ima_measure_critical_data() and
  process_buffer_measurement() (suggested by Mimi)
- return an integer from ima_measure_critical_data() and
  process_buffer_measurement() (suggested by Mimi)
- correctly check when process_buffer_measurement() should return earlier

Roberto Sassu (3):
  ima: Introduce ima_get_current_hash_algo()
  ima: Return int in the functions to measure a buffer
  ima: Add digest parameter to the functions to measure a buffer

 include/linux/ima.h                          | 22 +++++--
 security/integrity/ima/ima.h                 | 10 +--
 security/integrity/ima/ima_appraise.c        |  6 +-
 security/integrity/ima/ima_asymmetric_keys.c |  6 +-
 security/integrity/ima/ima_init.c            |  6 +-
 security/integrity/ima/ima_main.c            | 66 +++++++++++++-------
 security/integrity/ima/ima_queue_keys.c      | 15 ++---
 security/selinux/ima.c                       | 10 +--
 8 files changed, 92 insertions(+), 49 deletions(-)

-- 
2.25.1

