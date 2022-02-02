Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA14A735D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiBBOks (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 09:40:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbiBBOks (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 09:40:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DG11f005462;
        Wed, 2 Feb 2022 14:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DUGDWX63x6O+39JA4R1LBbVb62x/U2i5zOFyqPQjOwE=;
 b=UE9Y//A78Q9jq0ozoDvZqOXQCvQTbsKcaq8GsBDxRweFOxae8Z9tp6RKRBsw8U0vXBSA
 d622vghh9ps7fvAHQIc5X+GYblJ/kxr24hueCCV7R8VjqbQgcc4wLWInMKaz1WqgURhD
 9JKG439h+76pWpk3qTr99v09tWuO5ENpqaIkZgyIrZDMWAcE2mxlAvL0JEtoPcYaShXM
 OG32Y89TqghhvbkcuDR7f2OAFZX65q4m4HmWjj7+5HpwRWLELtRVPkOnx5/wHfWu54IH
 Re6uHC4Eay1hs1awMqF01x5JcbJoDeTUrfCmy+eqWl856FzwnC7PUcTPFLvJKMWKxeeW CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dytphsw0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:40:28 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212ESCMx012770;
        Wed, 2 Feb 2022 14:40:27 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dytphsw0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:40:27 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212EYfIk019819;
        Wed, 2 Feb 2022 14:40:26 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3dvw7bg38f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 14:40:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212EeOmA22086062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 14:40:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BEBB112067;
        Wed,  2 Feb 2022 14:40:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50041112063;
        Wed,  2 Feb 2022 14:40:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 14:40:24 +0000 (GMT)
Message-ID: <3f053d38-00f7-b495-4ea2-3c61fa120284@linux.ibm.com>
Date:   Wed, 2 Feb 2022 09:40:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 00/27] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220202141329.k5jcsbutpmzv53c3@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220202141329.k5jcsbutpmzv53c3@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BzeEa8Kdz_ZobbH7vXxScznarHbVxZVJ
X-Proofpoint-ORIG-GUID: HVqE4jbdEx_gjqR2H1hicnOM3fnnlVIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 09:13, Christian Brauner wrote:
> On Tue, Feb 01, 2022 at 03:37:08PM -0500, Stefan Berger wrote:
>>
>> v10:
>>   - Added A-b's; addressed issues from v9
>>   - Added 2 patches to support freeing of iint after namespace deletion
>>   - Added patch to return error code from securityfs functions
>>   - Added patch to limit number of policy rules in IMA-ns to 1024
> I'm going to go take a lighter touch with this round of reviews.
> First, because I have February off. :)
> Second, because I think that someone who is more familiar with IMA and
> its requirements should take another look to provide input and ask more
> questions. Last time I spoke to Serge he did want to give this a longer
> look and maybe also has additional questions.

The one problem I am seeing is that we probably cannot support auditing 
in IMA namespaces since every user can now create an IMA namespace. 
Unless auditing was namespaced, the way it is now gives too much control 
to the user to flood the host audit log. So, we may need to head towards 
support for IMA measurements in the IMA namespace right away and not 
support audit rules but also possibly eliminate other actions that are 
being audited by IMA to not occur while an IMA namespace is active, such 
as when policy rules are being set etc. Not supporting auditing in 
IMA-ns affects only few of the patches in this series. We need most of 
them for a basis of IMA measurements but to get to IMA measurements 
along with support for inheritance and configuration of hash algorithm 
and log template etc. to use in the IMA namespace and set it in its 
configuration 'stage' (before activation), we will need at least 25 more 
patches on top of what have here now... so this series will then be 
around 50 patches.

    Stefan

