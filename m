Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4852650C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381268AbiEMOoH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 10:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382829AbiEMOnR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 10:43:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1767D32
        for <linux-integrity@vger.kernel.org>; Fri, 13 May 2022 07:41:05 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEXsDc008074;
        Fri, 13 May 2022 14:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v3B7SEERfy1SjcfouVZzmv96paSlwkNHxZbNweVuXC4=;
 b=VfJfX6TGSRLSKCQoV8K1JCdefNWqe8znHmWyzZSBqBTfM8SKmH8MX3GOrWW1B12akeQM
 NN/K+a3gmXRvGHfMZiG9m8tS8ozRgrmrNlcpGo3uE4WhLOzqe7jZL0qEuTxdeTSBSHB/
 6fLoFpVzkboX+Hr2SMgr+XvPPkAuMwV5X5TLvfOovwJqCgQ608ye9JOCdWUeepYN1eGA
 ivwXGKTIcbafL/nrFkYpbBGGIGUW4ESpDaTKvvU3CQm1oU7t5naywBc+CuJXOCMZFcQ/
 UdEd636ipLZ1ItJQZBrn7lotsNBFDK6AU3amrmaZbKDl94r21Apix3o4wGyLqN6pSBHc KQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1s6y84sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:41:02 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DEcQH8032330;
        Fri, 13 May 2022 14:41:02 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3fwgdb5gq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:41:01 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DEf0Co26935596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:41:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E506DAE063;
        Fri, 13 May 2022 14:41:00 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F83AE062;
        Fri, 13 May 2022 14:41:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 14:41:00 +0000 (GMT)
Message-ID: <e51529e8-9af2-edf7-9e13-b2b1ab383bc9@linux.ibm.com>
Date:   Fri, 13 May 2022 10:41:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 ima-evm-utils 3/3] Verify an fs-verity file digest
 based signature
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
 <20220512183056.307597-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220512183056.307597-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W_HWzuVckSN_u07cDbQlbFQgbWv56Wi_
X-Proofpoint-GUID: W_HWzuVckSN_u07cDbQlbFQgbWv56Wi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205130064
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/12/22 14:30, Mimi Zohar wrote:
> ima-evm-utils does not attempt to calculate or even read the fs-verity
> file hash, but can verify the fs-verity signature based on the fsverity
> file hash, both contained in the measurement list record.
> 
> For the time being only fs-verity supports signature format v3 (sigv3).
> To differentiate between the existing IMA and fs-verity file signatures,
> modify the verify_hash() 'sig' argument to be a pointer to the entire
> xattr, including the xattr type.
> 
> Example:
> evmctl ima_measurement --key <DER encoded public key> \
>   --verify-sig /sys/kernel/security/ima/binary_runtime_measurements
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c    | 11 +++++++++--
>   src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++------------
>   2 files changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9152b0a5c7c2..593eed80f96a 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -909,7 +909,7 @@ static int verify_evm(const char *file)
>   		return mdlen;
>   	assert(mdlen <= sizeof(hash));
>   
> -	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
> +	return verify_hash(file, hash, mdlen, sig, len);
>   }
>   
>   static int cmd_verify_evm(struct command *cmd)
> @@ -1572,7 +1572,8 @@ void ima_ng_show(struct template_entry *entry)
>   	fieldp += field_len;
>   	total_len -= field_len;
>   
> -	if (!strcmp(entry->name, "ima-sig")) {
> +	if (!strcmp(entry->name, "ima-sig") ||
> +	    !strcmp(entry->name, "ima-sigv2")) {
>   		/* get signature */
>   		field_len = *(uint32_t *)fieldp;
>   		fieldp += sizeof(field_len);
> @@ -1618,11 +1619,17 @@ void ima_ng_show(struct template_entry *entry)
>   			log_info(" ");
>   			log_dump(sig, sig_len);
>   		}
> +
> +		/*
> +		 * Either verify the signature against the hash contained in
> +		 * the measurement list or calculate the hash.
> +		 */
>   		if (verify_list_sig)
>   			err = ima_verify_signature(path, sig, sig_len,
>   						   digest, digest_len);
>   		else
>   			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
> +
>   		if (!err && imaevm_params.verbose > LOG_INFO)
>   			log_info("%s: verification is OK\n", path);
>   	} else {
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 7c2ed5fb0556..8a37551132d6 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -534,11 +534,21 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
>   		return -EINVAL;
>   	}
>   
> -	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
> -		log_err("Hash algorithm %s not supported\n", algo);
> -		return -EINVAL;
> +	/*
> +	 * Calculating the hash is based on the fsverity hash algorithm,
> +	 * while verifying the signature is based on the hash algorithm
> +	 * contained in the signature header.
> +	 */
> +	if (algo) {
> +		if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
> +			log_err("Hash algorithm %s not supported\n", algo);
> +			return -EINVAL;
> +		}
> +		file_id.hash_algorithm = hash_algo;
> +	} else {
> +		algo = imaevm_params.hash_algo;
> +		file_id.hash_algorithm = imaevm_get_hash_algo(algo);

You should probably compare this also against '< 0' as it was before. If 
you do it outside the if-else the two cases can share this:

	if (!algo)
		algo = imaevm_params.hash_algo;

	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
		log_err("Hash algorithm %s not supported\n", algo);
		return -EINVAL;
	}
	file_id.hash_algorithm = hash_algo;


