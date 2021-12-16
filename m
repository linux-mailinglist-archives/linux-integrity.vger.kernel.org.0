Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428D0476832
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 03:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhLPCjG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 21:39:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhLPCjG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 21:39:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2UjVc014282;
        Thu, 16 Dec 2021 02:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5fxB99JRPBfYbglHzVV78M6qCAwzfg0m9YweccxQx2Q=;
 b=dewKnWHg6U651IcwRYSTkV4VZzsKZMHidMLzc9nTpXS8kf7yWZvyTF0ZQah4zPmFnB64
 t3yVK5yMxm17gQFgJ20DV5u+PKLvRx4PKu5W+jB1iQYBKSTKxutwxNxqEPGV2eRQe7tZ
 9gI9BRhgqIHYv/DyjZUTCXiRx6xAu0qiLe2cBjhrJSMZ+FqX7Iflg39dHN9ZVzaApcDX
 dOxQaYo2LXhebfHEDOqB6abh14WsFqlr7jsYBJvleVmaE77U2uR1M9ygMYX52QyMndmd
 eVPrHDAOtjsKpeWVSy61FmB4i83FUTL0B13T7esUdnVya3kCPmtpKvDQ9YyhJfVU8r+U HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyfdpad35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:38:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG2UiuW018655;
        Thu, 16 Dec 2021 02:38:52 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyfdpad2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:38:52 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2W1v3005507;
        Thu, 16 Dec 2021 02:38:51 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3cy76w903k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:38:51 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG2coC628836302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 02:38:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 721D3AC05F;
        Thu, 16 Dec 2021 02:38:50 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85D7AC060;
        Thu, 16 Dec 2021 02:38:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 02:38:45 +0000 (GMT)
Message-ID: <ffd4b877-389b-63b5-576d-f3ce66849ebf@linux.ibm.com>
Date:   Wed, 15 Dec 2021 21:38:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 03/17] ima: Namespace audit status flags
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-4-stefanb@linux.ibm.com>
 <925ed27a6375dffcb92e9812e36b1c461ae63aa2.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <925ed27a6375dffcb92e9812e36b1c461ae63aa2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uYDeGJqW3LVAk2VvDs4qYu9qDP3Pl7P8
X-Proofpoint-ORIG-GUID: 7bq-rTmYrHUnn-rC6QQ3Pkz5td4qY3uw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_13,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 16:15, Mimi Zohar wrote:
> On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
>> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
>>
>> The iint cache stores whether the file is measured, appraised, audited
>> etc. This patch moves the IMA_AUDITED flag into the per-namespace
>> ns_status, enabling IMA audit mechanism to audit the same file each time
>> it is accessed in a new namespace.
>>
>> The ns_status is not looked up if the CONFIG_IMA_NS is disabled or if
>> any of the IMA_NS_STATUS_ACTIONS (currently only IMA_AUDIT) is not
>> enabled.
> ^none of the ... are enabled.

You want me to rephrase it?


>
> thanks,
>
> Mimi
>
>> Read and write operations on the iint flags is replaced with function
>> calls. For reading, iint_flags() returns the bitwise AND of iint->flags
>> and ns_status->flags. The ns_status flags are masked with
>> IMA_NS_STATUS_FLAGS (currently only IMA_AUDITED). Similarly
>> set_iint_flags() only writes the masked portion to the ns_status flags,
>> while the iint flags is set as before. The ns_status parameter added to
>> ima_audit_measurement() is used with the above functions to query and
>> set the ns_status flags.
>>
