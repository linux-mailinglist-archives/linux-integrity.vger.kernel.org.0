Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C94B929D
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Feb 2022 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiBPUtl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Feb 2022 15:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBPUtk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Feb 2022 15:49:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919532AF3F1;
        Wed, 16 Feb 2022 12:49:25 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GKHW1D001239;
        Wed, 16 Feb 2022 20:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=33y0ttVyJSNnDQF0wYHoWsM8A04CFyM/g9Ys7ItkPBY=;
 b=Hun+DdThS+RMd7CrsTnFg8x5EojvxGZKo92RP25lRO15F0Wn0VXLT0lcCBXMJtUeMhuU
 EO7sNuyU8rU6IvRLOxeYSFCX1d7Za1hwNppgPO2s4IIjyxe0aO1zflVlU8KcM9X4cLFU
 9oBUOnQO0dnVxyOiOqcl+Ox76R/1HQwbxeA2q0+FuEn4d432qj5JaPHu9n8JurFUEF9i
 U6uZInRI7D5LUWJ8dlzn0LCFeSoN+KWEtQw0Ry7vCNlj7ysU7xE0kd+Gc5Hc5+qg/HkE
 1T/y3wtVVXrX/Nb+uLLO7MhMzqmvLlAFICVa2RO4bvfS4+E4Bwe/U9wH6e5cSqdlhrsx 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9866gked-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:49:02 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GKQq7b002092;
        Wed, 16 Feb 2022 20:49:02 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9866gkdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:49:02 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GKmCWV012433;
        Wed, 16 Feb 2022 20:49:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3e64hbrfce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:49:00 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GKmxQ414221636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 20:48:59 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 766796E050;
        Wed, 16 Feb 2022 20:48:59 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E11F6E052;
        Wed, 16 Feb 2022 20:48:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 20:48:58 +0000 (GMT)
Message-ID: <c350ccf1-f968-8b01-2f0d-015cabf39781@linux.ibm.com>
Date:   Wed, 16 Feb 2022 15:48:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 06/27] ima: Move arch_policy_entry into ima_namespace
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
 <20220201203735.164593-7-stefanb@linux.ibm.com>
 <bf435ffa5d176213acabb8c576c159d2cbd4d395.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <bf435ffa5d176213acabb8c576c159d2cbd4d395.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: byZlPvI5X3IiQUVsfMbkZOmOIS0uF8D0
X-Proofpoint-ORIG-GUID: a_MftUFaXoBuE1l4rVC0Krcb6I1kY2Vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202160113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/16/22 11:39, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote
>
> Let's update the patch description providing a bit more background
> info:
>
> The archictecture specific policy rules, currently defined for EFI and
> powerpc, require the kexec kernel image and kernel modules to be
> validly signed and measured, based on the system's secure boot and/or
> trusted boot mode and the IMA_ARCH_POLICY Kconfig option being enabled.
>
>> Move the arch_policy_entry pointer into ima_namespace.
> Perhaps include something about namespaces being allowed or not allowed
> to kexec a new kernel or load kernel modules.

Namespaces are not allowed to kexec but special-casing the init_ima_ns 
in the code to handle namespaces differently makes it much harder to 
read the code. I would avoid special-casing init_ima_ns as much as 
possible and therefore I have moved the arch_policy_entry into the 
ima_namespace.

    Stefan


> thanks,
>
> Mimi
>> When freeing the memory set the pointer to NULL.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Christian Brauner <brauner@kernel.org>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
