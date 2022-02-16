Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185284B9241
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Feb 2022 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiBPU0k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Feb 2022 15:26:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBPU0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Feb 2022 15:26:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045E1C118;
        Wed, 16 Feb 2022 12:26:26 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GK5tPo021259;
        Wed, 16 Feb 2022 20:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9k42IwgOqf27OH2lhjxNLaW55lHPjTwx+15DDVudLkE=;
 b=DGI0Kcn1jXyjlOOitPKOK2fyPdQ0eaaPAwhqP1fZYA6Zur+DWrTUi7bYR70LqAta35qy
 jFtWuXzbQYYxugsvRTvfHmhcU8ESx1AtAQ0WEDD69tG9DInho+wBRW/E0J7DysQ38Oav
 PrECtgIZrbQvSgUO5KK9hPo8652N9i/ypxDJvt1y1A1U78geeFy7bLiqj9UX9Kn/rQ9M
 hN0hzVrrfKNo/WIFTB135X6ToPSknsnm8joRoC+d+SJtd2tz0MOvoMPNbuN/w6dsNVm7
 O3Cd1lcvwtaEMaY12Uh0ua/r/PlC6EpoqDPhxiTIfp2cKrBDYoeijliHTRmHSeFY9j59 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e953hcjac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:25:54 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GJjqmG001727;
        Wed, 16 Feb 2022 20:25:54 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e953hcja3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:25:54 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GK3suW015734;
        Wed, 16 Feb 2022 20:25:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3e64hcwaav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:25:52 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GKPpVx31195646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 20:25:51 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BEC96A05D;
        Wed, 16 Feb 2022 20:25:51 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8120B6A061;
        Wed, 16 Feb 2022 20:25:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 20:25:49 +0000 (GMT)
Message-ID: <6b81ba48-af34-71ef-8ee7-9526e7f3b073@linux.ibm.com>
Date:   Wed, 16 Feb 2022 15:25:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 05/27] ima: Define ima_namespace struct and start
 moving variables into it
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
        Christian Brauner <brauner@kernel.org>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-6-stefanb@linux.ibm.com>
 <429010298df589687e1d1a09bac21e302d642c7e.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <429010298df589687e1d1a09bac21e302d642c7e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CeYeWgaRohWnrZpTWAqDZucUOPHvj9BU
X-Proofpoint-GUID: dtlht7H06heJv2V1YB2nYVuH8U8Pmr9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/16/22 09:41, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>> Define the ima_namespace structure and the ima_namespace variable
>> init_ima_ns for the host's IMA namespace. Implement basic functions for
>> namespacing support.
> Implement the basic functions - ima_ns_init()  and ima_init_namespace()
> - for namespacing support.
>
>> Move variables related to the IMA policy into the ima_namespace. This way
>> the IMA policy of an IMA namespace can be set and displayed using a
>> front-end like securityfs.
>> Implement ima_ns_from_file() to get the IMA namespace via the user
>> namespace of the securityfs superblock that a file belongs to.
> Currently, ima_ns_from_file() doesn't exist in this patch.
Ah, left-over from previous version. Remove.
>
>> To get the current ima_namespace use &init_ima_ns when a function
>> that is related to a policy rule is called.
> In preparation for IMA namespacing, update the existing functions to
> pass the ima_namespace struct.  For now, ...
>
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Christian Brauner <brauner@kernel.org>
> After addressing the one inline comment,
Done.
> 	Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks.


