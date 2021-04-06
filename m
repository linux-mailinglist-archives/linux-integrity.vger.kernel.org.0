Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB530355BB8
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDFSyt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 14:54:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239701AbhDFSx4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 14:53:56 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136IZA3T146243;
        Tue, 6 Apr 2021 14:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=rqY2PHD6r63nKab242YLhUvp5wVOuASNMmg7gQKzDvU=;
 b=LXbyfF6H0+JeWgHdKjG4sUY88Z07hmsyHUPvlloOrklkQJn9gPFeEYlIHTVNMlSX/Cgv
 8WsqEhDHtZ+2IVkhbp5C2gsdsv2xB34/3qZd1RvWuZ/dVADjB3esBJi5dsttS0n+2dXs
 cNKtQsAPjYR2bhiYWJR34RpPe5UY8sPNtO0fwvunAb8XVE6frUMV3tCXlOO9gX5SRf32
 1LErG/lSQHVETOAtokHaFKyWFscwvOXcupBuYy9hKP6AwnWkYwrfmXGzAHx4xK8Bl8fs
 5630xFA8Z2VQ1eSWF9XKhzek7jmCn0exY9QPwRlKT99OwH3/bs54dVpklarMzbAfZctA Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvmys6ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 14:53:47 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136IaGn0152084;
        Tue, 6 Apr 2021 14:53:47 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvmys6ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 14:53:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136IeHdF027813;
        Tue, 6 Apr 2021 18:53:46 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 37q32mhrj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 18:53:46 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136Irib923331162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 18:53:44 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8526A04D;
        Tue,  6 Apr 2021 18:53:44 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B736A047;
        Tue,  6 Apr 2021 18:53:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Apr 2021 18:53:44 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/2] Add support for ECDSA-signed kernel modules
Date:   Tue,  6 Apr 2021 14:53:38 -0400
Message-Id: <20210406185340.1079403-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R1zEFSbGnmwoNvyHgnryAN-KoLNXrn8W
X-Proofpoint-ORIG-GUID: 3wNgGsLIcDvNvGoAFnskEpfV9xMpuxDS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_06:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series adds support for ECDSA-signed kernel modules.

The first patch in this series attempts to address the issue where a
developer created an ECDSA key for signing modules and then falls back
to compiling an older version of the kernel that does not support
ECDSA keys. In this case this patch would delete that ECDSA key if it is
in certs/signing_key.pem and trigger the creation of an RSA key. However,
for this to work this patch would have to be applied to previous versions
of the kernel but would also only work for the developer if he/she used a
stable version of the kernel to which this patch was applied. So whether
this patch actually achieves the wanted effect is not always guaranteed.

The 2nd patch adds the support for the ECSDA-signed kernel modules.

This series depends on Nayna's series https://lkml.org/lkml/2021/3/30/571
and my ECDSA support series currently queued here:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc

  Stefan

Stefan Berger (2):
  certs: Trigger recreation of module signing key if it's not an RSA key
  certs: Add support for using elliptic curve keys for signing modules

 certs/Kconfig                         | 25 +++++++++++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
 3 files changed, 43 insertions(+)

-- 
2.29.2

