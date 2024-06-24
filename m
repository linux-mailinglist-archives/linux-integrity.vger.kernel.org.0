Return-Path: <linux-integrity+bounces-2931-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC6915A3B
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 01:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C5F285E79
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 23:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F61A2554;
	Mon, 24 Jun 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RfkFoXIS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00374AECE;
	Mon, 24 Jun 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270428; cv=none; b=bGfecSaVe8m8lttFQcd7dgUwgSxphVLBpX4AW0rvOk8QyDCXVB90xfQRrJ39RHxfOL0+Yuxvf2OaBYNUatXjiqNx6NREeLudlB14lCqALayNogmf1m9ospfEF6Pf/8lv+f7SYWPhBYV/oktPgzF852AuGz8NTg/De6KkYaKKojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270428; c=relaxed/simple;
	bh=6eyYkmcs7k8GYPUVFy86lVgqmNwARSx918cQHznJVfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=tudh9FbWwYpyoEpDAdmTvMKSa5WCoolz0nvu+HRYljWZQswnnsvfUG3oro4hae0gLAygGA6Nk4g+OePhe6oBpJpi5MeY3HoTh97MQpiCj6h/Sn8BUA4iO/bOpouAQrh1Rt3X9HfnO/SHapKsShJz8Y3tzykxG1byRlGemQQtvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RfkFoXIS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OMTkol005462;
	Mon, 24 Jun 2024 23:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	knwQoSRgMqzSPvVmvwudpuSCHwgSUHeBaTEusfDPqEg=; b=RfkFoXIS3oImtfLp
	co5CChwMtzPs4CbMWTDTaM6/BlSpynxV8pvhOxbnaHvqpuGI0VrErqWwQKVS6C5V
	vlSDvsSI+tY26ApC7nGjLniqDt9QytbzNtga8PtvSB/TQc0lkMQ2wtzgKhxtQgNa
	ITNqlUvfXdcUIcksM1DjkOQ+j33SO/jHlmL/S2wOJbtdfOvjObWLGu+++Jwdzsl8
	tcW7yy8DeyYnVc68f5dASrtjtlYroY1Cq93qrdn/lBkNCAqJJh/hdRCiH0lrS3Qv
	zw1xNiuAuHCKDMNu0zB+0Jx2vncpgErCALoZ0vNemyM/47M8k6rgjhTWXq8RyjDu
	avc25w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyhmu02n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:06:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ON6dnX025896;
	Mon, 24 Jun 2024 23:06:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyhmu02n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:06:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OJdluF019533;
	Mon, 24 Jun 2024 23:06:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xpuc63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:06:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ON6ZB43211906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 23:06:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B0A358065;
	Mon, 24 Jun 2024 23:06:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45455805D;
	Mon, 24 Jun 2024 23:06:34 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.65.213])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 23:06:34 +0000 (GMT)
Message-ID: <618bc57a3babe5ac85d0fea214d11de7ead89eea.camel@linux.ibm.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Mimi Zohar <zohar@linux.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore
 <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
Date: Mon, 24 Jun 2024 19:06:34 -0400
In-Reply-To: <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
	 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
	 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
	 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
	 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
	 <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
	 <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
	 <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
	 <CAHC9VhS8mC0NC=-gbK_xBq2Ry6Be76ARZSg9Zm3y0bsocGEtTQ@mail.gmail.com>
	 <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TezQC3vIllojA7G1Jb5EHMslJK8iK2vk
X-Proofpoint-GUID: Oy7gxmtyvK-2ZqRlsE-XOWQ3LzNWu97r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_20,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240183

On Mon, 2024-06-24 at 15:19 -0700, Casey Schaufler wrote:
> On 6/24/2024 3:03 PM, Paul Moore wrote:
> > On Mon, Jun 24, 2024 at 9:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
> > > > My only comment would be that I would not call the new functions with
> > > > the ima_ prefix, being those in security.c, which is LSM agnostic, but
> > > > I would rather use a name that more resembles the differences, if any.
> > > Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to these hooks
> > > as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename internal
> > > filter rule functions") renamed the function to ima_filter_rule_XXX) to avoid
> > > security namespace polution.
> > > 
> > > If these were regular security hooks, the hooks would be named:
> > > filter_rule_init, filter_rule_free, filter_rule_match with the matching
> > > "security" prefix functions. Audit and IMA would then register the hooks.
> > > 
> > > I agree these functions should probably be renamed again, probably to
> > > security_ima_filter_rule_XXXX.
> > It's funny, my mind saw that the patch was removing those preprocessor
> > macros and was so happy it must have shut off, because we already have
> > security_XXX functions for these :)
> > 
> > See security_audit_rule_init(), security_audit_rule_free(), and
> > security_audit_rule_match().
> > 
> > Casey, do you want to respin this patch to use the existing LSM
> > functions?
> 
> If you want to use shared functions they shouldn't be security_audit_blah().
> I like Mimi's suggestion. Rename security_audit_filter_rule_init() to
> security_filter_rule_init() and use that in both places.

The existing name is security_audit_rule_init().  Replacing '_audit_' with
'_filter_' would definitely resolve the naming issue.  Each of the LSMs would
need to be converted as well (e.g. smack_audit_rule_init,
selinux_audit_rule_init, aa_audit_rule_init).

> 
> >   It looks like you should have Mimi's and Roberto's support
> > in this.  Please submit this as a standalone patch as it really is a
> > IMA/LSM cleanup.
> > 
> > Thanks all.
> > 


