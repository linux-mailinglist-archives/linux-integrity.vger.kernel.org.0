Return-Path: <linux-integrity+bounces-16-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38B7E83AE
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FC21F20F12
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E53B791;
	Fri, 10 Nov 2023 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHTVNVzA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65233B785
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:23:49 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400243A82
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:23:47 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKGbn8029234;
	Fri, 10 Nov 2023 20:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=chk82VFIjXDl8jB4ID3UpeueuIYNM2C4sWz7glxFCqY=;
 b=qHTVNVzA8ou6erPXSLC73Cymx0HouExZv5zvdc/hvc6nQxJLJFyhMIVaLXue98MnHdfS
 ANxHEaiNE9j7pbYJx6w6xR5FVT4hxQbWemI12ccGZdALs+L0LMbpW0IWV/Wm9egvqxFp
 h+KlLyjlcMuMS4w/S57/aGMWnqnYwr0eTVpKzN04rKfGitItOGTYDOEsRVt3FyU1JFqa
 uMtwgKyQt1RiBmw+xU26/ukxBY/DAXMGstwAfMXhEc0wK6IfBeF4CtWMU4SlSXfcZLKo
 sUQPzn63/5KrbKTBn3x4krZ4enev2dqxWWrTan7zvoPrdzYqAdbp+25BxKd28URtUyEx 4w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9u000rru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:23:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJCIOR014325;
	Fri, 10 Nov 2023 20:21:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22de87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLiq335258752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 870A658058;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3598B58057;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 12/14] tests: Address issues raised by shellcheck SC2043
Date: Fri, 10 Nov 2023 15:21:35 -0500
Message-ID: <20231110202137.3978820-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110202137.3978820-1-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S6DYGF2MaoD_Z11h-SJcZ-6z4R5tm9GZ
X-Proofpoint-ORIG-GUID: S6DYGF2MaoD_Z11h-SJcZ-6z4R5tm9GZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=849 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100171

Address issues raised by shellcheck SC2043:
  "This loop will only ever run once for a constant value. Did you
   perhaps mean to loop over dir/*, $var or $(cmd)?

Disable this check in gen-keys.sh to leave the loop alone.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am | 2 +-
 tests/gen-keys.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 5de1dfb..653e4dd 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206,SC2196 \
+		-i SC2294,SC2206,SC2196,SC2043 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index c3d5a20..601ded2 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -15,6 +15,8 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
+# shellcheck disable=SC2043
+
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
 type openssl
-- 
2.41.0


