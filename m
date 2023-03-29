Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215D76CD5B7
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjC2JAY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjC2JAE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 05:00:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027865266
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 01:59:36 -0700 (PDT)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmgSk0bhFz6J7xP
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 16:58:30 +0800 (CST)
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 09:59:06 +0100
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <ilya.hanov@huawei-partners.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v1 0/1] ima: obtain child measurement list from init namespace
Date:   Wed, 29 Mar 2023 16:58:48 +0800
Message-ID: <20230329085848.278269-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
References: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch allows to read measurement lists of child namespaces
form init IMA namespace in order to obtain the values of hashes
to perform operations and procedures of remote attestation.

Denis Semakin (1):
  ima: obtain child measurement list from init namespace

 security/integrity/ima/ima.h             |   1 +
 security/integrity/ima/ima_fs.c          | 164 ++++++++++++++++++++++-
 security/integrity/ima/ima_init_ima_ns.c |   2 +
 security/integrity/ima/ima_ns.c          |  31 +++++
 4 files changed, 193 insertions(+), 5 deletions(-)

-- 
2.38.GIT

