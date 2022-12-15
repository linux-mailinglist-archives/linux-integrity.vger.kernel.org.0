Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4187864DA39
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLOLZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 06:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOLZ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 06:25:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDC2A95A;
        Thu, 15 Dec 2022 03:25:55 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFBKUPV032337;
        Thu, 15 Dec 2022 11:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=z7xOxeP/BmvlbavOrsl3suBVa3QPrzmm4oon1sLgOmw=;
 b=N4QyD7EwXjl/JhDDCMeqSKuPUz2VI+dVnbzjPmz3DVLeJXwC6qBs2e57JzBs8gExwUnb
 uAS7HmatZphU7niRTxcjSBjqI+IMuqGYabA1re9nX8MXsJLhhGPBHTSYxK+kDVdJO8lB
 ro9AY2p+w7KdEQY49XTaVOQslEbbcI+BnbWDtMe0+5TYlwhO68Tr2BX96ZFjp6dC1Zf9
 N+woK5beSE5Qw0DuoDKHhtJHy0H9qD5sWUD2cmzRyL9EnJ7d6NknjV+ycG7JNh2hxtXW
 /jLBwrMlDkdkxnSUe9mZrtaf6llQgfnD/UPS1AEHug8zyJSQ7p7zTLebXdry+okawLtA dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg2meg2cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:25:29 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFBKlje000961;
        Thu, 15 Dec 2022 11:25:28 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg2meg2bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:25:28 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFAgVAL011783;
        Thu, 15 Dec 2022 11:25:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3meyyhwc8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:25:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFBPQeD7930554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 11:25:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A1F58060;
        Thu, 15 Dec 2022 11:25:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E71F5805E;
        Thu, 15 Dec 2022 11:25:24 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 11:25:24 +0000 (GMT)
Message-ID: <26bb48845023a4e6515e1d4f6e1f38eb7e96e16d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/10] KEYS: X.509: Parse Key Usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 15 Dec 2022 06:25:24 -0500
In-Reply-To: <20221214003401.4086781-5-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <20221214003401.4086781-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ve0kohc5bjUKS47Woj99Hr9fxVMuq-dS
X-Proofpoint-ORIG-GUID: Y-cu894W-yZrl_eyoCdOUDvzzh0O-NTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_05,2022-12-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
> Parse the X.509 Key Usage.  The key usage extension defines the purpose of
> the key contained in the certificate.
> 
>    id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }
> 
>       KeyUsage ::= BIT STRING {
>            digitalSignature        (0),
>            contentCommitment       (1),
>            keyEncipherment         (2),
>            dataEncipherment        (3),
>            keyAgreement            (4),
>            keyCertSign             (5),
>            cRLSign                 (6),
>            encipherOnly            (7),
>            decipherOnly            (8) }
> 
> If the keyCertSign is set, store it in the x509_certificate structure.
> This will be used in a follow on patch that requires knowing the
> certificate key usage type.

Either in this patch or separately, the "digitalSignature" key usage
flag needs to be saved.

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
>  crypto/asymmetric_keys/x509_parser.h      |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index b4443e507153..edb22cf04eed 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -579,6 +579,28 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_keyUsage) {
> +		/*
> +		 * Get hold of the keyUsage bit string to validate keyCertSign
> +		 * v[1] is the encoding size
> +		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
> +		 * v[2] is the number of unused bits in the bit string
> +		 *       (If >= 3 keyCertSign is missing)
> +		 * v[3] and possibly v[4] contain the bit string
> +		 * 0x04 is where KeyCertSign lands in this bit string (from
> +		 *      RFC 5280 4.2.1.3)
> +		 */
> +		if (v[0] != ASN1_BTS)
> +			return -EBADMSG;
> +		if (vlen < 4)
> +			return -EBADMSG;
> +		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
> +			ctx->cert->kcs_set = true;
> +		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
> +			ctx->cert->kcs_set = true;
> +		return 0;
> +	}
> +
>  	if (ctx->last_oid == OID_authorityKeyIdentifier) {
>  		/* Get hold of the CA key fingerprint */
>  		ctx->raw_akid = v;
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index 7c5c0ad1c22e..74a9f929e400 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -39,6 +39,7 @@ struct x509_certificate {
>  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>  	bool		blacklisted;
>  	bool		root_ca;		/* T if basic constraints CA is set */
> +	bool		kcs_set;		/* T if keyCertSign is set */

Using acronyms as variable names makes reviewing code more difficult. 
Perhaps rename "kcs_set" to either "key_cert_sign" or "keycertsign".

>  };
>  
>  /*

-- 
thanks,

Mimi


