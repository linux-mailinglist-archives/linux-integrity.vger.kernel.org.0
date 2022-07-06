Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EBE568C94
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiGFPXz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiGFPXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 11:23:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BAD1EC43;
        Wed,  6 Jul 2022 08:23:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266EWNj2008525;
        Wed, 6 Jul 2022 15:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GqfdF8L1josTjn4gSKMpVt2e0w3DxLAN0XMqncZijg8=;
 b=a9xKkZ/o84iXC1aTc03gyo+GcQmCDIVOR47/iBPOXzKhG4N6xE7tjbKkyhSLQNREage1
 Pwx2bc343HnMaghT4+5JD+mJENXPHDsfkHrtDt1m9AZ7QsanYPXwzb/IfpbxVcXGPeyE
 DGF3kw2KF+xatgzTN9LPV/bT4v1Fq6B3QkVnMc41K3qqyxM6LUNSWQkoFQ/9mygJr8xG
 ZpYy/4B1HooUP+QZCbuT9C2vbXFGTLoY6kFH8RP96lRpZ0A0ScwpSiG9xeSbMrCqAONZ
 YiHPc5tvnkU1hSmPO5l4opPx3ZOlDWynnXlPruVpylKgjC9js8Q7TKj/vzomACRZBzZy BQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5as4c91b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 15:23:39 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266FLTkq002931;
        Wed, 6 Jul 2022 15:23:39 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3h4ud1n7yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 15:23:39 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266FNccK32506212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 15:23:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40B82112061;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BD9112064;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 0/6] tpm: Preserve TPM measurement log across kexec (ppc64)
Date:   Wed,  6 Jul 2022 11:23:23 -0400
Message-Id: <20220706152329.665636-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 74g5zCz-hh4mOnUkq2FRI6sXOvCKh7b6
X-Proofpoint-ORIG-GUID: 74g5zCz-hh4mOnUkq2FRI6sXOvCKh7b6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=605 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
series fixes this for the kexec_file_load() syscall using the flattened
device tree (fdt) to carry the TPM measurement log's buffer across kexec.

   Stefan

v5:
 - Rebased on 1 more patch that would otherwise create merge conflicts

v4:
 - Rebased on 2 patches that would otherwise create merge conflicts;
   posting these patches in this series with several tags removed so
   krobot can test the series already
 - Changes to individual patches documented in patch descripitons

v3:
 - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c

v2:
 - rearranged patches
 - fixed compilation issues for x86

Jonathan McDowell (1):
  x86/kexec: Carry forward IMA measurement log on kexec

Palmer Dabbelt (1):
  drivers: of: kexec ima: Support 32-bit platforms

Stefan Berger (3):
  tpm: of: Make of-tree specific function commonly available
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

Vaibhav Jain (1):
  of: check previous kernel's ima-kexec-buffer against memory bounds

 arch/x86/Kconfig                      |   1 +
 arch/x86/include/uapi/asm/bootparam.h |   9 +
 arch/x86/kernel/e820.c                |   6 +-
 arch/x86/kernel/kexec-bzimage64.c     |  42 +++-
 arch/x86/kernel/setup.c               |  63 +++++
 drivers/char/tpm/eventlog/of.c        |  31 +--
 drivers/of/kexec.c                    | 341 ++++++++++++++++++++++----
 include/linux/ima.h                   |   5 +
 include/linux/kexec.h                 |   6 +
 include/linux/of.h                    |  10 +-
 include/linux/tpm.h                   |  27 ++
 kernel/kexec_file.c                   |   6 +
 security/integrity/ima/ima_kexec.c    |   2 +-
 13 files changed, 467 insertions(+), 82 deletions(-)


base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.35.1

