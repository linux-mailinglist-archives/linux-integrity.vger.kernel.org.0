Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9600477E0B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhLPVBL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 16:01:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231656AbhLPVBL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 16:01:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKg4Fj021284;
        Thu, 16 Dec 2021 21:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5IksaDjfnq8lDmAgTxbBCvkPMQ9LS9n+g9dGRNHt3Go=;
 b=q8ngvx5wShQIaZ3TVAGI7saJ3eZVqebRXCv+RN40ohgHXivA2d2LQBKSUmMRtceNVMgK
 D7rC73JUJQGaczgNoGGtSs5OvT/IlaqUH2SKrgphmMLEVzVyCKtslopcFtxMySt1J9+n
 qx5HzUDx3LpsbyZhmCwistsURGpWOP/NJLiF/SfsBm+5mjQF7m3yRBGQpEvpEwB1vIhe
 PfMZ5BL+2vmnJaVGabof2jH6vkMCWEF4J1FoOplLS0WdABAgLlf1efX/5ewPaV8+aOLe
 vCpAOYAt4mqSvDKN84qlFNkPSweo9zVcOqtDrvOMp8+M4q4sC8Q/Ig4h5bkfvMpktl1t Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr22gnkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:00:45 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGKnYgc015141;
        Thu, 16 Dec 2021 21:00:44 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr22gnke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:00:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKvOJ2009929;
        Thu, 16 Dec 2021 21:00:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3d0bg1t0cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:00:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGL0gRo19202386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 21:00:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99A0EBE056;
        Thu, 16 Dec 2021 21:00:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B94BE062;
        Thu, 16 Dec 2021 21:00:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 21:00:41 +0000 (GMT)
Message-ID: <07c28891-5ac1-3c0d-bb67-cc49aca0aae2@linux.ibm.com>
Date:   Thu, 16 Dec 2021 16:00:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216125027.fte6625wu5vxkjpi@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211216125027.fte6625wu5vxkjpi@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RzSqIH8o8M9oI1Umi5ML3DqlKnEy7KVr
X-Proofpoint-ORIG-GUID: d-Nxf7XDsr4UilKGsfr1GIf5i7bMkeL8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_08,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/16/21 07:50, Christian Brauner wrote:
> On Thu, Dec 16, 2021 at 12:43:09AM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> The goal of this series of patches is to start with the namespacing of
>> IMA and support auditing within an IMA namespace (IMA-ns) as the first
>> step.
>>
>> In this series the IMA namespace is piggy backing on the user namespace
>> and therefore an IMA namespace gets created when a user namespace is
>> created. The advantage of this is that the user namespace can provide
>> the keys infrastructure that IMA appraisal support will need later on.
>>
>> We chose the goal of supporting auditing within an IMA namespace since it
>> requires the least changes to IMA. Following this series, auditing within
>> an IMA namespace can be activated by a user running the following lines
>> that rely on a statically linked busybox to be installed on the host for
>> execution within the minimal container environment:
>>
>> mkdir -p rootfs/{bin,mnt,proc}
>> cp /sbin/busybox rootfs/bin
>> cp /sbin/busybox rootfs/bin/busybox2
>> echo >> rootfs/bin/busybox2
>> PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
>>    --root rootfs busybox sh -c \
>>   "busybox mount -t securityfs /mnt /mnt; \
>>    busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
>>    busybox2 cat /mnt/ima/policy"
>>
>> [busybox2 is used to demonstrate 2 measurements; see below]
>>
>> Following the audit log on the host the last line cat'ing the IMA policy
>> inside the namespace would have been audited. Unfortunately the auditing
>> line is not distinguishable from one stemming from actions on the host.
>> The hope here is that Richard Brigg's container id support for auditing
>> would help resolve the problem.
>>
>> The following lines added to a suitable IMA policy on the host would
>> cause the execution of the commands inside the container (by uid 1000)
>> to be measured and audited as well on the host, thus leading to two
>> auditing messages for the 'busybox2 cat' above and log entries in IMA's
>> system log.
>>
>> echo -e "measure func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
>>          "audit func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
>>      > /sys/kernel/security/ima/policy
>>
>> The goal of supporting measurement and auditing by the host, of actions
>> occurring within IMA namespaces, is that users, particularly root,
>> should not be able to evade the host's IMA policy just by spawning
>> new IMA namespaces, running programs there, and discarding the namespaces
>> again. This is achieved through 'hierarchical processing' of file
>> accesses that are evaluated against the policy of the namespace where
>> the action occurred and against all namespaces' and their policies leading
>> back to the root IMA namespace (init_ima_ns).
> Note that your worst-case is 32 levels (maximum supported userns
> nesting) where each ima namespace defines a separate policy.
>
> So make sure you don't run into locking issues when hierarchically
> processing rules. So far I think it's fine since the locks aren't held
> across the hierarchial walk but are dropped and reaqcuired for each
> level.
>
> But that could still mean a lot of contention on iint->mutex since this
> lock is global, i.e. in this context: for all ima namespaces. You might
> want to consider coming up with some rough ideas for how to solve this
> _if_ this becomes a problem in the future.


