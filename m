Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D76E662A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Apr 2023 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDRNoT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Apr 2023 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjDRNoS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Apr 2023 09:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28BD86B6;
        Tue, 18 Apr 2023 06:44:14 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDG74s012838;
        Tue, 18 Apr 2023 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3rTxPXcrDEqRa/DaBHbZhPe1zpvsDR1Y31o1ZvJjF3s=;
 b=cwpLlpRCIH9kcNaFoDBJilVOnpiAWFvWxJEO8D6qQjW1yFy7604PuDFE/fhKsjkC9Xmh
 KAOdmKnjk60hUCkXgGXRKyCW12vWiIS0n4p97Ut4gujiJULcNsS2NbNjT/NFui/UsBcP
 qzZfQifUGxLFgYHEkowMjV7Ckje1s0vYmyvItK1Qa56F92sKtb2bQu3i2FWUJKV3VJag
 2Eh5Z2WVJlNvxdQu9HGccEWkLxuR9JLxcQtucQCAvVLuj0cqI905Iq4s1sUeMc0B0kuM
 d3TOYGAX9MMxvaktOU7UREMNdasQ6ePFSn+6fz4TsV/q7aYoLNhmwCWH/1anUhk3148B rg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q35a8qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 13:44:13 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ICSkMv012039;
        Tue, 18 Apr 2023 13:44:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pykj7967f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 13:44:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IDiBoJ27525774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 13:44:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E74F558059;
        Tue, 18 Apr 2023 13:44:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1351D58055;
        Tue, 18 Apr 2023 13:44:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 13:44:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
Date:   Tue, 18 Apr 2023 09:44:05 -0400
Message-Id: <20230418134409.177485-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VbtAIg_lLbzpMzY2eBe8yJ8mzsDB6Cdp
X-Proofpoint-ORIG-GUID: VbtAIg_lLbzpMzY2eBe8yJ8mzsDB6Cdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=696 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180118
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

v9:
 - 2/4: Rebased on 6.3-rc7: call tpm_read_log_memory_region if -ENODEV returned

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

 drivers/char/tpm/eventlog/of.c |  30 +--
 drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   6 +
 include/linux/tpm.h            |  36 ++++
 kernel/kexec_file.c            |   6 +
 6 files changed, 344 insertions(+), 76 deletions(-)


base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.38.1

