Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98EC67DEFC
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjA0IUo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjA0IUo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37A7750D
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 00:20:35 -0800 (PST)
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P39QK06wVz6J7dH
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 16:16:24 +0800 (CST)
Received: from localhost.localdomain (10.123.66.33) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 27 Jan 2023 08:20:32 +0000
From:   Ilya Hanov <ilya.hanov@huawei-partners.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <yusongping@huawei.com>, <hukeping@huawei.com>,
        <denis.semakin@huawei-partners.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <ilya.hanov@huawei-partners.com>
Subject: [RFC PATCH v1 0/3] ima: vPCR debug/security
Date:   Fri, 27 Jan 2023 16:19:50 +0800
Message-ID: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221031025507.298323-1-denis.semakin@huawei.com>
References: <20221031025507.298323-1-denis.semakin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.66.33]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

1. UUID value for each vPCR.

	There's no way to identify vPCR values reading
	/sys/kernel/security/ima/vpcr. It shows only vPCR values (which are in
	turn XORed with vPCR.secret, next cPCR = vPCR; vPCR value means vPCR.value XOR
	vPCR.secret), so imagine a situation when a server has
	hundreds of containers. In order to identify them it needs to keep in mind the
	order vPCR is created in. To solve this problem UUID values were added
	for each vPCR. They appear in the following form -
	"<cPCR-pfx><UUID-value><cPCR-val>...":

	# xxd /sys/kernel/security/ima/binary_vpcr
	00000000: 6350 4352 3a20 c57f 9efc 7149 4df5 a1b3  cPCR: ....qIM...
	00000010: 66fb 03db 4006 8780 7247 57d7 96e2 1b24  f...@...rGW....$
	00000020: 2f9b c891 2c09 05d2 4dfb 2011 a74f d1e9  /...,...M. ..O..
	00000030: 1134 b247 bf80 .... .... .... .... ....  ................
	(output truncated)

	6350 4352 3a20                          - cPCR prefix. 6  bytes long.
	c57f 9efc 7149 4df5 a1b3 66fb 03db 4006 - UUID value.  16 bytes long.
	8780 7247 57d7 96e2 1b24 2f9b c891 .... - cPCR value.  32 bytes long.
	...

2. ascii_vpcr pseudo-file for sysadmins.

	Dump cPCR values in human-readable format. This may add some flexibility for
	debugging. ima/vpcr also was renamed to ima/binary_vpcr. When something went wrong 
	System Administrator is able to see cPCR values without 
	doing PCR_Extend operations (for PCR12), this invokes only PCR_Read. ascii_vpcr
	has the same format as binary_vpcr, but can be read by humans:

	# cat /sys/kernel/security/ima/ascii_vpcr
	cPCR: c57f9efc-7149-4df5-a1b3-66fb03db4006     8780724757d796e21b242f9bc8912c0905d24dfb2011a74fd1e91134b247bf80
	(output truncated)

3. TPM RNG for vPCR.secret if it's presented.

	It adds some security because vPCR.secret will be generated using only
	TPM Hardware (as a Root Of Trust) without any Software
	Implementations. If there's no shipped TPM for a system - then use
	Software get_random_bytes(). To identify whether a system has been
	shipped with TPM RNG or not the code checks for CONFIG_HW_RANDOM_TPM.

Note: UUID values are always generated using get_random_bytes under the
hood. Here using Hardware is optional because UUIDs are not used inside
TPM like cPCRs (PCR_Extend{PCR12}).

Ilya Hanov (3):
  ima: Add a UUID value for each vPCR
  ima: ascii_vpcr pseudo-file for sysadmins
  ima: Use TPM RNG for vPCR.secret if it's presented.

 security/integrity/ima/ima.h             |   2 +
 security/integrity/ima/ima_fs.c          | 130 ++++++++++++++++++++---
 security/integrity/ima/ima_init_ima_ns.c |  12 +++
 3 files changed, 128 insertions(+), 16 deletions(-)

-- 
2.17.1

