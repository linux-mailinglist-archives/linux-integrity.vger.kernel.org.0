Return-Path: <linux-integrity+bounces-15-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4D7E83AC
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BDA2812D1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742A3B792;
	Fri, 10 Nov 2023 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PG8vk5nW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30783B7B4
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:52 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F7D64
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:50 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJldfs008913;
	Fri, 10 Nov 2023 20:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=M+ZOge8G/C9AZiziVzVAIk2r+uc9Rur3NBbX3RHLFBo=;
 b=PG8vk5nWa5kxpGh61qVGHbh+otzSt06/h+R/oe8PCphxOyej+8d+ReR4D8zaoP6Az1oH
 ibcL81MHmOvUSRNnMYmu5Z40wdMbNnc4K3X7TgZ5Y1hoOYuDd3TqDnumpOJwuxxDa8TP
 shkBqPxY/9fegg4M7JpQbmuj6Nrc3Nz+4HFgUyUIdxzxHA7/+YuhyNcbdyinM9t7tAC2
 AX7V1SY3z6A8uR1Fid5ywwWDxHru/bDN0LtXwB21nqtYXsb1ROK8NHUV5MnLe6ucebD6
 p0mZMYvN31wMyjaPsMGTIxO5qf/m3bDCMKs4wMKz6QyttFZzk3s0YiEVLk/Kf8x/1kCS fw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tyy8w0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJDUjq000644;
	Fri, 10 Nov 2023 20:21:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w23ddrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLerR18285292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22C058058;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D0358059;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 03/14] tests: Address issues raised by shellcheck SC2046
Date: Fri, 10 Nov 2023 15:21:26 -0500
Message-ID: <20231110202137.3978820-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110202137.3978820-1-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TOb0CH1SgcQFfjolHcCWu85UijMdQGUm
X-Proofpoint-ORIG-GUID: TOb0CH1SgcQFfjolHcCWu85UijMdQGUm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100171

Address issues raised by shellcheck SC2046:
  "Quote this to prevent word splitting."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am         | 2 +-
 tests/install-fsverity.sh | 2 +-
 tests/install-openssl3.sh | 2 +-
 tests/install-swtpm.sh    | 2 +-
 tests/install-tss.sh      | 2 +-
 tests/softhsm_setup       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 1848091..bcc1ee4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181 \
+	shellcheck -i SC2086,SC2181,SC2046 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
index c760485..fa31b2b 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -2,5 +2,5 @@
 
 git clone https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
 cd fsverity-utils
-CC=gcc make -j$(nproc)
+CC=gcc make -j"$(nproc)"
 cd ..
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
index 29457f3..f27da4c 100755
--- a/tests/install-openssl3.sh
+++ b/tests/install-openssl3.sh
@@ -21,7 +21,7 @@ fi
 ./Configure "$FLAGS" no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3
 # Uncomment for debugging
 # perl configdata.pm --dump | grep engine
-make -j$(nproc)
+make -j"$(nproc)"
 # only install apps and library
 sudo make install_sw
 
diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index de9b5c7..4fa97eb 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -16,6 +16,6 @@ mkdir ibmtpm$version
 cd ibmtpm$version
 tar --no-same-owner -xvzf ../download
 cd src
-make -j$(nproc)
+make -j"$(nproc)"
 $SUDO cp tpm_server /usr/local/bin/
 cd ../..
diff --git a/tests/install-tss.sh b/tests/install-tss.sh
index c9c179e..31ea690 100755
--- a/tests/install-tss.sh
+++ b/tests/install-tss.sh
@@ -3,6 +3,6 @@
 set -ex
 git clone https://git.code.sf.net/p/ibmtpm20tss/tss
 cd tss
-autoreconf -i && ./configure --disable-tpm-1.2 --disable-hwtpm && make -j$(nproc) && sudo make install
+autoreconf -i && ./configure --disable-tpm-1.2 --disable-hwtpm && make -j"$(nproc)" && sudo make install
 cd ..
 rm -rf tss
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
index 95bf0b1..6f8a74e 100755
--- a/tests/softhsm_setup
+++ b/tests/softhsm_setup
@@ -82,7 +82,7 @@ setup_softhsm() {
 		fi
 		sudo mv /etc/gnutls/pkcs11.conf \
 			/etc/gnutls/pkcs11.conf.bak &>/dev/null
-		if [ $(id -u) -eq 0 ]; then
+		if [ "$(id -u)" -eq 0 ]; then
 			SONAME="$(sudo -u nobody brew ls --verbose softhsm | \
 				  grep -E "\.so$")"
 		else
-- 
2.41.0


