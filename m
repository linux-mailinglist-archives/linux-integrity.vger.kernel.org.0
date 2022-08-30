Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298A5A62F1
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiH3MMW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiH3MMV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 08:12:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30454FBA72
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 05:12:20 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UC2sYY026228;
        Tue, 30 Aug 2022 12:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TZdMmcrkLOvjEXYhiVcDFKHnC3pHaZU+KLQ80HiXaIU=;
 b=GZBWDg2YXprth3MZ1KfRk0RWtHvWwOtvW2ySx2sL+FCiJ/EEbeMtLHf4LLgCGmOZWgQH
 F+NVgz6qGyZ3MmYgrZHwV9PyHH6Um6RI1Z46mMc0aRSWeAqS3R5N4cpLSReeDcitkcvv
 FtmhAGKGCJNfPHYKoKQgTiovm0cxnrBf0AEf4F3EXK/xNW0eOsXzGyM+VAMcEUrQF3AR
 ZqN/GueZXKXLA20G4KspgGWXWfVoEpjCvkYs5G6HbBHAwwPMl+/ob0Log6SnTmitL/7l
 lCmegOXnIOUYfZd3GDBPfzCKA956ri/w0VUY0pVDsL8B75xEyrLQlv/xh+D7kPRKN5PF jA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9j7b0e21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 12:12:12 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27UC76KX005925;
        Tue, 30 Aug 2022 12:12:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3j7aw9bhef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 12:12:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27UCCBAD47317502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 12:12:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6143D112061;
        Tue, 30 Aug 2022 12:12:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447AC112063;
        Tue, 30 Aug 2022 12:12:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 12:12:11 +0000 (GMT)
