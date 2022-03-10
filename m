Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1914D53D2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Mar 2022 22:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbiCJVqn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 16:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbiCJVqk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 16:46:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A774194ABF;
        Thu, 10 Mar 2022 13:45:37 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AKVLGv029687;
        Thu, 10 Mar 2022 21:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XhJGHjHVPbBPIheFTHx0rLbWMIi0ArD/NqKVNEbi6gs=;
 b=f/O2kspviAFKDs1A5efITdSa9KIvD7njcBJAIanGshKkkcexBj7so0hlNciIssPaTqp7
 WLaDKiOOfJ2+UDYk+aZyt810uK1jojjwZLM3Lzrsyds3LobVqc/YrkD2YVWkefrdMiLe
 QWHjAcHKzxjIegCUAu0nL6ySwkiOAZhpY3+FmPjBHCPLKb0/00/rP6f91PUSYdgdptw4
 PjfEzfKKZvFeMVMl4Hve0CHihEN0rZ42iFWXnZzstF77fBmjGG8qmWIAmEhURwX9Nz+/
 apMDyGuaDnLUqmHyZ7YcQ58ISmhSTEaG2I7BxS1LsR5VjOzRG5R+1Ws5sZd/qKlhehgM Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqnccdepe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:33 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ALjWS6018038;
        Thu, 10 Mar 2022 21:45:32 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqnccdent-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:32 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22ALgrpY017442;
        Thu, 10 Mar 2022 21:45:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3ekyg8kp1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22ALjQt240304956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 21:45:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3399A4051;
        Thu, 10 Mar 2022 21:45:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AACA8A4040;
        Thu, 10 Mar 2022 21:45:22 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.53.50])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 21:45:22 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v11 3/4] certs: conditionally build extract-cert if platform keyring is enabled
Date:   Thu, 10 Mar 2022 16:44:49 -0500
Message-Id: <20220310214450.676505-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310214450.676505-1-nayna@linux.ibm.com>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g_ZVBzIKgtvgHGkW3-KyQQVAmcb5fIM6
X-Proofpoint-GUID: bIWVXp3dpvyATzd7iURuY5n7ne5rbduO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

extract-cert is used outside certs/ by INTEGRITY_PLATFORM_KEYRING.
Also build extract-cert if INTEGRITY_PLATFORM_KEYRING is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index b92b6ff339d5..dfb48e043cfe 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -88,7 +88,11 @@ $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cer
 
 targets += x509_revocation_list
 
+ifeq ($(CONFIG_INTEGRITY_PLATFORM_KEYRING),y)
+hostprogs-always-y := extract-cert
+else
 hostprogs := extract-cert
+endif
 
 HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
 HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
-- 
2.27.0

