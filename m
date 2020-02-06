Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C795154977
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBFQn3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 11:43:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36102 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgBFQn3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 11:43:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016GcZtm031451;
        Thu, 6 Feb 2020 16:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=L4o/oM6TBlLfqTsyZEuVQ+YJnHAjTzD6fxlj3/5p29I=;
 b=X5hxHqbBErx93Bot+gLyxS+z/ors04Dv73zZAvGLM4JRVMJQsVKbHX/HxtCJdsFiN9Yl
 PTvkhd4/J4H7YBnHk8XibvSiNbruICvowofTHaKdyGM7X9yeSvcNfF2nuR9m6KDH03+y
 HGFXMniwrgIQ4EnEHNzN+NudvbcCsZ2/JkTZXR8hEi7WLG6w/adxZEIYy+JRPGD5C78A
 1AAXmiv7XYU1pPg4yHMcNJzAN71ze/+NJyrnbldMS7nPD+IwiEEttyYc6kwkgDABtnik
 aRw+82100ioHfJpShp/ZbFGBBcuBJ9kO9XNdAlHw1aapCBtzBBPAWWjv74KrDGBWtEf5 Vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=L4o/oM6TBlLfqTsyZEuVQ+YJnHAjTzD6fxlj3/5p29I=;
 b=PMg+zArVe77/IKCn8wzSyHWnkBGnrWzXgyrENmL6equDuXXseJ4Rs/7ZLnY4lGy4sL5S
 VYWVXfZYuDa4ZF3DjHC08xO3a+zZJGbhQThYQm/4H7oyNPksHF0OLQWbCBPDEFgGFxaD
 sYJjQhdCw8in7mIoEQ0If9URa5lVq9SAYqEI9SVaA4Plou9yGZ8pnq9kBVjhaD1f6HSc
 QXFk6k4wh/QL3rXDZC0tZAG7c5am4J3v8NunK08Y0wrbkvc5/pgKJYq0s+4WPgE4PLMP
 EhagD0VCe4zbyHUaSkDuhP5VsCwUUh7wV2NXo0tV+tVab4BJo3ZylQ2/3FMJlSQ+Cmas xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbpax3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016Gd8kU102463;
        Thu, 6 Feb 2020 16:42:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y080dj7af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:46 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016GgciP024401;
        Thu, 6 Feb 2020 16:42:38 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 08:42:37 -0800
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        eric.snowberg@oracle.com, tglx@linutronix.de,
        bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] ima: uncompressed module appraisal support
Date:   Thu,  6 Feb 2020 11:42:24 -0500
Message-Id: <20200206164226.24875-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When booting with either "ima_policy=secure_boot module.sig_enforce=1"
or building a kernel with CONFIG_IMA_ARCH_POLICY and booting with
"ima_policy=secure_boot", module loading behaves differently based on if
the module is compressed or not.  Originally when appraising a module
with ima it had to be uncompressed and ima signed.  Recent changes in 5.4 
have allowed internally signed modules to load [1].  But this only works 
if the internally signed module is compressed.  The uncompressed module
that is internally signed must still be ima signed. This patch series
tries to bring the two in line.

I'm sending this as an RFC in case this was done intentionally.  Or
maybe there is another way around this problem?  I also realize the 
uncompressed module will be verified again with module_sig_check.  I'm 
open to suggestions on improvement if this is seen as a problem.

[1] https://patchwork.kernel.org/cover/10986023

Eric Snowberg (2):
  ima: Implement support for uncompressed module appended signatures
  ima: Change default secure_boot policy to include appended signatures

 security/integrity/digsig.c           | 9 +++++++--
 security/integrity/ima/ima_appraise.c | 3 +++
 security/integrity/ima/ima_policy.c   | 4 ++--
 security/integrity/integrity.h        | 3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.18.1

