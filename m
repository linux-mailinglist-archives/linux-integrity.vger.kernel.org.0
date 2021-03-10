Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B204334B69
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhCJWTu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 17:19:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhCJWTW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 17:19:22 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AMJ7YP092842;
        Wed, 10 Mar 2021 17:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U6Q6YSp3p3MjpM5WvP5W3H0IQrrDqz81gomghM2Ui04=;
 b=UBJsZnvZiKL2KXoEau+XwwFzJcPlSzMwlZPX5rMuzM8HED92/oFUC0DCmJcbONqZ6A00
 qiB6wBl5nEs96hhTfq4D7nqTHyN2eQTDfAgxTx7CbvOugs+AQSNNJyM4MYKDhWl1ky8e
 xkzs+usu8TcSROLVIY1qVNZ9b70hKcCvT61RD8GxwQvPKrON02z1GB+J50yphHxs0QnL
 bQjNaBW0dx3FpBRe7w6H4MiXj66M2hHj1qtR888YNtm5UFEF3C944LE3yi2RGPDZgjlp
 ySQX3ejn34eSrldEc264Quj+gUZT/e8W0sWgfXlh3QquWqbdXtZxFrT02MebVe05eQw1 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kx3qwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:21 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AMJEp6093062;
        Wed, 10 Mar 2021 17:19:21 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kx3qwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:21 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AMI3Ua022068;
        Wed, 10 Mar 2021 22:19:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 37690a5uvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 22:19:20 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AMJJqb23724318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:19:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48793AE064;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31525AE05F;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] Fix bugs related to TPM2 event log
Date:   Wed, 10 Mar 2021 17:19:13 -0500
Message-Id: <20210310221916.356716-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches fixes a couple of issues related to TPM2
event logs, such as the disappearance of the TPM2 log on QEMU machines
running with UEFI (my fault) and a kernel fault due to an integer under-
flow when reading the TPM 2 log multiple times.

Regards,
   Stefan

v1->v2:
 - Revised patches 1 & 2

Stefan Berger (3):
  tpm: efi: Use local variable for calculating final log size
  tpm: acpi: Check eventlog signature before using it
  tpm: vtpm_proxy: Avoid reading host log when using a virtual device

 drivers/char/tpm/eventlog/acpi.c   | 33 +++++++++++++++++++++++++++++-
 drivers/char/tpm/eventlog/common.c |  3 +++
 drivers/char/tpm/eventlog/efi.c    | 29 ++++++++++++++++++--------
 3 files changed, 56 insertions(+), 9 deletions(-)

-- 
2.29.2

