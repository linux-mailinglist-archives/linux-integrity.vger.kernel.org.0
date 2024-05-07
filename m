Return-Path: <linux-integrity+bounces-2344-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1338BEE19
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1ABB23244
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CB187348;
	Tue,  7 May 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r9sTzlzC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73453187320;
	Tue,  7 May 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113708; cv=none; b=PYoo4tCfuFXZ7wglfcQTdWXr0m42VVk57mFHL7OXLy8EuKiXyZwlAg0Q/ZISuzFQDDnaiMuPGlX3pyPeCpUK+fKwfmlbfoDt2Cnvg6Kp7j6s5ZkVvGawygMTjfR4Keign9SOOZWbHSvD7rvpkjTzRhfHgBi2D+Z5i4bQUPfZKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113708; c=relaxed/simple;
	bh=x1GHjcPDDJTl+ZsQCF/flnxznBJUw6U2MMSDZ/gOtY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=kYwiTxnN6t/ols3EZRmc031e9GOh9SIXo5gFDtmfsYMm0rlQrMcfmJiEyPmJz0HNTykercqXpmgEQkaViJU5TMfOlUjpqGbFHE1UuiSPGHMOySd5v4hwchIlOzTHrUJN6bLOPaQFwlA403/hFuW+rxdfFpa0SAgN+QMJynrD6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r9sTzlzC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447KPtZg014781;
	Tue, 7 May 2024 20:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=idlRHBWRT8oxEc2fgBMDrdVapLVifpy7E0T+mI4TCgQ=;
 b=r9sTzlzC20dBN0730gS45SxoLTg3UYYGGzZvkAR04Nr8EHvnrzT8iJd7Bm+SE35Bjzi5
 iUzlsAG/I7QQosztWusqrjQaSIZhbDVu3TNqpIodqix7LElBld1jloLHHuf/mXFqWPTg
 +I9DBa2bAnjQEY1b0bvH1UCdj2esAwrhnUWTgaD6Kw5sYuqhuduUdHMmP3oX9ODEIb4y
 i+VDKwd8Zb1di/+VmFXu+drqbL2jQZDNrZQJbD62t5axRqTMX6mAdZ9b6wfAH6VB5EAO
 E7jUdTC50OugLsbLQ7zR+fUHMPl+pW0vq4gRWZ1iPdHqWwuqNPM4sPtj8BAYh5MQfhB2 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyua3r0ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 20:27:53 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447KRr7C017939;
	Tue, 7 May 2024 20:27:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyua3r0m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 20:27:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJhib009488;
	Tue, 7 May 2024 20:27:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysfx8mt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 20:27:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447KRnEp21430898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 20:27:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C27D25805A;
	Tue,  7 May 2024 20:27:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2EA158051;
	Tue,  7 May 2024 20:27:48 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 20:27:48 +0000 (GMT)
Message-ID: <cc11e15bdbfbb36415b36a796387e130b764fd6a.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: Use sequence number to wait for policy updates
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        eparis@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, guozihua@huawei.com, omosnace@redhat.com,
        audit@vger.kernel.org, apparmor@lists.ubuntu.com,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 07 May 2024 16:27:33 -0400
In-Reply-To: <e6e2b31983610bf566d8046edbac0e00c8453233.camel@huaweicloud.com>
References: <20240507092831.3590793-1-roberto.sassu@huaweicloud.com>
	 <e6e2b31983610bf566d8046edbac0e00c8453233.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DQc8ykwpdROiUFHjkXQPSgVcCkMS1H8j
X-Proofpoint-ORIG-GUID: kZPJ7Ktfupkc_F6AbfPESwKX_GFbzKBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=987
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405070143

Hi Roberto,

On Tue, 2024-05-07 at 11:32 +0200, Roberto Sassu wrote:
> On Tue, 2024-05-07 at 11:28 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Maintain a global sequence number, and set it to individual policy rules,
> > when they are created.
> 
> Just did an attempt, to see if this path is viable.
> 
> This patch would be an alternative to:
> 
> [PATCH v3] ima: Avoid blocking in RCU read-side critical section

Stephen had said,
   "Sidebar: the refactoring of the SELinux policy loading logic may have
   made it possible to revisit the approaches here to permit holding a
   reference to the policy from which the rule was derived so that we
   don't have to return -ESTALE in this scenario."

Removing -ESTALE would be the best solution.  We could then remove the -ESTALE
detection.

I assume the change would be in selinux_policy_commit(). Instead of freeing the
old policy, define and increment a per policy reference count for each
registered notifier callback.

        /* Free the old policy */
        synchronize_rcu();
        selinux_policy_free(oldpolicy);
        kfree(load_state->convert_data);

        /* Notify others of the policy change */
        selinux_notify_policy_change(seqno);

Mimi


