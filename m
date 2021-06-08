Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B9339F7D7
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhFHNcC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 09:32:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhFHNcB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 09:32:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158DJx7U113717;
        Tue, 8 Jun 2021 09:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ST4nynMMLfp5NZFAELAALnjCts90CO2/LW5ZIKiUwgM=;
 b=Zt1rOqAdplkkixq1sAwe1stH/gM/cmVyt/8Q/P+A/vJewsIjkjIgQIoR8rPH69eeYofx
 Y7MJ9M8Wb0APmt81ARp//nDcbWoZ1iaWNiy1PVYxYfUwRGiSJi7HR35txAYqIMUxhink
 qOS9AZku4jAQ/nN7gs6I/1wxsIN6JXGD4A4FZCPzQXRGUp9q+xr06oxAwG1zZxW7g/IC
 2yH6zhMEHDGokhvLZcp/2Cf6D7Q9s1YX4RulcFlm5CRbJxnyew+9O7mck27Q2Hz2BcWk
 nwiKKBl3fn49+nkoFyW2eJiXDYLdvHG6n08gCR4NEfDDLDrVtIyVZO1r2prn4m32T4n0 5Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39298j8e88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 09:30:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158DRRad019149;
        Tue, 8 Jun 2021 13:30:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hhsjfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 13:30:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158DTC4U33751388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 13:29:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3D8A4062;
        Tue,  8 Jun 2021 13:29:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4842A4060;
        Tue,  8 Jun 2021 13:29:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.43.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jun 2021 13:29:56 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/2] EVM: add some debugging info
Date:   Tue,  8 Jun 2021 09:29:48 -0400
Message-Id: <20210608132950.424148-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oPD5ziaaSlbfTZJWi_AhFK4nvEpDnUNu
X-Proofpoint-ORIG-GUID: oPD5ziaaSlbfTZJWi_AhFK4nvEpDnUNu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_09:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=759 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the recent EVM portable & immutable signature usability improvements
and the ability of including the EVM portable signatures in the IMA
measurement list, adding some dynamic debugging information - security
xattrs and file metadata (misc info) - would be useful.

Mimi Zohar (2):
  ima: differentiate between EVM failures in the audit log
  evm: output EVM digest calculation info

 security/integrity/evm/evm_crypto.c   | 42 +++++++++++++++++++++++++++
 security/integrity/evm/evm_main.c     |  4 +++
 security/integrity/ima/ima_appraise.c |  3 +-
 3 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.27.0

