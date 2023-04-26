Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640CF6EFD32
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDZWhP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWhO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 18:37:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDCA1
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 15:37:13 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMSMiD030455
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U8cPpZOX/ux367DtLLIZoV+EaqS0lkAThmXRmnjNTR8=;
 b=ldzt+GuLtWMR1yM69bOK/TNVHtukMxCzT6F0d2EOIVRxU+Fj1SsaEryuwxQ8JNGZ8F7K
 lAM96eSTCVToRI54RMV3UqfyIJ39RgtiJ6hLadmV6T/jXBfwwcTrQkNYZdZIO3ZWx0GP
 Kr1W0e8IgBF97dZBvwFgeEMYh51ecqSSu/ydufeRcsrVfS8kGO6UKFiTCk2hoCZHbl3m
 o9cSwL9NGN5neTf87MUIiITxmVa1aI/9IANN/H+2qRlpKOFPwg7lSaKtwcuDcctBfpM0
 tNWQXNIUSxwUxrkNfOdyUcIGvrDsMangRKBZgLaXAKUSVtUVRoNgOFs//qli4Qb3dO+i VA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7bnhj5g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:37:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLvDue009714
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q47795af2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 22:36:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QMa1ZA38076832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 22:36:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC9858056;
        Wed, 26 Apr 2023 22:36:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 599C858055;
        Wed, 26 Apr 2023 22:36:01 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 22:36:01 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 0/4] Update README and examples and add EC key support
Date:   Wed, 26 Apr 2023 18:35:55 -0400
Message-Id: <20230426223559.681668-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8VnBscHb50mS4PKERtaAhe0TPLaW6VfZ
X-Proofpoint-ORIG-GUID: 8VnBscHb50mS4PKERtaAhe0TPLaW6VfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=868 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update the README and add example scripts for RSA keys to use more up-to-date
values for key sizes and hash being used and adjust the OpenSSL config files so
that the created keys can be used with the .machine keyring. Add EC key and cert
support scripts and describe EC key and certificate generation in the README.

Regards,
   Stefan

Stefan Berger (4):
  Update default key sizes and hash to up-to-date values
  Update OpenSSL config files for support for .machine keyring
  Add openssl command line examples for creation of EC keys
  Add example scripts for EC key and certs generation

 Makefile.am                      |  8 ++++++-
 README                           | 41 +++++++++++++++++++++++++-------
 examples/ima-gen-local-ca-ecc.sh | 29 ++++++++++++++++++++++
 examples/ima-gen-local-ca.sh     |  4 ++--
 examples/ima-genkey-ecc.sh       | 34 ++++++++++++++++++++++++++
 examples/ima-genkey-self-ecc.sh  | 29 ++++++++++++++++++++++
 examples/ima-genkey-self.sh      |  4 ++--
 examples/ima-genkey.sh           |  5 ++--
 8 files changed, 139 insertions(+), 15 deletions(-)
 create mode 100755 examples/ima-gen-local-ca-ecc.sh
 create mode 100755 examples/ima-genkey-ecc.sh
 create mode 100755 examples/ima-genkey-self-ecc.sh

-- 
2.39.2

