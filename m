Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A843F479832
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Dec 2021 03:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhLRCiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 21:38:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhLRCiq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 21:38:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BI1w58Z005912;
        Sat, 18 Dec 2021 02:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7zu87PXAcjLj9MwqYNntGAFI5MmEH0+4qQz2VAHHJJk=;
 b=PjnalKm7c4SRXtmg98d1937aHZH1YjLEazZQLY8vtYu9LqoSY2yHJUa/nBfrN1TjiS6d
 sLuBd40STpBKxnc3G+tYRjPLmnI+kP1N244ue7fUdpTdRddq27+svcZTavywvavsgqeV
 W1VZf6WikRkFzu+UajqJqEMJSjer9Qvn50Or7JyzpBYPpT05w6QzAmLpSVC7NwRNPweE
 K66ecnWZIhstQTiDmIyG0WTVMuc7HZOwfTRUq9GZPncJEmTb7cWfl47POOqYPL5nOvxJ
 JbCGJK7YrQc2IlSDMEFDNBYhoQFmmTDS7gyoxmLAlKyWONUJE37yuI9+RfoFCqWZaDEv Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d16er0eyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 02:38:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BI2LJQf013012;
        Sat, 18 Dec 2021 02:38:19 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d16er0eyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 02:38:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BI2TrdD007495;
        Sat, 18 Dec 2021 02:38:17 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3cy780nf99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 02:38:17 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BI2cGag26542506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 02:38:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB840AE063;
        Sat, 18 Dec 2021 02:38:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A821AE062;
        Sat, 18 Dec 2021 02:38:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 18 Dec 2021 02:38:16 +0000 (GMT)
Message-ID: <0d6d0a22-0f3a-5f99-e603-f139d8fe7801@linux.ibm.com>
Date:   Fri, 17 Dec 2021 21:38:16 -0500
MIME-Version: 1.0
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
 <20211216133148.aw3xs4sxuebkampb@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211216133148.aw3xs4sxuebkampb@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A0GJBnBlQXWp4PxXPatzjUOVrk3uUXSn
X-Proofpoint-GUID: tqeWImRGSmQGMHofzBCeoZRt7cJw7G8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_10,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/16/21 08:31, Christian Brauner wrote:
>
> 1. namespace securityfs
>     This patch is thematically standalone and should move to the
>     beginning of the series.
>     I would strongly recommend to fold patch 9 and 10 into a single patch
>     and add a lengthy explanation. You should be able to recycle a lof of
>     stuff I wrote in earlier reviews.
>
> 2. Introduce struct ima_namespace and pass it through to all callers:
>     - introduce struct ima_namespace
>     - move all the relevant things into this structure (this also avoids
>       the "avoid_zero_size" hack).


We could defer the kmalloc() that doesn't work on a zero-sized request. 
I would say this  is minor.


>     - define, setup, and expose init_ima_ns
>     - introduce get_current_ns() and always have it return &init_ima_ns for now
>     - replace all accesses to global variables to go through &init_ima_ns
>     - add new infrastructure you'll need later on
>     Bonus is that you can extend all the functions that later need access
>     to a specific ima namespace to take a struct ima_namespace * argument
>     and pass down &init_ima_ns down (retrieved via get_current_ns()). This
>     will make the actual namespace patch very easy to follow.
>
> 3. namespace ima
>     - add a new entry for struct ima_namespace to struct user_namespace
>     - add creation helpers, kmem cache etc.
>     - create files in securityfs per ns

I have tried this now and I am looking at 4 remaining patches that need 
to somehow find its way into v8 without causing too many disturbances. 
At what point (over how many patches) can I introduce CONFIG_IMA_NS 
without anything related to IMA namespacing happening? I need it early 
in 'your 3rd part' since it is also used for conditional compilation 
(Makefile) and #ifdef's where Makefile content and what the #ifdefs are 
doing probably shouldn't be squeezed into a single patch just so it's 
all enabled in one patch, but it should probably still remain logically 
separated into different patches. Enablement of IMA namespace would be 
in the very last patch. But there may be several patches between the 
very last one and CONFIG_IMA_NS is introduced...

v7 at least, before the requirement to do late/lazy initialization, 
enabled CONFIG_IMA_NS right away and built ever step on top of it, even 
if the IMA namespace only became **configurable** in the last patch when 
securityfs was enbled and one could set a policy. From that perspective 
it would be easier to switch to late initialization in a patch on top of 
v7 but .. ok, we cannot do that.


> This way at all points in the series we have clearly defined semantics
> where ima namespacing is either fully working or fully not working and
> the switch is atomic in the patch(es) part of 3.
Atomic over multiple patches? So introducing CONFIG_IMA_NS that doesn't 
do anything for several patches is still considered 'atomic' then ?
