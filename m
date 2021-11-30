Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B46463D0B
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbhK3Rpi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 12:45:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244999AbhK3Rph (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 12:45:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUHOUHx024251;
        Tue, 30 Nov 2021 17:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VoPsW5UCQ7LEcy09whRgPcyRSdphbFWAjuSHcu35uMs=;
 b=bHOMmaQ5JEf3AwNKgz2QV74UfF8XcwXjqvMIElKXNfOU9NfWnb8HswLf+q4tXjaQihTJ
 F6ZmKOyUd3oqFk1wZ1OSYg5OcxfyFp4eAeVprQGgn12SujXrW6W+yCB3YQbmNmpCgSXm
 YRYOPNZ3AFnKChB+8Pp0RHdzR/pgtIsf6boeEydB5c1yd/KFJ9tf7OjasRX2Hy7rafsY
 MuXN/yqpqUWbqH6v2jWjlOKOfNhAPWSy3u+Q8VFCVE3KYbuqYYCi60DfNZqYavyC6ia/
 oXEG7aJLwsTHnllkzRo4QLXRndhwCl4TSwHNZWKjo3ltdGl2VJ6Jbu+pgF3Hs/ykT+Cx qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnr8xgha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 17:42:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUHeepM006535;
        Tue, 30 Nov 2021 17:42:02 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnr8xgh9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 17:42:02 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUHbhfS012097;
        Tue, 30 Nov 2021 17:42:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k1sdfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 17:42:01 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUHfxtN65995250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 17:41:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5882280D1;
        Tue, 30 Nov 2021 17:41:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEDA328090;
        Tue, 30 Nov 2021 17:41:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 17:41:58 +0000 (GMT)
Message-ID: <957f65ce-df0e-5980-57c3-57c05291ccc6@linux.ibm.com>
Date:   Tue, 30 Nov 2021 12:41:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 15/20] capabilities: Introduce CAP_INTEGRITY_ADMIN
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
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-16-stefanb@linux.ibm.com>
 <e482c499-8bff-72c8-bbda-1ecc5a7f3452@schaufler-ca.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <e482c499-8bff-72c8-bbda-1ecc5a7f3452@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cwqUDfQtHwF6PZEiIg_6qf3sCs7iWkRA
X-Proofpoint-GUID: JVuyyf7idwXMy_g04h1gmcfuY8WOzSvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=973 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111300090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/30/21 12:27, Casey Schaufler wrote:
> On 11/30/2021 8:06 AM, Stefan Berger wrote:
>> From: Denis Semakin <denis.semakin@huawei.com>
>>
>> This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
>> to setup IMA (Integrity Measurement Architecture) policies per container
>> for non-root users.
>
> Why not use CAP_MAC_ADMIN? IMA is a mandatory policy. The scope
> is system security administration. It seems to fit your needs.
> I introduced CAP_MAC_ADMIN for Smack, and believe that IMA using
> it would be completely appropriate.

Fine by me. I suppose we could be reusing it later on also for setting 
file extended attributes for IMA?

    Stefan


