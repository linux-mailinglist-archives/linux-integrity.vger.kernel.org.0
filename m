Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26D735B9F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jun 2023 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjFSPzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 11:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFSPzL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 11:55:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94C1B4
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jun 2023 08:55:10 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JFmZ3Y025468;
        Mon, 19 Jun 2023 15:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5xYUuygYiXyEEIclgNSjw7vPYsVYXGDo836BtylJGyc=;
 b=Sed4jRLby3rBNIGHHKKkLH0Gjw+UafZ90i/CW3v3pFtVVtwU/Ep9Vn8VM5yVfFrgyyrp
 O2YzG3utlFPHWWpOLsFS6fViv90fy1geW8pWrevsc1DrvKDSRfTk4C7Vo3/TAVkaM05J
 UuxITrUGMQ3G5ECOI9tR93iYDrAa2dxpG+0EVcaZlxIdzZdaAtSw83JONFurm6K1oMp6
 o8jH1IPkTaI7U3lTzBEGuMhDLfRSh3rc0CwKxXSTomDfbd3uNHY7JaB2DcCFMUMwjmoF
 D9xi9xUAr80sL2hAvDZ/qYBhPQQcPJZ/XZPFCCV5TLJFxbow2fi+2+bjyNaSgB0Zrz7B QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rat03g3b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:54:44 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35JFn9q3026634;
        Mon, 19 Jun 2023 15:54:44 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rat03g3ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:54:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J7QvIQ006222;
        Mon, 19 Jun 2023 15:54:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r94f5be1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:54:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JFsfm766978072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 15:54:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DB158059;
        Mon, 19 Jun 2023 15:54:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B29158058;
        Mon, 19 Jun 2023 15:54:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 15:54:35 +0000 (GMT)
Message-ID: <3afdbf3f-a08f-bf00-5583-140eb786dcb3@linux.ibm.com>
Date:   Mon, 19 Jun 2023 11:54:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 ima-evm-utils 2/4] Restore correct HMAC calculation for
 directories
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
 <20230616192358.314906-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230616192358.314906-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lGyCDJMWmEGoyupgkSFsIet6oKH1-XDA
X-Proofpoint-ORIG-GUID: fhYwRVcmajcrczcwLMjYMFMyqMvIVTkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=796 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306190143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/16/23 15:23, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for
> directory signing") removes fetching the inode generation for directories.
> 
> While directories might not be signed, EVM currently calculates the HMAC on
> them, including the inode generation.

> 
> To keep user space and kernel space aligned, reenable fetching the inode
> generation for directories, and add again the comment that the inode
> generation cannot be obtained for special files.

The user wouldn't notice anything, right?

> 
> Fixes: Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for directory signing")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   src/evmctl.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index c24261cf0e6..7a3ffd7c823 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1229,7 +1229,11 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
>   		goto out;
>   	}
>   
> -	if (S_ISREG(st.st_mode)) {
> +	if (S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) {
> +		/*
> +		 * We cannot at the moment get generation of special files..
> +		 * kernel API does not support it.
> +		 */
>   		int fd = open(file, 0);
>   
>   		if (fd < 0) {

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
