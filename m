Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F14C176F
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiBWPpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiBWPp2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 10:45:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4103C12C8;
        Wed, 23 Feb 2022 07:44:57 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NFZ6tY009316;
        Wed, 23 Feb 2022 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ko5rFaANlv28TkWdV5MQzkzdp12fcrrTojPC+F+P5kc=;
 b=aX8ngmoIdYoXKBgZVVxGioheT43rpsSbkvO9/49/0PRUM+TIeEAU+qdlVPgtCCQXPvbb
 M0fOq+rQFZXTfsa56QcQu8Fii5j6xUZeDzeB8yprDGESHqpmd8HLlm/VfPiQ0CTPb/Ni
 pUYGbZvJOqZNGCUYfdQqGVDJNydhm8JrJBX8jayFi8WaWbHAJKIaOlNGirKa87umlQSK
 MA8wblfIQ4wLw5j8cvYA/Za+3WKmTq4dW7PK8CqU3OAh7cWmrSa/dnuu7X+hdzCeZuje
 xNozqibPzZI6Jtdd/+SNM9ikzDi0CFqVx5nTlImbcDYEcDBTdVVUZupK7lxN7pUkH63W vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ednks3squ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 15:44:33 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NDrQxu029216;
        Wed, 23 Feb 2022 15:44:32 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ednks3sqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 15:44:32 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NFgL4M018818;
        Wed, 23 Feb 2022 15:44:31 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3ed22dwwdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 15:44:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NFiT3247710550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 15:44:29 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5C582806E;
        Wed, 23 Feb 2022 15:44:29 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D832806A;
        Wed, 23 Feb 2022 15:44:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 15:44:28 +0000 (GMT)
Message-ID: <bfd9878c-71d5-1a9e-6306-b2cc68b26772@linux.ibm.com>
Date:   Wed, 23 Feb 2022 10:44:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 22/27] securityfs: Extend securityfs with namespacing
 support
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-23-stefanb@linux.ibm.com>
 <177baf827c4dbf9a225b14552725360066af6471.camel@linux.ibm.com>
 <20220223081420.7mthf3rfxb3n5gvs@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220223081420.7mthf3rfxb3n5gvs@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z1V6jv2-RzqVVlMBrlgbrFsdYp-R9FH_
X-Proofpoint-ORIG-GUID: jRFSt3rFH0aegxryeZpf2xfITNgleL7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_07,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 03:14, Christian Brauner wrote:
> On Tue, Feb 22, 2022 at 08:48:47PM -0500, Mimi Zohar wrote:
>> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>>> Enable multiple instances of securityfs by keying each instance with a
>>> pointer to the user namespace it belongs to.
>>>
>>> Since we do not need the pinning of the filesystem for the virtualization
>> ^namespacing case
>>
>>> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
>> ^simple_release_fs
>>
>>> case when the init_user_ns is active. This simplifies the cleanup for the
>>> virtualization case where usage of securityfs_remove() to free dentries
>> ^namespacing
>>
>>> is therefore not needed anymore.
>>>
>>> For the initial securityfs, i.e. the one mounted in the host userns mount,
>>> nothing changes. The rules for securityfs_remove() are as before and it is
>>> still paired with securityfs_create(). Specifically, a file created via
>>> securityfs_create_dentry() in the initial securityfs mount still needs to
>>> be removed by a call to securityfs_remove(). Creating a new dentry in the
>>> initial securityfs mount still pins the filesystem like it always did.
>>> Consequently, the initial securityfs mount is not destroyed on
>>> umount/shutdown as long as at least one user of it still has dentries that
>>> it hasn't removed with a call to securityfs_remove().
>>>
>>> Prevent mounting of an instance of securityfs in another user namespace
>>> than it belongs to. Also, prevent accesses to files and directories by
>>> a user namespace that is neither the user namespace it belongs to
>>> nor an ancestor of the user namespace that the instance of securityfs
>>> belongs to. Do not prevent access if securityfs was bind-mounted and
>>> therefore the init_user_ns is the owning user namespace.
>>>
>>> Suggested-by: Christian Brauner <brauner@kernel.org>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Christian, I understand that "[PATCH v10 23/27] ima: Setup securityfs
>> for IMA namespace" needs to be deferred, but is there a reason for
>> deferring  "[PATCH v10 22/27] securityfs: Extend securityfs with
>> namespacing support"?   As the securityfs patches are really
>> independent of IMA namespacing, I would have thought  "[PATCH v10
>> 04/27] securityfs: rework dentry creation" and this patch should be co-
>> located at the beginning of the patch set.
> It felt more natural to me to defer it until the end but I have no
> strong thoughts on this as of right now. Since Stefan has mentioned
> moving this earlier already himself and you seem to agree as well, feel
> free to do so.

I'll move it after 'securityfs: rework dentry creation' if that's ok.

    Stefan

