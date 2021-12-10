Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0C470074
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhLJMNr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 07:13:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229762AbhLJMNq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 07:13:46 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BABGmGa002942;
        Fri, 10 Dec 2021 12:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=F2WS9VtJA0aucYunapKFUmvd+bZ0GHr7cx1VKk5z434=;
 b=f4OAfSiiZMyzEgEJr3jDykSf3kLeMprJ7lcc3OGUtsZLUY3HiL7ISNir78Mfxcqkcn0/
 IKPSzl7izfymtJlcc6lOE54h2ZqzJy4pbXLsZ/izNmw8M8YSwvLjH4YtldzZZ1MwgSJ5
 BeTqi2MkAdHyqPGHlSab8VgorWGlXnbe+nrU0lk/Nw6FuRXWdoyQB99XZZqPd1m0NO9V
 JL0IZ3RRz1rZOxUIAROsGazmrsnmKElcfTf7BakQKuyP18Om4/HXy7FFMoIB83CmJfUH
 /lnl5U1E9cV2hfT9B4z+nlxAxA592KkAF9IxoE6TyjlCKgrG/M07SNZgoN/NF5+JaHVi 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv49nb0a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:09:44 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BABVP1a023125;
        Fri, 10 Dec 2021 12:09:44 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv49nb09e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:09:43 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAC81Qu028702;
        Fri, 10 Dec 2021 12:09:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3cqyya8fwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:09:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAC9c6h22675966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:09:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62534AE057;
        Fri, 10 Dec 2021 12:09:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0BAAE055;
        Fri, 10 Dec 2021 12:09:35 +0000 (GMT)
Received: from sig-9-65-75-5.ibm.com (unknown [9.65.75.5])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 12:09:35 +0000 (GMT)
Message-ID: <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 07:09:30 -0500
In-Reply-To: <20211210114934.tacjnwryihrsx6ln@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xnGPL45WhVZ1Km2GXrzRaWYa2YGm2dRg
X-Proofpoint-GUID: C6zE09KP1KKnqSwpslC7fo3qDWzdjTqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100067
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> > There's still the problem that if you write the policy, making the file
> > disappear then unmount and remount securityfs it will come back.  My
> > guess for fixing this is that we only stash the policy file reference,
> > create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
> > something and refuse to create it for that value.
> 
> Some sort of indicator that gets stashed in struct ima_ns that the file
> does not get recreated on consecutive mounts. That shouldn't be hard to
> fix.

The policy file disappearing is for backwards compatibility, prior to
being able to extend the custom policy.  For embedded usecases,
allowing the policy to be written exactly once might makes sense.  Do
we really want/need to continue to support removing the policy in
namespaces?

thanks,

Mimi