Message-ID: <6958893d-d370-6906-0862-6c52b9ce701f@linux.ibm.com>
Date:   Tue, 30 Aug 2022 08:12:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH ima-evm-utils 04/11] Deprecate IMA signature version 1
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-5-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220830005936.189922-5-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MmYtKH6UZa_23KJHjnnD8Wzq9LTprpUU
X-Proofpoint-GUID: MmYtKH6UZa_23KJHjnnD8Wzq9LTprpUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_05,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208300059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/29/22 20:59, Mimi Zohar wrote:
> The original IMA file signatures were based on a SHA1 hash.  Kernel
> support for other hash algorithms was subsequently upstreamed.  Deprecate
> "--rsa" support.
> 
> Define "--enable-sigv1" option to configure signature v1 support.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   configure.ac           |  6 ++++++
>   src/Makefile.am        | 10 ++++++++++
>   src/evmctl.c           | 16 ++++++++++++----
>   src/libimaevm.c        | 24 ++++++++++++++++++++++--
>   tests/sign_verify.test | 18 ++++++++++++------
>   5 files changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 9d3b23ff8def..dc666f2bb1fa 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -49,6 +49,11 @@ AC_ARG_ENABLE([openssl_conf],
>   		AC_DEFINE(DISABLE_OPENSSL_CONF, 1, [Define to disable loading of openssl config by evmctl.])
>   	      fi], [enable_openssl_conf=yes])
>   
> +AC_ARG_ENABLE(sigv1,
> +	      AS_HELP_STRING([--enable-sigv1], [Build ima-evm-utils with signature v1 support]))
> +	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
> +	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
> +
>   #debug support - yes for a while
>   PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>   if test $pkg_cv_enable_debug = yes; then
> @@ -83,5 +88,6 @@ echo	"   openssl-conf: $enable_openssl_conf"
>   echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
>   echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
>   echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
> +echo    "         sigv1:  $enable_sigv1"
>   echo	"            doc: $have_doc"
>   echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 396496bb439d..90c7249020cf 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -7,6 +7,10 @@ libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>   libimaevm_la_LDFLAGS = -version-info 3:0:0
>   libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
>   
> +if CONFIG_SIGV1
> +libimaevm_la_CFLAGS = -DCONFIG_SIGV1
> +endif
> +
>   include_HEADERS = imaevm.h
>   
>   nodist_libimaevm_la_SOURCES = hash_info.h
> @@ -22,6 +26,12 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>   evmctl_LDFLAGS = $(LDFLAGS_READLINE)
>   evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
>   
> +# Enable IMA signature version 1
> +if CONFIG_SIGV1
> +evmctl_CFLAGS = -DCONFIG_SIGV1
> +endif
> +
> +
>   # USE_PCRTSS uses the Intel TSS
>   if USE_PCRTSS
>    evmctl_SOURCES += pcr_tss.c
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 76e2561798fa..621136b5b85f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -987,7 +987,6 @@ static int cmd_verify_ima(struct command *cmd)
>   			init_public_keys("/etc/keys/x509_evm.der");
>   	}
>   
> -	errno = 0;
>   	if (!file) {
>   		log_err("Parameters missing\n");
>   		print_usage(cmd);
> @@ -1006,6 +1005,7 @@ static int cmd_verify_ima(struct command *cmd)
>   
>   static int cmd_convert(struct command *cmd)
>   {
> +#if CONFIG_SIGV1
>   	char *inkey;
>   	unsigned char _pub[1024], *pub = _pub;
>   	int len, err = 0;
> @@ -1033,6 +1033,8 @@ static int cmd_convert(struct command *cmd)
>   
>   	RSA_free(key);
>   	return err;
> +#endif
> +	return 77;
>   }
>   
>   static int cmd_import(struct command *cmd)
> @@ -1088,6 +1090,7 @@ static int cmd_import(struct command *cmd)
>   		calc_keyid_v2((uint32_t *)keyid, name, pkey);
>   		EVP_PKEY_free(pkey);
>   	} else {
> +#if CONFIG_SIGV1
>   		RSA *key = read_pub_key(inkey, imaevm_params.x509);
>   
>   		if (!key)
> @@ -1095,6 +1098,10 @@ static int cmd_import(struct command *cmd)
>   		len = key2bin(key, pub);
>   		calc_keyid_v1(keyid, name, pub, len);
>   		RSA_free(key);
> +#else
> +		log_info("Importing public RSA key not supported\n");

.. key *is* not supported

> +		return 1;
> +#endif
>   	}
>   
>   	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
> @@ -2598,7 +2605,8 @@ static void usage(void)
>   		"  -d, --imahash      make IMA hash\n"
>   		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
>   		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
> -		"      --rsa          use RSA key type and signing scheme v1\n"
> +
> +		"      --rsa          use RSA key type and signing scheme v1 (deprecated)\n"
>   		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
>   		"                     or a pkcs11 URI\n"
>   		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
> @@ -2637,8 +2645,8 @@ static void usage(void)
>   struct command cmds[] = {
>   	{"--version", NULL, 0, ""},
>   	{"help", cmd_help, 0, "<command>"},
> -	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring.\n"},
> -	{"convert", cmd_convert, 0, "key", "convert public key into the keyring.\n"},
> +	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring. (deprecated)\n"},
> +	{"convert", cmd_convert, 0, "key", "convert public key into the keyring. (deprecated)\n"},

Unless CONFIG_SIGV1 is defined it looks like cmd_convert doesn't do 
anything anymore except return 77? In this case you could just ifdef 
this command out.

>   	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass [password] file", "Sign file metadata.\n"},
>   	{"verify", cmd_verify_evm, 0, "file", "Verify EVM signature (for debugging).\n"},
>   	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass [password] file", "Make file content signature.\n"},
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index e4b62b4989b2..cb815f953a80 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -294,8 +294,9 @@ out:
>   
>   RSA *read_pub_key(const char *keyfile, int x509)
>   {
> +	RSA *key = NULL;
> +#if CONFIG_SIGV1
>   	EVP_PKEY *pkey;
> -	RSA *key;
>   
>   	pkey = read_pub_pkey(keyfile, x509);
>   	if (!pkey)
> @@ -307,9 +308,11 @@ RSA *read_pub_key(const char *keyfile, int x509)
>   		output_openssl_errors();
>   		return NULL;
>   	}
> +#endif
>   	return key;
>   }
>   
> +#if CONFIG_SIGV1
>   static int verify_hash_v1(const char *file, const unsigned char *hash, int size,
>   			  unsigned char *sig, int siglen, const char *keyfile)
>   {
> @@ -351,6 +354,7 @@ static int verify_hash_v1(const char *file, const unsigned char *hash, int size,
>   
>   	return 0;
>   }
> +#endif
>   
>   struct public_key_entry {
>   	struct public_key_entry *next;
> @@ -686,6 +690,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
>   {
>   	/* Get signature type from sig header */
>   	if (sig[1] == DIGSIG_VERSION_1) {
> +#if CONFIG_SIGV1
>   		const char *key = NULL;
>   
>   		/* Read pubkey from RSA key */
> @@ -695,6 +700,10 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
>   			key = imaevm_params.keyfile;
>   		return verify_hash_v1(file, hash, size, sig + 1, siglen - 1,
>   					 key);
> +#else
> +		log_info("Signature version 1 deprecated.");
> +		return -1;
> +#endif
>   	} else if (sig[1] == DIGSIG_VERSION_2) {
>   		return verify_hash_v2(file, hash, size, sig, siglen);
>   	} else if (sig[1] == DIGSIG_VERSION_3) {
> @@ -747,6 +756,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
>    */
>   int key2bin(RSA *key, unsigned char *pub)
>   {
> +#if CONFIG_SIGV1
>   	int len, b, offset = 0;
>   	struct pubkey_hdr *pkh = (struct pubkey_hdr *)pub;
>   	const BIGNUM *n, *e;
> @@ -781,10 +791,14 @@ int key2bin(RSA *key, unsigned char *pub)
>   	offset += len;
>   
>   	return offset;
> +#else
> +	return 77; /* SKIP */
> +#endif
>   }

This function has no callers if CONFIG_SIGV1 is not set and otherwise 
it's useless also if someone was a user of the library only. I would 
consider ifdef'ing the whole function...

>   
>   void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len)
>   {
> +#if CONFIG_SIGV1
>   	uint8_t sha1[SHA_DIGEST_LENGTH];
>   	uint64_t id;
>   
> @@ -799,6 +813,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
>   
>   	if (imaevm_params.verbose > LOG_INFO)
>   		log_info("keyid-v1: %s\n", str);
> +#endif
>   }
>   
>   /*
> @@ -990,10 +1005,11 @@ err_engine:
>   	return NULL;
>   }
>   
> +#if CONFIG_SIGV1
>   static RSA *read_priv_key(const char *keyfile, const char *keypass)
>   {
> +	RSA *key = NULL;
>   	EVP_PKEY *pkey;
> -	RSA *key;
>   
>   	pkey = read_priv_pkey(keyfile, keypass);
>   	if (!pkey)
> @@ -1018,10 +1034,12 @@ static int get_hash_algo_v1(const char *algo)
>   
>   	return -1;
>   }
> +#endif
>   
>   static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
>   			int size, const char *keyfile, unsigned char *sig)
>   {
> +#if CONFIG_SIGV1
>   	int len = -1, hashalgo_idx;
>   	SHA_CTX ctx;
>   	unsigned char pub[1024];
> @@ -1099,6 +1117,8 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
>   out:
>   	RSA_free(key);
>   	return len;
> +#endif
> +	return 77;  /* SKIP */
>   }
>   
>   /*
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index c56290aa4932..948892759424 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -17,6 +17,7 @@
>   
>   cd "$(dirname "$0")" || exit 1
>   PATH=../src:$PATH
> +SIGV1=0
>   source ./functions.sh
>   
>   _require cmp evmctl getfattr openssl xxd
> @@ -368,13 +369,18 @@ try_different_sigs() {
>   
>   ## Test v1 signatures
>   # Signature v1 only supports sha1 and sha256 so any other should fail
> -expect_fail \
> -  check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREFIX=0x0301 OPTS=--rsa
> +if [ $SIGV1 -eq 0 ]; then
> +  __skip() { echo "IMA signature v1 tests are skipped: not supported"; return $SKIP; }
> +  expect_pass __skip
> +else
> +   expect_fail \
> +      check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREFIX=0x0301 OPTS=--rsa
>   
> -sign_verify  rsa1024  sha1    0x0301 --rsa
> -sign_verify  rsa1024  sha256  0x0301 --rsa
> -  try_different_keys
> -  try_different_sigs
> +   sign_verify  rsa1024  sha1    0x0301 --rsa
> +   sign_verify  rsa1024  sha256  0x0301 --rsa
> +      try_different_keys
> +      try_different_sigs
> +fi
>   
>   ## Test v2 signatures with RSA PKCS#1
>   # List of allowed hashes much greater but not all are supported.
