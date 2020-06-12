Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567C01F7B13
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLPqM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 11:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFLPqM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 11:46:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CF4jDw117181;
        Fri, 12 Jun 2020 11:46:10 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31kq692t97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 11:46:10 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CFjWGn025858;
        Fri, 12 Jun 2020 15:46:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 31g2s84rvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 15:46:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CFin1C56230358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 15:44:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A88952050;
        Fri, 12 Jun 2020 15:46:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.133.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B1FE55204E;
        Fri, 12 Jun 2020 15:46:05 +0000 (GMT)
Message-ID: <1591976765.11061.76.camel@linux.ibm.com>
Subject: [GIT PULL] integrity bug fix v5.8 (#1)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jun 2020 11:46:05 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 cotscore=-2147483648 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=2 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

One IMA performance fix for v5.8-rc to return immediately if IMA-
appraise is not enabled, before doing any mprotect IMA rules checking.

thanks,

Mimi

The following changes since commit
42413b49804b250ced70dac8815388af2d4ad872:

  ima: Directly free *entry in ima_alloc_init_template() if digests is
NULL (2020-06-05 06:04:11 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git tags/integrity-v5.8-fix

for you to fetch changes up to
4235b1a4efe19dd0309250170bbf0aa95e559626:

  ima: fix mprotect checking (2020-06-12 11:30:18 -0400)

----------------------------------------------------------------
ima: mprotect performance fix

----------------------------------------------------------------
Mimi Zohar (1):
      ima: fix mprotect checking

 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
