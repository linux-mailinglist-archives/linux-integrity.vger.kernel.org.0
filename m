Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2913477EE8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhLPViT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 16:38:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8212 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236820AbhLPViT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 16:38:19 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKQQnX024494;
        Thu, 16 Dec 2021 21:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0pyn4IWIx1Fu0WZKd1EhQmwziqA3HmO1dC0kUFj5hvc=;
 b=PupN7oOg6+KV4Ir1DW0oOcRQRTIHIqTDgULwVLU/KzRdRd+IvAfYDOFQq6uvZ9bCxkHr
 yqHi/LRJjMOHD7QM6bbJEtQiTuxdKmPQy+Kha/jQ0zdjZCdXG0xgu/yaPWD8Dz6PNA84
 v9eLV67HPiCibf2iEkQYn+pzeVqvtu87ax1QhcFs0JMShvRJ0x4i/DIKy3MsEGlgfgbE
 v9tMSKcOj4B99zY5i5Avyntb0mMtYW7Jvr/NrcQmssgoaK2HZASDb2E2Q6RZJoX9dWKn
 yHIaeHtn7dPqttQp/RaPlkNRgmnNnW3FmWJz67pwW9SdyDewM66KMuBO1B4/ILsIXTg+ kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyq8v51ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:38:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGLREPs018033;
        Thu, 16 Dec 2021 21:38:06 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyq8v51h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:38:06 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGLWIZ4005346;
        Thu, 16 Dec 2021 21:38:05 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 3cy76wvkvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:38:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGLc4wi20971896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 21:38:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD257805C;
        Thu, 16 Dec 2021 21:38:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73AF678067;
        Thu, 16 Dec 2021 21:38:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 21:38:03 +0000 (GMT)
Message-ID: <b6aaf04b-c20f-64b7-1c4d-14aea032a773@linux.ibm.com>
Date:   Thu, 16 Dec 2021 16:38:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 14/14] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
 <20211216135100.43suxkutyuwac7yh@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211216135100.43suxkutyuwac7yh@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fQIvGATwnszgSkOAlMn--SduAhzzpVVX
X-Proofpoint-GUID: o3WKyDHTbZUbfQu9X3ONmUopjWHAhjn2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_08,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112160115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/16/21 08:51, Christian Brauner wrote:
>
>> +int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>   {
>>   	struct ima_namespace *ns = user_ns->ima_ns;
>> -	struct dentry *ima_dir;
>> +	struct dentry *int_dir;
>> +	struct dentry *ima_dir = NULL;
>>   	struct dentry *ima_symlink = NULL;
>>   	struct dentry *binary_runtime_measurements = NULL;
>>   	struct dentry *ascii_runtime_measurements = NULL;
>>   	struct dentry *runtime_measurements_count = NULL;
>>   	struct dentry *violations = NULL;
>>   
>> -	ima_dir = securityfs_create_dir("ima", integrity_dir);
>> +	/* FIXME: update when evm and integrity are namespaced */
>> +	if (user_ns != &init_user_ns) {
>> +		int_dir =
>> +			securityfs_create_dir("integrity", root);
>> +		if (IS_ERR(int_dir))
>> +			return -1;
> That should probably be return PTR_ERR(int_dir)

That's actually from current usptream ( 
https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L457 
) The question is then whether at the end it should also return 
something else than what it currently returns:

out:
     securityfs_remove(violations);

     [...]

     securityfs_remove(ima_policy);
     return -1;


