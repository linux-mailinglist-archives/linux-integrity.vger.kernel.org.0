Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03D39A458
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFCPUa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 11:20:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhFCPUa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 11:20:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153F5Yk7003370;
        Thu, 3 Jun 2021 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5ie9oRi1eHkBEiOxwOQ/KHkIDg9sdkheXbT9aD5junY=;
 b=ji4ADqU/bhTUTZj8DmMeZopzZQ1Nb//kj0m0RaEIIWcLr5ESxSc0ygLit4W8aJRlc0fJ
 aJiPjjCH+HqhmD0rfoft3XJNmxsEdg0d85tPmP91hgiRQR3aOGHm9MoZG/1PlhOwNglH
 ahQE3kw5XuQMa/QCHoB/b79V26ffbCNRVSPoecSlw2dzsSx4d7e8q1C/eFVrZZJU1jk+
 ij+f87g7bRQrRmHTy4bH+xm+P9QppjDTt4N2WetsrJpg00uhtDuKcZEtSUfR3mTPkKzc
 nAODGvOulVthaPFXlzGVUHT9NTrPFjYGYYoc8JuMTv+7Hh9HYN9+qB0rzOGVoUZNCYdG ig== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y07ftrtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 11:18:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153FI7KK032761;
        Thu, 3 Jun 2021 15:18:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 38w413s22m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 15:18:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153FISbp25821540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 15:18:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60688A405B;
        Thu,  3 Jun 2021 15:18:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4EBA4057;
        Thu,  3 Jun 2021 15:18:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.13.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 15:18:26 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 0/2] EVM: add some debugging info
Date:   Thu,  3 Jun 2021 11:18:17 -0400
Message-Id: <20210603151819.242247-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zIRZ9NPy3-X94rkRzYVeGfg_Gl1PP80U
X-Proofpoint-ORIG-GUID: zIRZ9NPy3-X94rkRzYVeGfg_Gl1PP80U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_09:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=868 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the recent EVM portable & immutable signature usability improvements
and the ability of including the EVM portable signatures in the IMA
measurement list, adding some debugging information - security xattrs and
file metadata (misc info) - would be useful.

Suggestons on how to improve this patch set would be much appreciated.

thanks,

Mimi

Mimi Zohar (2):
  ima: differentiate between EVM failures in the audit log
  evm: output EVM digest calculation info needed for debugging

 security/integrity/evm/evm.h          |  1 +
 security/integrity/evm/evm_crypto.c   |  7 +++++++
 security/integrity/evm/evm_main.c     | 19 +++++++++++++++++++
 security/integrity/ima/ima_appraise.c |  3 ++-
 4 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.27.0