The plan is that each IMA namespace will have its own rbtree with its 
own set of iints. We cannot do it all at the same time, so this will 
take while until things can be completely moved over into a per-IMA 
namespace rbtree and each IMA namespace becomes fully independent.


>
>> The patch series adds support for a virtualized SecurityFS with a few
>> new API calls that are used by IMA namespacing. Only the data relevant
>> to the IMA namespace are shown. The files and directories of other
>> security subsystems (TPM, evm, Tomoyo, safesetid) are not showing
>> up when secruityfs is mounted inside a user namespace.
>>
>> Much of the code leading up to the virtualization of SecurityFS deals
>> with moving IMA's variables from various files into the IMA namespace
>> structure called 'ima_namespace'. When it comes to determining the
>> current IMA namespace I took the approach to get the current IMA
>> namespace (get_current_ns()) on the top level and pass the pointer all
>> the way down to those functions that now need access to the ima_namespace
>> to get to their variables. This later on comes in handy once hierarchical
>> processing is implemented in this series where we walk the list of
>> namespaces backwards and again need to pass the pointer into functions.
> Just to repeat the point from earlier reviews, all those functions need
> to be guaranteed to call from syscall context. Functions that operate on
> files have different semantics.


You mean files in general or SecurityFS files in particular?


>
>> This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
>> IMA policy via reduced capabilities. We would again later on use this
>> capability to allow users to set file extended attributes for IMA appraisal
>> support.
>>
>> My tree with these patches is here:
>>
>> git fetch https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v7.posted
>>
>> Regards,
>>     Stefan
>>
>> v7:
>>   - Dropped 2 patches related to key queues; using &init_ima_ns for all calls
>>     from functions related to key queues where calls need ima_namespace
>>   - Moved ima_namespace to security/integrity/ima/ima.h
>>   - Extended API descriptions with ns parameter where needed
>>   - Using init_ima_ns in functions related to appraisal and xattrs
>>   - SecurityFS: Using ima_ns_from_file() to get ns pointer
>>   - Reformatted to 80 columns per line
> Since we're starting to be fairly along I would ask you to please write
> detailed commit messages for the next revision.

Expand the existing commit texts, is that what you suggest that I do?


>
> I would also like to see all links for prior versions of this patchset
> in the commit message since the discussion has been fairly extensive so
> for this series it makes a lot of sense. So something like:
>
> Link: https://lore.kernel.org/r/$MSGID (v1)
> Link: https://lore.kernel.org/r/$MSGID (v2)
> Link: https://lore.kernel.org/r/$MSGID (v3)
> Link: https://lore.kernel.org/r/$MSGID (v4)
> Link: https://lore.kernel.org/r/$MSGID (v5)
> Link: https://lore.kernel.org/r/$MSGID (v6)
> Link: https://lore.kernel.org/r/$MSGID (v7)
> Signed-off-by: meh
> Signed-off-by: mih
> Signed-off-by: muh

So that's a link per patch to all its previous versions?


> I find that extremely pleasant in case we need to revisit things later.
> (Technically you can get the same by searching lore via the final link
> but I find it be pretty pleasing to just copy+paste directly from the
> commit message to the discussion for the earlier patch.)
