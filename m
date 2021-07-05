Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901B03BB9E5
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGEJMb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 05:12:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3356 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhGEJMb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 05:12:31 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJKKM5zNPz6H8Ls;
        Mon,  5 Jul 2021 16:55:51 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 11:09:51 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/3] ima: Provide more info about buffer measurement
Date:   Mon, 5 Jul 2021 11:09:19 +0200
Message-ID: <20210705090922.3321178-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
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

Lastly, it adds two new parameters to the functions above ('digest' and
'digest_len'), so that those functions can write the buffer digest to the
location supplied by the callers (patch 3).

This patch set replaces the patch 'ima: Add digest, algo, measured
parameters to ima_measure_critical_data()' in:

https://lore.kernel.org/linux-integrity/20210625165614.2284243-1-roberto.sassu@huawei.com/

Changelog

v2:
- remove assignments of ima_measure_critical_data() and
  process_buffer_measurement() return values (suggested by Lakshmi)

v1:
- add digest_len parameter to ima_measure_critical_data() and
  process_buffer_measurement() (suggested by Lakshmi)
- fix doc formatting issues

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
  ima: Add digest and digest_len params to the functions to measure a
    buffer

 include/linux/ima.h                          | 23 +++++--
 security/integrity/ima/ima.h                 | 10 +--
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_init.c            |  3 +-
 security/integrity/ima/ima_main.c            | 67 ++++++++++++++------
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 security/selinux/ima.c                       |  6 +-
 8 files changed, 78 insertions(+), 37 deletions(-)

-- 
2.25.1

