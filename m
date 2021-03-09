Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA97331D5A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 04:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCIDUS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 22:20:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhCIDUE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 22:20:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12933P4I035048;
        Mon, 8 Mar 2021 22:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xwuhBfjJgysHEK4duPU09vbuwPn5ZvItwHvLHoyabjo=;
 b=ZtLPy+UTj1aUsk0I5NkKc8UtZotxy7vo4ENAuRV9gOmK4X0uFBY5zq2H34XLG8erI9cl
 m9NYDuBHmjMg0Kxrs3ej85Mp6bDKQTea0cKLBFRM+FC60gkHFwai7LJTgxKpm/ygoltw
 jzJxbl/rvY/1hcqyS5fdoO7NsyBEb3HvOmXPP6aQ2kP1nqMg6YBY4yvc0Ey6hmuOAGD2
 3tUApDwnFnItuKI87VNNdouLNREs9RQfQ6RmpctP2fyet+Hn0emdzqPGCCw8MtUqfgda
 +5KWcY6ZUKzCPfYTmVqganuQ3K77UExxyqcVktcwbjF8ngAJBFlAD/AcVVlJuKUJ+j3P 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whqcej1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:02 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12936pb5043839;
        Mon, 8 Mar 2021 22:20:02 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whqceh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:02 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1293CXDS012370;
        Tue, 9 Mar 2021 03:20:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3741c9kayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 03:20:01 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1293K0p534472330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 03:20:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B163BE065;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9282CBE05F;
        Tue,  9 Mar 2021 03:19:59 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 03:19:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/3] Fix bugs related to TPM2 event log
Date:   Mon,  8 Mar 2021 22:19:51 -0500
Message-Id: <20210309031954.6232-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches fixes a couple of issues related to TPM2
event logs, such as the disappearance of the TPM2 log on QEMU machines
running with UEFI (my fault) and a kernel fault due to an integer under-
flow when reading the TPM 2 log multiple times.

Regards,
   Stefan

Stefan Berger (3):
  tpm: efi: Use local variable for calculating final log size
  tpm: acpi: Check eventlog signature before using it
  tpm: vtpm_proxy: Avoid reading host log when using a virtual device

 drivers/char/tpm/eventlog/acpi.c   | 31 +++++++++++++++++++++++++++++-
 drivers/char/tpm/eventlog/common.c |  3 +++
 drivers/char/tpm/eventlog/efi.c    | 10 ++++++----
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.29.2

