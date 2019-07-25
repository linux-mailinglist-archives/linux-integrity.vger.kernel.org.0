Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0847514B
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfGYOfQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 10:35:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728944AbfGYOfQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 10:35:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PEZ6Zs134369
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 10:35:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tycsgn2w2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 10:35:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Jul 2019 15:34:38 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 15:34:36 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PEYKOw32768432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 14:34:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C20111C111;
        Thu, 25 Jul 2019 14:34:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 827C911C114;
        Thu, 25 Jul 2019 14:34:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 14:34:34 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: Namespace some too generic object
 names
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Thu, 25 Jul 2019 10:34:23 -0400
In-Reply-To: <20190725141114.28415-1-vt@altlinux.org>
References: <20190725141114.28415-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072514-0008-0000-0000-00000300CA89
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072514-0009-0000-0000-0000226E5F7C
Message-Id: <1564065263.4245.122.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250170
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-25 at 17:11 +0300, Vitaly Chikunov wrote:
> Prefix `dump', `do_dump', and `params' with `imaevm_' to avoid colliding
> with other global symbols.
> Also, rename `libevm_' to `libimaevm_`, only used with `params'.
> Additionally, rename `dump' into `hexdump'.
> Finally, rename `get_hash_algo' to `imaevm_get_hash_algo' as suggested by
> Mimi Zohar.
> 
> Lines that became too long are splitted, indent corrected. No code changes.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Looks good, thanks!  At this point all 3 patches are applied, in the
order you indicated.  Just waiting to see if Bruno or Petr want to add
their tag to this version, before pushing it out.

thanks!

Mimi

