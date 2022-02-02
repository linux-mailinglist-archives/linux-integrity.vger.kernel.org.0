Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBB4A77C5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiBBSTN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 13:19:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242330AbiBBSTM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 13:19:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HjhAT040298;
        Wed, 2 Feb 2022 18:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dyv5HLjYtUNmS8nnmmvc00PAnHMdUMDHQE++s8FIwkI=;
 b=KlPp/cX24K4xJXKjfeIY7vPrmSSuY6/gkt+eEPKbf+ORrFUSIqrq9D/2mILTgplMSKs/
 j0Q8VTfIJ/oIL4CrgzgnRyg6R9HUXcJhRVN82CSmgplJtg5IrUcI+NCGa6I+RYUHco94
 QPRiyAgtgN13Ha/BkCBk+uZAA8Wx+mHDMHxgnz/cIae2jdTqJ6a99A9yo6P3dMyTdBzF
 ashRM9j6XseTD9vwDDGach9GOmtQeHjujPp+Pxi6+WonmrUJt8J4Kx7EFv/iukw+Knk1
 ES0aKVEclFOHGJ9HrpmEeC6ZhF56p20tSTQA8D1z8hzDfqPxNpKZynMjkNxNUXCIy5Xb +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyxmy8nfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 18:19:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212Hl6xe003556;
        Wed, 2 Feb 2022 18:18:59 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyxmy8nfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 18:18:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212ICknP013384;
        Wed, 2 Feb 2022 18:18:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7cda7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 18:18:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212IIseC26345898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 18:18:54 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E8511206D;
        Wed,  2 Feb 2022 18:18:54 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DD91112067;
        Wed,  2 Feb 2022 18:18:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 18:18:54 +0000 (GMT)
Message-ID: <cd9357bd-1d81-7af3-2882-f7e8cf5bce81@linux.ibm.com>
Date:   Wed, 2 Feb 2022 13:18:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 00/27] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220202141329.k5jcsbutpmzv53c3@wittgenstein>
 <3f053d38-00f7-b495-4ea2-3c61fa120284@linux.ibm.com>
 <d08ffbb2f803cd26f4d9697868e138cdb2e71d32.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d08ffbb2f803cd26f4d9697868e138cdb2e71d32.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eD3MolQmqX2jRxZ7Lk_lj_sZFZTe8kLV
X-Proofpoint-GUID: H2mCM1BPgVN3mHuwSfw7CgZMfhvxJfeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_08,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 11:04, Mimi Zohar wrote:
> On Wed, 2022-02-02 at 09:40 -0500, Stefan Berger wrote:
>> On 2/2/22 09:13, Christian Brauner wrote:
>>> On Tue, Feb 01, 2022 at 03:37:08PM -0500, Stefan Berger wrote:
>>>> v10:
>>>>    - Added A-b's; addressed issues from v9
>>>>    - Added 2 patches to support freeing of iint after namespace deletion
>>>>    - Added patch to return error code from securityfs functions
>>>>    - Added patch to limit number of policy rules in IMA-ns to 1024
>>> I'm going to go take a lighter touch with this round of reviews.
>>> First, because I have February off. :)
>>> Second, because I think that someone who is more familiar with IMA and
>>> its requirements should take another look to provide input and ask more
>>> questions. Last time I spoke to Serge he did want to give this a longer
>>> look and maybe also has additional questions.
>> The one problem I am seeing is that we probably cannot support auditing
>> in IMA namespaces since every user can now create an IMA namespace.
>> Unless auditing was namespaced, the way it is now gives too much control
>> to the user to flood the host audit log.
> Stefan, we need to differentiate between the different types of audit
> records being produced by IMA.  Some of these are informational, like
> the policy rules being loaded or "Time of Measure, Time of Use"
> (ToMToU) records.  When we discuss IMA-audit we're referring to the
> file hashes being added in the audit log.  These are the result of the
> IMA "audit" policy rules.
>
> How much of these informational messages should be audited in IMA
> namespaces still needs to be discussed.  For now, feel free to limit
> the audit messages to just the file hashes.
I doubt we should let a user produce informational audit messages or 
audit messages related to file hashes... it's unfortunate, but it opens 
a door for abuse.

> thanks,
>
> Mimi
>
