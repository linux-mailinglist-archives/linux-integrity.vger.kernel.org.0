Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38D4F9857
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiDHOmo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiDHOmf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 10:42:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DEED9F6;
        Fri,  8 Apr 2022 07:40:30 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238DubF7020912;
        Fri, 8 Apr 2022 14:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gJU9rwQMnMOw641NY/E3IJ06LX33hzJE4fQvstvrxas=;
 b=tSPsQbUwDQCeWtWVdsqz4AQX0U7OD94LzahQbhD/tbQlTEqEaRQyvnSl6MsQuU/D8eMm
 liYJ8wvi76xtGFQMfzB7++ARkA2uwnV7J90NRVihkFvy8thfJimKl5pbV6KS8PiED/Dw
 Zvyio1aivuhCIAtAbHrksgZCkiaO0K7TFLTawByvii+5v+SUpxxQUp+Di3Cfdh7/zD6O
 3JlF6vC46XGqywKJLNjIxaw1aeGnbJtToz+EzGQ1rtv+mh2dypYPh0iTU/3GC/Sj76mY
 sp/gzMQyKiyh4F9hVHjUxu3jpDNCrbZY1PzZQ7hc4ts3KWvdM/8h/ndHIc38OFqUjoWk ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa4jx5q31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238EJVUS001168;
        Fri, 8 Apr 2022 14:39:53 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa4jx5q29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238EavvK000733;
        Fri, 8 Apr 2022 14:39:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e4940eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:39:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238EdmIu11993474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:39:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F50042041;
        Fri,  8 Apr 2022 14:39:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 457B84203F;
        Fri,  8 Apr 2022 14:39:46 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Apr 2022 14:39:46 +0000 (GMT)
Message-ID: <7def8e4babcf1ae573ad483828a5696b1255c680.camel@linux.ibm.com>
Subject: Re: [PATCH 3/7] KEYS: X.509: Parse Key Usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        pvorel@suse.cz, tiwai@suse.de, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 08 Apr 2022 10:39:45 -0400
In-Reply-To: <20220406015337.4000739-4-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tvrOweUX9zeV0hDZdNr3SW-CUUvz0xBo
X-Proofpoint-ORIG-GUID: 75kh27NM2z4ORt6uAxqARD2XybEG7iT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
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
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 20 ++++++++++++++++++++
>  crypto/asymmetric_keys/x509_parser.h      |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 30f7374ea9c0..a89f1e0c8a0f 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -576,6 +576,26 @@ int x509_process_extension(void *context, size_t hdrlen,
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
> +		if (v[0] != ASN1_BTS || vlen < 4)
> +			return -EBADMSG;
> +		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
> +			ctx->cert->is_kcs_set = true;
> +		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
> +			ctx->cert->is_kcs_set = true;
> +		return 0;
> +	}
> +
>  	if (ctx->last_oid == OID_authorityKeyIdentifier) {
>  		/* Get hold of the CA key fingerprint */
>  		ctx->raw_akid = v;
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index dc45df9f6594..d6ac0985d8a5 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -39,6 +39,7 @@ struct x509_certificate {
>  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>  	bool		blacklisted;
>  	bool		is_root_ca;		/* T if basic constraints CA is set */
> +	bool		is_kcs_set;		/* T if keyCertSign is set */
>  };

Again there is no need to prefix the variable with "is_" or suffix it
with "set".  Simply naming the variable "cert_signing" or
"keycertsign", like "self_signed", will improve code readability.

thanks,

Mimi

