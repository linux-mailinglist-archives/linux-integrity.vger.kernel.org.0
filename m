Return-Path: <linux-integrity+bounces-7173-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7EB86310
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F781170BF8
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A989248F75;
	Thu, 18 Sep 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nmq3fNA+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AD2641E7;
	Thu, 18 Sep 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216066; cv=none; b=P1h7mSXsIjJoEeiZvqp21JBGy9mIirYC7bqtW8KK9mkzpCplmQdZu2+/p/WJTh57/XLYHYhs6gdoZsTaNsZhKPM+2cYaQs83+YhujG78hBosbNuvAvduCJ01J06pZ2w+dWn/DH4d6V2qUJPtQbsdPfFt5uj+pphH8KvV2/HJ67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216066; c=relaxed/simple;
	bh=fr9V6Q84uUUDuxpqvxAtyY5JWm48mW63WvKitI7Xtu8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SsHK0+pQB/kuIL5GUk9Op+WENNzjnXOLga9NBwKvMGZaPKF34oo1sKP6lYY2Dc4ST9NTqJllZKy51GF6DzkfmgR0KIHn6txTvNvL+lQinHFNiLzks55NNl7PAvgjoM2EQVpyA00e7pX2PIAZojviTx9nzvaWpGQicuipMxww3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nmq3fNA+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG04kE031409;
	Thu, 18 Sep 2025 17:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R/2t9u
	SmR99E68cq0Iwly/JUEzLvRbwieMLc54CkcDY=; b=nmq3fNA+rR3Ldw3PBOge3U
	5v6kt9KimaRXiewxMYextejr/mTtrpBgM2VtYtMj9JIW2fqOdfZQtJdbkXwAIviz
	zKk5qQGnfQpTHxmvubdSix/bk4J/yB/Y9Y8HsyU4e0i983F72x1eBiSDr8+G+ZnH
	eujjoTtVfP15rNVFkOrJm6l6GcxF+PpREse6jj+OYkHPOpCdrcVAcFqLWE8NGVje
	cii5nBHzCnWTnjd/BAW6cp/9RGmLncJuNIF/iugFEHl1VPXNEpbNwzdM4h78lLgt
	GZJt+ZIIQu6YAR0zL+D07jFI9SIb91uClBAi66XptOC/JfJiZCoDYUnfG7tkCJmA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hussv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:20:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IHFIQ0013304;
	Thu, 18 Sep 2025 17:20:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hussq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:20:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG0Xh3005963;
	Thu, 18 Sep 2025 17:19:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxug3vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:19:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IHJwch25100890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:19:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A2E58043;
	Thu, 18 Sep 2025 17:19:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26D165805D;
	Thu, 18 Sep 2025 17:19:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 17:19:57 +0000 (GMT)
Message-ID: <bcf051d30aa9021b4281cdc58e327cbd34b30c14.camel@linux.ibm.com>
Subject: Re: [PATCH v4 23/34] lsm: introduce an initcall mechanism into the
 LSM framework
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
In-Reply-To: <20250916220355.252592-59-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-59-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 13:19:56 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GbKLvIajYGoClOfMrE4L8ArAIRCdwfKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7uEPDF2bAlqP
 HeLrW7fkdDvJR0/UEMj602IRFH4y+KuZ444Dle0eFmKQImkjaMr3/UOxyuF8BcnLa2BwaK1g1X4
 PtM6U9AfPGr/83k4V3K41XlU3kDp5wQB4OPWBYO7qPE7u+ZZXG3U6oSAenkN12LHFBOajXcHGA5
 eB0WA1OJ59wYHbuV/GO+haLMiI7iLzSjKplAB4cMAlvGnPiI3e25gVnQcCw93iOUG+sBWFl2V+F
 kmu8tYW+Givqj0deJGb7fOmlLPDD+oqgL7qhssLrEuS2fK2CG1MHJKZIjw8i6mkc6PR+3oyyzKs
 5bJvBO4OljKfi5/Zhg8cnSumLxKHr0WqtgPF/0q4C5lyAai0zpIyXddcs0ngu5Cb4vLq1yvB9N5
 1n/GSrWU
X-Proofpoint-GUID: uFtpuqOZIUvChUNfq2MVsLiYijKK_CDC
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc3f41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=vpqfxihKAAAA:8
 a=DfNHnWVPAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=jY9fHlhbiYfxSyiXFfcA:9
 a=QEXdDO2ut3YA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Currently the individual LSMs register their own initcalls, and while
> this should be harmless, it can be wasteful in the case where a LSM
> is disabled at boot as the initcall will still be executed.  This
> patch introduces support for managing the initcalls in the LSM
> framework, and future patches will convert the existing LSMs over to
> this new mechanism.
>=20
> Only initcall types which are used by the current in-tree LSMs are
> supported, additional initcall types can easily be added in the future
> if needed.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

