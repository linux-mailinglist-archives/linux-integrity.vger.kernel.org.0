Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE8400697
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbhICU2E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 16:28:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34890 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhICU2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 16:28:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183K3oSH138702
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 16:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EsPGEWOIA7qXuy15tb4/aOlqQWYC+1e86WUXB810bCo=;
 b=fsaN0/WJvt+0skFUhOUDCmve7cIvhLnDuW3dYxbwMfK+z27FZLd5orTUzFXJCEnh4ri3
 hqKxCs4DWC82fHLLG5k/N3hdvCJzRTe1MxIHnrO6NgPAl6QRaxQbrrqimS6hO8xXnTt9
 GwHwgI/ukNbxBNUKUn4TeZcnEWRIoANNvEKZEC/5I9idhd1+XmsVl9vlJSUh7txf5Wy9
 yiiGk7wPctuAJb/WVFoWFvX4/olbJqWkZdWhypOocu08MweN7D847OIohBjYYY1utW+x
 Bx57jXdX5eBqx42Ob/CwSpO8+zMSLSEN9dPdtKco+2kUAiLOg/Rqd1vAuYeHxMwXuJ+b 8A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aus1jj428-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 16:27:02 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183KD2mu030882
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 20:27:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3au6pnu9y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 20:27:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183KR0vg12518394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 20:27:00 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CD6F12405A;
        Fri,  3 Sep 2021 20:27:00 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D09124054;
        Fri,  3 Sep 2021 20:27:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 20:27:00 +0000 (GMT)
Subject: Re: [PATCH v2 8/8] tests: Get the packages for pkcs11 testing on the
 CI/CD system
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
 <20210810134557.2444863-9-stefanb@linux.vnet.ibm.com>
 <290fc452e87d999dc8fe2bcc1128ecb5e11b3517.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c2eaad4c-636f-aea3-f636-40c1f1ebf4bd@linux.ibm.com>
Date:   Fri, 3 Sep 2021 16:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <290fc452e87d999dc8fe2bcc1128ecb5e11b3517.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eEsXI6ZxyQgnjR4V8u_1s_yLYkCbTQfE
X-Proofpoint-ORIG-GUID: eEsXI6ZxyQgnjR4V8u_1s_yLYkCbTQfE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/3/21 3:17 PM, Mimi Zohar wrote:

> On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Get the packages for pkcs11 testing on the CI/CD system.
>>
>> This is the status on various distros:
>>
>> - Alpine: could not find package with pkcs11 engine
>> - Alt Linux: works
>> - Debian: debian:stable: evmctl is not able to find the pkcs11 module but
>>            preceeding openssl command line tests with the pkcs11 URI succeeded;
>>            cannot recreate the issue locally in the debian:stable container
>>            --> disabled on Ubuntu and Debian
>> - CentOS7: tests with pkcs11 URI fail on openssl command line level
>> - CentOS: works
>> - Fedora: works
>> - OpenSuSE Leap: package not available in main repo
>> - OpenSuSE Tumbleweed: works
> In patch 7/8 there's a comment of requiring a certain release.  Should
> there be a test for a specific version?  Then only run the pkcs11 tests
> if that version or later is installed.

I'll add a test into softhsm_setup checking that the version identifier 
is at least 2.2.0.

   Stefan

> thanks,
>
> Mimi
>
