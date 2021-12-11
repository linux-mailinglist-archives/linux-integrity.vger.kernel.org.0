Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D073D47172F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhLKWd7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 17:33:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23522 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231516AbhLKWd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 17:33:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBMRCQN003689;
        Sat, 11 Dec 2021 22:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EcSstuXrlPcX99mLLNhOV/tDXzPh8dc/FswaQJkDwnk=;
 b=lqnOsMUihrCFPZ65tNcrIMo2eeSDT5z5HzZa40WD3KHIr5KaT+Jsx/wvsJUMV+H6JskD
 aNF39F5R2DQNfxqf0dtRkASqVOp5EGy3B3SOjDO7jfV7W53e/AqTj8FclqnIT85kt56R
 RFlu8nXxN/zbS9hLat/0BEVPa88lW9IOig7+cTWNST0iNvWVQ6hOQwJdm2KcX+e3TmAf
 Ms7KvaURq/SQ6FKk6rAk6r/Q02WU03lBuxWjVMLSSDNz5hpKQHkBaguZKaI07lHuuQ0P
 SzabjA2S0/++6Q8VOrRk6DWNW3/h1ganvGxKOFU59q09mhCzyvpgBEZXQKT4KOuph2o9 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw44hgcu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:33:47 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBMXAhj017224;
        Sat, 11 Dec 2021 22:33:47 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw44hgcu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:33:47 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBMX3cn021932;
        Sat, 11 Dec 2021 22:33:46 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3cvkm90sdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:33:46 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBMXjXm30081298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 22:33:45 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F25DD6E052;
        Sat, 11 Dec 2021 22:33:44 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 045896E04E;
        Sat, 11 Dec 2021 22:33:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 22:33:42 +0000 (GMT)
Message-ID: <0c95df54-cac0-6fb6-a3f0-94583d886a76@linux.ibm.com>
Date:   Sat, 11 Dec 2021 17:33:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 14/17] ima: Tie opened SecurityFS files to the IMA
 namespace it belongs to
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-15-stefanb@linux.ibm.com>
 <20211211110038.dbshu23uvlhv65vn@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211211110038.dbshu23uvlhv65vn@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lBbnWW53L7LnVea46BDDZIhWviGe-zeb
X-Proofpoint-GUID: RcUk-CqGx18OOcpDaidIlaFFCRwtJFJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_10,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/11/21 06:00, Christian Brauner wrote:
> On Fri, Dec 10, 2021 at 02:47:33PM -0500, Stefan Berger wrote:
>> Tie IMA's files in SecurityFS to the IMA namespace they belong to so that
>> also file descriptor that were passed or inherited to other user/IMA
>> namespaces will always access the data of the IMA namespace they originally
>> belonged to.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima_fs.c     | 74 ++++++++++++++++++++++++-----
>>   security/integrity/ima/ima_policy.c |  4 +-
>>   2 files changed, 63 insertions(+), 15 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 0e582ceecc7f..a136d14f29ec 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -35,6 +35,20 @@ static int __init default_canonical_fmt_setup(char *str)
>>   }
>>   __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>>   
>> +static inline struct user_namespace *ima_user_ns_from_file(struct file *filp)
>> +{
>> +	return filp->f_path.mnt->mnt_sb->s_user_ns;
>> +}
> I'd probably rewrite this as:
>
> static inline struct user_namespace *ima_user_ns_from_file(const struct file *filp)
> {
> 	return file_inode(filp)->i_sb->s_user_ns;
> }
>
> as it spares you some pointer chasing and also looks cleaner.

Ok. This patch is being absorbed by all the functions currently using 
get_current_ns() and should access it via the file instead.

    Stefan
