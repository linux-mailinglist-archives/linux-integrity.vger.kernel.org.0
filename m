Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED359141D
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Aug 2022 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiHLQnn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Aug 2022 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHLQnm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Aug 2022 12:43:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3888EAF0E2;
        Fri, 12 Aug 2022 09:43:41 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CGdYwi017656;
        Fri, 12 Aug 2022 16:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=W1kP0PQIOg8AznSGh3VKLzr+YxR+U4p2hGMeCUapCEo=;
 b=DhTWcU81TTD8AtxrX2FUkeGhlqYOpCrEuARXSBl/WaO0WrVbgYmY8OK2Lla95kx55QV/
 Gn01sJxspo51uvKmyokSrAgEbX9riRkx97dahF++wsyVO2aqetZ4OCOnqwVOPr9tmg/2
 R3c0iP6Q+bICKrZvEUDFEogpYW9DSx/zSjDy1oBzfZtu2IBfIs7ljuit3CEWNVKs5xXD
 4qEDJeVSLwBIkbYjJ5KlxE8gfOhIzW0oTkP47BkiPP89hZ921o2k1XrXKE47gi5J7wAl
 MKsc+/utp6K77CdhtHzr7055vOJ8Zwvm7hlxrbrdeh6E91jkJRyr37i8ADn/T763aRHU lg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwtd20k9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:43:25 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27CGZjN4010612;
        Fri, 12 Aug 2022 16:43:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3huwvry194-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:43:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27CGhBg410814012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 16:43:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23FA428058;
        Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A69D28059;
        Fri, 12 Aug 2022 16:43:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 16:43:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 0/6] tpm: Preserve TPM measurement log across kexec (ppc64)
Date:   Fri, 12 Aug 2022 12:42:59 -0400
Message-Id: <20220812164305.2056641-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ijKvv2nNsPSA_-Jv3zP-e4i4QPuup8r
X-Proofpoint-GUID: 5ijKvv2nNsPSA_-Jv3zP-e4i4QPuup8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=572 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120044
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
 drivers/of/kexec.c                    | 342 ++++++++++++++++++++++----
 include/linux/ima.h                   |   5 +
 include/linux/kexec.h                 |   6 +
 include/linux/of.h                    |  11 +-
 include/linux/tpm.h                   |  36 +++
 kernel/kexec_file.c                   |   6 +
 security/integrity/ima/ima_kexec.c    |   2 +-
 13 files changed, 478 insertions(+), 82 deletions(-)


base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
-- 
2.35.1

