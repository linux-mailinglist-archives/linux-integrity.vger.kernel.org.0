Return-Path: <linux-integrity+bounces-9073-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE0gM7gBw2nRngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9073-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:27:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478731CD5F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 718F7301D308
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4D35E95E;
	Tue, 24 Mar 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ELxx+e0O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D735B634
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387623; cv=none; b=I40cNTN4bgVgep7SlCpf7PQeSpvHiZdThMPbtCEuxaVQDAAgceTWDDoygcTs3/q1/fK44Ii2j72xonZetVEV3II27BaygRCBEH2wLE94iaAvEFweDtD7YFrwutegbVftxSFk35hW1qtAor7fjszh+R5Bvk42EJL+WphNmakr/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387623; c=relaxed/simple;
	bh=40VjQ/tS1Q6lNqAoxj3f8HjQkS9JaIU2QbXA4gE5Ovs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWuQQVuFIGAry12qyDslkoWusnlezIoVH6lk/ISIEo5Sgb9wwVge9vtdIB2VLKu+ezwL8EikcXjWGNQDzBrcWVeFXoQWo4g67j8toLOsqVa2dRpSz8zzu4cYTYa6TexgYPbdUyNyoYDVtuqW1P50WYthLW4/RlZQNcjZtQIJFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ELxx+e0O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJ12Qd717890;
	Tue, 24 Mar 2026 21:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7IrmQ6Vf9aRDiD+IqkWEj4lAsASLCjeBWmVI2DC9c
	Mg=; b=ELxx+e0OdLeDhvFeBZDuiOFh8W7GHt1KmM+IJn1WPwUXDlF5fuLv1rKvt
	VnurOSnmM/NPOppgIuQULYeA5EtwbKSptUbBIRuZfXS1fUREwaOSZzYtRMlUBg7K
	Lp5hfNMkU1G7rOTRWD76QMMqdBwFVdCWf70ffKIpSINczODGIOklKaugDC/ftaZF
	J7et0iK2wgz5THyEzEbo/+RdYhywCOrPDw/UJuuhlq8/wuoV0SF6BIkm6g1xrapW
	wm3WTyD9pDdMZ6rymoPQImKUOxSWtYohbVuCrB67dS5Sa4zuXYH5SxLwHQ9rt/0a
	P3mbittt9Clji7MZJc3YjiuI8OxJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuw4a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:26:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OK2aJe012203;
	Tue, 24 Mar 2026 21:26:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk3r4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:26:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OLQo9M20972116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 21:26:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ACAA58055;
	Tue, 24 Mar 2026 21:26:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6FC95804B;
	Tue, 24 Mar 2026 21:26:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 21:26:49 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH] shellcheck: Fix shellcheck v0.11.0 issues detected in fsverity.test
Date: Tue, 24 Mar 2026 17:26:38 -0400
Message-ID: <20260324212638.739797-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z_yPaFLKp-Tt_Ws8cD3QGOsNaHJK1877
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c3019c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=H9VqmB7XAAAA:8 a=VnNF1IyMAAAA:8
 a=hwfshhjcq_gbVOUJzI0A:9 a=v3k57InNul7ldpsxCyLV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NCBTYWx0ZWRfX2cZM8489OgjF
 945rp1ikpxCBtqxPVCmzKk1hRBkgGazjWQg7Z9THXqQ+VovC5+B8yuPzB45+TgIwWRTvdXE4AL+
 FKKKmTWrD+hll/g82YKW7nvSHcSugDmmUt+KBvsMpDwwBojbdVK/NNzZ8tDQsi4Aex/zlOtHHK/
 PXbG96abWGnwetoqq8DvdPvdKdSkmqAmLEYi9d50RVpgT9oSsGt2SOOIh5PzfZnXRekGXsE0z5u
 FFE3Vs4ORXU5Ak02MoMcN3ryh5OTZrU8CMt74PN4XOAeOZ4JU9LM3rGduTEW2EmyYVlgAwVInXl
 /E4GZXYUDgfgGrutfvXs0cbmPjDPyMduMkiHXeReNyVbQmFWit/0KtnvsmPgMpafNMGHE8BNeRV
 oAFTA0mTrwlWgyyWOn3cgM9A1R3APEgLdpv31rX27qa8mekbm+e4jLCpCtSTKVQ0S1zpUTXoM1I
 o63J8X6/fMdl87LS+pA==
X-Proofpoint-GUID: z_yPaFLKp-Tt_Ws8cD3QGOsNaHJK1877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240164
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9073-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3478731CD5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix the following issue detected by shellcheck:

if [ "x$(id -u)" != "x0" ]; then
     ^---------^ SC2268 (style): Avoid x-prefix in comparisons as it no \
    longer serves a purpose.

Also fix several of the following types of issues by disabling the
shellcheck error. Shellcheck does not recognize the invocation of functions
when they are indirectly invoked when they are passed as parameter to
another function.

__skip() { return "$SKIP"; }
^-- SC2329 (info): This function is never invoked. Check usage (or \
    ignored if invoked indirectly).

Also see: https://www.shellcheck.net/wiki/SC2329

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/kernel/fsverity.test | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/kernel/fsverity.test b/tests/kernel/fsverity.test
index 734d490..9c0f381 100755
--- a/tests/kernel/fsverity.test
+++ b/tests/kernel/fsverity.test
@@ -52,6 +52,7 @@ _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
 
 trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM EXIT
 
+# shellcheck disable=SC2329
 cleanup() {
         if [ -e "$TST_MNT" ]; then
 		if [ "$LOOPBACK_MOUNTED" -eq 1 ]; then
@@ -220,6 +221,7 @@ load_policy_rule() {
 	return 0
 }
 
+# shellcheck disable=SC2329
 create_file() {
 	local test=$1
 	local type=$2
@@ -236,6 +238,7 @@ create_file() {
 	chmod a+x "$TST_FILE"
 }
 
+# shellcheck disable=SC2329
 measure-verity() {
 	local test=$1
 	local verity="${2:-disabled}"
@@ -297,6 +300,7 @@ measure-verity() {
 	return "$error"
 }
 
+# shellcheck disable=SC2329
 measure-ima() {
 	local test=$1
 	local digest_filename
@@ -375,7 +379,7 @@ if ! evmctl --help | grep -q veritysig ; then
 	exit "$SKIP"
 fi
 
-if [ "x$(id -u)" != "x0" ]; then
+if [ "$(id -u)" != "0" ]; then
 	echo "${CYAN}SKIP: Must be root to execute this test${NORM}"
 	exit "$SKIP"
 fi
@@ -403,6 +407,7 @@ create_loopback_file ext4
 
 # Commit 989dc72511f7 ("ima: define a new template field named 'd-ngv2' and
 # templates") introduced ima-ngv2 and ima-sigv2 in linux-5.19.
+# shellcheck disable=SC2329
 __skip() { return "$SKIP"; }
 
 # IMA policy rule using the ima-ngv2 template
-- 
2.53.0


