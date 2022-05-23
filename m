Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182665306DD
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiEWAcw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAct (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 20:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3F38BDD
        for <linux-integrity@vger.kernel.org>; Sun, 22 May 2022 17:32:48 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N051a0031352;
        Mon, 23 May 2022 00:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GTwwx1Da9hE2VlMgGuNjHAAc0rRnvjL4YlUQUljjZ70=;
 b=B7wLG/FNn+LG0A0Ar7PW8Hz+hJmHrgkOgdRmXpGvH6sbBEnbWscq1rQVZ435vjKWQ6Eu
 DvWA9jkYPrRwBrgbRovT/m+Z+IOWT+IZB8sb78FRrNUSrakFpQQFikZmsjN2q6Dh1Nwh
 PbjVUSpRApj5QOGwhtN6z7E3BUVJnzknwFW+tYH8lpcViSMPSBfTjdMmEpvGPJjgjOJ9
 bwg/YLHwNEl4ilvCWHsFwFmmR3FyecO5CBLV6h89U8bxMlJn217PeXu7h4VoZN/Lu4Rm
 6akP5IJo4SwUIDLlVhtMy2sdWnaJLIAqg8WtzsHlpcy6gAKXVUReqryUtBkBEMK7jVhu cA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79e80hc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 00:32:45 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N08uhq008251;
        Mon, 23 May 2022 00:32:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3g6qqa7964-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 00:32:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N0Whu717432946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 00:32:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99472AC05F;
        Mon, 23 May 2022 00:32:43 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D77DAC05E;
        Mon, 23 May 2022 00:32:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 23 May 2022 00:32:43 +0000 (GMT)
Message-ID: <597ff6a8-f8cb-d1bf-e30e-8232b594314e@linux.ibm.com>
Date:   Sun, 22 May 2022 20:32:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 ima-evm-utils 2/3] Sign an fs-verity file digest
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20220520161103.373554-1-zohar@linux.ibm.com>
 <20220520161103.373554-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220520161103.373554-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q2V-lcXKZL5R8MF9r-AKTBb7YQN5fSIk
X-Proofpoint-ORIG-GUID: q2V-lcXKZL5R8MF9r-AKTBb7YQN5fSIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-22_12,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230001
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 12:11, Mimi Zohar wrote:
> Sign fs-verity file digests provided in the format as produced by
> "fsverity digest".  The output is of the same format as the input,
> but with the file signature appended.  Use setfattr to write the
> signature as security.ima xattr.
> 
> fsverity digest format: <algo>:<hash> <pathname>
> output format: <algo>:<hash> <pathname> <signature>
> 
> Instead of directly signing the fsverity hash, to disambiguate the
> original IMA signatures from the fs-verity signatures stored in the
> security.ima xattr a new signature format version 3 (sigv3) was
> defined as the hash of the xattr type (enum evm_ima_xattr_type),
> the hash algorithm (enum hash_algo), and the hash.
> 
> Example:
> fsverity digest <pathname> | evmctl sign_hash --veritysig \
>   --key <pem encoded private key>
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   README          |  3 +-
>   src/evmctl.c    | 99 +++++++++++++++++++++++++++++++++++++++++--------
>   src/imaevm.h    |  5 ++-
>   src/libimaevm.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 175 insertions(+), 17 deletions(-)
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
> index 101cd407e05d..c7c8c8cf6e89 100644
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
> @@ -731,33 +732,97 @@ static int cmd_sign_ima(struct command *cmd)
>   	return do_cmd(cmd, sign_ima_file);
>   }
>   
> +/*
> + * Sign file hash(es) provided in the format as produced by either
> + * sha*sum or "fsverity digest".
> + *
> + * sha*sum format: <hash> <pathname>
> + * fsverity digest format: <algo>:<hash> <pathname>
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
> +	int siglen, algolen = 0, hashlen = 0;
> +	char *line = NULL, *token, *hashp;
> +	size_t line_len = 0;
>   	const char *key;
> -	char *token, *line = NULL;
> -	int hashlen = 0;
> -	size_t line_len;
> +	char algo[7];	/* Current maximum fsverity hash algo name length */
>   	ssize_t len;
> -	unsigned char hash[MAX_DIGEST_SIZE];
> -	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
> -	int siglen;
> +	int ret;
>   
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
> +			if (hashp)	/* pointer to the delimiter */
> +				algolen = hashp - line;
> +
> +			if (!hashp || algolen <= 0 ||
> +			    algolen >= sizeof(algo)) {
> +				log_err("Missing/invalid fsverity hash algorithm\n");
> +				continue;
> +			}
> +
> +			strncpy(algo, line, algolen);
> +			algo[algolen] = '\0';	/* Nul terminate algorithm */
> +
> +			hashp++;
> +			token = strpbrk(line, ", \t");
> +			hashlen = token - hashp;
> +			if (hashlen <= 0) {
> +				log_err("Missing fsverity hash\n");
> +				continue;
> +			}
> +
> +			assert(hashlen / 2 <= sizeof(hash));
> +			hex2bin(hash, hashp, hashlen / 2);
> +
> +			ret = calc_hash_sigv3(IMA_VERITY_DIGSIG, algo, hash,
> +					      sigv3_hash);
> +			if (ret < 0 || ret == 1) {
> +				log_info("Failure to calculate fs-verity hash\n");
> +				continue;
> +			}
> +
> +			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
> +					   key, NULL, sig + 1);
> +
> +			sig[0] = IMA_VERITY_DIGSIG;
> +			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
> +		} else {
> +			token = strpbrk(line, ", \t");
> +			hashlen = token ? token - line : strlen(line);
> +			assert(hashlen / 2 <= sizeof(hash));
> +			hex2bin(hash, line, hashlen / 2);
> +
> +			siglen = sign_hash(imaevm_params.hash_algo, hash,
> +					   hashlen / 2, key, NULL, sig + 1);
> +			sig[0] = EVM_IMA_XATTR_DIGSIG;
> +		}
>   
> -		assert(hashlen / 2 <= sizeof(hash));
> -		hex2bin(hash, line, hashlen / 2);
> -		siglen = sign_hash(imaevm_params.hash_algo, hash, hashlen / 2,
> -				 key, NULL, sig + 1);
>   		if (siglen <= 1)
>   			return siglen;
>   		assert(siglen < sizeof(sig));
> @@ -2568,7 +2633,7 @@ struct command cmds[] = {
>   	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
>   	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
> -	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
> +	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass [password]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},

