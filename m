Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF649FD07
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 16:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349652AbiA1Poz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 10:44:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbiA1Poz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 10:44:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SFDpa3031444;
        Fri, 28 Jan 2022 15:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HIjjE1zlk9hEiC0Q3Em9Eron0a2ojY4ey5mwMzrssTA=;
 b=AZvXwxHFbpOJc300X4PkhvsvbRHQy77Oetru7vXXf4nDqBElZ2MQYkU6XP0Pw1IjCD2e
 LTMDatgqJGadvO/EIYXdnT2tTs26dmZOKRlDiJTq04LbFUa3eN8oj1oBpoUWcLJpDCD5
 ioGX+4wOEsGqBggksPVRoEYe0olwSIyV/CzlxwFqiNp8NSlHJlumgn+7mxWUC/sPCO+2
 zFgbzc5diPkPvPX/8iR92hbsLhfJSAeZdaVDMOWKG602MFXZBlvW9sdSMVUwObb0P7v3
 GXWJsDvYm3O+IFbWgUPOddnw8mLe/+1DPHKaWYb6U3Zww0/+CeIDbsANIYUzZpZbeYqe BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvfuvvv2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 15:44:36 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SFE3Zo000696;
        Fri, 28 Jan 2022 15:44:35 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvfuvvv21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 15:44:35 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SFgk8q003430;
        Fri, 28 Jan 2022 15:44:34 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3dr9jcca2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 15:44:34 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SFiWRY13631844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 15:44:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6555AE060;
        Fri, 28 Jan 2022 15:44:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F6F1AE05C;
        Fri, 28 Jan 2022 15:44:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 15:44:32 +0000 (GMT)
Message-ID: <be31137d-57d9-24f7-01f6-f33080dd4bba@linux.ibm.com>
Date:   Fri, 28 Jan 2022 10:44:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 09/23] ima: Move some IMA policy and filesystem related
 variables into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-10-stefanb@linux.vnet.ibm.com>
 <1af8f2155730c38dcd510016fe82bc90e4acee39.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <1af8f2155730c38dcd510016fe82bc90e4acee39.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oNMoqWvway8KQY33qhrPQazP4sPzp6Oy
X-Proofpoint-ORIG-GUID: rw6ih2xvEdCfMfu60-sFJd6gAZT630mO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_04,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/27/22 17:30, Mimi Zohar wrote:
> On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
>> ima_namespace. This way each IMA namespace can set those variables
>> independently.
> This patch description needs to be expanded a bit, indicating why
> they're being moved together.  These flags are needed when loading a
> policy. Please also update the "struct ima_namespace" comment.

I'll extend the above sentence like this:

... those variables independently in its instance of securityfs.

    Stefan

>
> thanks,
>
> Mimi
>
