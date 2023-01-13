Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB94669D6B
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jan 2023 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAMQRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Jan 2023 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAMQRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jan 2023 11:17:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DFB983C6;
        Fri, 13 Jan 2023 08:10:33 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFgUrK029247;
        Fri, 13 Jan 2023 16:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KKK98Acpc6wwU1hscfqPlS/CSZLuOJzjFQYQkvz3fII=;
 b=IoTxmUP2jl0bgG4vLGbZfTwxyCRcyyYjRX5ksQM50eYxbJxXFAAC4HRWnkHHI5xJl4yx
 S1arKBXjCM0BHgwo1BYs49CB5zkSlpKIg/R/0ux2T3k/hyNGusK/FlGriTb/aFBD3/ms
 v00Sd8Hp3la8HBDK+zUFlATuT31BPc59NpmKIGkzE9R6nfrN+t2CBWDamv9NMN2yQWWK
 GGZsSciZ4hOOG16Nm5h+QqfR8QwLrP6WI9Xql2RR9necR4JC4J815H4d08kH+vsKUdoD
 /bqGuyGOxgJusMlCXdb8YZoHEuOt1hOAxj4OCA4pies3GmASLQzRVjeljEqEqQpLOZSa Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3a60gp5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30DGAMtb000705;
        Fri, 13 Jan 2023 16:10:25 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3a60gp4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:25 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFKktU014454;
        Fri, 13 Jan 2023 16:10:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n1kv5mmtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30DGANfO42074494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:10:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5301D58056;
        Fri, 13 Jan 2023 16:10:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56F1358058;
        Fri, 13 Jan 2023 16:10:22 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.189])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 16:10:22 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/2] tpm: Add reserved memory event log
Date:   Fri, 13 Jan 2023 10:10:15 -0600
Message-Id: <20230113161017.1079299-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6wBqC1GcM4b3PCR7GwF5a3wOhE7wf65t
X-Proofpoint-GUID: dKOjhHNaXG0hjnX270jLPRVXY9DQcxVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=948
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some platforms may desire to pass the event log up to linux in the
form of a reserved memory region. Add support for this in the TPM
core to find the reserved memory region and map it. Since the memory
is mapped, not allocated, change all the event log allocation
functions to managed allocations so that the memory can be either
automatically freed or unmapped.

Changes since v1:
 - Use managed memory

Eddie James (2):
  tpm: Use managed allocation for bios event log
  tpm: Add reserved memory event log

 drivers/char/tpm/eventlog/acpi.c |  5 ++--
 drivers/char/tpm/eventlog/efi.c  | 13 +++++-----
 drivers/char/tpm/eventlog/of.c   | 41 ++++++++++++++++++++++++++++++--
 drivers/char/tpm/tpm-chip.c      |  1 -
 4 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.31.1

