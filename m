Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166D5465A42
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 01:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353963AbhLBAG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 19:06:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354062AbhLBAGY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 19:06:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Nn6jJ023346;
        Thu, 2 Dec 2021 00:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yUNEa0s2nVgfVBNE9QqNs2iNB7Sbcogq6TLMz6iaTKU=;
 b=aXW07kBPHYP7bPNkpdkMF4ai8yv1Tk5mjCU8wrW9FNSgCwHHJbRhtxOTD9WD36YSLH9I
 e6lqAyzAWju/KIgBmYzyCoLgrrihTDMZxrWAbs3WrFw1hN5sAG3hK900VBfcA/Qz/WV3
 jZ+HLYmqU0iY4pWJ9gvywgr6WZ0qwWW5EnUlmAPcx/bL/WkQ1LHiP+idFx1NyhLtTDLx
 291KFOaSRuE2mdqTUJ+TwlQ4zPkHeVyiQaVqbhHiShX91fVw6m4juNiF0+xxDNb9MsD2
 fRQpSNzv/nkeQstaEZubSAdHCaFEI+jRSKTGDAdEnuF+Ikd5c2YasdDWUQ2nPu9XcXMF 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpk23r5v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 00:02:47 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1NqhJ9004492;
        Thu, 2 Dec 2021 00:02:47 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpk23r5uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 00:02:47 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Nr9aQ013700;
        Thu, 2 Dec 2021 00:02:45 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcachmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 00:02:45 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B202gPL64356740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 00:02:43 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7615124060;
        Thu,  2 Dec 2021 00:02:42 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74234124058;
        Thu,  2 Dec 2021 00:02:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 00:02:42 +0000 (GMT)
Message-ID: <0303c534-d54b-d032-88a6-11e1fe13748f@linux.ibm.com>
Date:   Wed, 1 Dec 2021 19:02:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
Content-Language: en-US
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-21-stefanb@linux.ibm.com>
 <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
 <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
 <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
 <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
 <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
 <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
 <38458eee904713824b85a2dcef248e752634f67c.camel@linux.ibm.com>
 <b8c21064-05f3-91a9-d23c-0417f046f4cc@linux.ibm.com>
 <29770c86261bbc7f6380c7c355ecb6a1c9f40980.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <29770c86261bbc7f6380c7c355ecb6a1c9f40980.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hN-JE31om2zg3ix1jMjRXmq9r6c1OfBV
X-Proofpoint-ORIG-GUID: 7ZTmkSsEQ-K-3-REzgZwds2SHwqOrl1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 17:19, James Bottomley wrote:
> On Wed, 2021-12-01 at 17:09 -0500, Stefan Berger wrote:
>> On 12/1/21 17:01, James Bottomley wrote:
>>
>>
>>
>>> I don't see this because my setup for everything is triggered off
>>> the first use of the IMA namespace.  You'd need to have some type
>>> of lazy setup of the inodes as well to give unshare time to install
>>> the uid/gidmappings.
>> What could trigger that? A callback while mounting - but I am not
>> sure where to hook into then. What is your mechanisms to trigger as
>> the 'first use of the IMA namespace'? What is 'use' here?
> use for me is first event that gets logged in the new namespace.
>
> However, I don't think this is a good trigger, it's just a random thing
> I was playing with.  Perhaps trigger on mount is a good one ... that
> could be done from securityfs_ns_init_fs_context?

Yes, this here does the trick now for late init also with runc. The late 
uid adjustments are gone.

static int securityfs_ns_init_fs_context(struct fs_context *fc)
{
         int rc;

         if (fc->user_ns->ima_ns->late_fs_init) {
                 rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
                 if (rc)
                         return rc;
         }
         fc->ops = &securityfs_ns_context_ops;
         return 0;
}


    Stefan


>
> James
>
>
>
>
