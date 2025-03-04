Return-Path: <linux-integrity+bounces-5059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F2A4DD1E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 12:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8733AD4C2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4C202F7C;
	Tue,  4 Mar 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rAsqf8IU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403E202F70
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089234; cv=none; b=HUXASloQmNKIoGKkH4IhcWAIO87eCV3OmL1DDB3PiznUHyFXN+0zF7nTtcJz+ynmqdmrBVaw8sPP3PUCocLw6aUtWYg5YUk8hFLeSy/8E4Z2EZRnnmPnymMpbkiaj62QIsH3zgbWixsr4XlxkeE43B3bRyG8hwhRuttxafm3xcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089234; c=relaxed/simple;
	bh=fKqOujWGfSkTs3U2EAKh2d5/OQJ4Acnf3gFeY0vvZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbKv9e0bUHy8D+mDh8t5gamAxvwTxuAfkKtx8sL/hYJcjO96Q9C7igJnrV+R4DPpFZpTaepAnQnXveF08DVcvZjzKitmwuMzxyvtpi3VGzhvTyD2HTujtLb6EBrV9BSsLx3iqaTPSLkzMoSVJCnmGz49cMJvu2+zeNwX3dWj0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rAsqf8IU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AMPf0022727;
	Tue, 4 Mar 2025 11:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jzA00iPH3y1KhRc0P
	YH01aFKBhpZjsf4vuLx80l7lvw=; b=rAsqf8IU57GOkRvLrKEYa8VlhithChb7F
	yxy4XIsaxSxjtKotJRTDI6DXQQjnHPyv/4P1pH6GGuJ/hRAC8ACQhTCc/EJ4CGFb
	kRW2PScuuJFe5UzTdvHwB0b/JS5gCV9Gk//1NDnhWXk7a00n4xVcduPY2HLVRRo5
	+zbAgU4rTEvq7QfTAKOmNPVb4HAKM5U15fuzYzO23qC9NMD/TsYqt+AZYYAwfFuz
	z7Yv68DPhkDIXx+064poXIkZvyN4Q3KQbBXkS6UKV3oqEuV/dNN0iU9WEUfQ4dwZ
	PTv3mdfpA3U4hJ+/Sc+mUaFr91penXM2dj317fU9F2+3riJ+71Dhw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunxfq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524BJCmJ020835;
	Tue, 4 Mar 2025 11:53:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnd73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524BrgO648562592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:53:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276D520043;
	Tue,  4 Mar 2025 11:53:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8404220040;
	Tue,  4 Mar 2025 11:53:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.57.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:53:40 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/4] ima_violations.sh: additional ToMToU violation tests
Date: Tue,  4 Mar 2025 06:53:31 -0500
Message-ID: <20250304115331.524842-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -UyI8bMjsuIdrCDaFs2dQw9FXctdvXBK
X-Proofpoint-GUID: -UyI8bMjsuIdrCDaFs2dQw9FXctdvXBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=649 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097

Kernel patch "ima: limit the number of ToMToU integrity violations"
prevents superfluous ToMToU violations.  Add corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250228205505.476845-3-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 578cb1402..2fbffc5da 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=6
+TST_CNT=8
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -246,6 +246,50 @@ test6()
 	validate "$num_violations" "$count" "$search" 2
 }
 
+test7()
+{
+	tst_res TINFO "verify limiting single open reader ToMToU violations"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test8()
+{
+	tst_res TINFO "verify new open reader causes additional violation"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate "$num_violations" "$count" "$search" 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


