Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441446AB43
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353321AbhLFWRB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 17:17:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353310AbhLFWQ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 17:16:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M7B7L003110;
        Mon, 6 Dec 2021 22:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uZ41HTN1GylIpvKaQE/oIG+gEXrT5wV9Be5l7n5latM=;
 b=DTCSmv6KjSipYhYcLYoc83pI3rwpVED+T4Y33fX5i3nuHsospIA92eKyVRWo9puGBtPt
 x0OobmMgO+93Ns/3xQrnVPgunGKG+50HmHC+OnbE5uKNG9BaPJ859grDWzbxWVesidKs
 CvKUpGvSVZIxMLdcpjSz1fj1eZkoL7Itf+es9tG6rLylrKKVtLxDXXroYP1uWCI5tY6M
 lEy7T54lvnwW6tRv5r2oJfweXiStDact2ZGsGwefgqS4VmR6qqbCFVRvMy8hahyNNK47
 dt2GJyolztXRqWkm7ScoK/jChJowHs+KpgYJL3yhk57Izg8Hhi7E75bz+y0O6BW17lSM Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csr40ut0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 22:13:18 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6M0ivX023812;
        Mon, 6 Dec 2021 22:13:18 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csr40ut02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 22:13:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6LvhW6007380;
        Mon, 6 Dec 2021 22:13:16 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyy9yck9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 22:13:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6MDFbp39387518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 22:13:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502D06E090;
        Mon,  6 Dec 2021 22:13:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B806E088;
        Mon,  6 Dec 2021 22:13:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 22:13:14 +0000 (GMT)
Message-ID: <8f4f9759-33c3-d2b0-7849-509cb91392cc@linux.ibm.com>
Date:   Mon, 6 Dec 2021 17:13:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
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
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
 <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E3qnUXYbNFOjNf4UUQ5MDor8ZeauYUQX
X-Proofpoint-GUID: 4tvY-_qhWip3DB3zfZ7QRfrzP3TiCt4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxlogscore=763 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060136
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/6/21 16:14, James Bottomley wrote:
> On Mon, 2021-12-06 at 12:25 -0500, Stefan Berger wrote:
> [...]
>> v3:
>>   - Further modifications to virtualized SecurityFS following James's
>> posted patch
>>   - Dropping of early teardown for user_namespaces since not needed
>> anymore
> This is my incremental to this series that moves the namespaced
> securityfs away from using a vfsmount and on to a root dentry instead,
> meaning we can call the blocking notifier from fill_super as Christian
> requested (and thus can remove the securityfs_notifier_sent indicator
> since it's only called once).

Thanks. I have this now in a branch for v4.


    Stefan


