Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBA4702C6
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbhLJOaS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 09:30:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36998 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242109AbhLJOaR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 09:30:17 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BADtqMt004417;
        Fri, 10 Dec 2021 14:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=Iiu88jiNCaTFcvZMP/mNVUZO9RLCCrcb3DmdMekTq24=;
 b=UF1c3wFds9I+zGLO/Vldrz0BGZ7VnRpPvoxanMCRccS2TFCGIWBB7q6JTymVnXyI/lXQ
 1oDtn7l7frmfkEvoPuc1slIf/4usxZ8S16R6MysdblI81uSshs4QlmGOsainvXecxymL
 fabAukut3I4I5dBee5YcR1znGzEWpYVtFWnyvUW6u63YoCrSEFUc4o7y2X9PTVfIueHZ
 b73Ju2DUBAfxBvPk1f0RpfL1kq/lzagMhyEVFqIQLCODm3Cjfeaf3AS1gupjxMdIjIVx
 pm3jHjMf9T2DcSBg+rQknACN6+FEcFyL213f6U1fFHzvivcvQ3vImAQjysotCyrs1B28 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv8798ky5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:26:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAEAmck018448;
        Fri, 10 Dec 2021 14:26:30 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv8798kxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:26:30 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAEGGoj024972;
        Fri, 10 Dec 2021 14:26:29 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyycg5f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:26:29 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAEQRWG24576342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 14:26:28 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E23D778068;
        Fri, 10 Dec 2021 14:26:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F15E778064;
        Fri, 10 Dec 2021 14:26:23 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 14:26:23 +0000 (GMT)
Message-ID: <d6011a5a40c3c304f386a328385836ba9838baf9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 09:26:22 -0500
In-Reply-To: <66b377f6-40b4-77da-c02b-2650fa72d0b4@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
         <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
         <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
         <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
         <66b377f6-40b4-77da-c02b-2650fa72d0b4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hndfFc4n6jChqIslSHhgXxf_bLsiHx3u
X-Proofpoint-GUID: P3lOV3Fq68bOOKeIJWJt7gPCkmFh5Qni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_04,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 09:17 -0500, Stefan Berger wrote:
> On 12/10/21 08:02, Mimi Zohar wrote:
> > On Fri, 2021-12-10 at 07:40 -0500, Stefan Berger wrote:
> > > On 12/10/21 07:09, Mimi Zohar wrote:
> > > > On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> > > > > > There's still the problem that if you write the policy,
> > > > > > making the file disappear then unmount and remount
> > > > > > securityfs it will come back.  My guess for fixing this is
> > > > > > that we only stash the policy file reference,
> > > > > > create it if NULL but then set the pointer to PTR_ERR(-
> > > > > > EINVAL) or something and refuse to create it for that
> > > > > > value.
> > > > > Some sort of indicator that gets stashed in struct ima_ns
> > > > > that the file does not get recreated on consecutive mounts.
> > > > > That shouldn't be hard to fix.
> > > > The policy file disappearing is for backwards compatibility,
> > > > prior to being able to extend the custom policy.  For embedded
> > > > usecases, allowing the policy to be written exactly once might
> > > > makes sense.  Do we really want/need to continue to support
> > > > removing the policy in namespaces?
> > > I don't have an answer but should the behavior for the same
> > > #define in this case be different for host and namespaces? Or
> > > should we just 'select IMA_WRITE_POLICY and IMA_READ_POLICY' when
> > > IMA_NS is selected?
> > The latter option sounds good.  Being able to analyze the namespace
> > policy is really important.
> 
> Ok, I will adjust the Kconfig for this then. This then warrants the 
> question whether to move the dentry into the ima_namespace. The
> current code looks like this.
> 
> #if !defined(CONFIG_IMA_WRITE_POLICY) &&
> !defined(CONFIG_IMA_READ_POLICY)
>          securityfs_remove(ns->policy_dentry);
>          ns->policy_dentry = NULL;
>          ns->policy_dentry_removed = true;
> #elif defined(CONFIG_IMA_WRITE_POLICY)
> 
> With IMA_NS selecting IMA_WRITE_POLICY and IMA_READ_POLICY the above 
> wouldn't be necessary anymore but I find it 'cleaner' to still have
> the dentry isolated rather than it being a global static as it was
> before...

This is really, really why you don't want the semantics inside the
namespace to differ from those outside, because it creates confusion
for the people reading the code, especially with magically forced
config options like this.  I'd strongly suggest you either keep the
semantic in the namespace or eliminate it entirely.

If you really, really have to make the namespace behave differently,
then use global variables and put a big comment on that code saying it
can never be reached once CONFIG_IMA_NS is enabled.

James


