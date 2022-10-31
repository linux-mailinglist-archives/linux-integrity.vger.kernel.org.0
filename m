Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30141612F28
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Oct 2022 03:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaC4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaC4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 22:56:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425F6564
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 19:56:42 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N0yRd6vkbz67hlj;
        Mon, 31 Oct 2022 10:54:37 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 03:56:38 +0100
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 02:56:38 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <roberto.sassu@huawei.com>, <krzysztof.struczynski@huawei.com>,
        <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2 0/4] Virtualize PCR for Container-IMA
Date:   Mon, 31 Oct 2022 10:55:07 +0800
Message-ID: <20221031025507.298323-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The main goal of this series is to provide the opportunity
for retrieving integrity information from containters (namespaces)
in case of remote attestation requests and requests from another servers
querying the state of integrity for any given container.

The detailed description and architecture can be found here:
https://www.usenix.org/system/files/raid2019-luo.pdf,
this paper shows the basics for how it works in general
but did not solve the some practical issues related to memoy allocation,
TPM interaction etc.

Summary:

Let Ih is host integrity, and Ic1, Ic2, Icn the integrity
of the first, second and etc container.
Then the whole integrity of system would be:

        Ih = Ic1 + Ic2 + ... + Icn;

        where Ic1, Ic2 ... are integrity of corresponding
        containers (namespaces)

Each container integrity consists of measurement lists
and the value of virtual PCR (container PCR). vPCR = cPCR.

        Architecture scheme

        .---------.     .---------.          .---------.
        | C1 with |     | C2 with |          | Cn with |
        | IMA-ns  |     | IMA-ns  |          | IMA-ns  |
        |---------|     |---------|          |---------|
        |  vPCR1  |<--->|  vPCR2  |... <---> |  vPCRn  |
        |---------|     |---------|          |---------|
        |         |     |         |          |         |
        '---------'     '---------'          '---------'

        C1, C2, Cn - containers (with IMA namespaces)
        vPCRi - virtual PCR (in other words cPCR - container PCRs)

Each IMA namespace which belongs to container should
store its own PCR value (virtual vPCR or in other words
container PCR = cPCR = vPCR, virtual PCR)
and should perform a number of operation.

Measurement:
1. records the history value of a specific PCR (historyPCR)
   which is not used in the current system. In our prototype
   based on TPM 2.0, we choose PCR12.

2. records the digest of all cPCRs
   (cPCR - container PCR or virtual PCR that is stored for namespace).
   During measurement perform:

   tempValue := cPCRi.value xor cPCRi.secret;
   tempPCR := HASH(tempPCR || tempValue);

   Where cPCRi.value - is a value of a given namespaces, cPCRi.secret -
   random generated sequence of bytes for namespace,
   || - concatenation.

3. extends the physical PCR12 with the final tempPCR.
   PCR12 := PCR_Extend(PCR12,tempPCR)

Attestation:
When receiving this request, the IMA (and TPM) should provide
the following data:
1. the related PCR values, in our case this is PCR12

2. sendcPCRs list where sendcPCR for each namespace is calculated as:
   sendcPCRs = cPCRi.value xor cPCRi.secret
3. Measurement lists for namespace.

This work is also based on Stefan Berger's patches from:
https://github.com/stefanberger/linux-ima-namespaces

Denis Semakin (4):
  ima: Introduce PCR virtualization for IMA namespace.
  ima: Use tpm_chip from init IMA namespace.
  ima: Create vpcr file on securityfs.
  ima: Extend the real PCR12 with tempPCR value.

 security/integrity/ima/ima.h             |  13 +-
 security/integrity/ima/ima_fs.c          | 147 +++++++++++++++++++++++
 security/integrity/ima/ima_init_ima_ns.c |  21 ++++
 security/integrity/ima/ima_ns.c          |   3 +
 security/integrity/ima/ima_queue.c       |  55 +++++++++
 5 files changed, 238 insertions(+), 1 deletion(-)

v2: use sequential structure and methods for file on securityfs

-- 
2.38.GIT

