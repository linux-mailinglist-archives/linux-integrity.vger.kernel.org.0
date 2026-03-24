Return-Path: <linux-integrity+bounces-9072-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCEJGj8Bw2nRngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9072-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:25:19 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E503531CD2B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84AF03047BC6
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539535DA61;
	Tue, 24 Mar 2026 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AA0REGxK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EC2E093E
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387438; cv=none; b=HBd+lWgEPcJnfnTnsIbpJfRZGdUu/rYrT4owtYQJUpZUCk1uOgYD4Y/cFWFW0BcQ5KwqjBkWLjqGDcAcnExXA3T4M+SwYkgpJ40i9V1XDdROus7unUJPRHJxQZONF4tAgoMPFYisjYtSBn6DIIlean3FGMaiyTA7GwVLF9Wh5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387438; c=relaxed/simple;
	bh=U7k3fOkYslLyTjIDKsjuBHibd2Iz+LlK8hlOwl9PHHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8FP51ibHyqFC+cGqQW+pP/WYBTOUuCv7NwaTpromymWRV8ezrLIALder1MaGp2uMAEtWFSCbvXu6c7hT+fqbfrXVxxJxihkMkfCJ7w9Fx5FMH476uPRiKXzuxz2d/ymFN8yU4yfyoBxIyGRdk2SDCBQ2Fij5BTx955nEMaUPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AA0REGxK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ODUdQP2945148;
	Tue, 24 Mar 2026 21:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ypceqVtZN1tpHfkHkM485+dUEpO1xNhdga/hawz4E
	x4=; b=AA0REGxKtM9OKiZpxYirJ0xTfEvxeiZFG+K7NlwrvkPisjnZ2QLFxM35r
	iv6GZ7NEDlQh/8baqOHo/pZvGT2cdOhAEEpU+THU18MuA0mslKVJ65bhVaHEsQj4
	SrACCCf8s1l+gLo4Aurpx/S3YVk5gzNyRHRd9r1Nm+0whQy0yAkx68OsY/m6rdO8
	chvOWrXypmoeZnfQop5FdgsubvwdWv7VsA9zV9FEAz0G0DBET6doWus+gqYKruBg
	8Lw9L4rKxPKRb7oNyXHsnrz+RZHad/4+vkO1u3nBtKzbxYWH4t+6jg8BhufuGlpG
	WnzyDGH6PtLcjU197fhgLQPxwawvg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuw43u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKj8nG011789;
	Tue, 24 Mar 2026 21:23:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk3qux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OLNjAA33358590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 21:23:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1FB158051;
	Tue, 24 Mar 2026 21:23:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AFD85805A;
	Tue, 24 Mar 2026 21:23:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 21:23:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 0/2] Fix memory leaks in libimaevm
Date: Tue, 24 Mar 2026 17:23:40 -0400
Message-ID: <20260324212342.739685-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: etYZTBKC1-f9ej1-wwUIR8Lrr0jpvj2d
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c300e3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=fP-ZIkwX40fDXU7GDZgA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NCBTYWx0ZWRfXwoIztYuqCFL3
 vcI8mhk0pzLS4muVNm+jvE1erb3dsssa/lK6OdH1W3dBSKte11GZUiAQ4t7uPhCKPRACouDz/dV
 B82SuV0xo7GJg5Q/+WggQus3xnTgnCQalxUFSD3DD0Uubs4fhl3obWFgxKN8QJchrB/LHslNxWO
 etXV944zvqbeWzfBbILH/iZBgcDFxnIQkJtGIBok/4wx5VFUp7EJsxIBpL35bmaGhE0ix08oU5R
 vo22O/YxnRHH5pde0h9j7aiNPsRQW9xSShckucIODxmkEtLSH/v2w5SSBVxyLgb001AAM9BY8YS
 l71JZteZU1DMtwwkOYVqW725OjZotuTJRIU0xdtTXjPxkSGbHZZni/Knr+iStOhVAlX/TUxOrj2
 5Hjv7BAKFtqAACdZ0Es88HAaI05ed/kpzEzfY4Q40rLFF7+1+g3L3nNJo2pFLyQzEXt5cKevbs/
 txAoVgru4sO50ZlX0Vg==
X-Proofpoint-GUID: etYZTBKC1-f9ej1-wwUIR8Lrr0jpvj2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240164
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9072-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E503531CD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two memory leaks in libimaevm.

   Stefan

Stefan Berger (2):
  Use EVP_PKEY_free to free a key of public_key_entry
  Avoid memory leak if public_keys is NULL

 src/libimaevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
2.53.0


