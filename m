Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4143AA7E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJZCwU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 22:52:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232091AbhJZCwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 22:52:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q1ZH6Y005083;
        Tue, 26 Oct 2021 02:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Un4Qha0nCbOPQ2Db0qxLyKpKocnsdP8oSJpPnqLrT4Q=;
 b=DSxZ+i6ZZ/KUBKXIgfBB6KorBoQFRz2JvfsX+rUV/IVlpnK/Pyvsq1+gTXTgU7OhLSaS
 1eeI9Nzk+YdysmLDwzK5Xb3YT7yxTyJ6ELA4zX+BBywaqDFsnf+s1C5qCbRirH+fAlzN
 ucFRTLTMNalXnoD4UMdSS0HbA/v+8aFFAQ1sIuYVRtBsOvsJc9AxgoUt7JM0t2oV8GSv
 ACpfI7GlaWX6q9O7O98MbuulcPQtsS5Zt6zR1prj/8sZRbFZKo4mwzl5cYCyNv5tWJ3L
 7NwRBXBB3KsiYVvbfI1VdxJXJwIC9QtEXclBbQssBA68BVCrjfXkbI49avnmkMgwfcwC Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k3dygk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:55 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q2nsmK018706;
        Tue, 26 Oct 2021 02:49:54 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k3dyfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q2bL1i032170;
        Tue, 26 Oct 2021 02:49:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bx4f791ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q2hjrN58655100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 02:43:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473C9AE04D;
        Tue, 26 Oct 2021 02:49:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7093FAE045;
        Tue, 26 Oct 2021 02:49:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.77.130.61])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 02:49:48 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH ima-evm-utils 2/2] upgrade to glibc-2.34 uses clone3 causing CI to fail
Date:   Mon, 25 Oct 2021 22:49:29 -0400
Message-Id: <20211026024929.535519-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211026024929.535519-1-zohar@linux.ibm.com>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vTWUn7PAKkH997gM9GeC-0-q7cQeLZOZ
X-Proofpoint-ORIG-GUID: HzF0J0xIAPDDjNPBieyKl1fAEfiraUMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Both opensuse/tumbleweed and Alt Linux have upgraded to glibc-2.34,
causing the CI testing to fail.  Disable seccomp (which is not needed
anyway, since GA uses throwable virtual environments anyway).

options: --security-opt seccomp=unconfined

Suggested-by: Vitaly Chikunov <vt@altlinux.org>
Acked-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 0931f2487d50..ad611ad914b4 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -103,6 +103,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
+      options: --security-opt seccomp=unconfined
 
     steps:
     - name: Show OS
-- 
2.27.0

