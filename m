Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3884A7A73
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 22:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiBBV2W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 16:28:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15874 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236968AbiBBV2W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 16:28:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212JwUoA018828;
        Wed, 2 Feb 2022 21:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IOQ1Ok8FwrmNa54srIU+CDOmQozHJaHHikWD9t/F1WU=;
 b=h9YJhzq8Fo8ZgfwYfX8dY9z4stMivUaspZTW7Xu/Xf2Un0DBHuVUS/TfIQ9fcDqhymS6
 3kqvT4Lowm8GqIT6WefGSamtQeRcja77tAHX/BUoOz6MUQUmTfCHngZCdzpYRw7wsM78
 hrFIiVF4gzfeocHox8ZX45FTIXiqp/yuhiqQAvj+pRcuprX2U9ut26k1kkGrXWtE8IbA
 5VQmFr1lWNl0ywjrinwoRp4qX35uR5cbTEheA4tYtKJCfTeLClkfuxx9xNfEi5fdk+0W
 tQLcKmPldcohVyvCX/eeId4ckuXXxAAo+F+hq/XSxmgGyQcu2G87LAfeaCIW7NA7o+iE NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyx6hmf8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 21:27:55 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212LMjFL002918;
        Wed, 2 Feb 2022 21:27:54 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyx6hmf8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 21:27:54 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212L8hZM026468;
        Wed, 2 Feb 2022 21:27:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3dvw7bsdm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 21:27:53 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212LRqKb22282580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 21:27:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268E6C6061;
        Wed,  2 Feb 2022 21:27:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED6FAC6057;
        Wed,  2 Feb 2022 21:27:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 21:27:50 +0000 (GMT)
Message-ID: <14d47f2c-abaa-1dc1-de0d-6edeccb429bd@linux.ibm.com>
Date:   Wed, 2 Feb 2022 16:27:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 00/27] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
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
 <cd9357bd-1d81-7af3-2882-f7e8cf5bce81@linux.ibm.com>
In-Reply-To: <cd9357bd-1d81-7af3-2882-f7e8cf5bce81@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4yl7X9vmMQhaZOibczT-hAnTSg0Xdt28
X-Proofpoint-ORIG-GUID: 7iv2y6v6_EPJNrJDqww9_PCt13lXu6SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 13:18, Stefan Berger wrote:
>
> On 2/2/22 11:04, Mimi Zohar wrote:
>> Stefan, we need to differentiate between the different types of audit
>> records being produced by IMA.  Some of these are informational, like
>> the policy rules being loaded or "Time of Measure, Time of Use"
>> (ToMToU) records.  When we discuss IMA-audit we're referring to the
>> file hashes being added in the audit log.  These are the result of the
>> IMA "audit" policy rules.
>>
>> How much of these informational messages should be audited in IMA
>> namespaces still needs to be discussed.  For now, feel free to limit
>> the audit messages to just the file hashes.
> I doubt we should let a user produce informational audit messages or 
> audit messages related to file hashes... it's unfortunate, but it 
> opens a door for abuse.

After some offline discussion with Mimi, the solution may be to gate 
setting IMA audit policy rules with CAP_SYS_ADMIN.

    Stefan
