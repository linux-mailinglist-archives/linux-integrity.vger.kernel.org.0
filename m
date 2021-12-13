Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9DA473674
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhLMVQF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 16:16:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237803AbhLMVQE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 16:16:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDKEYc7008885;
        Mon, 13 Dec 2021 21:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TNKQa6wLqS/fUlw+QxnA0HirQ7Bz+Sd8iwtCktfzaJw=;
 b=m066ldecW/nyucJXDbfUNOX+bHLWU6yNGYDAtb+4ThogACejYanaVRQAbSjt5EHb7I5T
 sxCO9dV0KIfas6XucfiEgXGQ4XFv3iuJRRrcNzMrFvu841pwOkwR5XdZnAfLxPMcXlpL
 aG9rvZm0BHflLVMViilEQHB0TmInYKnMcAjNwYqEh6JvvcZU8zydNqklHXoDEKbaaXWm
 ZFhlxz339nDbHKHp9lAwe/QoV2alaHRp95F+aTXsk4/q3oCE4yVxL7fVfjLGgb2MvzfX
 dF0NDTDjVI8LZCElxcZS+XA9NzUFdFoqOg4RPQFDCGb5d6Cr0S7lKABDOM+fvbWFAvqM Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8q450-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:15:51 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BDLD9LZ017229;
        Mon, 13 Dec 2021 21:15:51 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8q44q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:15:51 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLEMqs032480;
        Mon, 13 Dec 2021 21:15:49 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkmah29w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:15:49 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDLFfle39059904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 21:15:41 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB882124062;
        Mon, 13 Dec 2021 21:15:40 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4977124053;
        Mon, 13 Dec 2021 21:15:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 21:15:40 +0000 (GMT)
Message-ID: <350c814d-d49e-4815-c9da-bc4e0f26b510@linux.ibm.com>
Date:   Mon, 13 Dec 2021 16:15:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 06/17] ima: Move policy related variables into
 ima_namespace
Content-Language: en-US
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-7-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211210194736.1538863-7-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J9VpyQZuZ1-LJxUCK8Aq5HDjjkxvFPve
X-Proofpoint-ORIG-GUID: DytkPzju0IHDow7bPZayueOfn5zBxy2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_10,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 14:47, Stefan Berger wrote:
> @@ -357,7 +359,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>   
>   		rc = is_binary_blacklisted(digest, digestsize);
>   		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> -			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
> +			process_buffer_measurement(ns, &init_user_ns, NULL, digest, digestsize,
>   						   "blacklisted-hash", NONE,
>   						   pcr, NULL, false, NULL, 0);
>   	}
> @@ -527,14 +529,15 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
>   			    struct dentry *dentry)
>   {
>   	struct inode *inode = d_backing_inode(dentry);
> +	struct ima_namespace *ns = get_current_ns();

I am getting the ima_namespace now from the dentry in the 3 locations in 
this file.

   Stefan


