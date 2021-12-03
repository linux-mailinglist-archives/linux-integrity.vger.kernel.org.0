Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE20467CB2
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353434AbhLCRmu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 12:42:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353430AbhLCRmu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 12:42:50 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3GlVRc007660;
        Fri, 3 Dec 2021 17:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/7LhyGIZH6v6tPB7DC3vcIfS3YrBDj9yF1r+y5dVl90=;
 b=bfO3mJdipvHwh2mP7NU/mMbb0l6nlFgFoCj2C4QS2dHvbjQLc+1xSzeyvXydHoxTqo7O
 yjOXYta1Loun+vAJF+1Cgar/imqJNJhLfzkvQt6UwH0O4Br42A8NB6HYOIJUXjY/zV5C
 pCh16tnT2Qupn2m485gFPlYxhj6bhkWgwDC3lDLtmDGO4HUQWCX5RYfVS4sk+XqVbvgY
 qISRHOdG8NyoXg2xncViw5/UTSo8Z02W69W5llu3JQn06e/9GdmW9CHYu/kADoxzs6ef
 2N+Z0iHUIW04dXAppRQUdsl9PuDV0qxmr6vKlmn3/WwRmE4DdHay16hyvrPiO0GxC3md ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqq2qrxnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:39:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3HZ9Wn011228;
        Fri, 3 Dec 2021 17:39:09 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqq2qrxn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:39:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3HbTOe029820;
        Fri, 3 Dec 2021 17:39:07 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne45fpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:39:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3Hd5XP15073584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 17:39:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCFFD6A054;
        Fri,  3 Dec 2021 17:39:05 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC996A057;
        Fri,  3 Dec 2021 17:39:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 17:39:02 +0000 (GMT)
Message-ID: <75aca493-e8d6-ab1e-2aaf-9e9a6b183ed7@linux.ibm.com>
Date:   Fri, 3 Dec 2021 12:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 15/19] capabilities: Introduce CAP_INTEGRITY_ADMIN
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-16-stefanb@linux.ibm.com>
 <2f145bcf-72a7-3697-0bce-f7a74e6ecc93@schaufler-ca.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <2f145bcf-72a7-3697-0bce-f7a74e6ecc93@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HBTmL5KWKRrmWjl2NBBTkqNqb7Y646vT
X-Proofpoint-ORIG-GUID: 2oQLY0P3JcJk2IXrLUywr7QCnOxW9aYe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/3/21 11:40, Casey Schaufler wrote:
> On 12/2/2021 6:31 PM, Stefan Berger wrote:
>> From: Denis Semakin <denis.semakin@huawei.com>
>>
>> This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
>> to setup IMA (Integrity Measurement Architecture) policies per container
>> for non-root users.
>>
>> The main purpose of this new capability is discribed in this document:
>> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
>> It is said: "setting the policy should be possibly without the powerful
>> CAP_SYS_ADMIN and there should be the opportunity to gate this with a 
>> new
>> capability CAP_INTEGRITY_ADMIN that allows a user to set the IMA policy
>> during container runtime.."
>>
>> In other words it should be possible to setup IMA policies while not
>> giving too many privilges to the user, therefore splitting the
>> CAP_INTEGRITY_ADMIN off from CAP_SYS_ADMIN.
>
> Please use CAP_MAC_ADMIN, as discussed on the previous submission.

I wasn't clear on consensus. But sure, let's go with CAP_MAC_ADMIN.

    Stefan


