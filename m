Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6367BFAC
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 23:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjAYWNh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 17:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjAYWNg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 17:13:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48B23DB2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 14:13:34 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLjcj023897;
        Wed, 25 Jan 2023 22:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NWFsY9j2KOOk1G/c+m3GALVvfYnfhgRaB20Wl+mPDeU=;
 b=NHG4nk4wt2HuycGZfZuYNqYLbjsdsj9OHCp43IRdIqjnQK18gBAH8OONLoUOf7hOi3IQ
 ZgxCYjcuAkmz3GVp8ukUUKcmSjHg9mRWcSMG9tGEPEWwv7AvMqiz8Papl01/BYgJ51Su
 Wq7E4DqJBpzA2ZfqMNJ9GfMZyogAmlIMvdjLKWVO95nz1MGLm03YEP8Oq1dTc1UuXlfE
 U9VaHcK5MVPM2u5MY25rmnFeCbQpEBBeOwEzoasVImxhZNRO6Qkdc5HeS3PYzMVDWXwt
 FrnSnLt1ObaGoEv22zCW3slasg4D8cygEd4bd+JjAV40atjn47YJmL25jySqoX/jCjP6 Sw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb7pp8xvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:13:26 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEYqfn031828;
        Wed, 25 Jan 2023 22:13:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p641vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:13:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMDLDV47317382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:13:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9FC420049;
        Wed, 25 Jan 2023 22:13:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 983B520040;
        Wed, 25 Jan 2023 22:13:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.18.164])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:13:19 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils] ci: cleanup build.sh test log output
Date:   Wed, 25 Jan 2023 17:13:11 -0500
Message-Id: <20230125221311.395032-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EoUTcwyedmZdhYF_87Qdp3DKULbx8csf
X-Proofpoint-GUID: EoUTcwyedmZdhYF_87Qdp3DKULbx8csf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unlike the original ima-evm-utils ima_hash.test and sign_verify.test
selftests, kernel tests may fail for any number of reasons (e.g. kernel
config, permissions, missing applications, test infrastructure).  For
these tests, the full test log is needed to analyze the failure.

Create a phony target in tests/Makefile.am named "check-logs". Based on
test name, output different amounts of the test log.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
[Applies on top of Roberto's "v3 Support testing in new enviroments"
 patch set.]

 build.sh          | 23 +----------------------
 tests/Makefile.am | 13 +++++++++++++
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/build.sh b/build.sh
index 0920599b2780..c226dd1f1773 100755
--- a/build.sh
+++ b/build.sh
@@ -97,28 +97,7 @@ VERBOSE=1 make check || ret=$?
 
 title "logs"
 if [ $ret -eq 0 ]; then
-	if [ -f tests/ima_hash.log ]; then
-		tail -3 tests/ima_hash.log
-		grep "skipped" tests/ima_hash.log  && \
-		   grep "skipped" tests/ima_hash.log | wc -l
-	fi
-	if [ -f tests/sign_verify.log ]; then
-		tail -3 tests/sign_verify.log
-		grep "skipped" tests/sign_verify.log  && \
-		   grep "skipped" tests/sign_verify.log | wc -l
-	fi
-	tail -20 tests/boot_aggregate.log
-
-	if [ -f tests/fsverity.log ]; then
-		[ -n "$CI" ] && cat tests/fsverity.log || tail tests/fsverity.log
-		grep "skipped" tests/fsverity.log  && \
-		   grep "skipped" tests/fsverity.log | wc -l
-	fi
-	if [ -f tests/portable_signatures.log ]; then
-		[ -n "$CI" ] && cat tests/portable_signatures.log || tail tests/portable_signatures.log
-		grep "skipped" tests/portable_signatures.log  && \
-		   grep "skipped" tests/portable_signatures.log | wc -l
-	fi
+	cd tests; make check_logs; cd ..
 	exit 0
 fi
 
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 421fac577b55..a0463b7b5b5d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -4,6 +4,19 @@ TESTS = $(check_SCRIPTS)
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
 		 fsverity.test portable_signatures.test
 
+.PHONY: check_logs
+check_logs:
+	@for log in $(TEST_LOGS); do \
+	   echo -e "\n***" $$log "***" ; \
+	   case $$log in \
+	   ima_hash.log | sign_verify.log ) \
+	       tail -3 $$log ; \
+	       grep "skipped" $$log && grep "skipped" $$log | wc -l ;; \
+	   *) \
+	       cat $$log ;; \
+	   esac ; \
+	done
+
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
 
-- 
2.31.1