In the readme change above the [--pass password] above looks right. 
While you are at it you could remove the additional '[' here.

>   #ifdef DEBUG
>   	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
>   #endif
> @@ -2608,6 +2673,7 @@ static struct option opts[] = {
>   	{"verify-bank", 2, 0, 143},
>   	{"keyid", 1, 0, 144},
>   	{"keyid-from-cert", 1, 0, 145},
> +	{"veritysig", 0, 0, 146},
>   	{}
>   
>   };
> @@ -2838,6 +2904,9 @@ int main(int argc, char *argv[])
>   			}
>   			imaevm_params.keyid = keyid;
>   			break;
> +		case 146:
> +			veritysig = 1;
> +			break;
>   		case '?':
>   			exit(1);
>   			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 0d53a0232ae4..afcf1e042014 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -93,6 +93,7 @@ enum evm_ima_xattr_type {
>   	EVM_IMA_XATTR_DIGSIG,
>   	IMA_XATTR_DIGEST_NG,
>   	EVM_XATTR_PORTABLE_DIGSIG,
> +	IMA_VERITY_DIGSIG,
>   };
>   
>   struct h_misc {
> @@ -138,7 +139,8 @@ enum digest_algo {
>   
>   enum digsig_version {
>   	DIGSIG_VERSION_1 = 1,
> -	DIGSIG_VERSION_2
> +	DIGSIG_VERSION_2,
> +	DIGSIG_VERSION_3	/* hash of ima_file_id struct (portion used) */
>   };
>   
>   struct pubkey_hdr {
> @@ -233,5 +235,6 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsig
>   void init_public_keys(const char *keyfiles);
>   int imaevm_hash_algo_from_sig(unsigned char *sig);
>   const char *imaevm_hash_algo_by_id(int algo);
> +int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
>   
>   #endif
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index a4f2ec40684d..af145bd62ac9 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -497,6 +497,91 @@ err:
>   	return ret;
>   }
>   
> +#define HASH_MAX_DIGESTSIZE 512

SHA 512 has 64 bytes, which seems to be the biggest hash. Also the 
kernel defines this to 64... 512 seems excessive.

> +
> +struct ima_file_id {
> +	__u8 hash_type;		/* xattr type [enum evm_ima_xattr_type] */
> +	__u8 hash_algorithm;	/* Digest algorithm [enum hash_algo] */
> +	__u8 hash[HASH_MAX_DIGESTSIZE];
> +} __packed;
> +
> +/*
> + * Calculate the signature format version 3 hash based on the portion
> + * of the ima_file_id structure used, not the entire structure.
> + *
> + * For openssl errors return 1, other errors return -EINVAL.
> + */
> +int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
> +		    const unsigned char *in_hash, unsigned char *out_hash)
> +{
> +	struct ima_file_id file_id = { .hash_type = IMA_VERITY_DIGSIG };
> +	uint8_t *data = (uint8_t *) &file_id;
> +
> +	const EVP_MD *md;
> +	EVP_MD_CTX *pctx;
> +	unsigned int mdlen;
> +	int err;
> +#if OPENSSL_VERSION_NUMBER < 0x10100000
> +	EVP_MD_CTX ctx;
> +	pctx = &ctx;
> +#else
> +	pctx = EVP_MD_CTX_new();
> +#endif
> +	int hash_algo;
> +	int hash_size;
> +	unsigned int unused;
> +
> +	if (type != IMA_VERITY_DIGSIG) {
> +		log_err("Only fsverity supports signature format v3 (sigv3)\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
> +		log_err("Hash algorithm %s not supported\n", algo);
> +		return -EINVAL;
> +	}
> +	file_id.hash_algorithm = hash_algo;
> +
> +	md = EVP_get_digestbyname(algo);
> +	if (!md) {
> +		log_err("EVP_get_digestbyname(%s) failed\n", algo);
> +		err = 1;
> +		goto err;
> +	}
> +
> +	hash_size = EVP_MD_size(md);
> +	memcpy(file_id.hash, in_hash, hash_size);
> +
> +	err = EVP_DigestInit(pctx, md);
> +	if (!err) {
> +		log_err("EVP_DigestInit() failed\n");
> +		err = 1;
> +		goto err;
> +	}
> +
> +	unused = HASH_MAX_DIGESTSIZE - hash_size;
> +	if (!EVP_DigestUpdate(pctx, data, sizeof(file_id) - unused)) {
> +		log_err("EVP_DigestUpdate() failed\n");
> +		err = 1;
> +		goto err;
> +	}
> +
> +	err = EVP_DigestFinal(pctx, out_hash, &mdlen);
> +	if (!err) {
> +		log_err("EVP_DigestFinal() failed\n");
> +		err = 1;
> +		goto err;
> +	}
> +	err = mdlen;
> +err:
> +	if (err == 1)
> +		output_openssl_errors();
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	EVP_MD_CTX_free(pctx);
> +#endif
> +	return err;
> +}
> +
>   int imaevm_get_hash_algo(const char *algo)
>   {
>   	int i;

