Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3B234AD8
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgGaSYi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387716AbgGaSYi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIKM4K023591;
        Fri, 31 Jul 2020 14:24:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mfb908yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:34 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIKs1I026120;
        Fri, 31 Jul 2020 14:24:33 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mfb908xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:33 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIL7kE030249;
        Fri, 31 Jul 2020 18:24:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 32gcqk4m9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIOTbO30015762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:24:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F3D052057;
        Fri, 31 Jul 2020 18:24:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 115775204E;
        Fri, 31 Jul 2020 18:24:26 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 0/5] initial travis support
Date:   Fri, 31 Jul 2020 14:24:03 -0400
Message-Id: <20200731182408.696931-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_06:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=843 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Support for multiple TSS and crypto libraries resulted in needing to
test different software package combinations.  Although this is a
first attempt at using travis matrix, I've been asked to include the
travis.yml file in the git repo.  Before doing so, I'd appreciate
some sort of review.

thanks,

Mimi

Mimi Zohar (5):
  ima-evm-utils: travis: define travis.yml
  ima-evm-utils: travis: download, compile, and install a swTPM
  ima-evm-utils: travis: dependency on TSS for initializing software TPM
  ima-evm-utils: travis: support tpm2-tss
  ima-evm-utils: travis: openssl gost engine

 .travis.yml                  | 44 ++++++++++++++++++++++++++++++++++++
 tests/install-gost-engine.sh | 10 ++++++++
 tests/install-swtpm.sh       | 11 +++++++++
 tests/install-tpm2-tss.sh    | 19 ++++++++++++++++
 tests/install-tss.sh         |  8 +++++++
 5 files changed, 92 insertions(+)
 create mode 100644 .travis.yml
 create mode 100755 tests/install-gost-engine.sh
 create mode 100755 tests/install-swtpm.sh
 create mode 100755 tests/install-tpm2-tss.sh
 create mode 100755 tests/install-tss.sh

-- 
2.18.4

