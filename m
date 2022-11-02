Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A3616699
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKBPzv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKBPzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 11:55:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE32B184
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 08:55:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Fo8YC016800;
        Wed, 2 Nov 2022 15:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kSJAemRJ/anp8qTcFMGAiYfXiQLfLDL8GP0vCVI6COE=;
 b=aSww5CO9n/xC+7RFlCs9vcWhg+MSGlJAr8aYDRLwLIxuaTAHFuwBWfsvHGlpjwXelWEr
 tfAruR59F9bi+D/2TbyTVaR41z0AkRkbrYZcJzHPope9yqt5pZboBKEU8un3BuOMdqq8
 uglY4oKgx6YsMO/Q3lW0rQDe41M0TeRQhcbi9ASbQThdHwu3zm1tjPpdHJio3dN1F+Bz
 GSYs0EaC6R1JL53a7JsJtJY1TNHO0rMDaiT89rL7/XFabJJhV/XxMrrTMoUuI27lleMF
 S7HUhfEhn2bNDRtwB+T80DecZva0PmZVJWwNvfJsoF3h0XZnWE6Rm38WH+fiXdEMxSwR YA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqqn1swy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:55:42 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2FoQ9W007822;
        Wed, 2 Nov 2022 15:55:41 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3kgut9uptm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:55:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2FtgmI49217978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 15:55:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C202358058;
        Wed,  2 Nov 2022 15:55:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5709458059;
        Wed,  2 Nov 2022 15:55:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 15:55:40 +0000 (GMT)
Message-ID: <4811654a-8b58-5998-24c3-38d1a1eba0d9@linux.ibm.com>
Date:   Wed, 2 Nov 2022 11:55:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 03/17] Log and reset 'errno' on lsetxattr
 failure
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-4-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221101201803.372652-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N4g_2H7pE2JXIp1-BvEBHvX9iy-GG3Qp
X-Proofpoint-ORIG-GUID: N4g_2H7pE2JXIp1-BvEBHvX9iy-GG3Qp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 16:17, Mimi Zohar wrote:
> Writing either security.ima hashes or security.evm hmacs from userspace
> will fail regardless of the IMA or EVM fix mode.  In fix mode, 'touch'
> will force security.ima and security.evm to be updated.
> 
> Make the setxattr error messages more explicit and clear errno.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 54123bf20f03..b1dcd9b1c1ef 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -572,7 +572,7 @@ static int sign_evm(const char *file, const char *key)
>   	if (xattr) {
>   		err = lsetxattr(file, xattr_evm, sig, len, 0);
>   		if (err < 0) {
> -			log_err("setxattr failed: %s\n", file);
> +			log_errno_reset(LOG_ERR, "Set EVM xattr failed: %s", file);

Change 'Set' to 'Setting' (in other cases as well)?

>   			return err;
>   		}
>   	}
> @@ -615,7 +615,8 @@ static int hash_ima(const char *file)
>   	if (xattr) {
>   		err = lsetxattr(file, xattr_ima, hash, len, 0);
>   		if (err < 0) {
> -			log_err("setxattr failed: %s\n", file);
> +			log_errno_reset(LOG_ERR, "Set IMA hash xattr failed: %s",
> +					file);
>   			return err;
>   		}
>   	}
> @@ -652,7 +653,8 @@ static int sign_ima(const char *file, const char *key)
>   	if (xattr) {
>   		err = lsetxattr(file, xattr_ima, sig, len, 0);
>   		if (err < 0) {
> -			log_err("setxattr failed: %s\n", file);
> +			log_errno_reset(LOG_ERR, "Set IMA sig xattr failed: %s",
> +					file);
>   			return err;
>   		}
>   	}
> @@ -1125,7 +1127,7 @@ static int setxattr_ima(const char *file, char *sig_file)
>   
>   	err = lsetxattr(file, xattr_ima, sig, len, 0);
>   	if (err < 0)
> -		log_err("setxattr failed: %s\n", file);
> +		log_errno_reset(LOG_ERR, "Set IMA sig xattr failed: %s", file);
>   	free(sig);
>   	return err;
>   }
> @@ -1323,7 +1325,8 @@ static int hmac_evm(const char *file, const char *key)
>   		sig[0] = EVM_XATTR_HMAC;
>   		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
>   		if (err < 0) {
> -			log_err("setxattr failed: %s\n", file);
> +			log_errno_reset(LOG_ERR, "Set EVM hmac xattr failed: %s",
> +					file);
>   			return err;
>   		}
>   	}


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
