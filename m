Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37A4ADC64
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351645AbiBHPUu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379944AbiBHPUq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 10:20:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5792C061577;
        Tue,  8 Feb 2022 07:20:45 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218FDEPR021819;
        Tue, 8 Feb 2022 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IeuOn+Gq1Tqn7HoNRMECPZnN53gB+9RPcD7aXMPa5fM=;
 b=n25ZNEH/0+rftuyR+5pjomOyjjdiFzJLn0VTDWRMmAIW3pWgV4oacKSWmN8nk6IV2dJQ
 bsZLSlSFgCqbe9QdcwsIvoCYslRMveliygmTRIekYfW2a/n9x/gSrcIT3CLbMHz59nIr
 hmjpU0T/CqWD1epQbEHM9NIea7RPABbL2wNO6I5fPtxM9vkU6NSevQeZERiHSdJw9r1B
 gVZoZw1FAslznKfh/OB7U5W4pkVQcQ4FSdAEiVlvi8xQrCpSHUs6ialHnQstyF4ZOtIz
 a+WKpV3nvGG64GqYwoa/sjNojPJaiI4xN3s8fMFPTGtod+8LOWnfZNixFB5o6X95LRHi VQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tyc08tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:20:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218FEdpN004247;
        Tue, 8 Feb 2022 15:20:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv9f509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:20:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218FKWiw45613402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 15:20:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C9842049;
        Tue,  8 Feb 2022 15:20:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8CF42047;
        Tue,  8 Feb 2022 15:20:31 +0000 (GMT)
Received: from sig-9-65-88-92.ibm.com (unknown [9.65.88.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 15:20:30 +0000 (GMT)
Message-ID: <ec4348e54b39811b727a29f3c23972eab616dcd3.camel@linux.ibm.com>
Subject: Re: Problem with commit ccf11dbaa07b ("evm: Fix memleak in
 init_desc")
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        wangweiyang <wangweiyang2@huawei.com>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>
Date:   Tue, 08 Feb 2022 10:20:30 -0500
In-Reply-To: <e852660c-17fa-cd75-e361-45dd77b8884d@huawei.com>
References: <e852660c-17fa-cd75-e361-45dd77b8884d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J5lJ4acfhYYVdM7WnrLzsbUBv-EUg8g8
X-Proofpoint-ORIG-GUID: J5lJ4acfhYYVdM7WnrLzsbUBv-EUg8g8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-08 at 16:53 +0800, Guozihua (Scott) wrote:
> Hi Mimi,
> 
> I found an issue with commit ccf11dbaa07b ("evm: Fix memleak in init_desc").
> 
> This commit tries to free variable "tmp_tfm" if something went wrong 
> after the "alloc" label in function init_desc, which would potentially 
> cause a user-after-free issue
> 
> The codes are as follows:
> 
>    1 static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>    2 {
>    3 	long rc;
>    4 	const char *algo;
>    5 	struct crypto_shash **tfm, *tmp_tfm = NULL;
>    6 	struct shash_desc *desc;
>    7
>    8 	if (type == EVM_XATTR_HMAC) {
>    9 		if (!(evm_initialized & EVM_INIT_HMAC)) {
>   10 			pr_err_once("HMAC key is not set\n");
>   11 			return ERR_PTR(-ENOKEY);
>   12 		}
>   13 		tfm = &hmac_tfm;
>   14 		algo = evm_hmac;
>   15 	} else {
>   16 		if (hash_algo >= HASH_ALGO__LAST)
>   17 			return ERR_PTR(-EINVAL);
>   18
>   19 		tfm = &evm_tfm[hash_algo];
>   20 		algo = hash_algo_name[hash_algo];
>   21 	}
>   22
>   23 	if (*tfm)
>   24 		goto alloc;
>   25 	mutex_lock(&mutex);
>   26 	if (*tfm)
>   27 		goto unlock;
>   28
>   29 	tmp_tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
>   30 	if (IS_ERR(tmp_tfm)) {
>   31 		pr_err("Can not allocate %s (reason: %ld)\n", algo,
>   32 		       PTR_ERR(tmp_tfm));
>   33 		mutex_unlock(&mutex);
>   34 		return ERR_CAST(tmp_tfm);
>   35 	}
>   36 	if (type == EVM_XATTR_HMAC) {
>   37 		rc = crypto_shash_setkey(tmp_tfm, evmkey, evmkey_len);
>   38 		if (rc) {
>   39 			crypto_free_shash(tmp_tfm);
>   40 			⋅mutex_unlock(&mutex);
>   41 			return ERR_PTR(rc);
>   42 		}
>   43 	}
>   44 	*tfm = tmp_tfm;
>   45 unlock:
>   46 	mutex_unlock(&mutex);
>   47 alloc:
>   48 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>   49 			GFP_KERNEL);
>   50 	if (!desc) {
>   51 		crypto_free_shash(tmp_tfm);
>   52 		return ERR_PTR(-ENOMEM);
>   53 	}
>   54
>   55 	desc->tfm = *tfm;
>   56
>   57 	rc = crypto_shash_init(desc);
>   58 	if (rc) {
>   59 		crypto_free_shash(tmp_tfm);
>   60 		kfree(desc);
>   61 		return ERR_PTR(rc);
>   62 	}
>   63 	return desc;
>   64 }
> 
> As we can see, variable *tfm points to one of the two global variable 
> hmac_tfm or evm_tfm[hash_algo]. tmp_tfm is used as an intermediate 
> variable for initializing these global variables. Freeing tmp_tfm after 
> line 44 would invalidate these global variables and potentially cause a 
> user-after-free issue.
> 
> I think this commit should be reverted.
> 
> Reference: commit 843385694721 ("evm: Fix a small race in init_desc()")

Why this one, as opposed to commit ccf11dbaa07b ("evm: Fix memleak in
init_desc")? 

-- 
thanks,

Mimi


