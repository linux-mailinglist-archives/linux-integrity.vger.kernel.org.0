Return-Path: <linux-integrity+bounces-3732-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C498F242
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0731C21242
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EFC197A65;
	Thu,  3 Oct 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWIVpEg2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C319CD0B;
	Thu,  3 Oct 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968492; cv=none; b=kUT9/WEb8fmkmkWxr3daxfMidT1eMumh8IYCDQrNkjf5+S14qT4EBoikKn61JixEw9YDrmB+C7rkcPv+QJlWynnm4d+34ZmNVkpgXgUxI69Fb9DTtWHKQZWd5wX82srVX6idBHQpjZdqfdWMk6P+rhgnf9Na3H0mg+coKO3IrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968492; c=relaxed/simple;
	bh=xmEH20Nq5o5Un2lXFQ1wQmstfsur9/CVwpYLSoOVYG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uL7/hmpq5RrIN9GCTA57M1xPmPOdksoBlcgBKdA8EpGNclzK07DRJZ1pYKuDSlCZZYAB/5rjrH5a7GtKOLf+ljJ0RMpjfAQNxvcAyZb/6Jtx8ET7Qxe5F8lldbZLQ/FnVYORLz3zANJNOC6qP4ojI1R0uoMBd2nOfEXzW63A34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWIVpEg2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EkfED032613;
	Thu, 3 Oct 2024 15:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	06CT3E910iENCLWyqE+iVYG+TqUy1wGVmKngE4Bo+qw=; b=rWIVpEg2d0uIFxRM
	m+cdImoSGwdsYjxRhOC1ocsvRUo1ohP+oUL1xQtgpHGF/fnflAw3XOj+hiKLI7dM
	NPCTn5Mij14wgFJj7+t7QBfmJY7lW19kF7vSVIhx7s/YCa4bW0mwcBiOeBw/RxJg
	Ln7zibjOjFpToeZl1JPzYJ8lorxr8zN/rPqHGEip/0+7x7NUOwbGLdYkNsF1A9o8
	n3BJAkf9Tosk3p9znJvkbKFOVBNLTo+EKG/azJn6pkXiBy9Wkjz7eO5dzZKfsglE
	lsRkUyt/GvtosGpmN5jPb/4FPuFmnGK0js9nHYjlBXRj3EHTUbOAl5FnRVndn2bp
	orCXvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421wae04ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:14:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493FERfw006145;
	Thu, 3 Oct 2024 15:14:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421wae04pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:14:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493BsNKo020408;
	Thu, 3 Oct 2024 15:14:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4sgmr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:14:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493FEP8I56951112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 15:14:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2A45805E;
	Thu,  3 Oct 2024 15:14:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3017D5805A;
	Thu,  3 Oct 2024 15:14:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 15:14:24 +0000 (GMT)
Message-ID: <7f05ff8e-6103-4ad7-8a32-9ff5643b8a41@linux.ibm.com>
Date: Thu, 3 Oct 2024 11:14:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com,
        mapengyu@gmail.com, Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240921120811.1264985-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DrgH_RP9_UttccGGai0UddPG_vRoRn8C
X-Proofpoint-ORIG-GUID: f_eH5Q7IsdQSTJubjWUFHlsqUMbaRzGw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 mlxlogscore=900 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030110



On 9/21/24 8:08 AM, Jarkko Sakkinen wrote:
> This patch set aims to fix:
> https://bugzilla.kernel.org/show_bug.cgi?id=219229.
> 
> The baseline for the series is the v6.11 tag.

I was testing this with 6.12-rc1 on ppc64/kvm + vtpm boot time from 
pressing return on grub until login prompt appears while using an IMA 
measure policy:

with HMAC2: 36s
with HMAC2+this series: 29s
without HMAC2: 28s

Looks good to me, though using a hardware TPM would probably be more 
critical in this type of measurement.

> 
> v4:
> https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kernel.org/
> v3:
> https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
> v2:
> https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
> v1:
> https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/
> 
> Jarkko Sakkinen (5):
>    tpm: Return on tpm2_create_null_primary() failure
>    tpm: Implement tpm2_load_null() rollback
>    tpm: flush the null key only when /dev/tpm0 is accessed
>    tpm: Allocate chip->auth in tpm2_start_auth_session()
>    tpm: flush the auth session only when /dev/tpm0 is open
> 
>   drivers/char/tpm/tpm-chip.c       |  14 ++++
>   drivers/char/tpm/tpm-dev-common.c |   8 +++
>   drivers/char/tpm/tpm-interface.c  |  10 ++-
>   drivers/char/tpm/tpm2-cmd.c       |   3 +
>   drivers/char/tpm/tpm2-sessions.c  | 109 ++++++++++++++++++------------
>   include/linux/tpm.h               |   2 +
>   6 files changed, 102 insertions(+), 44 deletions(-)
> 

