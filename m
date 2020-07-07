Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54F216401
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGGC1e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:27:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbgGGC1e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:27:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06723nEa074805;
        Mon, 6 Jul 2020 22:27:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324bpme4da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:31 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0672RVqW006155;
        Mon, 6 Jul 2020 22:27:31 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324bpme4cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:31 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672RTOC024557;
        Tue, 7 Jul 2020 02:27:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 322hd7sf0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:27:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672RQqS64094364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:27:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C585A4051;
        Tue,  7 Jul 2020 02:27:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0687A4040;
        Tue,  7 Jul 2020 02:27:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:27:25 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 0/3] ima-evm-utils: original "ima" template support
Date:   Mon,  6 Jul 2020 22:27:14 -0400
Message-Id: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=910 adultscore=0
 suspectscore=1 bulkscore=0 clxscore=1015 cotscore=-2147483648 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070014
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA LTP and standalone tests supported verifying the the original
"ima" template format against the TPM PCRs, as well as verifying the 
"boot_aggregate" based on walking the TPM 1.2 event log and calculating
the TPM PCRs values.

Add this support to ima-evm-utils.

(Dependency on the misc-fixes patch set.)

Mimi

Mimi Zohar (3):
  ima-evm-utils: support the original "ima" template
  ima-evm-utils: read the TPM 1.2 binary_bios_measurements
  ima-evm-utils: mixed "ima" and other template formats not supported

 src/evmctl.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 168 insertions(+), 18 deletions(-)

-- 
2.7.5

