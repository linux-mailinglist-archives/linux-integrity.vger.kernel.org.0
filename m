Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1F67D75B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjAZVI0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 16:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjAZVIU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 16:08:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD812F3E;
        Thu, 26 Jan 2023 13:08:18 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKKSje019516;
        Thu, 26 Jan 2023 21:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YN4wQepIscQnrjjeq8TYGcaDHfM6tUB+QuAo5PrqWJM=;
 b=G0USgGdotVLXdk40XcCePGFJarWkMXvfLutwsK6TwRCjtFOh9+PF9AuKSPcGoyJGyQyB
 BpdNxaFkc2eR4ogSC82VnDsFyqRiqNa4qiMM+m83ze0q7hLg/QFw6iGv4cvIHtaV4Cpf
 NPi0NCQzwDT6IgmfuK22nuV8bxgBGO9DMmcoM4PgtVgkiLwPMuDMXIoXUE8j7tXeUjPh
 +x0z4nPrx6LrZDYjpzN5beGCZgGeJpoVoSyUAomBmRNsdEqrUBGqJGlNFUbvYUALJ36D
 MtDeEPjvOzs3oqJmKBArKJqasf76ELMO0KvuD3FMo0g52sdSTwOpb+SzI1IjK5Ioyjgc rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc0fhguy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:14 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QKqnoT018446;
        Thu, 26 Jan 2023 21:08:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc0fhguxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKCIdl003161;
        Thu, 26 Jan 2023 21:08:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7fbu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QL8CbD67043734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:08:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41BCA58063;
        Thu, 26 Jan 2023 21:08:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF94B58059;
        Thu, 26 Jan 2023 21:08:10 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 21:08:10 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        stefanb@linux.ibm.com, eajames@linux.ibm.com
Subject: [PATCH v3 0/2] tpm: Add reserved memory event log
Date:   Thu, 26 Jan 2023 15:08:08 -0600
Message-Id: <20230126210810.881119-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cA0NYR5KYYUq_tjkqG5jQP28Au1jsGWy
X-Proofpoint-GUID: ORLHV1HNL4xE4ctbYlwwid4kIrRKIXMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=800 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some platforms may desire to pass the event log up to Linux in the
form of a reserved memory region. In particular, this is desirable
for embedded systems or baseboard management controllers (BMCs)
booting with U-Boot. IBM OpenBMC BMCs will be the first user.
Add support for the reserved memory in the TPM core to find the
region and map it.
Since the memory is mapped, not allocated, change all the event log
allocation functions to managed allocations so that the memory can be
either automatically freed or unmapped.

Changes since v2:
 - Improve commit message for patch 2

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

