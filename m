Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40262735B8D
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jun 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFSPwb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFSPw2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 11:52:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915831A8
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jun 2023 08:52:27 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JFdSRY021508;
        Mon, 19 Jun 2023 15:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3WR5/4+NymkxZtpoIRBQe6wBglNeQdkDw/lvja6P8/U=;
 b=BQPVsv4ZuEzR37GckLKBiE1xV14dNLw7mD9zuiq7EsUzm97o4zFR+kbf2rbmqM81rzKK
 UBKaSjMroENQTjXTrr8ZXtmlnuzVFHzcJaHWJEtPbSfe8HjLEPcypvUx5DEQxcDZHif/
 UNR902nuQEcmjO/rn2rRYk90TghMZBCE5UZQOiWRXuXFZuJBjuzGA3GCKkKKTYD8SU8Q
 q9YW/+/reJI4hqNGTLwIE1vaEsQGHorwHpE8rr8uEFh5t0+BCbMOdlCrqvctjB2kChYz
 8x6Um/bNhDkrJNJr9J1Uh9oWyAV8HR7xP9RbGjp8byteoMfKgP5CH14BBuJxAWMc/kEv qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rash78nft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:51:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35JFdjfn022164;
        Mon, 19 Jun 2023 15:51:57 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rash78nf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:51:57 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35JDUgsp010292;
        Mon, 19 Jun 2023 15:51:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r94f69h7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:51:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JFpthn65012080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 15:51:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4BF5805C;
        Mon, 19 Jun 2023 15:51:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E2D658054;
        Mon, 19 Jun 2023 15:51:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 15:51:54 +0000 (GMT)
Message-ID: <25349506-65a5-67ac-ca0f-b6e4fe829313@linux.ibm.com>
Date:   Mon, 19 Jun 2023 11:51:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 ima-evm-utils 1/4] Include the filesystem UUID in HMAC
 calculation
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
 <20230616192358.314906-2-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230616192358.314906-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3BS8c5rbMOJYOgSE9lo9pQrb6mU6iBEi
X-Proofpoint-ORIG-GUID: XCGEYWq81_I46S7IZqAO9QG0SR8MnCOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
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
> Modify calc_evm_hmac() to include, similarly to calc_evm_hash(), the
> filesystem UUID in the HMAC calculation.
> 
> If the -u option is not specified in the evmctl command line, the UUID of
> the filesystem the input file resides on is taken for the calculation.
> 
> If a string is specified as a value for the -u option, that string is taken
> as UUID (assuming that it is formatted correctly).
> 
> If no value is specified for the -u option, the filesystem UUID is not
> included in the HMAC calculation.
> 
> Not including the filesystem UUID in the digest/HMAC calculation is needed
> for the case where the kernel is compiled with CONFIG_EVM_ATTR_FSUUID=n, or
> the digest/HMAC is not for an EVM portable signature.
> 
> Fixes: 1d24a94bb556 ("added uuid support for EVM")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   src/evmctl.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index c35a28c58f4..c24261cf0e6 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1199,6 +1199,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
>   	int keylen;
>   	unsigned char evmkey[MAX_KEY_SIZE];
>   	char list[1024];
> +	char uuid[16];
>   	ssize_t list_size;
>   	struct h_misc_64 hmac_misc;
>   	int hmac_size;
> @@ -1330,6 +1331,18 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
>   		log_err("EVP_DigestSignUpdate() failed\n");
>   		goto out_ctx_cleanup;
>   	}
> +	if (!(hmac_flags & HMAC_FLAG_NO_UUID)) {
> +		err = get_uuid(&st, uuid);
> +		if (err)
> +			goto out_ctx_cleanup;
> +
> +		err = EVP_DigestSignUpdate(pctx, (const unsigned char *)uuid,
> +					   sizeof(uuid));
> +		if (!err) {
> +			log_err("EVP_DigestSignUpdate() failed\n");
> +			goto out_ctx_cleanup;
> +		}
> +	}
>   	err = EVP_DigestSignFinal(pctx, sig, &siglen);
>   	if (err != 1)
>   		log_err("EVP_DigestSignFinal() failed\n");

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
