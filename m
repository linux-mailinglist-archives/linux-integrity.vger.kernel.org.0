Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3654C1986
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 18:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiBWRJX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiBWRJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 12:09:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF86A052;
        Wed, 23 Feb 2022 09:08:55 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NGklN0008284;
        Wed, 23 Feb 2022 17:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v/9iqPWP9GaGeN8okiXT35bEkgeyZqF20Bo4yaP6Zbc=;
 b=VrNvN7cWxIpZfqBeMZvwBdiF+qR4DSX3Jrpjh+RM18NOFPvuZKNgDelEWT5QxRbYUULM
 wvfITQ+gQe6GJgrX3BWzgmgxCp+TpPfSkNNtarqAH/n+WALIP9E18D62YgERYXZphIQQ
 sN/foGGalX68UUCaAAg/VsoZn0YB4sglEOpGthe8mOsbwXeO2SrBLow9Op492C593J1g
 blI9MCoyeKbmuTDKAX8NNOtqL+llbNMN1layjFGb0JRmjVii19J91KTeTIqPxMc6amTB
 7k+PsV6q6Zr2aaxS77dj40bWnxNH3HfqT4FtFVgV40kpCzA5hWbnP13VPyixgu/b8yEl YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edrrcrhk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:08:44 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NH6OSV001118;
        Wed, 23 Feb 2022 17:08:43 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edrrcrhjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:08:43 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NH60Tl022427;
        Wed, 23 Feb 2022 17:08:42 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3ear6bvx2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:08:42 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NH8eCP46334246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 17:08:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6BD7B2065;
        Wed, 23 Feb 2022 17:08:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FB38B205F;
        Wed, 23 Feb 2022 17:08:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 17:08:40 +0000 (GMT)
Message-ID: <9262a630-1f3e-0f58-110d-abfebe8274af@linux.ibm.com>
Date:   Wed, 23 Feb 2022 12:08:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 24/27] ima: Introduce securityfs file to activate an
 IMA namespace
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
 <20220201203735.164593-25-stefanb@linux.ibm.com>
 <9a720bf5928151a0cbc7994ee498a1c3ca779c56.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <9a720bf5928151a0cbc7994ee498a1c3ca779c56.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dzCcfQ4VjkfeIovbD0g_06AG5j1fOtQW
X-Proofpoint-ORIG-GUID: 8TkWLL1sE-GCLWOycacwjGZZ1pviQHG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_08,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 08:54, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>
>>   int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>   {
>>   	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
>> @@ -531,6 +596,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>   		}
>>   	}
>>   
>> +	if (ns != &init_ima_ns) {
>> +		ret = ima_fs_add_ns_files(ima_dir);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
> In all other cases, the securityfs files are directly created in
> ima_fs_ns_init().   What is different about "active" that a new
> function is defined?


It was meant as a function to create namespace-specific files, if more 
were to come along.  I can move the code from ima_fs_add_ns_files() into 
this function if you want.


>
> thanks,
>
> Mimi
>
>
