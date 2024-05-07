Return-Path: <linux-integrity+bounces-2343-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607988BE16F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 13:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D171F2397F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3915252F;
	Tue,  7 May 2024 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IGaHRBuu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339A1509B0;
	Tue,  7 May 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082876; cv=none; b=iMe9738mNEOOcyKHvzSbagZYd0V3ALyt1mZd7NdgylL9L7nNuZWkcyVNt76iPxUDxXKfTnwT0c8pyj/nZxEksRRcR9kyTG24jdmYeLbVaci/3WMw288I/iVyID4cZmkxdAQuCoLc2blbsMVjhmvHDl+PNyFZA/Sc8Yp92GAyq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082876; c=relaxed/simple;
	bh=dTHlifqT8rTPMbPEVR3X+UNuN6wPypI1d/rW8hGvkNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Aqa69Eu+aabuXCr9OlNA+p5NbfwGmEaHHrCBQscSPy9I1IIeXe2kdPMWsQXC8tbE+7T6WGktqRq2VnjrtyPF7cDk1CyUjb1KqjC/Jc9MX4Dx0/Uw9PI38fO63yw9uL9v+G+1v6tMLM6rxXpdappY7Nyv1kr2po7hIvQn0x70U4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IGaHRBuu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447BgHOG006505;
	Tue, 7 May 2024 11:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2AhXXN/V3wCElifhaMO+4M4/JQCST6uMKGpBgF1i3N0=;
 b=IGaHRBuurVHUC0n3co4OAgwkn0LDLk+f/xCtJPOsM6Aze5l1xHHdAwM7tiqjqdLgz1IP
 TBLBLQgkbq3sfzI8eELlLaVuehJuWGJQW0iQ5VicLAIXyu0V5DLo4uDFO8LoQfNNOo0N
 s/6UbCSMYxppRDg3Ohbt3qIUsYzf4YprZhOHCAXP5w1wbMujGPaw5XyzvNiwNm/FfkKv
 LWW7PER415nnri6j7HQDrmN7x1PznLtuh4JzYUR8TpZTWToMzp2tsLpRkJK8//kF4XrP
 H6d9AFQ2/fdkz4KGhpp1BLXwC+v8eu3+W6uR35IwkrcDizcddykdlugOZrbEQucW8x8D 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xykncg0xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:54:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447BsAa9024552;
	Tue, 7 May 2024 11:54:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xykncg0x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:54:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447B6jiA005882;
	Tue, 7 May 2024 11:54:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx5yh4gkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:54:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447Bs6HF51380660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 11:54:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8FD158065;
	Tue,  7 May 2024 11:54:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BC2158057;
	Tue,  7 May 2024 11:54:06 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.105.150])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 11:54:06 +0000 (GMT)
Message-ID: <baff6527d8d1e1f7287e33d6a8570bd242d5cadf.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
From: Mimi Zohar <zohar@linux.ibm.com>
To: GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 07 May 2024 07:54:05 -0400
In-Reply-To: <20240507093714.1031820-1-guozihua@huawei.com>
References: <20240507093714.1031820-1-guozihua@huawei.com>
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
X-Proofpoint-ORIG-GUID: f2H7xKIE5oj-CNtTXPVsPtH1VAdwA9by
X-Proofpoint-GUID: Zz0LFyf-Myp0bDtHdEkceTM9USe5-7Nf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070081

On Tue, 2024-05-07 at 09:37 +0000, GUO Zihua wrote:
> From: liqiong <liqiong@nfschina.com>
> 
> [ Upstream commit eb0782bbdfd0d7c4786216659277c3fd585afc0e ]
> 
> The current IMA ruleset is identified by the variable "ima_rules"
> that default to "&ima_default_rules". When loading a custom policy
> for the first time, the variable is updated to "&ima_policy_rules"
> instead. That update isn't RCU-safe, and deadlocks are possible.
> Indeed, some functions like ima_match_policy() may loop indefinitely
> when traversing "ima_default_rules" with list_for_each_entry_rcu().
> 
> When iterating over the default ruleset back to head, if the list
> head is "ima_default_rules", and "ima_rules" have been updated to
> "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
> stays always true, traversing won't terminate, causing a soft lockup
> and RCU stalls.
> 
> Introduce a temporary value for "ima_rules" when iterating over
> the ruleset to avoid the deadlocks.
> 
> Addition:
> 
> A rcu_read_lock pair is added within ima_update_policy_flag to avoid
> suspicious RCU usage warning. This pair of RCU lock was added with
> commit 4f2946aa0c45 ("IMA: introduce a new policy option
> func=SETXATTR_CHECK") on mainstream.
> 
> Signed-off-by: liqiong <liqiong@nfschina.com>
> Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>
> Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
> Reported-by: kernel test robot <lkp@intel.com> (Fix sparse: incompatible types in comparison expression.)
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Sig=ned-off-by: GUO Zihua <guozihua@huawei.com>

Hi Scott,

I'm confused by this patch.  Is it meant for upstream?

thanks,

Mimi


