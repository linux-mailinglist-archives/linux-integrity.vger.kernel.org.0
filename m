Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF7465371
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhLARCA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 12:02:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242454AbhLARB7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 12:01:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FBd83026640;
        Wed, 1 Dec 2021 16:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=VU6MM+ROwKEmDcMes7UuCYMgIHLwkYSvn+IJYoamdTQ=;
 b=NEENPoWNZZfahISMyzbk/Gi0JOz/WxSr8dVE8WEFajbTJS9oyYbu/K28BOjXO7wGYB9J
 bT5oXNLlJl8JBDF/c1Ota390GQ+8Nrpk5w0aMHebP1aRs2M/auLaaaWLS03ipxB8yCj4
 NxapkzzgcwLA587ZBJjOTCO0ZROCppVwAPZ00W41ytJU/iHmOw4B+fhtKiYc2XWL1HLA
 tOVeJEMMupuLk4LkY8yjmwSS6M2AaCtBwjO4dNxKmShU4UcqxY1/jJQTBZrSqbqc56mz
 kqaxR/AAXquK7nT/b6axj2qlfPS/dzxec/ASMa1spwQ24bQRZXzwm6dvYGnDyA8lxVCY pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpb76u3xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 16:58:15 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1GJMVU019722;
        Wed, 1 Dec 2021 16:58:15 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpb76u3x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 16:58:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Gr49u000871;
        Wed, 1 Dec 2021 16:58:14 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcac15a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 16:58:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1GwCFg25428276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 16:58:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE26078067;
        Wed,  1 Dec 2021 16:58:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B1E78082;
        Wed,  1 Dec 2021 16:58:10 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 16:58:10 +0000 (GMT)
Message-ID: <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Date:   Wed, 01 Dec 2021 11:58:09 -0500
In-Reply-To: <20211130160654.1418231-18-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-18-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IV8FMQfPPxHh36jAptePXcUOmmrwDJhM
X-Proofpoint-ORIG-GUID: CdmKW_qXY0asGSqdRmoOdmU2cK0kTiNa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> From: Denis Semakin <denis.semakin@huawei.com>
> 
> Use integrity_admin_ns_capable() to check corresponding capability to
> allow read/write IMA policy without CAP_SYS_ADMIN but with
> CAP_INTEGRITY_ADMIN.
> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> ---
>  security/integrity/ima/ima_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_fs.c
> b/security/integrity/ima/ima_fs.c
> index fd2798f2d224..6766bb8262f2 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -393,7 +393,7 @@ static int ima_open_policy(struct inode *inode,
> struct file *filp)
>  #else
>  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>  			return -EACCES;
> -		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> +		if (!integrity_admin_ns_capable(ns->user_ns))

so this one is basically replacing what you did in RFC 16/20, which
seems a little redundant.

The question I'd like to ask is: is there still a reason for needing
CAP_INTEGRITY_ADMIN?  My thinking is that now IMA is pretty much tied
to requiring a user (and a mount, because of securityfs_ns) namespace,
there might not be a pressing need for an admin capability separated
from CAP_SYS_ADMIN because the owner of the user namespace passes the
ns_capable(..., CAP_SYS_ADMIN) check.  The rationale in 

https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations

Is effectively "because CAP_SYS_ADMIN is too powerful" but that's no
longer true of the user namespace owner.  It only passes the ns_capable
() check not the capable() one, so while it does get CAP_SYS_ADMIN, it
can only use it in a few situations which represent quite a power
reduction already.

James