> ---
> Changes from 1:
> - Change prefix from ima_ to imaevm_.
> - Add prefix to get_hash_algo.
> - This should be applied over "[PATCH 2/2] ima-evm-utils: Show used hash algo
>   in verbose mode".
> 
>  src/evmctl.c    | 109 +++++++++++++++++++++++++++++---------------------------
>  src/imaevm.h    |  16 +++++----
>  src/libimaevm.c |  46 ++++++++++++------------
>  3 files changed, 89 insertions(+), 82 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 75dd163..b02be8b 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -403,9 +403,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		return -1;
>  	}
> 
> -	md = EVP_get_digestbyname(params.hash_algo);
> +	md = EVP_get_digestbyname(imaevm_params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> +		log_err("EVP_get_digestbyname(%s) failed\n",
> +			imaevm_params.hash_algo);
>  		return 1;
>  	}
> 
> @@ -549,7 +550,7 @@ static int sign_evm(const char *file, const char *key)
>  		return len;
>  	assert(len <= sizeof(hash));
> 
> -	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
>  	if (len <= 1)
>  		return len;
>  	assert(len < sizeof(sig));
> @@ -564,8 +565,8 @@ static int sign_evm(const char *file, const char *key)
>  	if (evm_immutable)
>  		sig[1] = 3; /* immutable signature version */
> 
> -	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(sig, len);
> +	if (sigdump || imaevm_params.verbose >= LOG_INFO)
> +		imaevm_hexdump(sig, len);
> 
>  	if (xattr) {
>  		err = lsetxattr(file, xattr_evm, sig, len, 0);
> @@ -582,10 +583,10 @@ static int hash_ima(const char *file)
>  {
>  	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
>  	int len, err, offset;
> -	int algo = get_hash_algo(params.hash_algo);
> +	int algo = imaevm_get_hash_algo(imaevm_params.hash_algo);
> 
>  	if (algo < 0) {
> -		log_err("Unknown hash algo: %s\n", params.hash_algo);
> +		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
>  		return -1;
>  	}
>  	if (algo > PKEY_HASH_SHA1) {
> @@ -604,11 +605,11 @@ static int hash_ima(const char *file)
> 
>  	len += offset;
> 
> -	if (params.verbose >= LOG_INFO)
> -		log_info("hash(%s): ", params.hash_algo);
> +	if (imaevm_params.verbose >= LOG_INFO)
> +		log_info("hash(%s): ", imaevm_params.hash_algo);
> 
> -	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(hash, len);
> +	if (sigdump || imaevm_params.verbose >= LOG_INFO)
> +		imaevm_hexdump(hash, len);
> 
>  	if (xattr) {
>  		err = lsetxattr(file, xattr_ima, hash, len, 0);
> @@ -632,7 +633,7 @@ static int sign_ima(const char *file, const char *key)
>  		return len;
>  	assert(len <= sizeof(hash));
> 
> -	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
>  	if (len <= 1)
>  		return len;
>  	assert(len < sizeof(sig));
> @@ -641,8 +642,8 @@ static int sign_ima(const char *file, const char *key)
>  	len++;
>  	sig[0] = EVM_IMA_XATTR_DIGSIG;
> 
> -	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(sig, len);
> +	if (sigdump || imaevm_params.verbose >= LOG_INFO)
> +		imaevm_hexdump(sig, len);
> 
>  	if (sigfile)
>  		bin2file(file, "sig", sig, len);
> @@ -722,7 +723,7 @@ static int sign_ima_file(const char *file)
>  {
>  	const char *key;
> 
> -	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
> +	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> 
>  	return sign_ima(file, key);
>  }
> @@ -743,7 +744,7 @@ static int cmd_sign_hash(struct command *cmd)
>  	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
>  	int siglen;
> 
> -	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
> +	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> 
>  	/* support reading hash (eg. output of shasum) */
>  	while ((len = getline(&line, &line_len, stdin)) > 0) {
> @@ -757,7 +758,7 @@ static int cmd_sign_hash(struct command *cmd)
> 
>  		assert(hashlen / 2 <= sizeof(hash));
>  		hex2bin(hash, line, hashlen / 2);
> -		siglen = sign_hash(params.hash_algo, hash, hashlen/2,
> +		siglen = sign_hash(imaevm_params.hash_algo, hash, hashlen / 2,
>  				 key, NULL, sig + 1);
>  		if (siglen <= 1)
>  			return siglen;
> @@ -783,7 +784,7 @@ static int sign_evm_path(const char *file)
>  	const char *key;
>  	int err;
> 
> -	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
> +	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> 
>  	if (digsig) {
>  		err = sign_ima(file, key);
> @@ -842,13 +843,13 @@ static int cmd_verify_evm(struct command *cmd)
>  		return -1;
>  	}
> 
> -	if (params.keyfile)	/* Support multiple public keys */
> -		init_public_keys(params.keyfile);
> -	else			/* assume read pubkey from x509 cert */
> +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> +		init_public_keys(imaevm_params.keyfile);
> +	else				/* assume read pubkey from x509 cert */
>  		init_public_keys("/etc/keys/x509_evm.der");
> 
>  	err = verify_evm(file);
> -	if (!err && params.verbose >= LOG_INFO)
> +	if (!err && imaevm_params.verbose >= LOG_INFO)
>  		log_info("%s: verification is OK\n", file);
>  	return err;
>  }
> @@ -888,9 +889,9 @@ static int cmd_verify_ima(struct command *cmd)
>  	char *file = g_argv[optind++];
>  	int err;
> 
> -	if (params.keyfile)	/* Support multiple public keys */
> -		init_public_keys(params.keyfile);
> -	else			/* assume read pubkey from x509 cert */
> +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> +		init_public_keys(imaevm_params.keyfile);
> +	else				/* assume read pubkey from x509 cert */
>  		init_public_keys("/etc/keys/x509_evm.der");
> 
>  	errno = 0;
> @@ -902,7 +903,7 @@ static int cmd_verify_ima(struct command *cmd)
> 
>  	do {
>  		err = verify_ima(file);
> -		if (!err && params.verbose >= LOG_INFO)
> +		if (!err && imaevm_params.verbose >= LOG_INFO)
>  			log_info("%s: verification is OK\n", file);
>  	} while ((file = g_argv[optind++]));
>  	return err;
> @@ -917,15 +918,15 @@ static int cmd_convert(struct command *cmd)
>  	uint8_t keyid[8];
>  	RSA *key;
> 
> -	params.x509 = 0;
> +	imaevm_params.x509 = 0;
> 
>  	inkey = g_argv[optind++];
>  	if (!inkey) {
> -		inkey = params.x509 ? "/etc/keys/x509_evm.der" :
> -				      "/etc/keys/pubkey_evm.pem";
> +		inkey = imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
> +					     "/etc/keys/pubkey_evm.pem";
>  	}
> 
> -	key = read_pub_key(inkey, params.x509);
> +	key = read_pub_key(inkey, imaevm_params.x509);
>  	if (!key)
>  		return 1;
> 
> @@ -949,8 +950,8 @@ static int cmd_import(struct command *cmd)
> 
>  	inkey = g_argv[optind++];
>  	if (!inkey) {
> -		inkey = params.x509 ? "/etc/keys/x509_evm.der" :
> -				      "/etc/keys/pubkey_evm.pem";
> +		inkey = imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
> +					     "/etc/keys/pubkey_evm.pem";
>  	} else
>  		ring = g_argv[optind++];
> 
> @@ -979,8 +980,8 @@ static int cmd_import(struct command *cmd)
>  		}
>  	}
> 
> -	if (params.x509) {
> -		EVP_PKEY *pkey = read_pub_pkey(inkey, params.x509);
> +	if (imaevm_params.x509) {
> +		EVP_PKEY *pkey = read_pub_pkey(inkey, imaevm_params.x509);
> 
>  		if (!pkey)
>  			return 1;
> @@ -992,7 +993,7 @@ static int cmd_import(struct command *cmd)
>  		calc_keyid_v2((uint32_t *)keyid, name, pkey);
>  		EVP_PKEY_free(pkey);
>  	} else {
> -		RSA *key = read_pub_key(inkey, params.x509);
> +		RSA *key = read_pub_key(inkey, imaevm_params.x509);
> 
>  		if (!key)
>  			return 1;
> @@ -1003,7 +1004,8 @@ static int cmd_import(struct command *cmd)
> 
>  	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
> 
> -	id = add_key(params.x509 ? "asymmetric" : "user", params.x509 ? NULL : name, pub, len, id);
> +	id = add_key(imaevm_params.x509 ? "asymmetric" : "user",
> +		     imaevm_params.x509 ? NULL : name, pub, len, id);
>  	if (id < 0) {
>  		log_err("add_key failed\n");
>  		err = id;
> @@ -1011,7 +1013,7 @@ static int cmd_import(struct command *cmd)
>  		log_info("keyid: %d\n", id);
>  		printf("%d\n", id);
>  	}
> -	if (params.x509)
> +	if (imaevm_params.x509)
>  		free(pub);
>  	return err;
>  }
> @@ -1123,9 +1125,10 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  		goto out;
>  	}
> 
> -	md = EVP_get_digestbyname(params.hash_algo);
> +	md = EVP_get_digestbyname(imaevm_params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> +		log_err("EVP_get_digestbyname(%s) failed\n",
> +			imaevm_params.hash_algo);
>  		goto out;
>  	}
> 
> @@ -1247,7 +1250,7 @@ static int cmd_hmac_evm(struct command *cmd)
>  		return -1;
>  	}
> 
> -	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
> +	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> 
>  	if (digsig) {
>  		err = sign_ima(file, key);
> @@ -1588,7 +1591,7 @@ void ima_ng_show(struct template_entry *entry)
>  	}
> 
>  	/* ascii_runtime_measurements */
> -	if (params.verbose > LOG_INFO) {
> +	if (imaevm_params.verbose > LOG_INFO) {
>  		log_info("%d ", entry->header.pcr);
>  		log_dump_n(entry->header.digest, sizeof(entry->header.digest));
>  		log_info(" %s %s", entry->name, algo);
> @@ -1601,7 +1604,7 @@ void ima_ng_show(struct template_entry *entry)
>  	}
> 
>  	if (sig) {
> -		if (params.verbose > LOG_INFO) {
> +		if (imaevm_params.verbose > LOG_INFO) {
>  			log_info(" ");
>  			log_dump(sig, sig_len);
>  		}
> @@ -1610,10 +1613,10 @@ void ima_ng_show(struct template_entry *entry)
>  						   digest, digest_len);
>  		else
>  			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
> -		if (!err && params.verbose > LOG_INFO)
> +		if (!err && imaevm_params.verbose > LOG_INFO)
>  			log_info("%s: verification is OK\n", path);
>  	} else {
> -		if (params.verbose > LOG_INFO)
> +		if (imaevm_params.verbose > LOG_INFO)
>  			log_info("\n");
>  	}
> 
> @@ -1648,9 +1651,9 @@ static int ima_measurement(const char *file)
>  		return -1;
>  	}
> 
> -	if (params.keyfile)	/* Support multiple public keys */
> -		init_public_keys(params.keyfile);
> -	else			/* assume read pubkey from x509 cert */
> +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> +		init_public_keys(imaevm_params.keyfile);
> +	else				/* assume read pubkey from x509 cert */
>  		init_public_keys("/etc/keys/x509_evm.der");
> 
>  	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
> @@ -1959,7 +1962,7 @@ int main(int argc, char *argv[])
>  			exit(0);
>  			break;
>  		case 'v':
> -			params.verbose++;
> +			imaevm_params.verbose++;
>  			break;
>  		case 'd':
>  			digest = 1;
> @@ -1973,13 +1976,13 @@ int main(int argc, char *argv[])
>  			sigdump = 1;
>  			break;
>  		case 'a':
> -			params.hash_algo = optarg;
> +			imaevm_params.hash_algo = optarg;
>  			break;
>  		case 'p':
>  			if (optarg)
> -				params.keypass = optarg;
> +				imaevm_params.keypass = optarg;
>  			else
> -				params.keypass = get_password();
> +				imaevm_params.keypass = get_password();
>  			break;
>  		case 'f':
>  			sigfile = 1;
> @@ -1990,10 +1993,10 @@ int main(int argc, char *argv[])
>  				hmac_flags |= HMAC_FLAG_NO_UUID;
>  			break;
>  		case '1':
> -			params.x509 = 0;
> +			imaevm_params.x509 = 0;
>  			break;
>  		case 'k':
> -			params.keyfile = optarg;
> +			imaevm_params.keyfile = optarg;
>  			break;
>  		case 'i':
>  			if (evm_portable)
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 0414433..b881d92 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -50,8 +50,10 @@
>  #include <openssl/rsa.h>
> 
>  #ifdef USE_FPRINTF
> -#define do_log(level, fmt, args...)	({ if (level <= params.verbose) fprintf(stderr, fmt, ##args); })
> -#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) do_dump(stderr, p, len, cr); })
> +#define do_log(level, fmt, args...)	\
> +	({ if (level <= imaevm_params.verbose) fprintf(stderr, fmt, ##args); })
> +#define do_log_dump(level, p, len, cr)	\
> +	({ if (level <= imaevm_params.verbose) imaevm_do_hexdump(stderr, p, len, cr); })
>  #else
>  #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
>  #define do_log_dump(level, p, len, cr)
> @@ -188,7 +190,7 @@ struct signature_v2_hdr {
>  	uint8_t sig[0];		/* signature payload */
>  } __packed;
> 
> -struct libevm_params {
> +struct libimaevm_params {
>  	int verbose;
>  	int x509;
>  	const char *hash_algo;
> @@ -204,12 +206,12 @@ struct RSA_ASN1_template {
>  #define	NUM_PCRS 20
>  #define DEFAULT_PCR 10
> 
> -extern struct libevm_params params;
> +extern struct libimaevm_params imaevm_params;
> 
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr);
> -void dump(const void *ptr, int len);
> +void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
> +void imaevm_hexdump(const void *ptr, int len);
>  int ima_calc_hash(const char *file, uint8_t *hash);
> -int get_hash_algo(const char *algo);
> +int imaevm_get_hash_algo(const char *algo);
>  RSA *read_pub_key(const char *keyfile, int x509);
>  EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 11dbf11..a582872 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -81,7 +81,7 @@ const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };
> 
> -struct libevm_params params = {
> +struct libimaevm_params imaevm_params = {
>  	.verbose = LOG_INFO - 1,
>  	.x509 = 1,
>  	.hash_algo = "sha1",
> @@ -89,7 +89,7 @@ struct libevm_params params = {
> 
>  static void __attribute__ ((constructor)) libinit(void);
> 
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr)
> +void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr)
>  {
>  	int i;
>  	uint8_t *data = (uint8_t *) ptr;
> @@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bool cr)
>  		fprintf(fp, "\n");
>  }
> 
> -void dump(const void *ptr, int len)
> +void imaevm_hexdump(const void *ptr, int len)
>  {
> -	do_dump(stdout, ptr, len, true);
> +	imaevm_do_hexdump(stdout, ptr, len, true);
>  }
> 
>  const char *get_hash_algo_by_id(int algo)
> @@ -258,9 +258,10 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>  		goto err;
>  	}
> 
> -	md = EVP_get_digestbyname(params.hash_algo);
> +	md = EVP_get_digestbyname(imaevm_params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> +		log_err("EVP_get_digestbyname(%s) failed\n",
> +			imaevm_params.hash_algo);
>  		err = 1;
>  		goto err;
>  	}
> @@ -500,8 +501,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  	const EVP_MD *md;
>  	const char *st;
> 
> -	if (params.verbose > LOG_INFO) {
> -		log_info("hash(%s): ", params.hash_algo);
> +	if (imaevm_params.verbose > LOG_INFO) {
> +		log_info("hash(%s): ", imaevm_params.hash_algo);
>  		log_dump(hash, size);
>  	}
> 
> @@ -521,7 +522,7 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  	if (!EVP_PKEY_verify_init(ctx))
>  		goto err;
>  	st = "EVP_get_digestbyname";
> -	if (!(md = EVP_get_digestbyname(params.hash_algo)))
> +	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
>  		goto err;
>  	st = "EVP_PKEY_CTX_set_signature_md";
>  	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> @@ -550,7 +551,7 @@ err:
>  	return ret;
>  }
> 
> -int get_hash_algo(const char *algo)
> +int imaevm_get_hash_algo(const char *algo)
>  {
>  	int i;
> 
> @@ -609,7 +610,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
>  		const char *key = NULL;
> 
>  		/* Read pubkey from RSA key */
> -		if (!params.keyfile)
> +		if (!imaevm_params.keyfile)
>  			key = "/etc/keys/pubkey_evm.pem";
>  		return verify_hash_v1(file, hash, size, sig, siglen, key);
>  	} else if (sig[0] == DIGSIG_VERSION_2) {
> @@ -635,7 +636,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
>  		return -1;
>  	}
>  	/* Use hash algorithm as retrieved from signature */
> -	params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
> +	imaevm_params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
> 
>  	/*
>  	 * Validate the signature based on the digest included in the
> @@ -707,7 +708,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
>  	id = __be64_to_cpup((__be64 *) keyid);
>  	sprintf(str, "%llX", (unsigned long long)id);
> 
> -	if (params.verbose > LOG_INFO)
> +	if (imaevm_params.verbose > LOG_INFO)
>  		log_info("keyid-v1: %s\n", str);
>  }
> 
> @@ -735,7 +736,7 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
>  	log_debug_dump(keyid, 4);
>  	sprintf(str, "%x", __be32_to_cpup(keyid));
> 
> -	if (params.verbose > LOG_INFO)
> +	if (imaevm_params.verbose > LOG_INFO)
>  		log_info("keyid: %s\n", str);
> 
>  	X509_PUBKEY_free(pk);
> @@ -825,7 +826,7 @@ int sign_hash_v1(const char *hashalgo, const unsigned char *hash, int size, cons
>  	log_info("hash(%s): ", hashalgo);
>  	log_dump(hash, size);
> 
> -	key = read_priv_key(keyfile, params.keypass);
> +	key = read_priv_key(keyfile, imaevm_params.keypass);
>  	if (!key)
>  		return -1;
> 
> @@ -908,17 +909,17 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
>  		return -1;
>  	}
> 
> -	log_info("hash(%s): ", params.hash_algo);
> +	log_info("hash(%s): ", imaevm_params.hash_algo);
>  	log_dump(hash, size);
> 
> -	pkey = read_priv_pkey(keyfile, params.keypass);
> +	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
>  	if (!pkey)
>  		return -1;
> 
>  	hdr = (struct signature_v2_hdr *)sig;
>  	hdr->version = (uint8_t) DIGSIG_VERSION_2;
> 
> -	hdr->hash_algo = get_hash_algo(algo);
> +	hdr->hash_algo = imaevm_get_hash_algo(algo);
>  	if (hdr->hash_algo == -1) {
>  		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
>  		return -1;
> @@ -934,7 +935,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
>  	if (!EVP_PKEY_sign_init(ctx))
>  		goto err;
>  	st = "EVP_get_digestbyname";
> -	if (!(md = EVP_get_digestbyname(params.hash_algo)))
> +	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
>  		goto err;
>  	st = "EVP_PKEY_CTX_set_signature_md";
>  	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> @@ -965,10 +966,11 @@ err:
>  int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
>  {
>  	if (keypass)
> -		params.keypass = keypass;
> +		imaevm_params.keypass = keypass;
> 
> -	return params.x509 ? sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
> -			     sign_hash_v1(hashalgo, hash, size, keyfile, sig);
> +	return imaevm_params.x509 ?
> +		sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
> +		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
>  }
> 
>  static void libinit()

