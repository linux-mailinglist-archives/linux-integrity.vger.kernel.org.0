Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDA349CA3
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Mar 2021 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCYXBx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Mar 2021 19:01:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhCYXBo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Mar 2021 19:01:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PMX4u6039549;
        Thu, 25 Mar 2021 19:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=zxF/XDKGFeP4ewBd/n0tLOOKs681BRXZ/yDahaLJnuY=;
 b=U852/r0YlzwlnZzAgR1pibwbA5wEDu3QprEtyhzY3nRTUT3pSTDMsBHDUtiaIrr2059z
 skxlFUj5htfg6EgDHZXCrMErMa/FChV2TYBKX+6zaJM4TO6pRfXoE1XA332NsF8F/5vu
 I7vwxi7AzReCjTpw36sPYXrF6hCNypdpUkgV+QFshk50g7ENXTcyJ2zfcV9WDANIIV5n
 q2l/z7anWGEo6k1+meUcs2QAkJ55GhSJBqE35L14qZ3Y62vD8/EPXOSPQ6Bii6V2Geg0
 Byadk9pNB/vzfqVCOe7GMpHmF+r78kbvUNdYo2VQb+Q0+pBdiUUjnwVKIonRbfhpNw+O qQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37h17n3xnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 19:01:42 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12PMw7do027130;
        Thu, 25 Mar 2021 23:01:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37h15103km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 23:01:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12PN1JEM30933278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 23:01:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D731C4C052;
        Thu, 25 Mar 2021 23:01:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7635D4C058;
        Thu, 25 Mar 2021 23:01:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.11.141])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Mar 2021 23:01:36 +0000 (GMT)
Message-ID: <98cd4b74a0658c14acc0071349122b13e7238a53.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem fix for v5.12
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Mar 2021 19:01:34 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cpmpSSkpYhZhTg8n3OAoi61RjdnqhXT3
X-Proofpoint-GUID: cpmpSSkpYhZhTg8n3OAoi61RjdnqhXT3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_10:2021-03-25,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250166
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Here's just one patch to address a NULL ptr dereferencing when there is
a mismatch between the user enabled LSMs and IMA/EVM.

thanks,

Mimi

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:
  
  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.12-fix

for you to fetch changes up to 92063f3ca73aab794bd5408d3361fd5b5ea33079:

  integrity: double check iint_cache was initialized (2021-03-22 14:54:11 -0400)

----------------------------------------------------------------
integrity-v5.12-fix

----------------------------------------------------------------
Mimi Zohar (1):
      integrity: double check iint_cache was initialized

 security/integrity/iint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

