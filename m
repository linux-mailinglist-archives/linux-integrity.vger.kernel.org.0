Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C515645956B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Nov 2021 20:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhKVTVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Nov 2021 14:21:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22238 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhKVTVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Nov 2021 14:21:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJFnoP019941;
        Mon, 22 Nov 2021 19:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hyDZMZs0PrlEjLZfvf32IqhNVdXKS4hHj8B4idCs7a8=;
 b=AON3J5xzmVwkDGEJ+Ob8OD5vivfL2pIWqlG+3phlIAgoUIbuVo+2fjdQPXOfP3mxyeLw
 H9zAjN/fPOcUdzCSHMqHDgY6fwZlkjEChsi5FN+FURpe7Lc5kI46tEhbBPfmv846QeIU
 5iRq8jOXpPOLb+siT5O62YyyI2gWj153Df0K+cmpA9zUao/Z+uY62KIVCTcDTUGF73UO
 AldlQIbe7RC2M6mUNm81skCTaROvZJpVJQ6eL06Q2mScfQ7wF3A7YJK0YrDzZM5n7TUr
 1FZjB+iUS5oo8sZaKLT2YNnXqYB2SuDvPHUzufRD45QoNvCMjI1gCOU6Ivp6lk5bAH3i Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgh78r10f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:17:57 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMJGneR022168;
        Mon, 22 Nov 2021 19:17:57 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgh78r106-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:17:57 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJCvaI006147;
        Mon, 22 Nov 2021 19:17:56 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 3cerna54m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:17:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMJHtpH56754486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 19:17:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD7EBE053;
        Mon, 22 Nov 2021 19:17:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DE7DBE05A;
        Mon, 22 Nov 2021 19:17:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 19:17:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/2] selftests: tpm2: Probe for available PCR bank
Date:   Mon, 22 Nov 2021 14:17:50 -0500
Message-Id: <20211122191752.1308953-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bXOVH6KMazcLTHodsjJVAJzYN1N49_hA
X-Proofpoint-ORIG-GUID: zoorMl3mNpbew4kta4gNjY2ki2j4akr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches fixes two issues with TPM2 selftest.
- Probes for available PCR banks
- Resets DA lock on TPM2 to avoid subsequent test failures

  Stefan

Stefan Berger (2):
  selftests: tpm: Probe for available PCR bank
  selftests: tpm2: Reset the dictionary attack lock

 tools/testing/selftests/tpm2/tpm2_tests.py | 32 ++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.31.1

