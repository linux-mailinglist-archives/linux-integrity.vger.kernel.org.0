Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F99616CF5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiKBSpt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiKBSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624A2F672
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 11:45:43 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Ie6KK010692
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=tqR+bn9D/9JN38qx9VFMgO6JcptkLfdwPFdavPB4lFU=;
 b=lFlvdt4e4SFI5DGvJHNxA9wsHkkGidQFAGH58XWS2VXNXiicW5m8yfOz0crIwcZUtqX5
 MDN0DEZIU3S9MlpR3FKHinVrhv5AjWswHnkOcBKO0i3iVJ1oeVQkxDA7+uM2euFGBlvL
 /kWX2FKvE/oq/o+rBdiS+MZXWmYsYvFFWb6ED9XbpO4f7wdThRNK8oj2zRFTceVGYdOs
 A3vYd0FO5WGgFybIFFBVwv+ybIRidmAcc344Y2my+cvikxBVXQMZO7zJHdml8wsl2pNH
 l0IluEdW6OPZJCymuAoHuIx/5lXFsR/pyW3mL5lbmdiKT1+2k1fjpOHxWpXkMvO4IZoq Mw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkvbybm1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:42 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Ia9cX004225
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:42 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3kgut9vhe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2IjdUM16122504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:45:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A5358043;
        Wed,  2 Nov 2022 18:45:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6444A58059;
        Wed,  2 Nov 2022 18:45:40 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 18:45:40 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v1 0/4] Fix some issues in evmctl
Date:   Wed,  2 Nov 2022 14:45:30 -0400
Message-Id: <20221102184534.1075049-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1pTD-MT4Arlu4NccMBnKGKsiW6cDY6aZ
X-Proofpoint-ORIG-GUID: 1pTD-MT4Arlu4NccMBnKGKsiW6cDY6aZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=959
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches fixes memory leaks related to tpm_bank_info
allocations and entry.template as well as gcc compiler warnings
when building with -fanalyzer (gcc 12.2.1).

This series is intended to be applied on top of Mimi's current series
at https://github.com/mimizohar/ima-evm-utils/tree/next-testing .

   Stefan

Stefan Berger (4):
  Fix memory leaks of tpm_bank_info allocations
  Fix memory leak related to entry.template
  Add assert to ensure that algo_name in bank is set
  Change condition to free(pub)

 src/evmctl.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)


base-commit: f6abaed5d0d0a4478cf25a8096a4ff44be4a234e
-- 
2.38.1

