Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82066EE551
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Apr 2023 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjDYQLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Apr 2023 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjDYQLW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Apr 2023 12:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA91A2
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 09:11:08 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PG8v3g000810
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4uFW9cnxsPiZkCDcw04SGRBajVWwwKRQg7t9CZhrAKI=;
 b=MIRKICJcVkAJarPQZASEBBeHz5sCo4XboEib3pi1HrU2wEDgpVQzba4o09fxDyimByhb
 Ytwm2i++QG9U9d5JP7DfjiLFQvHMOWZT9f5zKEAUQ55+XbVrSXv9Jl7hve5Zd5HWckLy
 NM8ux+ZRnGUzG0/Yfyx8Woxli24WbapcM/WiwMLVNCKCvrP6PM5qSQRlLzCjAXaa5FlT
 Y4cZ4lPQPlXbgiU8MFK77N+3zcHKtWNabWe2PLIkj4GGCoiV5Hfkfr+vcL74qaO0aVkd
 ZUHxjt7ikPSjtsDY+oXcJPL7pVAvILIETAozCWn17ysFWBeQu45Q6lu/kkTNOMr0q8Wb UA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6j0bgd7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:11:06 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFObcb010715
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3q4778daud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 16:10:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PGAJhX22413826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:10:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B19D958064;
        Tue, 25 Apr 2023 16:10:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689F858061;
        Tue, 25 Apr 2023 16:10:19 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 16:10:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 0/2] Update README and examples for ECC key support
Date:   Tue, 25 Apr 2023 12:10:13 -0400
Message-Id: <20230425161015.593988-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: thzQq43cEgoQ0OGOY8zzjkvJERcJYfcH
X-Proofpoint-GUID: thzQq43cEgoQ0OGOY8zzjkvJERcJYfcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=832 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update the README and add example scripts for ECC key and cert support.

Regards,
   Stefan

Stefan Berger (2):
  Add openssl command line examples for creation of EC keys
  examples: Add examples for elliptic curve key and certs generation

 README                           | 24 +++++++++++++++++++++++
 examples/ima-gen-local-ca-ecc.sh | 29 ++++++++++++++++++++++++++++
 examples/ima-genkey-ecc.sh       | 33 ++++++++++++++++++++++++++++++++
 examples/ima-genkey-self-ecc.sh  | 29 ++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100755 examples/ima-gen-local-ca-ecc.sh
 create mode 100755 examples/ima-genkey-ecc.sh
 create mode 100755 examples/ima-genkey-self-ecc.sh

-- 
2.39.2

