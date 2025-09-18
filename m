Return-Path: <linux-integrity+bounces-7159-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA2B859F6
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC3482D31
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3B30CB31;
	Thu, 18 Sep 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wd+K3adH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EF22D7B5;
	Thu, 18 Sep 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209363; cv=none; b=pyBAjELP2XAqvMMgeZJEsccy5X2yrYsBBf7gRt9S2BYdhgkhkJ9LnJD4N1ClXAUPCCoFe4bJh9Ya7zNppoj3swgeDxsnwHefu7nGV6x8gSQSbYdEE+u36GAC0w60M3XtsR2RSTHFeRHixZWm9sad7oWjofOmd6NH34iqhV3Fvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209363; c=relaxed/simple;
	bh=WjQOdUIhxKxIlOUmvfEs/EbBcW4JuCY0+St3brDKOhk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=f4SQbOCCHi1X7nzTa7UzO+ZbrGWQhFtFqURSMRDpZIotTd++X0q9vqGSt9CbohbyvnX9IgXIjw4l5RER+g9STgJJ89E0hdTwfv0svfxjISBxpAH1j0MRN2cXmRbN4oQj/vHfmzfeTy4Xg5eTnTbEwygroLKAoINxV01b5a/vTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wd+K3adH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEnEPV028332;
	Thu, 18 Sep 2025 15:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WjQOdU
	IhxKxIlOUmvfEs/EbBcW4JuCY0+St3brDKOhk=; b=Wd+K3adH1cwwFflJHNwQd8
	eVE96BJleTNzOp/xLf/rY6O7kqNWGaWzSt4f+zeLGJD9+AyPxfDowAHLFaWuvLh9
	kvZQi10YXWlA6IBul/L3QrZQw5qmApjOiHcRlO0a1W5xIxIrUOKTql4Dp48lPCo9
	S40JAXeA9NB2SWOw9KmazCfKU0zwKtqTLnhMUtb36nyu3Z3byacMESuSmgWBgr8C
	EM8hI4R8mOCDYJ2k43wpgogEWbWXdGBTVpQvakVsW4nv0TXNRBtEonJ2otmzTEIK
	rNtAi4LU7R5yo/KtdShqKRqSzlah//H+l+Yrf0Q3esbLAHET6dSSIRZM2FZynK8g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pb7vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:28:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IFSEMm010019;
	Thu, 18 Sep 2025 15:28:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pb7vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:28:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFNVQJ009363;
	Thu, 18 Sep 2025 15:28:13 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3py9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:28:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IFSDp05178056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 15:28:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F313058059;
	Thu, 18 Sep 2025 15:28:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB6A5804B;
	Thu, 18 Sep 2025 15:28:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.89.238])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 15:28:11 +0000 (GMT)
Message-ID: <2e83f9b4c7f6dcc570c18f5c9f5fb655bcf10d62.camel@linux.ibm.com>
Subject: Re: [PATCH v4 17/34] lsm: cleanup initialize_lsm() and rename to
 lsm_init_single()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-53-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-53-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 11:28:10 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXz9ykgdIzk9rD
 muVC64o2bm5ZcoPevag+XPlpVJRpEu0o6ctnkJKqnG+M/OYlkod+cyOH4kOaJXWe9KYhPKILkeE
 oWauz5bxjCfJ2eWQCie/L/8CJXZ1Npt8dgfNEcjdbpgfsZGb89hTpOp+XDTV/zmoWhdfT6xXI+P
 8kENwN91cwonIdmAi+YxiupfkzXHmO+hcafd0zH/FZfYL6JsZQTzMeMXtIeErLLw5UENj36aHnq
 13LaHkTpVV2ZIKLEuh2ASh5LcJhadr2r2AuVj/ESRbm+Xhv0Z6c5wFFNMHlBDuzCbGmw4y6TmQe
 qR6p8qlPOn+A5P5VN8oVYdJ6BOAuihBvINL3hT47DF+TpSQppRotP1Gfozpn38Z7Yc5A52glurF
 Jfl1dBzK
X-Proofpoint-ORIG-GUID: -V4x2mUJKfsUoo-xa97-JO075Qk639V8
X-Proofpoint-GUID: gWC5zTDRIiI7_LhO0gFFnQcMBLnhqtK5
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc250f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=viIWlect0QnoYGXmhEcA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AULIiLoY-XQsE5F6gcqX:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Rename initialize_lsm() to be more consistent with the rest of the LSM
> initialization changes and rework the function itself to better fit
> with the "exit on fail" coding pattern.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

