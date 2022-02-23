Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7B4C1D77
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 22:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiBWVHa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 16:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiBWVH0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 16:07:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C60646B;
        Wed, 23 Feb 2022 13:06:58 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NJgVTQ024276;
        Wed, 23 Feb 2022 21:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z7Xd9jxc9tzGFCJShmB8n/yyZ4MnF/i2KsEAp1969D4=;
 b=WQmBLRdxQl2wocCSEnoEFmfjLVRLBFQaILGIVp8M5qnIiHBYao/CHaCT4IHGDL5yrZi9
 JcLzy2oCUDMba+oEEJ5qjl3eBsJhbRgKlExE68t0l0VuFVex5eWcH3J6ViBcC4W29NLS
 VKgsfOSBESJlROG/g6kku+OfwVE0jM4KOl5+mImHyA2x3MjGOG33tLJvE9sq8AJmDNOz
 qzYbM0hIKFXSmZxWzbLMuywbWzMSSn9F3Sbf/FMIS5YfKsWxzh7GMcDM832hcWhaAJhL
 pysGjJNXw4RdIoD+7yigWAUfpPu8GDtl9A4En5DdDOq/gbAjKoRqH/Dd9Uv6WLzb/Unw 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eduas9pwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 21:06:45 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NKunFH006384;
        Wed, 23 Feb 2022 21:06:44 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eduas9pw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 21:06:44 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NKwWhu009053;
        Wed, 23 Feb 2022 21:06:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3ear6b97e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 21:06:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NL6fs434341208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 21:06:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E349ABE05B;
        Wed, 23 Feb 2022 21:06:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DB4ABE051;
        Wed, 23 Feb 2022 21:06:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 21:06:39 +0000 (GMT)
Message-ID: <57237fc5-cb48-3286-4148-76a6b3c8efd3@linux.ibm.com>
Date:   Wed, 23 Feb 2022 16:06:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 26/27] ima: Limit number of policy rules in
 non-init_ima_ns
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-27-stefanb@linux.ibm.com>
 <5e4a862917785972281bbcb483404da01b71e801.camel@linux.ibm.com>
 <479f09e7-0d39-0281-45ef-5cce4861d24d@linux.ibm.com>
 <8a4f9cb6cab5ba04eb61e346d0fca16efa4c6703.camel@linux.ibm.com>
 <46156a90-d6a6-a0cc-247a-3ceb29f1cf75@linux.ibm.com>
 <9efd4502617e39280ca47a91d395eae154a328a4.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <9efd4502617e39280ca47a91d395eae154a328a4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8q4kvvc2ICLujWCGC5_SaD7jVWdBRhTq
X-Proofpoint-ORIG-GUID: JkqNZB9-b71SXYRTDrYQyhcjAPD4FIoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 15:59, Mimi Zohar wrote:
> On Wed, 2022-02-23 at 15:45 -0500, Stefan Berger wrote:
>
>> avoid huge kernel memory consumption in the case that a cgroup limit for
>> memory was not set up.
> Ok, that is the motivation for the this patch.
>
Any user can create several user namespaces and with that several IMA 
namespaces and now we want to limit the number of rules inside an IMA 
namespace to limit the amount of kernel memory the policy rules are 
consuming. It isn't necessarily  related to cgroups but a hard limit on 
the number of rules to avoid wasted of memory.
