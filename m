Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339954633A8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhK3MAn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 07:00:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241270AbhK3L7j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 06:59:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUBlNL8025105;
        Tue, 30 Nov 2021 11:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uIZAjevreFQmW522hR9rWhA8J4q1gu1y06hXqfBlV2Y=;
 b=QeFRaR5DaoMGlKuYpfbqlCtNVeTUbxT8huTwU6HVwfDYuaihSOIMXWSZEH+/KW9ZcR/C
 OXNMapZHWrARKcTOTWfNB1I20nuZNGhOPVC0354mqEbSPcPV91pkmw8JXIeZzuGD4gVe
 X+N1AoqyXa93ab80WCj2qCWm+m5f2VfR0vdfkKa4l7w6Ke/evts8bjkI37i9YQPieHoZ
 hmTZN6NrsJvWggcNqR350vj4goHpwMMWUVhJF4Ezm2NDJhLM/ljqtnHORMosr0Uv5xEw
 jVMRgnwAzgiQWUYH/ez31O5edLswgeC22jzSdZLS2UbHdkqfZxkR3jU3SlTpmVh/3Te+ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnkd2849h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 11:55:55 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUBqZXM010526;
        Tue, 30 Nov 2021 11:55:54 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnkd28494-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 11:55:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUBs2ii010233;
        Tue, 30 Nov 2021 11:55:54 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3ckcab8xy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 11:55:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUBtqYC21562020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 11:55:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B645CBE05F;
        Tue, 30 Nov 2021 11:55:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C64C1BE05A;
        Tue, 30 Nov 2021 11:55:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 11:55:51 +0000 (GMT)
Message-ID: <2246a547-3971-8b92-47a4-589a59a33db7@linux.ibm.com>
Date:   Tue, 30 Nov 2021 06:55:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
References: <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
 <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
 <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
 <20211130050316.GC32444@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211130050316.GC32444@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KPncAg3FQE3e0faVS3zF97wrRIIWIcuz
X-Proofpoint-ORIG-GUID: romtJ-TP0pSdOaaIVHLQq4cToFerABo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300066
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/30/21 00:03, Serge E. Hallyn wrote:
> On Mon, Nov 29, 2021 at 12:04:29PM -0500, Stefan Berger wrote:
>> On 11/29/21 11:16, Christian Brauner wrote:
>>> On Mon, Nov 29, 2021 at 09:35:39AM -0600, Serge Hallyn wrote:
>>>> On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
>>>>> On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
>>>>>> On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
>>>>>>
>>> I kept thinking about this question while I was out running and while I
>>> admittedly have reacted poorly to CLONE_NEWIMA patches before it feels
>>> to me that this is the right approach after all. Making it part of
>>> userns at least in this form isn't clean.
>>>
>>> I think attaching a uuid to a userns alone for the sake of IMA is wrong.
>>> Additionally, I think a uuid only for the userns is too limited. This is
>>> similar to the problem of the audit container id. If we have some sort
>>> of uuid for ima it will automatically evolve into something like a
>>> container id (I'm not even arguing that this is necessarily wrong.).
>>> We also have the issue that we then have the container audit id thing -
>>> if this ever lands and the ima userns uuid. All that makes it quite
>>> messy.
>>>
>>> I think CLONE_NEWIMA is ultimately nicer and allows the implementation
>>> to be decoupled from the userns and self-contained as possible. This
>>> also means that ima ns works for privileged containers which sure is a
>>> valid use-case.
>> The thing is that piggy backing on the user namespace at least allows us to
>> 'always see' where IMA's keyring is (across setns()). If we were using an
>> independent IMA namespace how would we guarantee that the user sees the
>> keyring for IMA appraisal? We would at least have to take a reference (as in
>> get_user_ns()) to the user namespace when the IMA namespace is created so
>> that it at least the association of IMA namespace to user namespace remains
> Maybe we pull they keyring info into a new struct which is referred
> to and pinned by both user_ns and ima_ns?  (But I actually am ignorant
> of how ima is using the keyrings, so again I need to go do some reading.)
>
> More moving parts isn't my first choice.  But if you need namespaced IMA
> for containers that aren't doing CLONE_NEWUSER, then a separate ima_ns is
> your only option.  Is that a requirement for you?

I cannot think of a scenario where a user wouldn't want/refuse to open a 
user namespace to get an IMA namespace...


