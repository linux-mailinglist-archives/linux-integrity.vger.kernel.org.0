Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEA4700D7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhLJMog (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 07:44:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235838AbhLJMof (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 07:44:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BACT2Cg029161;
        Fri, 10 Dec 2021 12:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=mcvB4ZKrTPS+PcRdTZblXwUsuW4rFbow5N/jDPyjKf0=;
 b=XtTFbJQWmbsz4FQmd5tG+2ATuSdUWozI+wZ8xt11DrMbhQq6mKLC15fUu7xpL+8IU97f
 5T6D9eFJscluwgSSG6vKrWzUZNzJjPX31njy3KdCyvt3rl+OmEgW5KkPAWZrC9LnXVbi
 6VcZ7cROisLgcc95OMBzCok4DvI4B1DfqdgmYhwBI3VjJmBkhOl7F91t7geHzGqiYs1h
 2VHc95RCgL7osFhxkod16qg/NLCF+O/FjNMWsKypBT7omvnOIED91+BjhUA3R1gdPGiW
 MzdBn1htceXhPsrpK55mxLJJF/HPZyDZaIfUztRmNJ5aCqXUlB7LbNWZdiKRK+D8GMyH SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6xar6vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BACWSoI010321;
        Fri, 10 Dec 2021 12:40:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6xar6v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BACcdIm029788;
        Fri, 10 Dec 2021 12:40:47 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3cqyyceddr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:47 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BACejAS27197762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:40:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A922B78068;
        Fri, 10 Dec 2021 12:40:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D03137806D;
        Fri, 10 Dec 2021 12:40:42 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 12:40:42 +0000 (GMT)
Message-ID: <d321f676a5ba54ae1704f5e23f0b134e70dfea3f.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 07:40:41 -0500
In-Reply-To: <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
         <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jpn_R-ynv9PZrE1JedW0HfWD4UlMpACb
X-Proofpoint-ORIG-GUID: mkbRS4mEuAp1y0MVzgtIhJEGKQkApGle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100070
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 07:09 -0500, Mimi Zohar wrote:
> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> > > There's still the problem that if you write the policy, making
> > > the file disappear then unmount and remount securityfs it will
> > > come back.  My guess for fixing this is that we only stash the
> > > policy file reference, create it if NULL but then set the pointer
> > > to PTR_ERR(-EINVAL) or something and refuse to create it for that
> > > value.
> > 
> > Some sort of indicator that gets stashed in struct ima_ns that the
> > file does not get recreated on consecutive mounts. That shouldn't
> > be hard to fix.

Yes, Stefan said he was doing that.

> The policy file disappearing is for backwards compatibility, prior to
> being able to extend the custom policy.  For embedded usecases,
> allowing the policy to be written exactly once might makes sense.  Do
> we really want/need to continue to support removing the policy in
> namespaces?

The embedded world tends also to be a big consumer of namespaces, so if
this semantic is for them, likely it should remain in the namespaced
IMA.

But how necessary is the semantic?  If we got rid of it from the whole
of IMA, what would break? If we can't think of anything it could likely
be removed from both namespaced and non-namespaced IMA.

James


