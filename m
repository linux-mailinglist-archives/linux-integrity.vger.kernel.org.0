Return-Path: <linux-integrity+bounces-373-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B710F8078AF
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CE51C20A85
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0B47F47;
	Wed,  6 Dec 2023 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fPsvGLNW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CAD98
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:33:36 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6ImnJc006149
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=xOg4rsu4rEtzh5igcW2KfwtL9HjpV/2hG+rGxi5ylMc=;
 b=fPsvGLNWCQ5gsoYvdUt+SgXHMCtApwRP9FVvSq9QTU8ZBe9Oa6mmbv3DHIT++EIZSeVE
 wg/QusA5bAKYJkNEPmOzuHeN4lyxijzJPTlGmVAxyf0VlSb9D8hVT18Adr1VcQ6GqjoX
 uB+kMJi5K96DL8SHWHL3Zpvi0Brru0C0Gl7A9R4kPigiSTDfEvJVi5K+yFO/efwZBWEf
 zusqQYxIhSJnDRpMMMT1KpBq4uFSZ2YJB7SudwhK8RyIntkOl53+JFa5RZVZn51LCLq7
 Hk/fT8aVIiFniVwwr+o7gqKu51dysLiYCU440rucavT94lDUEANYq6GLwKnMCWMWq5d/ oA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utus2f5wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:33:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IQxgE028432
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:33:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavjpkjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:33:34 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JXXnu29491804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:33:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853AE5805D;
	Wed,  6 Dec 2023 19:33:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D21C58055;
	Wed,  6 Dec 2023 19:33:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.99.183])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:33:33 +0000 (GMT)
Message-ID: <8b45fae3677cc3827b653b519b00f2f3ebdd3545.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils PATCH v3 00/14] Enable shellcheck and fix some
 issues
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Date: Wed, 06 Dec 2023 14:33:32 -0500
In-Reply-To: <20231201133136.2124147-1-stefanb@linux.ibm.com>
References: <20231201133136.2124147-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gJj9gRiWqaDJ86dQjB25sMiYnsK8IRXX
X-Proofpoint-GUID: gJj9gRiWqaDJ86dQjB25sMiYnsK8IRXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

On Fri, 2023-12-01 at 08:31 -0500, Stefan Berger wrote:
> Enable shellcheck for the bash scripts in the tests directory. Fix issues
> on the way that are found when particular checks are enabled. In the end
> all shellcheck v0.9 checks are enabled and shellcheck passes without any
> issues.
> 
> Shellcheck can be run using the following command:
> 
>    make shellcheck
> 
> Apart from style issues two real issues are detected by SC2003 and SC2295.
> 
> Regards,
>    Stefan
> 
> v3:
>  - Replace read with readarray
> 
> v2:
>  - Rebased on latest next-testing branch
>  - 1/14: Use ${var:+${var}} pattern for variables that hold multiple
>          arguments like "--foo bar" which would become one argument
>          if passed with "${var}"; fixed a build issue
>  - 4/14: remove $new_policy file in success and failure cases

Thanks, Stefan.  Other than modifying 1/14 as discussed, it looks good.
The patch set is now queued in next-testing.

Mimi


