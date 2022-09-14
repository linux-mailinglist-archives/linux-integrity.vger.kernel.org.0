Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08B5B8A38
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiINOWk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiINOWi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:22:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A34662E
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:22:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EEMDoj008500;
        Wed, 14 Sep 2022 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=73UQ/bwPu/pCUKxgGM/1FCTFJFszKENFQdfDN0AcmCI=;
 b=o62Wcnue93yhuzoXkAqCSxrkvqVysROXk9Ipfpt/RNgLnWBiYzULZMkYAVt/ktSzJnKL
 ccXo0ZFzo3h3l23SJbr2WMRVTKuxM2L/qwGRGoFvZZTwyn4Zk6iLdNGEUvit8sESbZyW
 GikuVQKHJoBKkrtSqK5VdxNgr2Ir9pAV/88N7h1mpeHL8zUoOzJHLGvpm5p+r5dODPt8
 Kj+WrmRoRPMj6bb2pXNXIO6lxlzrFVWAQZgEZgndGBPHC6tlKeP6Xf+zOdAG99kTvyll
 YVzxJ638ycn/w8kiQ3hEL8AWyALITfutBxu08gN61eTUkgyAwtm1nBrN1GEHbKxoy7oU og== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkgnmr062-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EEKWW4021805;
        Wed, 14 Sep 2022 14:22:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jjyfr93vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EEMUmA28508514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:22:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF38752051;
        Wed, 14 Sep 2022 14:22:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.200.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B3225204E;
        Wed, 14 Sep 2022 14:22:29 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 0/4] misc bug and other fixes
Date:   Wed, 14 Sep 2022 10:22:21 -0400
Message-Id: <20220914142225.1381077-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BCclBbX3kuuBSSbf48VV3IE01bQTSQXY
X-Proofpoint-GUID: BCclBbX3kuuBSSbf48VV3IE01bQTSQXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix coverity reported issues and the tpm2_pcr_supported() informational
message.

Mimi Zohar (4):
  Don't ignore number of items read
  Define and verify the template data length upper bounds
  Sanity check the template data field sizes
  Fix tpm2_pcr_supported() output messages

 src/evmctl.c         | 57 +++++++++++++++++++++++++++++++++++++-------
 src/imaevm.h         | 10 ++++++++
 src/pcr_ibmtss.c     | 12 +---------
 src/pcr_tsspcrread.c |  4 ++--
 4 files changed, 62 insertions(+), 21 deletions(-)

-- 
2.31.1

