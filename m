Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86B470129
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhLJNGQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 08:06:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238148AbhLJNGP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 08:06:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAD1PqS009950;
        Fri, 10 Dec 2021 13:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7Af6OiZfeZr/MWIUPLN9S9F3O/cq0ozE5pKi902+JhU=;
 b=VIimoFqzwYSemEUvAGLZOgPnFa+6twuv4QVIz9NEIawxVIeqjIlmXxa0oNKxcR6vvB/Y
 m1is076hlzEfYkmgrWr0c/1g/c4HmKeaVaMSlnOUfmmpVm4hTxdfbY1K2CqOt5SEJDYm
 F9pFJx5AUOGc9MAGfCC85pFKhM7YKIbz9wn8Q/vm7B1Zkl3VQJhhxWhNTZkYLggrsGRl
 wNUw4m4cZvoUwDUSaJKjNNbTBa34u59ifqDceMLWwjVEuNYvG0DC+8jnhnN/1Y0EZe8E
 NUheBS7+4MH7OPpTyMHHTi8KrdnRA4qADB5r2TiqB7ni1bUfkhTgwiIdAgCPBdAlD9Nl sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6g719u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:02:24 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAD1Tl6010423;
        Fri, 10 Dec 2021 13:02:23 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6g719sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:02:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAD25LM013707;
        Fri, 10 Dec 2021 13:02:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3cqyyagw0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:02:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAD2G8Q30474724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 13:02:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71938A4054;
        Fri, 10 Dec 2021 13:02:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9856A405C;
        Fri, 10 Dec 2021 13:02:13 +0000 (GMT)
Received: from sig-9-65-75-5.ibm.com (unknown [9.65.75.5])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 13:02:13 +0000 (GMT)
Message-ID: <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 08:02:13 -0500
In-Reply-To: <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
         <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
         <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u2ZDp_iAvevGhiUByT_N8lL_5jN6cTpM
X-Proofpoint-GUID: ANty0JWsO92036xgJFMrTIdrfEXb7u7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 07:40 -0500, Stefan Berger wrote:
> On 12/10/21 07:09, Mimi Zohar wrote:
> > On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> >>> There's still the problem that if you write the policy, making the file
> >>> disappear then unmount and remount securityfs it will come back.  My
> >>> guess for fixing this is that we only stash the policy file reference,
> >>> create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
> >>> something and refuse to create it for that value.
> >> Some sort of indicator that gets stashed in struct ima_ns that the file
> >> does not get recreated on consecutive mounts. That shouldn't be hard to
> >> fix.
> > The policy file disappearing is for backwards compatibility, prior to
> > being able to extend the custom policy.  For embedded usecases,
> > allowing the policy to be written exactly once might makes sense.  Do
> > we really want/need to continue to support removing the policy in
> > namespaces?
> 
> I don't have an answer but should the behavior for the same #define in 
> this case be different for host and namespaces? Or should we just 
> 'select IMA_WRITE_POLICY and IMA_READ_POLICY' when IMA_NS is selected?

The latter option sounds good.  Being able to analyze the namespace
policy is really important.

thanks,

Mimi

