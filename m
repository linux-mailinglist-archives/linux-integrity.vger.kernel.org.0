Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32F72E3DA
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjFMNPz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbjFMNPu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 09:15:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A61AA
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 06:15:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DCl6CN014774
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mkLIaHm1kWivMrIHQG2UDALafvFVtysE0maZUzAkZts=;
 b=OLNh23XwbQsNFpEu45cwDG0gS/0d8bf+sTSSxlwrErPFH/Qvfuq/TlD0sQfrGx+xVWh8
 sfRlJGMVX1ygdDoG95V4XkOFZme0M59tq7r9aTNkZf3q7R2RMzRXHuH6UjbYnybPNCbI
 MVehOoQXELLIyOMKTMx1oUEnTnNOs2SIKB2LGlNC6OqTmFkqGKPk8+1rSXvSBg5n6E/D
 rUZ1wkD4pVmUnTgOyMrzAD+MFx9MthvlXB+EEVFGWsFC+jR+dT9jJ93cV6M1r2Mr41Bq
 0edUnOzWcHayloCQGSXUcbF57ZGuO4yVrEvlRcRU3+mOkLDBW4cuA4NKjHxWLF99tKoQ 9g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6rrugn7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:49 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35DD0DZv014073
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5gha3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DDFknc36897196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 13:15:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A560D58067;
        Tue, 13 Jun 2023 13:15:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D25258052;
        Tue, 13 Jun 2023 13:15:46 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 13:15:46 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 0/2] Fix issues related to password
Date:   Tue, 13 Jun 2023 09:15:40 -0400
Message-Id: <20230613131542.3603874-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QjQYlSmWmLIb4CMbtZNH9fyiXYEZY5ie
X-Proofpoint-GUID: QjQYlSmWmLIb4CMbtZNH9fyiXYEZY5ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=799 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the trailing newline from passwords entered on the command line
so that password-protected keys can be used.

Document that providing the password along with the -p option does not
work since the provided password would become the file to sign.

Regards,
    Stefan

Stefan Berger (2):
  Strip trailing newline from password entered via prompt
  Add note that when -p is used password must not be provided

 README       | 1 +
 src/evmctl.c | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.39.2

