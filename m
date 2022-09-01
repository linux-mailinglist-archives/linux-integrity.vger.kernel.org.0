Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8C5AA1A0
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Sep 2022 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiIAVqj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Sep 2022 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiIAVqi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Sep 2022 17:46:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE379A45;
        Thu,  1 Sep 2022 14:46:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281LUgSW031933;
        Thu, 1 Sep 2022 21:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r2ZqQzsxMzMBvy51gRpn7fAMC1irQrpsOuT7QpcOflw=;
 b=Ket3w1/Aq7qOEsc1YWBmSvfDetKV0jycPNgjtk3WQz4+UqU9QmMUv2aY7WA9w2pHCekL
 wO0oTAuRi0TJNALLyyK9+8vfuOAWj20F2UsS+5D7XPsKaWI3WG/SEbT5aygf8que9ukB
 5GUp+vkg8ka3NP9Hl4yvISnny3swTxU1LyF+rF07evkOPGS2C+MCbwHtU0/6eulxYlNp
 Pk00G4vRokI7ualg5vnFn418SdkAS1PmPLqVM59mqzSF7M96TtdAXVOPw4lh73yocgeQ
 HMTtznSqxXpH4uxnh/hpcr+7btmzBHJiXYsOiYiQCuGxkmV3qnzA9z5JPYnHJ2qrUH9E 8A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jb4qg0h3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 21:46:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 281LaGBO019083;
        Thu, 1 Sep 2022 21:46:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3j7awa4v52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 21:46:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 281LkL3S15860208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 21:46:21 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E35A5C6057;
        Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE01C6055;
        Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
Date:   Thu,  1 Sep 2022 17:46:06 -0400
Message-Id: <20220901214610.768645-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GsA1unPRsVQRw4jZ6R8Ro8Eu6KpIZ5_9
X-Proofpoint-GUID: GsA1unPRsVQRw4jZ6R8Ro8Eu6KpIZ5_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010094
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

v8:
 - Added Jarkko's, Coiby's, and Rob's tags
 - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches

v7:
 - Added Nageswara's Tested-by tags
 - Added back original comment to inline function and removed Jarkko's R-b tag

v6:
 - Add __init to get_kexec_buffer as suggested by Jonathan
 - Fixed issue detected by kernel test robot

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

Palmer Dabbelt (1):
  drivers: of: kexec ima: Support 32-bit platforms

Stefan Berger (3):
  tpm: of: Make of-tree specific function commonly available
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

 drivers/char/tpm/eventlog/of.c |  31 +--
 drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   9 +-
 include/linux/tpm.h            |  36 ++++
 kernel/kexec_file.c            |   6 +
 6 files changed, 346 insertions(+), 78 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.35.1

