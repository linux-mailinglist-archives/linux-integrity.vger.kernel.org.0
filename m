Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3D525755
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358912AbiELVs6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 17:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358965AbiELVsu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 17:48:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157E2802C0
        for <linux-integrity@vger.kernel.org>; Thu, 12 May 2022 14:48:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLkh6v024354;
        Thu, 12 May 2022 21:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3WfahNbxHn86I02/OPc3OeRsefyW9lfNAdBXenuNeDU=;
 b=qjj09YX7Z+iqceRi9i66A5Owq8/FcekUN/uKvl/It5c0jUlYukNK25VPf0pPLGw9mYxX
 25WsFv9sBJv/RVORl/r1flxfbIMJjmA8SZ9bpAyVWpHXGvIS2ihnyQAO1NF+Psv+LL07
 0aiKy098obzZ1ZM2xle8gd2AQ6252GmS2lYeGiydj0JPdW6448dPFs5kdRaIGfB7JRBU
 Hjzq93NwnmaAWB/Gj0Tf7GTFxwPaq8dLQjEIZ8k3Q0ppGLJ2dSwzReGoS3eMBduFa6cN
 IkD2bk0/nqU4TmEyqu87s8UflUOQVCKxz+GtKvwPAthHCq1WBWAvVTg9I+Wh13yPquG1 dg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1aex00ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 21:48:40 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CLlGXN011736;
        Thu, 12 May 2022 21:48:39 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3fwgdb7fuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 21:48:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CLmc5C32506336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:48:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C0678060;
        Thu, 12 May 2022 21:48:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D17DF7805E;
        Thu, 12 May 2022 21:48:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 21:48:37 +0000 (GMT)
Message-ID: <b4ed4a2c-2da2-b9f0-cb1c-50ee7ec43eba@linux.ibm.com>
Date:   Thu, 12 May 2022 17:48:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 ima-evm-utils 2/3] Sign an fs-verity file digest
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
 <20220512183056.307597-2-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220512183056.307597-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4L3wxPdIuhsaVPFqlxVs7LnARGRuH1hs
X-Proofpoint-GUID: 4L3wxPdIuhsaVPFqlxVs7LnARGRuH1hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_17,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120090
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
> Sign fs-verity file digests provided in the format as produced by
> "fsverity measure".  The output is of the same format as the input,
> but with the file signature appended.  Use setfattr to write the
> signature as security.ima xattr.
> 
> fsverity measure format: <algo>:<hash> <pathname>
> output format: <algo>:<hash> <pathname> <signature>
> 
> Instead of directly signing the fsverity hash, to disambiguate the
> original IMA signatures from the fs-verity signatures stored in the
> security.ima xattr a new signature format version 3 (sigv3) was
> defined as the hash of the xattr type (enum evm_ima_xattr_type),
> the hash algorithm (enum hash_algo), and the hash.
> 
> Example:
> fsverity measure <pathname> | evmctl sign_hash --veritysig \
>   --key <pem encoded private key>
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   README          |   3 +-
>   src/evmctl.c    | 103 +++++++++++++++++++++++++++++++++++++++++-------
>   src/imaevm.h    |   5 ++-
>   src/libimaevm.c |  85 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 179 insertions(+), 17 deletions(-)
> 
> diff --git a/README b/README
> index 5b5ecb52a74b..ffe46ad75728 100644
> --- a/README
> +++ b/README
> @@ -34,7 +34,7 @@ COMMANDS
>    ima_hash file
>    ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
>    ima_fix [-t fdsxm] path
> - sign_hash [--key key] [--pass password]
> + sign_hash [--veritysig] [--key key] [--pass password]
>    hmac [--imahash | --imasig ] file
>   
>   
> @@ -43,6 +43,7 @@ OPTIONS
>   
>     -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
>     -s, --imasig       make IMA signature
> +      --veritysig    sign an fs-verity file digest hash
>     -d, --imahash      make IMA hash
>     -f, --sigfile      store IMA signature in .sig file instead of xattr
>         --xattr-user   store xattrs in user namespace (for testing purposes)
> diff --git a/src/evmctl.c b/src/evmctl.c
> index ca9449498321..9152b0a5c7c2 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -135,6 +135,7 @@ static int msize;
>   static dev_t fs_dev;
>   static bool evm_immutable;
>   static bool evm_portable;
> +static bool veritysig;
>   
>   #define HMAC_FLAG_NO_UUID	0x0001
>   #define HMAC_FLAG_CAPS_SET	0x0002
> @@ -726,34 +727,102 @@ static int cmd_sign_ima(struct command *cmd)
>   	return do_cmd(cmd, sign_ima_file);
>   }
>   
> +/*
> + * Sign file hash(es) provided in the format as produced by either
> + * sha*sum or "fsverity measure".
> + *
> + * sha*sum format: <hash> <pathname>
> + * fsverity measure format: <algo>:<hash> <pathname>
> + *
> + * To disambiguate the resulting file signatures, a new signature format
> + * version 3 (sigv3) was defined as the hash of the xattr type (enum
> + * evm_ima_xattr_type), the hash algorithm (enum hash_algo), and the hash.
> + *
> + * Either directly sign the sha*sum hash or indirectly sign the fsverity
> + * hash (sigv3).
> + *
> + * The output is the same format as the input with the resulting file
> + * signature appended.
> + */
>   static int cmd_sign_hash(struct command *cmd)
>   {
> +	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
> +	unsigned char sig[MAX_SIGNATURE_SIZE];
> +	unsigned char hash[MAX_DIGEST_SIZE];
> +	int siglen, algolen, hashlen = 0;
> +	char *line = NULL, *token, *hashp;
> +	size_t line_len = 0;
>   	const char *key;
> -	char *token, *line = NULL;
> -	int hashlen = 0;
> -	size_t line_len;
> +	char algo[12];
>   	ssize_t len;
> -	unsigned char hash[MAX_DIGEST_SIZE];
> -	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
> -	int siglen;
> +	int ret;
>   
>   	errno = 0;
>   	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
>   
> -	/* support reading hash (eg. output of shasum) */
>   	while ((len = getline(&line, &line_len, stdin)) > 0) {
>   		/* remove end of line */
>   		if (line[len - 1] == '\n')
>   			line[--len] = '\0';
>   
> -		/* find the end of the hash */
> -		token = strpbrk(line, ", \t");
> -		hashlen = token ? token - line : strlen(line);
> +		/*
> +		 * Before either directly or indirectly signing the hash,
> +		 * convert the hex-ascii hash representation to binary.
> +		 */
> +		if (veritysig) {
> +
> +			/* split the algorithm from the hash */
> +			hashp = strpbrk(line, ":");
> +			if (!hashp) {	/* pointer to the delimiter */
> +				log_err("Missing fsverity hash algorithm\n");
> +				continue;
> +			}
> +
> +			algolen = hashp - line;
> +			if (algolen > sizeof(algo))
> +				algolen = sizeof(algo);

I think a hash name exceeding the max buffer size and needing to be 
truncating it should be an error since the name to index conversion will 
fail  later on.


> +			if (algolen <= 0) {
> +				log_err("Missing fsverity hash algorithm\n");
> +				continue;
> +			}
> +
> +			strncpy(algo, line, algolen);
> +			algo[algolen] = 0;	/* Nul terminate algorithm */

per above: if algolen == sizeof(algo) then you have an out-of-bounds 
access here...

