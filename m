Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04345A8639
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiHaS7q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Aug 2022 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiHaS7i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Aug 2022 14:59:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06086C276F
        for <linux-integrity@vger.kernel.org>; Wed, 31 Aug 2022 11:58:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VIUiOO028017;
        Wed, 31 Aug 2022 18:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HO5SQSaaprbBsBPHvQa4nWukrHHV/YnGvLNBehvIIXw=;
 b=oNILkY+H1YBgfV3ESWFNFK8PfXTtDnnRvTJ8LfxbHw5JaNo3XEnnQzG1nFTu4w4E4869
 qRWw4Z1ZL1rpGA0akdjt2ew5kLST6o6Vfq0ujBG2U7pnUQrrYlF5C51Ndsr21Ck4dwYd
 m9RH+kr16eNy+UaNqcLEf07J0kPvsEN11W0TRjOV3GuR5HVMyJqArHLAI5ldc624Qg+o
 KbBC1eU81vF9fuQPPl6hnFatyRNHw44DQCqkpRxvzz+IN4RxjHw0P/sphyrIx7zPlrNz
 72yK9gePZZw2FUeo795Sl2XJwBEExrCTBNxrC8+NqCF3BpRgBbve7UQ927ccysGm3PEO DQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jad049ume-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 18:58:39 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VIqJVI017101;
        Wed, 31 Aug 2022 18:58:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3j7aw9v7bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 18:58:37 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VIwajS59441442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 18:58:36 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344CCBE051;
        Wed, 31 Aug 2022 19:04:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46E9BE04F;
        Wed, 31 Aug 2022 19:04:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.98.41])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 19:04:10 +0000 (GMT)
Message-ID: <5f1a5458f8f4d283ca61ccfcc02f9301e5b8c27d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 04/11] Deprecate IMA signature version
 1
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Wed, 31 Aug 2022 14:58:35 -0400
In-Reply-To: <Yw36rCs7MhTAWFEr@pevik>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
         <20220830005936.189922-5-zohar@linux.ibm.com> <Yw36rCs7MhTAWFEr@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M_dliCiGr_pGUfU5mredSIFGCrkQrnZN
X-Proofpoint-ORIG-GUID: M_dliCiGr_pGUfU5mredSIFGCrkQrnZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_11,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2022-08-30 at 13:55 +0200, Petr Vorel wrote:
> > The original IMA file signatures were based on a SHA1 hash.  Kernel
> > support for other hash algorithms was subsequently upstreamed.  Deprecate
> > "--rsa" support.
> 
> > Define "--enable-sigv1" option to configure signature v1 support.
> 
> LGTM, few minor comments below.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thank you for all the reviews!

> 
> ...
> > +++ b/configure.ac
> ...
> 
> >  static int cmd_convert(struct command *cmd)
> >  {
> > +#if CONFIG_SIGV1
> >  	char *inkey;
> >  	unsigned char _pub[1024], *pub = _pub;
> >  	int len, err = 0;
> > @@ -1033,6 +1033,8 @@ static int cmd_convert(struct command *cmd)
> 
> >  	RSA_free(key);
> >  	return err;
> > +#endif
> > +	return 77;
> What is this this magic number? EBADFD?
> Well, git grep shows many places with 77, so it's just a tip for next cleanup :).

SKIP is defined as 77 in the tests/ directory.  Using 77 in src/*.c is
incorrect.  v2 ifdefs all of cmd_convert(), so this is going away. 
I'll remove the other occurance of 77 in the src/ directory.

> 
> ...
> >  	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
> > @@ -2598,7 +2605,8 @@ static void usage(void)
> >  		"  -d, --imahash      make IMA hash\n"
> >  		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
> >  		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
> > -		"      --rsa          use RSA key type and signing scheme v1\n"
> > +
> nit: was this blank line intentional?
> > +		"      --rsa          use RSA key type and signing scheme v1 (deprecated)\n"
> >  		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
> >  		"                     or a pkcs11 URI\n"
> >  		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
> > @@ -2637,8 +2645,8 @@ static void usage(void)
> >  struct command cmds[] = {
> >  	{"--version", NULL, 0, ""},
> >  	{"help", cmd_help, 0, "<command>"},
> > -	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring.\n"},
> > -	{"convert", cmd_convert, 0, "key", "convert public key into the keyring.\n"},
> > +	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring. (deprecated)\n"},
> > +	{"convert", cmd_convert, 0, "key", "convert public key into the keyring. (deprecated)\n"},
> >  	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass [password] file", "Sign file metadata.\n"},
> >  	{"verify", cmd_verify_evm, 0, "file", "Verify EVM signature (for debugging).\n"},
> >  	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass [password] file", "Make file content signature.\n"},
> ...
> > +++ b/src/libimaevm.c
> ...
> 
> > +#if CONFIG_SIGV1
> >  static RSA *read_priv_key(const char *keyfile, const char *keypass)
> >  {
> > +	RSA *key = NULL;
> nit: NULL is safe, I wonder if it is necessary (was needed before).

Looking at this again, it isn't needed.  On failure to set either pkey
or key, NULL is returned.

> >  	EVP_PKEY *pkey;
> > -	RSA *key;
> 
> >  	pkey = read_priv_pkey(keyfile, keypass);
> >  	if (!pkey)
> > @@ -1018,10 +1034,12 @@ static int get_hash_algo_v1(const char *algo)
> 
> >  	return -1;
> >  }
> > +#endif
-- 
thanks,

Mimi

