Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB146C01B
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhLGQB1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 11:01:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239304AbhLGQB1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 11:01:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FIIbc013271;
        Tue, 7 Dec 2021 15:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=65md6V5Pcr/9iFsp1hGdphmC4sd1Nvuz10RhJxDh8tw=;
 b=EtHtK6hy49KtQjoa7/4NKkHQNRmizR/3DFUkgYJZFKKGAkTzcmfCxQ5IMhhbv4+LYwQI
 GSLqCq3VH20jEtMf/34HlZ60bzGg/Vvo0899XCbWoNeJec3S4hiGx6m4u8so63QeOjgz
 usciUrN7nfu7NM7OMLO0hlGUCIKOxfKvB83ssOXAYoZNFAchvK8TrLZ8dnhXRSA+UWlx
 Jmes671JPnr7J3DMyksn8qS057/ACSdrjk/3DP8JtjJtsbZmu2Ar97O7kMb6s1iYanY3
 C/F0hoE5FdYVc+OD/6VT5fTfKKB/2ILe2yxiP5D/2YDNGuor7JWBRi4Es2t5uIZLZIeJ kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cta4krueu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:57:42 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7FIP8c013399;
        Tue, 7 Dec 2021 15:57:41 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cta4kruen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:57:41 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FrpKI012514;
        Tue, 7 Dec 2021 15:57:40 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyyaf3kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:57:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7FvdaD28377604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 15:57:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2602D78074;
        Tue,  7 Dec 2021 15:57:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B72F878072;
        Tue,  7 Dec 2021 15:57:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 15:57:34 +0000 (GMT)
Message-ID: <6240b686-89cf-2e31-1c1b-ebdcf1e972c1@linux.ibm.com>
Date:   Tue, 7 Dec 2021 10:57:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
 <20211207151737.vlzfwfrba4n6uxpx@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211207151737.vlzfwfrba4n6uxpx@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3YTfwK8Qinc0bR3UasboWLPyckcaTnfb
X-Proofpoint-ORIG-GUID: WttjQDoJePWaXI5hhS91IysdmVCZL596
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/7/21 10:17, Christian Brauner wrote:

> On Mon, Dec 06, 2021 at 12:25:44PM -0500, Stefan Berger wrote:
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
>> PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
>>    --root rootfs busybox sh -c \
>>   "busybox mount -t securityfs /mnt /mnt; \
>>    busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
>>    busybox cat /mnt/ima/policy"
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
>> auditing messages for the 'busybox cat' above and log entries in IMA's
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
>>
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
>>
>> This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
>> IMA policy via reduced capabilities. We would again later on use this
>> capability to allow users to set file extended attributes for IMA appraisal
>> support.
>>
>> The basis for this series of patches is Linux v5.15.
>> My tree with these patches is here:
>> https://github.com/stefanberger/linux-ima-namespaces/tree/v5.15%2Bimans.v3.public
> I have one small procedural favor to ask. :)
>
> I couldn't apply your patch series directly. It if isn't too
> inconvenient for you could you pass --base with a proper upstream tag,
> e.g. --base=v5.15.
>
> The branch you posted here doesn't exist afaict and I had to peruse your
> github repo and figured the correct branch might be v5.15+imans.v3.posted.
>
> In any case, --base with a proper upstream tag would make this all a bit
> easier or - if it really is necessary to pull from your tree it would be
> nice if you could post it in a form directly consumable by git and note
> url-escaped. So something like
>
> git clone https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v3.posted
>
> would already help.

Sure, will do.

   Stefan


>
> Christian
