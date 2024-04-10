Return-Path: <linux-integrity+bounces-2045-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A989FA13
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Apr 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFAFB30833
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Apr 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485415EFA8;
	Wed, 10 Apr 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+bHSTF0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC815ADB0
	for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758439; cv=none; b=TZ590csCoAOetdnn5IAhU6LMMkCVlb3FjVO5yyGJOpIn3LavhDtEV+aWfwDiyVXAL9Zh3lB0XduZZdQRWmLxhTwrYLpdoCCJXY0JX3RR4saMh5Tl2in+qdCBek/qOlxeba21zreazR32ishkeEXiqxzTzhvkH9eslRp4mMJFIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758439; c=relaxed/simple;
	bh=G6NW9t/HtSLNevCv5qI1wPGhWs5h9lN3HdTpgQYJL7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=FHNczn1M1CXfAOLOP8kr5nYRPaIrEwW7eVi5z3qDUYHNo253KW71cNSd4bZpOJ4ECAGytnE19GktsbTUBf+OVXVopSg7emKUpeFjMbqVgtggvnbn/JBLaiT3vEDhBcFH/ewWzC13tC26bCYNJoPP+8F48/0DuT9QSyhpUl43HZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+bHSTF0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AE21Wd008040;
	Wed, 10 Apr 2024 14:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HExzwo/u3PfujzkeiLzaC/f+okLiDCBHOFTmm79Rx0M=;
 b=l+bHSTF0Sv83TrFZ9zOgMVM64BalGSTseYB6o5LA52DFWYlxuctiuglez9HBEa4ffMdn
 5jcrbONr5wslSEcK7oe8+c9sUBdbyFr5tMdWyi20KN3hTTQJpd844cZ2Huf1x3/s9wuv
 aDivlTyLXmgdkovzx49EFhclCOpoXWMPegJ8Fia/5XyQPpT4dKxYSj3j6p3wAUH20cSC
 gISlqucI9Z/95SkJcstuDPjnLw4vH4fSkKqqExtGEtJeITs0y3w6xrE9XS08eoHTh0nM
 8ZGUrHGSevjP+oKqdRw5ssdUxUfp0rjdBz6OCBTino+bafR/jOYMOqkS9XjDMUW/jk08 iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdv61r17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:13:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AEDlEr028438;
	Wed, 10 Apr 2024 14:13:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdv61r17m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:13:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43ACg6bS016996;
	Wed, 10 Apr 2024 14:13:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2mqg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:13:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AEDhBo25363072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 14:13:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13735805B;
	Wed, 10 Apr 2024 14:13:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E7C958058;
	Wed, 10 Apr 2024 14:13:43 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.48.44])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 14:13:43 +0000 (GMT)
Message-ID: <b45c2f7645ce1869e6246c618b230bb5be47fe19.camel@linux.ibm.com>
Subject: Re: [PATCH v6] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Wed, 10 Apr 2024 10:13:42 -0400
In-Reply-To: <e2a10f8c-aa70-43c1-93b8-2e07430ab6a9@polito.it>
References: <20240408212810.1043272-1-enrico.bravi@polito.it>
	 <74f8f5fa75629c41455f28544ab8c430ebd9006a.camel@linux.ibm.com>
	 <e2a10f8c-aa70-43c1-93b8-2e07430ab6a9@polito.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fr_Ly_HV_pFsfmIvWNoPU5TYAAfcb9qx
X-Proofpoint-GUID: 4_ObRO_jZXUh0VELjWX55warZjPh-zgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100103

On Wed, 2024-04-10 at 10:37 +0200, Enrico Bravi wrote:
> > > +static struct dentry **ascii_securityfs_measurement_lists
> > > __ro_after_init;
> > > +static struct dentry **binary_securityfs_measurement_lists
> > > __ro_after_init;
> > > +static int securityfs_measurement_list_count __ro_after_init;
> > > +
> > > +static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
> > > +                              struct seq_file *m, struct dentry
> > > **dentry_list)
> > 
> > Please rename the function without "_by_dentry". Consider naming the
> > function
> > lookup_measurement_list_algo().  Instead of dentry_list, consider naming the
> > variable measurement_lists or just lists.
> What do you think of lookup_template_data_hash_algo()?

Sounds good.

Mimi


