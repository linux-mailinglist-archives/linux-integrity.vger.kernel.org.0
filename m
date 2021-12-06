Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1221646A2AA
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhLFRZ4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:25:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232414AbhLFRZy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:25:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6FjSxW005643;
        Mon, 6 Dec 2021 17:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ubl+npukGCKFaQX9Fvtq8DHnrcsdC/VCt+FCKi1gKeA=;
 b=m8+2jccfuVL2KORn8fSRcTIfX1jXc+n5cisnEag2Hb5AmgLpQLph4nOF7r6arlcCcia4
 fAMc91D8ZZrRp2rZODQ+qaxl3iKokSdO7CDY5AQ1x/ErzFm5Pge60TfrFoMvcctRSEV6
 O0X8i97VMMn0EDDr5GMoldsNBXcKd1JEF+drID5zH57wNQ4rXT7fsuBEgRPvjr3NGdHI
 qHWa81jjx/8nT0XB4n2AhmHxj9mVeyn8wS1202k5Z39U+/ZMyKXJWyRt126bM7n0Pmqd
 tB4Xv13A+v1ugiKY0n+eTVrYH4+qFEj/S6GbZx+v5qtNcmH7VcVP28TsyAgIocG0YaHn DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csmnekatc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:22:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6HGonx032007;
        Mon, 6 Dec 2021 17:22:07 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csmnekasy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:22:07 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HEHgb000452;
        Mon, 6 Dec 2021 17:22:05 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy72auv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:22:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HM4rE52822378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:22:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AABF78063;
        Mon,  6 Dec 2021 17:22:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 289B378060;
        Mon,  6 Dec 2021 17:22:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:22:01 +0000 (GMT)
Message-ID: <f3a6d18f-86e4-e567-16d4-47c15d3d9aab@linux.ibm.com>
Date:   Mon, 6 Dec 2021 12:22:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
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
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
 <084e6522e1e778408cf6b3581d75f7349d336006.camel@linux.ibm.com>
 <e4134d4f-5134-ade8-6428-3510ac940757@linux.ibm.com>
 <915b3be92544f6572f214f360a592708f46ad7e6.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <915b3be92544f6572f214f360a592708f46ad7e6.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ScE-9ZebKg2WAdfktQWEDRzFXmo1XYlw
X-Proofpoint-GUID: UQe5HTJ0U2Xr8ZFrgYvxzn4qNKSj6OSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=676 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/6/21 09:11, James Bottomley wrote:
> On Mon, 2021-12-06 at 09:03 -0500, Stefan Berger wrote:
>
> It's never too early to see what the series is shaping up as.  However,
> I'm still not sure I got the right trigger for the SECURITYFS_NS_ADD
> notifier, so that may still have to move ... or even that there isn't
> some locking subtlety I missed in triggering SECURITY_NS_REMOVE from
> kill_sb.

I'll post v3 with the early changes and your Signed-off-by's added where 
I made changes to files.

    Stefan
