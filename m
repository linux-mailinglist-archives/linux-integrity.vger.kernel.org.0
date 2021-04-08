Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAB358832
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhDHPYV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 11:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231931AbhDHPYV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 11:24:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138FAKNY049513;
        Thu, 8 Apr 2021 11:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=nMgDagvUiQ4G3wBqYsuuu5noca3UTFZwGZRQb1V8X4I=;
 b=Koc5kRX2UglPYyOhvxgHVQqtgVM4ZqjX2vbtcedtn+8Yx4Tf+Ta5BFjtcoEfvx+uPrWv
 86eY9tCEoD1HBtnketjElHoVMf0uLFL6Gj2FA/67ujktDLHeHmpA+/b3dPGqdwdPEOFn
 Tem5yvuXBvnDyW5rFfSnmDWW3FpWI6GsiIo4MTSpoWPJGsgqbbbusI8G0aTzTusvef/q
 IywKiq9dGW874+GaNFskDCFwhPkjqzA2I3GifgpY/n4x8rfI65bButlG0a8wNcE3ky36
 X9MbWTgS1pJ0x2ONxBT5sSXRIVGSNlYhZXFkxkWlXhhDswLIFRTvaBFoX2MeHLb4ASZ0 wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37t3g9hwtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:24:09 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138FAdIq050716;
        Thu, 8 Apr 2021 11:24:08 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37t3g9hwsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:24:08 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138FNSuV008846;
        Thu, 8 Apr 2021 15:24:07 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 37rvs1h6dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 15:24:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138FO62P26345862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 15:24:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC94112064;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31284112063;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] Add support for ECDSA-signed kernel modules
Date:   Thu,  8 Apr 2021 11:24:01 -0400
Message-Id: <20210408152403.1189121-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CCSQ8LB3uydsbfcLNY6ddgo2avTSmbcT
X-Proofpoint-GUID: GgEhysX5mCA_ltCM-oRlTcssmMFjBcps
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series adds support for ECDSA-signed kernel modules. It also
attempts to address a kbuild issue where a developer created an ECDSA
key for signing kernel modules and then builds an older version of the
kernel, when bisecting the kernel for example, that does not support
ECDSA keys.

The first patch addresses the kbuild issue of needing to delete that
ECDSA key if it is in certs/signing_key.pem and trigger the creation
of an RSA key. However, for this to work this patch would have to be
backported to previous versions of the kernel but would also only work
for the developer if he/she used a stable version of the kernel to which
this patch was applied. So whether this patch actually achieves the
wanted effect is not always guaranteed.

The 2nd patch adds the support for the ECSDA-signed kernel modules.

This patch depends on the ECDSA support series currently queued here:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc

  Stefan

v2:
  - Adjustment to ECDSA key detector string in 2/2
  - Rephrased cover letter and patch descriptions with Mimi


Stefan Berger (2):
  certs: Trigger creation of RSA module signing key if it's not an RSA
    key
  certs: Add support for using elliptic curve keys for signing modules

 certs/Kconfig                         | 25 +++++++++++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
 3 files changed, 43 insertions(+)

-- 
2.29.2

