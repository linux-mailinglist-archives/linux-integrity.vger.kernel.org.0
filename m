Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071BB470106
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbhLJM6l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 07:58:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241067AbhLJM6l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 07:58:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BACRpuu028782;
        Fri, 10 Dec 2021 12:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=P8NxtWpypggT43TiPhPCjS93PqOOrE9plYGcwIADtkY=;
 b=OOz357Gsmrh8KLUXbEdXeMLR9f3nQfLJqSScScU3s8KJ+hsqzCLkqPGwBHIfusQGy2uO
 SzwS4SR4dqHMGpfhlE8hj0D82j2kj1tIGurcnPhUYzW27tlE+hv8hsG2tWUBMo58B3Cb
 tC/2Mac4HbZfV8c3CuEfhAj8yICYeaNqZePWDloUIKKzl4LmYB72S3lOUHMjTj9HcXvf
 3JtwlHYv83MmFVedV1ZgkG5iI2ox7+WvDR44w8w8JuOkfiHvZ5eiXHZMEbY82ddTlDfW
 EaEAYoVh0FN33mD2hBocfrCszdvKSBjqPPc2di8EQ62uJdYhIsiBlzQzXwq0+y4x9hxB cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv6ww0g2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:54:55 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BACRiYw028654;
        Fri, 10 Dec 2021 12:54:55 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv6ww0g1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:54:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BACq6HQ031550;
        Fri, 10 Dec 2021 12:54:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3cqyyagtw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:54:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BACsl4R21233954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:54:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A776A4054;
        Fri, 10 Dec 2021 12:54:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D118A405C;
        Fri, 10 Dec 2021 12:54:45 +0000 (GMT)
Received: from sig-9-65-75-5.ibm.com (unknown [9.65.75.5])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 12:54:45 +0000 (GMT)
Message-ID: <d72550d9690d563e4c43220111b39d2d55ea10ff.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     jejb@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 07:54:44 -0500
In-Reply-To: <d321f676a5ba54ae1704f5e23f0b134e70dfea3f.camel@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
         <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
         <d321f676a5ba54ae1704f5e23f0b134e70dfea3f.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XRyjxnJ0BmzTdVjLISQpGgMEcKw-kMNx
X-Proofpoint-ORIG-GUID: Lrhpzyr38RYmizTFmcMlH758q0V0LBUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100070
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 07:40 -0500, James Bottomley wrote:
> On Fri, 2021-12-10 at 07:09 -0500, Mimi Zohar wrote:
> > On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> > > > There's still the problem that if you write the policy, making
> > > > the file disappear then unmount and remount securityfs it will
> > > > come back.  My guess for fixing this is that we only stash the
> > > > policy file reference, create it if NULL but then set the pointer
> > > > to PTR_ERR(-EINVAL) or something and refuse to create it for that
> > > > value.
> > > 
> > > Some sort of indicator that gets stashed in struct ima_ns that the
> > > file does not get recreated on consecutive mounts. That shouldn't
> > > be hard to fix.
> 
> Yes, Stefan said he was doing that.
> 
> > The policy file disappearing is for backwards compatibility, prior to
> > being able to extend the custom policy.  For embedded usecases,
> > allowing the policy to be written exactly once might makes sense.  Do
> > we really want/need to continue to support removing the policy in
> > namespaces?
> 
> The embedded world tends also to be a big consumer of namespaces, so if
> this semantic is for them, likely it should remain in the namespaced
> IMA.

Think of a simple device that loads a custom IMA policy, which never
changes once loaded.
> 
> But how necessary is the semantic?  If we got rid of it from the whole
> of IMA, what would break? If we can't think of anything it could likely
> be removed from both namespaced and non-namespaced IMA.

The question isn't an issue of "breaking", but of leaking info.  If
this isn't a real concern, then the ability of removing the securityfs
isn't needed.

thanks,

Mimi

